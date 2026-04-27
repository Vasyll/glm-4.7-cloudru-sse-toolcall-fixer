## Qwen/Qwen3-Coder-Next and zai-org/GLM-4.7

Это логи двух LLM генерации команды вызова (tool_calls) двух инструментов (write и read) в режиме SSE. Каждый чанк генерации разделен от следующего двумя пустыми строками.

---

This is the log of two LLM generations of tool call commands (tool_calls) for two tools (write and read) in SSE mode. Each generation chunk is separated from the next by two blank lines.

### Qwen/Qwen3-Coder-Next

```
data: {"id":"chatcmpl-ded72075-bbcd-413f-a580-136d213f4323","object":"chat.completion.chunk","created":1776866868,"model":"Qwen/Qwen3-Coder-Next","choices":[{"index":0,"delta":{"reasoning_content":null,"tool_calls":[{"id":"call_8a738261208a4538a6a45506","type":"function","index":0,"function":{"name":"write","arguments":""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10663,"total_tokens":10670,"completion_tokens":7}}


data: {"id":"chatcmpl-ded72075-bbcd-413f-a580-136d213f4323","object":"chat.completion.chunk","created":1776866868,"model":"Qwen/Qwen3-Coder-Next","choices":[{"index":0,"delta":{"reasoning_content":null,"tool_calls":[{"index":0,"function":{"arguments":"{"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10663,"total_tokens":10671,"completion_tokens":8}}


data: {"id":"chatcmpl-ded72075-bbcd-413f-a580-136d213f4323","object":"chat.completion.chunk","created":1776866868,"model":"Qwen/Qwen3-Coder-Next","choices":[{"index":0,"delta":{"reasoning_content":null,"tool_calls":[{"index":0,"function":{"arguments":"\"content\": \"123\""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10663,"total_tokens":10682,"completion_tokens":19}}


data: {"id":"chatcmpl-ded72075-bbcd-413f-a580-136d213f4323","object":"chat.completion.chunk","created":1776866868,"model":"Qwen/Qwen3-Coder-Next","choices":[{"index":0,"delta":{"reasoning_content":null,"tool_calls":[{"index":0,"function":{"arguments":", \"filePath\": \"/home/chju/dev/rndsoft/1/123\""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10663,"total_tokens":10704,"completion_tokens":41}}


data: {"id":"chatcmpl-ded72075-bbcd-413f-a580-136d213f4323","object":"chat.completion.chunk","created":1776866868,"model":"Qwen/Qwen3-Coder-Next","choices":[{"index":0,"delta":{"reasoning_content":null,"tool_calls":[{"index":0,"function":{"arguments":"}"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10663,"total_tokens":10707,"completion_tokens":44}}


data: {"id":"chatcmpl-ded72075-bbcd-413f-a580-136d213f4323","object":"chat.completion.chunk","created":1776866868,"model":"Qwen/Qwen3-Coder-Next","choices":[{"index":0,"delta":{"reasoning_content":null,"tool_calls":[{"id":"call_0061065f43604133aff0488e","type":"function","index":1,"function":{"name":"read","arguments":""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10663,"total_tokens":10715,"completion_tokens":52}}


data: {"id":"chatcmpl-ded72075-bbcd-413f-a580-136d213f4323","object":"chat.completion.chunk","created":1776866868,"model":"Qwen/Qwen3-Coder-Next","choices":[{"index":0,"delta":{"reasoning_content":null,"tool_calls":[{"index":1,"function":{"arguments":"{"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10663,"total_tokens":10716,"completion_tokens":53}}


data: {"id":"chatcmpl-ded72075-bbcd-413f-a580-136d213f4323","object":"chat.completion.chunk","created":1776866868,"model":"Qwen/Qwen3-Coder-Next","choices":[{"index":0,"delta":{"reasoning_content":null,"tool_calls":[{"index":1,"function":{"arguments":"\"filePath\": \"/home/chju/dev/rndsoft/1/123\""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10663,"total_tokens":10737,"completion_tokens":74}}


data: {"id":"chatcmpl-ded72075-bbcd-413f-a580-136d213f4323","object":"chat.completion.chunk","created":1776866868,"model":"Qwen/Qwen3-Coder-Next","choices":[{"index":0,"delta":{"reasoning_content":null,"tool_calls":[{"index":1,"function":{"arguments":"}"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10663,"total_tokens":10740,"completion_tokens":77}}


data: {"id":"chatcmpl-ded72075-bbcd-413f-a580-136d213f4323","object":"chat.completion.chunk","created":1776866868,"model":"Qwen/Qwen3-Coder-Next","choices":[{"index":0,"delta":{"content":"","reasoning_content":null},"logprobs":null,"finish_reason":"tool_calls","stop_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10663,"total_tokens":10742,"completion_tokens":79}}

data: {"id":"chatcmpl-ded72075-bbcd-413f-a580-136d213f4323","object":"chat.completion.chunk","created":1776866868,"model":"Qwen/Qwen3-Coder-Next","choices":[],"usage":{"prompt_tokens":10663,"total_tokens":10742,"completion_tokens":79,"prompt_tokens_details":{"cached_tokens":1360}}}

data: [DONE]
```

