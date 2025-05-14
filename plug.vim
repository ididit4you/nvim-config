if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()
    Plug 'mhinz/vim-startify'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'nvim-lua/plenary.nvim'

    " Closes brackets automaticaly
    Plug 'windwp/nvim-autopairs'

    " Helper for better buffers expirience
    Plug 'moll/vim-bbye'

    " Completion plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvimdev/lspsaga.nvim'

    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
    Plug 'rafamadriz/friendly-snippets'

    " Linters
    Plug 'mfussenegger/nvim-lint'

    " Color schemas
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'klen/nvim-test'

    " Statusbar
    Plug 'feline-nvim/feline.nvim'

    " Nvim tree
    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua'

    " Bufferline
    Plug 'akinsho/bufferline.nvim'

    " GitSigns installation
    Plug 'lewis6991/gitsigns.nvim'

    " Toggle comments
    Plug 'numToStr/Comment.nvim'

    Plug 'windwp/nvim-ts-autotag'

    " Telescope
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
    Plug 'AckslD/nvim-neoclip.lua'

    " LSP Extensions
    Plug 'nvim-lua/lsp_extensions.nvim'

    " LSP Lines
    Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

    " LSP null-lsp
    Plug 'https://github.com/jose-elias-alvarez/null-ls.nvim'

    " LSP statusline/winbar component that uses LSP
    Plug 'SmiteshP/nvim-navic'

    Plug 's1n7ax/nvim-window-picker'

    " Plug 'easymotion/vim-easymotion'
    Plug 'phaazon/hop.nvim'

    " Switch bools
    Plug 'nat-418/boole.nvim'

    " Color schema
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }

    " Rust stuff
    Plug 'simrat39/rust-tools.nvim',

    " LLM STUFF
    " Copylot
    Plug 'zbirenbaum/copilot.lua',
    Plug 'zbirenbaum/copilot-cmp',

    " Codecompanion
    Plug 'olimorris/codecompanion.nvim'
    Plug 'OXY2DEV/markview.nvim'
    Plug 'ravitemer/codecompanion-history.nvim'

    " Zen Mode
    Plug 'folke/zen-mode.nvim',

    Plug 'famiu/bufdelete.nvim'

    " DAP stuff
    Plug 'mfussenegger/nvim-dap'
    Plug 'mfussenegger/nvim-dap-python'
    Plug 'nvim-neotest/nvim-nio'
    Plug 'rcarriga/nvim-dap-ui'

call plug#end()
