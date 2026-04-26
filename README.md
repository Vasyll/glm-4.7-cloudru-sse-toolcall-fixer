## Что это?

Это проксирующий http сервер для исправления последовательности чанков `tool_calls.arguments` запросов opencode к GLM 4.7 на cloud.ru.

## В чем проблема?

zai-org/GLM-4.7 из cloud.ru в opencode генерит кривые инструменты (tools).

## Как проявляется проблема?

#### User 

Создай в проекте файл с текстом 123 

#### Assistant (Build · glm-4.7 · 8.5s)

Thinking: The user is asking me to create a file in the project with the text "123". Let me first understand what the current project structure looks like, and then I'll create the file. The user wants me to:

Create a file with the content "123" This is a straightforward task. I should:

First check what's in the current directory to understand the project structure

Create a file with the text "123" Let me start by looking at the current directory structure, then create the file Tool: invalid Input:
```
{
  "tool": "read",
  "error": "Invalid input for tool read: JSON parsing failed: Text: {"filePath":"/home/chju/dev/rndsoft/datepicker"{"filePath": "/home/chju/dev/rndsoft/datepicker"}.\nError message: JSON Parse error: Expected '}'"
}
```

Output: The arguments provided to the tool are invalid: Invalid input for tool read: JSON parsing failed: Text: {"filePath":"/home/chju/dev/rndsoft/datepicker"{"filePath": "/home/chju/dev/rndsoft/datepicker"}.

Error message: JSON Parse error: Expected '}'

## Что еще известно о проблеме?

В сообществе opencode есть несколько похожих issues:

-    #7692 (https://github.com/anomalyco/opencode/issues/7692) — [Bug] JSON Parse Error with Zhipu GLM-4.7: Stream chunks are concatenated incorrectly.
-    #8102 (https://github.com/anomalyco/opencode/issues/8102) — MCP tool JSON parsing errors: модель генерирует невалидный JSON для аргументов инструментов.
-    #8282 (https://github.com/anomalyco/opencode/issues/8282) — SSE streaming parse error: хендлер стриминга некорректно конкатенирует чанки от GLM-4.7.
-    #10731 (https://github.com/anomalyco/opencode/issues/10731) — дублирование параметров в JSON, инструментальные теги попадают внутрь

Корневая причина (из комментариев #7692):
Проблема не в парсере OpenCode, а в формате SSE-стрима от GLM-4.7. Модель отправляет чанки без корректных границ, из-за чего парсер OpenCode склеивает

## Как это исправить?

Кратко: запустить приложение локально в docker, настроив в opencode.json "baseURL": "http://127.0.0.1:8083/v1/"

Приложение слушает порт 8083 на роуте '/v1/chat/completions', проксирует запросы к API 'https://foundation-models.api.cloud.ru' и обрабатывает SSE (Server-Sent Events) ответы.

В чанках приходят части `arguments` (кусочки этой строки: `{"filePath":"/home/chju/dev/rndsoft/datepicker"`).  Мы не буферизируем чанки, а передаём их клиенту по мере поступления. В последнем чанке вместо закрывающей скобки `}` приходит сразу **полный** `arguments`: `{"filePath": "/home/chju/dev/rndsoft/datepicker"}`. Поэтому прокси **заменяет** содержимое `function.arguments` на строку `"}"`.

В конце этого документа есть логи, чтобы можно было реализовать по другому, если нужно.

Далее разные варианты запуска и удаления приложения:

#### Запустить приложение командой docker

Запустить приложение через docker run с именем glm-fixer в режиме 'всегда перезапускать контейнер'
```bash
docker run -d -p 8083:8083 --name glm-fixer --restart always ghcr.io/vasyll/glm-4.7-cloudru-sse-toolcall-fixer:main
```

Остановить контейнер:
```bash
docker stop glm-fixer
```

Удалить контейнер:
```bash
docker rm glm-fixer
```

#### Собрать локально и запустить командой docker compose:

Склонируйте репозиторий:
```
git clone https://github.com/vasyll/glm-4.7-cloudru-sse-toolcall-fixer
cd glm-4.7-cloudru-sse-toolcall-fixer
```

Создайте файл docker-compose.yml с содержимым:
```yaml
services:
  glm-fixer:
    build: .
    ports:
      - "8083:8083"
    restart: always
```
Запустите командой:
```bash
docker compose up -d
```

#### Запустить готовый образ командой docker compose.

Создайте файл docker-compose.yml с содержимым:
```yaml
services:
  glm-fixer:
    image: ghcr.io/vasyll/glm-4.7-cloudru-sse-toolcall-fixer:main
    ports:
      - "8083:8083"
    restart: always
```

Запустите командой
```bash
docker compose up -d
```

Чтобы остановить и удалить контейнеры, запущенные через docker compose up -d, используйте команду:
```bash
docker compose down
```

#### Пример конфигурации opencode.json

Для запуска opencode с моделью 'zai-org/GLM-4.7' и glm-fixer создайте нового провайдера, укажите для него baseURL ("http://127.0.0.1:8083/v1/") и пропишите его в разделе agent. Вот пример, как это может выглядеть:
```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "cloudru": {
      "npm": "@ai-sdk/openai-compatible",
      "models": {
        "qwen3-coder-next": {
          "id": "Qwen/Qwen3-Coder-Next"
        }
      },
      "options": {
        "apiKey": "***",
        "baseURL": "https://foundation-models.api.cloud.ru/v1/"
      }
    },
    "cloudru_glm-4.7": {
      "npm": "@ai-sdk/openai-compatible",
      "models": {
        "glm-4.7": {
          "id": "zai-org/GLM-4.7"
        }
      },
      "options": {
        "apiKey": "***",
        "baseURL": "http://127.0.0.1:8083/v1/"
      }
    }
  },
  "agent": {
    "build": {
      "mode": "primary",
      "model": "cloudru_glm-4.7/glm-4.7"
    },
    "plan": {
      "mode": "primary",
      "model": "cloudru_glm-4.7/glm-4.7"
    }
  }
}
```

