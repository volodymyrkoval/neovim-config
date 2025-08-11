-- Set leader key before loading any configurations
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core editor settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true

-- Additional modern settings for better experience
vim.opt.relativenumber = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

-- Load configurations
require("config.lazy")
require("config.keymaps")
