local navic = require("nvim-navic")

local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local bufopts = { noremap = true, silent = false }
    -- Go to definition
    vim.api.nvim_set_keymap(
      'n', 'gd',
      '<cmd>lua vim.lsp.buf.definition()<CR>',
      bufopts
    )
    vim.api.nvim_set_keymap(
      'n', 'gf',
      '<cmd>lua vim.lsp.buf.declaration()<CR>',
      bufopts
    )
  end
})

-- LUA
vim.lsp.enable('lua_ls', {
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
    -- Create buffer-local autocommand for formatting
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
    })
  end,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})

-- RUST
vim.lsp.enable('rust_analyzer', {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
  ,
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
      checkOnSave = {
        command = "clippy"
      },
    }
  }
})

-- PYTHON
vim.lsp.enable('pyright', {
  -- capabilities = capabilities,
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end,
  python = {
    analysis = {
      autoSearchPaths = false,
      diagnosticMode = "workspace",
      useLibraryCodeForTypes = true
    }
  }
})

vim.lsp.enable('arduino_language_server', {
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
})

-- TS
vim.lsp.enable('ts_ls', {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end,
  settings = {
    javascript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
})

-- Angular
vim.lsp.enable('angularls', {
  -- capabilities = capabilities,
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end,
})

-- Volar
vim.lsp.enable('vls', {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end,
})

-- ESLINT (JS, TS)
local es_on_attach = vim.lsp.config.eslint.on_attach
vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    if not es_on_attach then return end

    es_on_attach(client, bufnr)
  end,
})
