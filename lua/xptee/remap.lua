local vim = vim

vim.g.mapleader = " "

-- OPEN FILE EXPLORER
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- RESIZE WINDOW WIDTH
-- <leader> -w to decrease the size of the window by 10 columns
-- <leader> =w to increase the size of the window by 10 columns
vim.keymap.set("n", "<leader>-w", "<C-w>10><Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>=w", "<C-w>10<<Esc>", { noremap = true, silent = true })

-- SCROLL HALF PAGES
vim.keymap.set("n", "<C-q>", "<C-u>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", "<C-d>", { noremap = true, silent = true })

-- SCROLL UP BY A LINE
vim.keymap.set("n", "<C-Up>", "<C-y>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Down>", "<C-e>", { noremap = true, silent = true })

-- NVIMTREE REMAPS
vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
