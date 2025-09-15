lua << EOF
  vim.g.loaded = 1
  vim.g.loaded_netrwPlugin = 1
EOF

" Enable line numbers
set number

" Disable swap files
set noswapfile

" Keep 7 lines visible when scrolling
set scrolloff=7

" Set terminal title
set title

" Set dark background for better contrast
set background=dark

" Ignore case in search patterns
set ignorecase

" Open new splits to the right and below
set splitright
set splitbelow

" Configure tab behavior
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set signcolumn=yes

" Use Unix file format
set fileformat=unix

" Highlight column 80 for better readability
set colorcolumn=80

" Highlight the current line
set cursorline

" Use system clipboard
set clipboard+=unnamedplus

" Disable backup files
set nobackup
set backupskip=/tmp/*,/private/tmp/*

" Enable filetype-specific indent files
filetype indent on

" Limit syntax highlighting to 128 columns
set synmaxcol=128
syntax sync minlines=256

" Show invisible characters
set list
set listchars=tab:>-,trail:⎵,nbsp:⎵

" Set timeout for mapped sequences
set timeoutlen=300

" Enable relative line numbers
set number relativenumber

" Enable spell checking for US English
set spelllang=en_us
set spell

" Enable true color support if available
if (has('termguicolors'))
  set termguicolors
endif

" Specify Python 3 host program
let g:python3_host_prog = '/Users/developer/.pyenv/versions/py3nvim'

" Load plugins and configurations
runtime ./plug.vim

" Platform-specific configurations
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif

" Load color schemes
runtime ./colors/tokionight.lua

" Load additional configurations

runtime ./maps.lua
runtime ./nvim_tree.lua
runtime ./render-markdown.lua
runtime ./treesitter.lua
runtime ./diagnostics.lua
runtime ./bufferline.lua
runtime ./feline.lua
runtime ./masson.lua
runtime ./nvim_lint.lua
runtime ./lsp/navic.lua
runtime ./lsp/init.lua
runtime ./lsp/lsp_lines.lua
runtime ./lsp/saga.lua
runtime ./telescope.lua
runtime ./neoclip.lua
runtime ./cmp.lua
runtime ./comment.lua
runtime ./gitsigns.lua
runtime ./ts_autotag.lua
runtime ./nvim-autopairs.lua
runtime ./hop.lua
runtime ./bool.lua
runtime ./copilot.lua
runtime ./dap.lua
runtime ./codecompanion/init.lua
runtime ./mcp_hub.lua
runtime ./floatingterminal.lua
runtime ./ui/init.lua

" Apply the selected color scheme
colorscheme tokyonight
