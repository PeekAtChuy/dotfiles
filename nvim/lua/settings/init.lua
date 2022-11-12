vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 2

vim.opt.laststatus = 3
vim.g.hlsearch = true
vim.g.insearch = true
vim.g.ignorecase = true
vim.g.smartcase = true
vim.g.cmdheight = 0
vim.g.clipboard = unnamedplus
vim.opt.wrap = true
vim.opt.scrolloff = 5
vim.opt.fileencoding = 'utf-8'
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false

vim.opt.hidden = true
vim.notify = require("notify")

vim.cmd('filetype plugin indent on') -- allow auto-indenting depending on filetype
vim.cmd('filetype plugin on')
