return function()
  return require("codecompanion.adapters").extend("codex", {
    defaults = {
      auth_method = "openai-api-key",       -- "openai-api-key"|"codex-api-key"|"chatgpt"
    },
  })
end
