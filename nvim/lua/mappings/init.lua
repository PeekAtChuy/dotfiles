local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

map('n', '<C-n>', ':NvimTreeFindFileToggle<CR>', opts)
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>gd', ':lua vim.diagnostic.open_float()', opts)
map('n', 'q', ':HopChar2<CR>', {})
map('n', '<leader>gn', '<cmd>BufferPrevious<CR>', opts)
map('n', '<leader>gb', '<cmd>BufferNext<CR>', opts)
map('n', '<leader>del', '<cmd>BufferClose<CR>', opts)
map('n', '<leader>1', '<cmd>BufferGoto 1<CR>', opts)
map('n', '<leader>2', '<cmd>BufferGoto 2<CR>', opts)
map('n', '<leader>3', '<cmd>BufferGoto 3<CR>', opts)
map('n', '<leader>4', '<cmd>BufferGoto 4<CR>', opts)
map('n', '<leader>5', '<cmd>BufferGoto 5<CR>', opts)
map('n', '<leader>6', '<cmd>BufferGoto 6<CR>', opts)
map('n', '<leader>7', '<cmd>BufferGoto 7<CR>', opts)
map('n', '<leader>8', '<cmd>BufferGoto 8<CR>', opts)
map('n', '<leader>9', '<cmd>BufferGoto 9<CR>', opts)
