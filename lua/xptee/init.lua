local vim = vim

-- DISABELINE NETRW BECAUSE WE HAVE NVIMTREE
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("xptee.remap")
require("xptee.options")
require("xptee.lazy")
require("xptee.color")
