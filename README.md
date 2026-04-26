## Что это? / What is this?

Это проксирующий HTTP сервер для исправления последовательности чанков `tool_calls.arguments` запросов opencode к GLM 4.7 на cloud.ru.

---

A proxy HTTP server that fixes the sequence of `tool_calls.arguments` chunks for opencode requests to GLM 4.7 on cloud.ru.

## В чем проблема? / What is the problem?

`zai-org/GLM-4.7` от cloud.ru генерирует кривые инструменты (tools) в opencode.

---

`zai-org/GLM-4.7` from cloud.ru produces malformed tools in opencode.

## Как проявляется проблема? / How does the problem manifest?

#### User

Создай в проекте файл с текстом 123 / Create a file in the project with the text "123"

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

## Что еще известно о проблеме? / What else is known about the problem?

В сообществе opencode есть несколько похожих issue / There are several related issues in the opencode community:

- [#7692](https://github.com/anomalyco/opencode/issues/7692) — [Bug] JSON Parse Error with Zhipu GLM-4.7: Stream chunks are concatenated incorrectly.
- [#8102](https://github.com/anomalyco/opencode/issues/8102) — MCP tool JSON parsing errors: модель генерирует невалидный JSON для аргументов инструментов.
- [#8282](https://github.com/anomalyco/opencode/issues/8282) — SSE streaming parse error: хендлер стриминга некорректно конкатенирует чанки от GLM-4.7.
- [#10731](https://github.com/anomalyco/opencode/issues/10731) — дублирование параметров в JSON, инструментальные теги попадают внутрь.

**Корневая причина (из комментариев #7692):**
Проблема не в парсере OpenCode, а в формате SSE-стрима от GLM-4.7. Модель отправляет чанки без корректных границ, из-за чего парсер OpenCode склеивает их неправильно.

---

**Root cause (from comments in #7692):**
The issue is not in OpenCode's parser but in the SSE stream format from GLM-4.7. The model sends chunks without proper boundaries, causing OpenCode's parser to concatenate them incorrectly.

## Как это исправить? / How to fix it?

**Кратко:** запустить приложение локально в docker, настроив в `opencode.json` `"baseURL": "http://127.0.0.1:8083/v1/"`.

Приложение слушает порт 8083 на роуте `/v1/chat/completions`, проксирует запросы к API `https://foundation-models.api.cloud.ru` и обрабатывает SSE (Server-Sent Events) ответы.

В чанках приходят части `arguments` (кусочки этой строки: `{"filePath":"/home/chju/dev/rndsoft/datepicker"`).
Мы не буферизируем чанки, а передаём их клиенту по мере поступления.
В последнем чанке вместо закрывающей скобки `}` приходит сразу **полный** `arguments`: `{"filePath": "/home/chju/dev/rndsoft/datepicker"}`.
Поэтому прокси **заменяет** содержимое `function.arguments` на строку `"}"`.

Логи будут в файле `logs.md`, чтобы можно было реализовать по-другому, если нужно.

---

**TL;DR:** Run the application locally in Docker and set `"baseURL": "http://127.0.0.1:8083/v1/"` in your `opencode.json`.

The application listens on port 8083 at route `/v1/chat/completions`, proxies requests to the API `https://foundation-models.api.cloud.ru`, and processes SSE (Server-Sent Events) responses.

Chunks contain partial `arguments` (pieces of a string like `{"filePath":"/home/chju/dev/rndsoft/datepicker"`).
We do not buffer chunks — we forward them to the client as they arrive.  
In the final chunk, instead of a closing brace `}`, the **entire** `arguments` arrives: `{"filePath": "/home/chju/dev/rndsoft/datepicker"}`.
Therefore, the proxy **replaces** the content of `function.arguments` with the string `"}"`.

Logs will be written to `logs.md` in case you need to implement a different approach later.

---

### Варианты запуска / Launch options

#### Запустить приложение командой docker / Run with docker command

Запустить приложение через docker run с именем glm-fixer в режиме 'всегда перезапускать контейнер'

---

Run the container with the name `glm-fixer` and auto-restart policy:

```bash
docker run -d -p 8083:8083 --name glm-fixer --restart always ghcr.io/vasyll/glm-4.7-cloudru-sse-toolcall-fixer:main
```

Остановить контейнер / Stop the container:

```bash
docker stop glm-fixer
```

Удалить контейнер / Remove the container:

```bash
docker rm glm-fixer
```

#### Собрать локально и запустить командой docker compose / Build locally and run with docker compose

Склонируйте репозиторий / Clone the repository:

```bash
git clone https://github.com/vasyll/glm-4.7-cloudru-sse-toolcall-fixer
cd glm-4.7-cloudru-sse-toolcall-fixer
```

Создайте файл `docker-compose.yml` с содержимым / Create a `docker-compose.yml` file:

```yaml
services:
  glm-fixer:
    build: .
    ports:
      - "8083:8083"
    restart: always
```

Запустите командой / Run with:

```bash
docker compose up -d
```

#### Запустить готовый образ командой docker compose / Run the prebuilt image with docker compose

Создайте файл `docker-compose.yml` с содержимым / Create a `docker-compose.yml` file:

```yaml
services:
  glm-fixer:
    image: ghcr.io/vasyll/glm-4.7-cloudru-sse-toolcall-fixer:main
    ports:
      - "8083:8083"
    restart: always
```

Запустите командой / Run with:

```bash
docker compose up -d
```

Чтобы остановить и удалить контейнеры, запущенные через `docker compose up -d`, используйте команду / To stop and remove containers started with `docker compose up -d`, run:

```bash
docker compose down
```

### Пример конфигурации opencode.json / Example opencode.json configuration

Для запуска opencode с моделью `zai-org/GLM-4.7` и glm-fixer создайте нового провайдера, укажите для него `baseURL` (`"http://127.0.0.1:8083/v1/"`) и пропишите его в разделе `agent`. Вот пример:

---

To run opencode with the `zai-org/GLM-4.7` model and glm-fixer, create a new provider, set its `baseURL` to `"http://127.0.0.1:8083/v1/"`, and reference it in the `agent` section. Example:

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

**Примечание:** замените `***` на ваш реальный API-ключ.  

---

**Note:** replace `***` with your actual API key.
