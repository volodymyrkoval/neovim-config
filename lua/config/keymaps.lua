-- Key mappings configuration
local keymap = vim.keymap.set

-- General keymaps
keymap("n", "<leader>w", "<cmd>write<cr>", { desc = "Save buffer" })
keymap("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
keymap("n", "<leader>Q", "<cmd>quitall<cr>", { desc = "Quit all" })
keymap("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })

-- Buffer navigation
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Better indenting
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Move lines
keymap("n", "<A-j>", ":m .+1<cr>==", { desc = "Move line down" })
keymap("n", "<A-k>", ":m .-2<cr>==", { desc = "Move line up" })
keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Toggle options
keymap("n", "<leader>tw", "<cmd>set wrap!<cr>", { desc = "Toggle line wrapping" })