return function()
  return require("codecompanion.adapters").extend("ollama", {
    schema = {
      model = {
        default = "qwen3:8b",
      },
      think = {
        default = false,
      },
    },
    env = {
      url = "https://ollama.hl.ididit4u.ru",
      api_key = 'CHANGE_ME',
    },
    headers = {
      ["Content-Type"] = "application/json",
      ["Authorization"] = "Bearer ${api_key}",
    },
    parameters = {
      sync = true,
    },
  })
end
