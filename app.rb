#!/usr/bin/env ruby 
require 'sinatra' 
require 'net/http' 
require 'uri' 
require 'json' 
require 'logger'
require 'event_stream_parser'

set :port, 8083
set :bind, '127.0.0.1'

UPSTREAM_URL = 'https://foundation-models.api.cloud.ru' 
UPSTREAM_PATH = '/v1/chat/completions' 

def fix_tool_calls_arguments(data)
  return data unless data.is_a?(Hash) && data['choices'].is_a?(Array) && data['choices'].any?

  data['choices'].each do |choice|
    delta = choice['delta']
    next unless delta.is_a?(Hash) && delta['tool_calls'].is_a?(Array)

    delta['tool_calls'].each do |tool_call|
      # Если id и type есть и равны null
      next unless tool_call.key?('id') && tool_call['id'].nil? && tool_call.key?('type') && tool_call['type'].nil?

      func = tool_call['function']
      next unless func.is_a?(Hash)

      # Заменяем arguments на строку "}"
      func['arguments'] = '}'
    end
  end

  data
end

post '/v1/chat/completions' do
  content_type 'text/event-stream; charset=utf-8'
  headers['Cache-Control'] = 'no-cache'
  headers['Connection'] = 'keep-alive'
  headers['X-Accel-Buffering'] = 'no'

  begin
    req_body = JSON.parse(request.body.read)
  rescue => e
    halt 400, JSON.generate(error: "Invalid JSON: #{e.message}")
  end

  auth_header = request.env['HTTP_AUTHORIZATION']
  unless auth_header
    halt 401, JSON.generate(error: "Missing Authorization header")
  end

  req_body['stream'] = true

  stream do |out|
    begin
      uri = URI.join(UPSTREAM_URL, UPSTREAM_PATH)

      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.open_timeout = 10
        http.read_timeout = 600
        http.keep_alive_timeout = 30

        upstream_req = Net::HTTP::Post.new(uri.request_uri)
        upstream_req['Authorization'] = auth_header
        upstream_req['Content-Type'] = request.content_type || 'application/json'
        upstream_req['User-Agent'] = request.env['HTTP_USER_AGENT'] if request.env['HTTP_USER_AGENT']
        upstream_req['X-Session-Affinity'] = request.env['HTTP_X_SESSION_AFFINITY'] if request.env['HTTP_X_SESSION_AFFINITY']
        upstream_req.body = JSON.generate(req_body)

        http.request(upstream_req) do |res|
          code = res.code.to_i

          if code != 200
            body = +''
            res.read_body { |chunk| body << chunk }
            out << "event: error\ndata: #{JSON.generate(error: "API error #{code}", body: body[0, 2000])}\n\n"
            next
          end

          parser = EventStreamParser::Parser.new

          res.read_body do |chunk|
            safe = chunk.dup.force_encoding(Encoding::UTF_8).scrub('?')

            parser.feed(chunk) do |type, data, id, reconnection_time|
              # `data` — это содержимое строки 'data: ...', без префикса
              if data == '[DONE]'
                out << "data: [DONE]\n\n"
                next
              end

              begin
                parsed_data = JSON.parse(data)

                if parsed_data['model'] == 'zai-org/GLM-4.7'
                  parsed_data = fix_tool_calls_arguments(parsed_data)
                end

                out << "data: #{JSON.generate(parsed_data)}\n\n"
              rescue JSON::ParserError => e
                out << "event: error\ndata: #{JSON.generate(error: e.message)}\n\n"
              end
            end
          end
        end
      end

    rescue => e
      out << "event: error\ndata: #{JSON.generate(error: e.message)}\n\n"
    ensure
      out.close
    end
  end
end

