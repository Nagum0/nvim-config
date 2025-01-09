local vim = vim
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

-- OPEN FILE EXPLORER
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- RESIZE WINDOW WIDTH
-- <leader> -w to decrease the size of the window by 10 columns
-- <leader> =w to increase the size of the window by 10 columns
vim.keymap.set("n", "<leader>-w", "<C-w>10><Esc>", opts)
vim.keymap.set("n", "<leader>=w", "<C-w>10<<Esc>", opts)

-- SCROLL HALF PAGES
vim.keymap.set("n", "<C-q>", "<C-u>", opts)
vim.keymap.set("n", "<C-s>", "<C-d>", opts)

-- SCROLL UP BY A LINE
vim.keymap.set("n", "<C-Up>", "<C-y>", opts)
vim.keymap.set("n", "<C-Down>", "<C-e>", opts)

-- NVIMTREE REMAPS
vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", opts)

-- MOVEMENT KEY REBINDS
vim.keymap.set("n", "o", "k", opts)
vim.keymap.set("n", "l", "j", opts)
vim.keymap.set("n", "k", "h", opts)
vim.keymap.set("n", ";", "l", opts)
vim.keymap.set("v", "o", "k", opts)
vim.keymap.set("v", "l", "j", opts)
vim.keymap.set("v", "k", "h", opts)
vim.keymap.set("v", ";", "l", opts)

-- BUFFERLINE KEYMAPS
vim.keymap.set("n", "<leader>bl", ":BufferLinePick<CR>", opts)
vim.keymap.set("n", "<leader>cl", ":BufferLinePickClose<CR>", opts)
