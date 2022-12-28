local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

map('n', '<C-n>', ':NvimTreeFindFileToggle<CR>', opts)
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>gd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
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
vim.keymap.set("n", "<leader>s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
vim.keymap.set("x", "<leader>s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
--refactoring
--- Remaps for the refactoring operations currently offered by the plugin
vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
    { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "<leader>rf",
    [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
    { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
    { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
    { noremap = true, silent = true, expr = false })

-- Extract block doesn't need visual mode
vim.api.nvim_set_keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
    { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
    { noremap = true, silent = true, expr = false })

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.api.nvim_set_keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
    { noremap = true, silent = true, expr = false })
-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
    "v",
    "<leader>rr",
    "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    { noremap = true }
)
