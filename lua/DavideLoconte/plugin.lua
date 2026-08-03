local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-mini/mini.nvim", version = "*" },

	{
		"0x00-ketsu/autosave.nvim",
		opts = {
			write_all_buffers = false,
			conditions = {
				exists = true,
				modifiable = true,
				filename_is_not = {},
				filetype_is_not = {},
			},
		},
	},

	{ "stevearc/conform.nvim" },

	{
		"johnfrankmorgan/whitespace.nvim",
		opts = {
			highlight = "DiffDelete",
			ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "dashboard" },
			ignore_terminal = true,
			return_cursor = true,
		},
	},

	{ "neovim/nvim-lspconfig" },
	{ "mason-org/mason.nvim" },
	{ "mason-org/mason-lspconfig.nvim" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ "ibhagwan/fzf-lua" },
	{ "MeanderingProgrammer/render-markdown.nvim" },
	{ "lervag/vimtex", lazy = false },
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c", "cpp", "python", "javascript", "typescript", "rust",
					"html", "css", "markdown", "markdown_inline", "json", "yaml",
					"lua", "bash", "cmake", "rst", "vim", "vimdoc",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
})

-- Mini packages
local icons = require("mini.icons")
icons.setup()
icons.mock_nvim_web_devicons()
require("mini.statusline").setup()
require("mini.diff").setup()
require("mini.pairs").setup()