### zai-org/GLM-4.7
```
data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"id":"chatcmpl-tool-b85402c90e2699f7","type":"function","index":0,"function":{"name":"write","arguments":""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10665,"completion_tokens":134}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"{\"content\":\""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10669,"completion_tokens":138}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"123\""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10671,"completion_tokens":140}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":",\"filePath\":\""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10675,"completion_tokens":144}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"/home/chju"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10677,"completion_tokens":146}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"/dev/r"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10679,"completion_tokens":148}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"ndsoft"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10681,"completion_tokens":150}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"/1"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10683,"completion_tokens":152}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"/123"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10685,"completion_tokens":154}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"\""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10687,"completion_tokens":156}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"}"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10689,"completion_tokens":158}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"id":"chatcmpl-tool-bd0f15060abbfb78","type":"function","index":1,"function":{"name":"read","arguments":""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10691,"completion_tokens":160}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":"{\"filePath\":\""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10693,"completion_tokens":162}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":"/home/ch"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10695,"completion_tokens":164}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":"ju/dev"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10697,"completion_tokens":166}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":"/rnd"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10699,"completion_tokens":168}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":"soft/"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10701,"completion_tokens":170}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":"1/"}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10703,"completion_tokens":172}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":"123\""}}]},"logprobs":null,"finish_reason":null,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10705,"completion_tokens":174}}


data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[{"index":0,"delta":{"tool_calls":[{"id":null,"type":null,"index":1,"function":{"name":null,"arguments":"{\"filePath\": \"/home/chju/dev/rndsoft/1/123\"}"}}]},"logprobs":null,"finish_reason":"tool_calls","stop_reason":151338,"token_ids":null}],"usage":{"prompt_tokens":10531,"total_tokens":10707,"completion_tokens":176}}

data: {"id":"chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79","object":"chat.completion.chunk","created":1776867122,"model":"zai-org/GLM-4.7","choices":[],"usage":{"prompt_tokens":10531,"total_tokens":10707,"completion_tokens":176,"prompt_tokens_details":{"cached_tokens":32}}}

data: [DONE]

```

### Момент замены / Replacement moment

```
<...>

{
  "id": "chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79",
  "object": "chat.completion.chunk",
  "created": 1776867122,
  "model": "zai-org/GLM-4.7",
  "choices": [
    {
      "index": 0,
      "delta": {
        "tool_calls": [
          {
            "index": 1,
            "function": {
              "arguments": "123\""
            }
          }
        ]
      },
      "logprobs": null,
      "finish_reason": null,
      "token_ids": null
    }
  ],
  "usage": {
    "prompt_tokens": 10531,
    "total_tokens": 10705,
    "completion_tokens": 174
  }
}

В этом чанке производим замену / In this chunk, we perform the replacement:

{
  "id": "chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79",
  "object": "chat.completion.chunk",
  "created": 1776867122,
  "model": "zai-org/GLM-4.7",
  "choices": [
    {
      "index": 0,
      "delta": {
        "tool_calls": [
          {
            "id": null,
            "type": null,
            "index": 1,
            "function": {
              "name": null,
              "arguments": "{\"filePath\": \"/home/chju/dev/rndsoft/1/123\"}"
            }
          }
        ]
      },
      "logprobs": null,
      "finish_reason": "tool_calls",
      "stop_reason": 151338,
      "token_ids": null
    }
  ],
  "usage": {
    "prompt_tokens": 10531,
    "total_tokens": 10707,
    "completion_tokens": 176
  }
}

Получается такой чанк / The resulting chunk looks like this:

{
  "id": "chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79",
  "object": "chat.completion.chunk",
  "created": 1776867122,
  "model": "zai-org/GLM-4.7",
  "choices": [
    {
      "index": 0,
      "delta": {
        "tool_calls": [
          {
            "id": null,
            "type": null,
            "index": 1,
            "function": {
              "name": null,
              "arguments": "}"
            }
          }
        ]
      },
      "logprobs": null,
      "finish_reason": "tool_calls",
      "stop_reason": 151338,
      "token_ids": null
    }
  ],
  "usage": {
    "prompt_tokens": 10531,
    "total_tokens": 10707,
    "completion_tokens": 176
  }
}

{
  "id": "chatcmpl-ac04ece3-690e-4957-94a2-d41b06074b79",
  "object": "chat.completion.chunk",
  "created": 1776867122,
  "model": "zai-org/GLM-4.7",
  "choices": [],
  "usage": {
    "prompt_tokens": 10531,
    "total_tokens": 10707,
    "completion_tokens": 176,
    "prompt_tokens_details": {
      "cached_tokens": 32
    }
  }
}

[DONE]
```