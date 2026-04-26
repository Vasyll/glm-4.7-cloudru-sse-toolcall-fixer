FROM ruby:3.2.2-slim

RUN apt-get update -qq && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
EXPOSE 8083
CMD ["ruby", "app.rb"]