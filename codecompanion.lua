local fmt = string.format
local prompt_library = {
  ["Commit with ticket"] = {
    strategy = "chat",
    description = "Generate a commit message prefixed with ticket from branch name",
    opts = {
      index = 10,
      is_default = true,
      is_slash_cmd = true,
      short_name = "bcommit",
      auto_submit = true,
    },
    prompts = {
      {
        role = "user",
        content = function()
          local branch = vim.fn.system("git symbolic-ref --short HEAD")

          return fmt(
            [[
              You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me.
                Also follow these rules:
              if branch name started with some ticket prefix like ABC-XXX use it in a commit message as a prefix
                If branch name starts with a ticket prefix like ABC-XXX, use it in the commit message as a prefix.
              Branch name: GMS-1234-some-stuff
              Commit message: GMS-1234 <generated commit message>

              Branch name: ABC-12345-other-stuff
              Commit message: ABC-12345 <generated commit message>

              If there is no ticket in branch name use just a commit message without a ticket prefix or any other prefix like feature, fix, etc.
                If there is no ticket in the branch name, use just a commit message without a ticket prefix or any other prefix like feature, fix, etc.
              Branch name: some-stuff
              Commit message: <generated commit message>
              ```diff
              %s,
              ```
              %s
            ]],
            vim.fn.system("git diff --no-ext-diff --staged"),
            branch and "Branch name: " .. branch or ""
          )
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
}


adapters = {
  ollama = function()
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
        -- just for test and example
        url = "https://ollama.hl.ididit4u.ru",
        api_key = '037efd07-4542-4ca9-8710-7f2a702f954a',
      },
      headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer ${api_key}",
      },
      parameters = {
        sync = true,
      },
    })
  end,
  copilot = function()
    return require("codecompanion.adapters").extend("copilot", {})
  end,
}


local extensions = {
  history = {
    enabled = true,
    opts = {
      -- Keymap to open history from chat buffer (default: gh)
      keymap = "gh",
      -- Keymap to save the current chat manually (when auto_save is disabled)
      save_chat_keymap = "sc",
      -- Save all chats by default (disable to save only manually using 'sc')
      auto_save = true,
      -- Number of days after which chats are automatically deleted (0 to disable)
      expiration_days = 0,
      -- Picker interface (auto resolved to a valid picker)
      picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
      ---Optional filter function to control which chats are shown when browsing
      chat_filter = nil,    -- function(chat_data) return boolean end
      -- Customize picker keymaps (optional)
      picker_keymaps = {
        rename = { n = "r", i = "<M-r>" },
        delete = { n = "d", i = "<M-d>" },
        duplicate = { n = "<C-y>", i = "<C-y>" },
      },
      ---Automatically generate titles for new chats
      auto_generate_title = true,
      title_generation_opts = {
        ---Adapter for generating titles (defaults to current chat adapter)
        adapter = nil,               -- "copilot"
        ---Model for generating titles (defaults to current chat model)
        model = nil,                 -- "gpt-4o"
        ---Number of user prompts after which to refresh the title (0 to disable)
        refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
        ---Maximum number of times to refresh the title (default: 3)
        max_refreshes = 3,
        format_title = function(original_title)
          -- this can be a custom function that applies some custom
          -- formatting to the title.
          return original_title
        end
      },
      ---On exiting and entering neovim, loads the last chat on opening chat
      continue_last_chat = false,
      ---When chat is cleared with `gx` delete the chat from history
      delete_on_clearing_chat = false,
      ---Directory path to save the chats
      dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
      ---Enable detailed logging for history extension
      enable_logging = false,

      -- Summary system
      summary = {
        -- Keymap to generate summary for current chat (default: "gcs")
        create_summary_keymap = "gcs",
        -- Keymap to browse summaries (default: "gbs")
        browse_summaries_keymap = "gbs",

        generation_opts = {
          adapter = nil,               -- defaults to current chat adapter
          model = nil,                 -- defaults to current chat model
          context_size = 90000,        -- max tokens that the model supports
          include_references = true,   -- include slash command content
          include_tool_outputs = true, -- include tool execution results
          system_prompt = nil,         -- custom system prompt (string or function)
          format_summary = nil,        -- custom function to format generated summary e.g to remove <think/> tags from summary
        },
      },

      -- Memory system (requires VectorCode CLI)
      memory = {
        -- Automatically index summaries when they are generated
        auto_create_memories_on_summary_generation = true,
        -- Path to the VectorCode executable
        vectorcode_exe = "vectorcode",
        -- Tool configuration
        tool_opts = {
          -- Default number of memories to retrieve
          default_num = 10
        },
        -- Enable notifications for indexing progress
        notify = true,
        -- Index all existing memories on startup
        -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
        index_on_startup = false,
      },
    }
  },
  mcphub = {
    callback = "mcphub.extensions.codecompanion",
    opts = {
      -- MCP Tools
      make_tools = true,                    -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
      show_server_tools_in_chat = true,     -- Show individual tools in chat completion (when make_tools=true)
      add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
      show_result_in_chat = true,           -- Show tool results directly in chat buffer
      format_tool = nil,                    -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
      -- MCP Resources
      make_vars = true,                     -- Convert MCP resources to #variables for prompts
      -- MCP Prompts
      make_slash_commands = true,           -- Add MCP prompts as /slash commands
    }
  }

}

require("codecompanion").setup({
  prompt_library = prompt_library,
  -- strategies = {
  --   chat = {
  --     adapter = "ollama",
  --   },
  -- },
  adapters = {
    http = adapters,
  },
  display = {
    action_palette = {
      width = 95,
      height = 10,
      prompt = "Prompt ",                   -- Prompt used for interactive LLM calls
      provider = "telescope",               -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
      opts = {
        show_default_actions = true,        -- Show the default actions in the action palette?
        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
        title = "CodeCompanion actions",    -- The title of the action palette
      },
    },
  },
  extensions = extensions,
})
