local function plugin_require(path)
  local info = debug.getinfo(1, "S")
  local plugin_dir = info.source:match("^@(.+/)init.lua$") or ""
  local mod_path = plugin_dir .. path:gsub("%.", "/") .. ".lua"
  return dofile(mod_path)
end

local prompt_library = {
  ["Commit with ticket"] = plugin_require("prompts.commit_with_ticket"),
}

local adapters = {
  ollama = plugin_require("adapters.ollama"),
  copilot = plugin_require("adapters.copilot"),
  openai = plugin_require("adapters.openai"),
}

local acp_adapters = {
  codex = plugin_require("adapters.acp_codex"),
}

local extensions = {
  history = plugin_require("extensions.history"),
  mcphub = plugin_require("extensions.mcphub"),
}

require("codecompanion").setup({
  prompt_library = prompt_library,
  adapters = {
    http = adapters,
    acp = acp_adapters,
  },
  strategies = {
    chat = {
      roles = {
        -- LLM header: customize to include the model name
        llm = function(adapter)
          return "CodeCompanion (" ..
              adapter.formatted_name ..
              " " .. (adapter.schema and adapter.schema.model and adapter.schema.model.default or "MODEL") .. ")"
        end,
        user = "Me",
      }
    }
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
    chat = {
      show_tools_processing = true, -- Show the loading message when tools are being executed?
      child_window = {
        width = vim.o.columns - 5,
        height = vim.o.lines - 2,
        row = "center",
        col = "center",
        relative = "editor",
        opts = {
          wrap = false,
          number = false,
          relativenumber = false,
        },
      },
    },
  },
  extensions = extensions,
  memory = {
    default = {
      description = "My default group",
      files = {
        "AGENTS.md",
        ".rules",
      },
    },
    opts = {
      chat = {
        default_memory = "default",
        enabled = true,
      },
    },
  },
  tools = {
    opts = {
      auto_submit_errors = true,  -- Send any errors to the LLM automatically?
      auto_submit_success = true, -- Send any successful output to the LLM automatically?
    },
  },
})
