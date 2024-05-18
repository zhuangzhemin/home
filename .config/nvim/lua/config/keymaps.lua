-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del

-- Navigate buffers
map("n", "<A-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<A-h>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

-- Navigate Tabs
map("n", "<S-l>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<S-h>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- <F1> for <ESC> to prevent unexpected click
map("n", "<F1>", "<esc>", { desc = "Escape" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>update<cr><esc>", { desc = "Update File" })

-- SHIFT-Insert are Paste
map("n", "<S-Insert>", '"+gP', { desc = "Update File" })

-- Yank from the cursor to the end of the line, to be consistent with C and D.
map("n", "Y", "y$", { desc = "Yank To End Of Line" })

-- <Space> for page down
map("n", "<Space>", "<C-f>", { desc = "Page Down" })

-- "zw" for easier toggle wrap and no wrap
map("n", "zw", "<cmd>set wrap!<bar>set wrap?<cr>", { desc = "Toggle Wrap" })

-- Code folding options
map("n", "<leader>z0", "<cmd>set foldlevel=0<cr>", { desc = "Set Fold Level 0" })
map("n", "<leader>z1", "<cmd>set foldlevel=1<cr>", { desc = "Set Fold Level 1" })
map("n", "<leader>z2", "<cmd>set foldlevel=2<cr>", { desc = "Set Fold Level 2" })
map("n", "<leader>z3", "<cmd>set foldlevel=3<cr>", { desc = "Set Fold Level 3" })
map("n", "<leader>z4", "<cmd>set foldlevel=4<cr>", { desc = "Set Fold Level 4" })
map("n", "<leader>z5", "<cmd>set foldlevel=5<cr>", { desc = "Set Fold Level 5" })
map("n", "<leader>z6", "<cmd>set foldlevel=6<cr>", { desc = "Set Fold Level 6" })

-- -- easier copy/delete from mark a to mark b
-- map("n", "<leader>mc", "<cmd>'a,'by<cr>", { desc = "Copy from mark a to mark b" })
-- map("n", "<leader>mx", "<cmd>'a,'bd<cr>", { desc = "Delete from mark a to mark b" })

-- Better cursor navigation
map("i", "<C-h>", "<Left>", { desc = "Move Left" })
map("i", "<C-j>", "<Down>", { desc = "Move Down" })
map("i", "<C-k>", "<Up>", { desc = "Move Up" })
map("i", "<C-l>", "<Right>", { desc = "Move Right" })

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- backspace in Visual mode deletes selection
map("v", "<BS>", "d", { desc = "Delete" })

-- SHIFT-Del for Cut
map("v", "<S-Del>", '"+x', { desc = "Cut" })

-- CTRL-Insert for Copy
map("v", "<C-Insert>", '"+y', { desc = "Copy" })

-- Shif-Insert for Paste
map("c", "<S-Insert>", "<C-R>+", { desc = "Paste" })

-- Visual Block --
-- Move text up and down
map("x", "J", "<cmd>move '>+1<CR>gv-gv", { desc = "Move Down" })
map("x", "K", "<cmd>move '<-2<CR>gv-gv", { desc = "Move Up" })
map("x", "<A-j>", "<cmd>move '>+1<CR>gv-gv", { desc = "Move Down" })
map("x", "<A-k>", "<cmd>move '<-2<CR>gv-gv", { desc = "Move Up" })
