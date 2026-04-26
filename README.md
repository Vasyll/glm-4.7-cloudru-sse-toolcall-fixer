Патчер SSE-чанков для OpenAI-совместимых моделей (GLM 4.7 на cloud.ru via Opencode), решающий проблему дублирования и невалидного JSON в `tool_calls.arguments`.[web:51]

## 🚨 Проблема, которую решает
Модель GLM 4.7 стримит `tool_calls` так: сначала фрагменты аргументов, потом полный JSON целиком. При сборке SSE получается дублированный невалидный JSON:


```json
{
  "tool": "write",
  "error": "Invalid input for tool write: JSON parsing failed: Text: {"content":"","filePath":"/home/chju/dev/rndsoft/1/123"{"content": "", "filePath": "/home/chju/dev/rndsoft/1/123"}.\nError message: JSON Parse error: Expected '}'"
}
```

Зарегистрировано в [Opencode #7692](https://github.com/anomalyco/opencode/issues/7692). 