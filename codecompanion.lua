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
              Also wollow this rules:
              if branch name started with some ticket prefix like ABC-XXX use it in a commit message as a prefix
              examples:
              Branch name: GMS-1234-some-stuff
              Commit message: GMS-1234 <generated commit message>

              Branch name: ABC-12345-other-stuff
              Commit message: ABC-12345 <generated commit message>

              If there is no ticket in branch name use just a commit message without a ticket prefix or any other prefix like feature, fix, etc.
              examples:
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

require("codecompanion").setup({
  prompt_library = prompt_library,
  -- strategies = {
  --   chat = {
  --     adapter = "ollama",
  --   },
  -- },
  adapters = adapters,
  extensions = {
    history = {
      enabled = true,
      opts = {
        -- Keymap to open history from chat buffer (default: gh)
        keymap = "gh",
        -- Automatically generate titles for new chats
        auto_generate_title = true,
        ---On exiting and entering neovim, loads the last chat on opening chat
        continue_last_chat = false,
        ---When chat is cleared with `gx` delete the chat from history
        delete_on_clearing_chat = false,
        -- Picker interface ("telescope" or "snacks" or "default")
        picker = "telescope",
        ---Enable detailed logging for history extension
        enable_logging = false,
        ---Directory path to save the chats
        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        -- Save all chats by default
        auto_save = true,
        -- Keymap to save the current chat manually
        save_chat_keymap = "sc",
        -- Set debug logging
        log_level = "DEBUG",
      }
    }
  }
})
