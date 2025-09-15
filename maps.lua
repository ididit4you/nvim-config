local opts = { noremap = true, silent = false }
-- Shorten nvim_set_keymap name
local keymap = vim.api.nvim_set_keymap

-- Remap leader key to leader
keymap("", "<leader>", "<Nop>", opts)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
-- Close buffer
keymap("n", "gw", "<cmd>Bdelete<CR>", opts)
keymap("i", "gw", "<cmd>Bdelete<CR>", opts)
keymap("v", "gw", "<cmd>Bdelete<CR>", opts)

keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)


keymap("n", "tr", ":set relativenumber!<CR>", opts)

-- line or visually selected block - alt+j/k
-- TODO: Alt does not work
-- inoremap <A-j> <Esc>:m .+1<CR>==gi
-- inoremap <A-k> <Esc>:m .-2<CR>==gi
-- vnoremap <A-j> :m '>+1<CR>gv=gv
-- vnoremap <A-k> :m '<-2<CR>gv=gv
-- move split panes to left/bottom/top/right
keymap("n", "<A-h>", "<C-W>h", opts)
keymap("n", "<A-j>", "<C-W>j", opts)
keymap("n", "<A-k>", "<C-W>k", opts)
keymap("n", "<A-l>", "<C-W>l", opts)
-- move between panes to left/bottom/top/right
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- Press i to enter insert mode, and jk(kj) to exit insert mode.
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in ident mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Apply macro over visual range
keymap('x', '@', '":norm @" . getcharstr() . "<cr>"', { expr = true, silent = false, noremap = true })

-- Diagnostics
keymap('n', '<leader>de', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '<leader>dl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

keymap('n', '<leader>]', ':BufferLineMoveNext<CR>', opts)
keymap('n', '<leader>[', ':BufferLineMovePrev<CR>', opts)
-- TELESCOPE
keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
keymap('', '<leader>fp', '<cmd>Telescope neoclip<cr>', opts)

-- LSP STUFF
keymap('n', '<leader>df', '<cmd>lua vim.lsp.buf.format {async = true}<CR>', opts)
-- LSP LINES
keymap('n', "<leader>ll", '<cmd>lua require("lsp_lines").toggle()<CR>', opts)
-- LSP SAGA
keymap("n", "gh", "<cmd>Lspsaga finder<CR>", opts)
keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
keymap("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)
keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

-- Hop
keymap('', 'ff',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>"
  , opts)
keymap('', 'FF',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>"
  , opts)
keymap('', 'tt',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })<cr>"
  , opts)
keymap('', 'TT',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
  , opts)
keymap('', '<leader><leader>', "<cmd>lua require'hop'.hint_char2({})<cr>", opts)
keymap('', '<leader>l', "<cmd>HopLineStart<cr>", opts)

-- NvimTree
keymap('n', '<leader>tt', '<cmd>NvimTreeToggle<CR>', opts)

-- Tests
keymap('n', '<leader>tn', '<cmd>TestNearest<CR>', opts)

-- Copilot stuff
keymap("i", "<leader>w", "<cmd> lua require('copilot.suggestion').accept_word()<CR>", opts)
keymap("i", "<leader>l", "<cmd> lua require('copilot.suggestion').accept_line()<CR>", opts)
keymap("i", "<leader>a", "<cmd> lua require('copilot.suggestion').accept()<CR>", opts)
keymap("n", "<leader>ct", "<cmd> lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)
keymap("i", "<leader>n", "<cmd> lua require('copilot.suggestion').next()<CR>", opts)


-- ZenMode
keymap('', "gz", ":ZenMode<CR>", opts)


if vim.lsp.inlay_hint then
  vim.keymap.set('n', '<leader>uh', function()
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
  end, { desc = 'Toggle Inlay Hints' })
end


-- Terminal stuff

-- Exit terminal mode
keymap('', '<leader>q', '<cmd>Floaterminal<CR>', opts)
keymap("t", "<esc><esc>", "<c-\\><c-n>", opts)
