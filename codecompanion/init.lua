local prompt_library = {
  ["Commit with ticket"] = require("codecompanion.prompts.commit_with_ticket"),
}

local adapters = {
  ollama = require("codecompanion.adapters.ollama"),
  copilot = require("codecompanion.adapters.copilot"),
}

local extensions = {
  history = require("codecompanion.extensions.history"),
  mcphub = require("codecompanion.extensions.mcphub"),
}

require("codecompanion").setup({
  prompt_library = prompt_library,
  adapters = {
    http = adapters,
  },
  display = {
    action_palette = {
      width = 95,
      height = 10,
      prompt = "Prompt ",
      provider = "telescope",
      opts = {
        show_default_actions = true,
        show_default_prompt_library = true,
        title = "CodeCompanion actions",
      },
    },
  },
  extensions = extensions,
})
