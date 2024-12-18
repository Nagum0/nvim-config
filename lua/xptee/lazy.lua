local vim = vim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Currently all of my plugins and their settings are here.
-- Why? Because it's simple and I like simple stuff.

require("lazy").setup({
	-- ---------- THEMES ----------
	"blazkowolf/gruber-darker.nvim",
    "ellisonleao/gruvbox.nvim",
    {
        "Mofiqul/vscode.nvim",
        config = function()
            require("vscode").setup({
                --transparent = true,
            })
        end,
    },
    {
        "neanias/everforest-nvim",
        priority = 1000,
        config = function ()
            require("everforest").setup({
                options = {
                    background = "hard",
                },
            })
        end
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').setup({
                bold_keywords = true,
            })
        end
    },
    {
        "rebelot/kanagawa.nvim",
        config = function ()
            require("kanagawa").setup()
        end
    },
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function() end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                term_colors = true,
                transparent_background = true,
                styles = {
                    comments = { "italic" },
                    keywords = { "bold" },
                },
                integrations = {
                    treesitter = true,
                },
            })
        end
    },
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require("nightfox").setup({
                options = {
                    transparent = true,
                },
                styles = {
                    keywords = "bold",
                },
            })
        end
    },


	-- TELESCOPE
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		-- Telescope bindings
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set("n", "<leader>ff", builtin.find_files)
			vim.keymap.set('n', '<leader>fg', builtin.live_grep)
		end,
	},

	-- TREESITTER
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "c", "lua", "rust", "go" },
                highlight = {
                    enable = true,
                },
			})
		end,
	},

    -- LUALINE
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({
                theme = "vscode"
            })
        end,
    },

    -- NVIM-CMP (autocompletion)
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer", -- source for text in buffer
            "hrsh7th/cmp-path", -- source for file system paths
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
            },
            "saadparwaiz1/cmp_luasnip", -- for autocompletion
            "rafamadriz/friendly-snippets", -- useful snippets
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Loads vscode style snippets from installed plugins (e.g. friendly-snippets)
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,preview,noselect",
                },
                mapping = cmp.mapping.preset.insert({
                    -- Confirm mapping
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ['<C-o>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-l>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

                }),
                snippet = { -- configure how nvim-cmp interacts with snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                -- Sources for autocompletion
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- lsp snippets
                    { name = "luasnip" }, -- snippets
                    { name = "buffer" }, -- text within current buffer
                    { name = "path" }, -- file system paths
                }),
            })
        end
    },

    -- MASON LSP
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")

            mason.setup()

            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls",
                },
            })
        end,
    },

    -- NVIM/LSPCONFIG
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }

                    -- Show documentation for what is under cursor
                    opts.desc = "Show documentation for what is under cursor"
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

                    -- Mapping to restart lsp if necessary
                    opts.desc = "Restart LSP"
                    vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

                    -- Go to implementation
                    opts.desc = "Go to implementation"
                    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts);
                end,
            })

            -- Enable autocompletion
            local capabilities = cmp_nvim_lsp.default_capabilities()

            mason_lspconfig.setup_handlers({
                -- Default handler for installed servers
                function(servername)
                    lspconfig[servername].setup({
                        capabilities = capabilities,
                    })
                end,
            })
        end,
    },

    -- COMMENTS
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        }
    },

    -- NVIMTREE
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {
                view = {
                    side = "right",
                },
                filters = {
                    git_ignored = false,
                },
            }
        end,
    }
})
