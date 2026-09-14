local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
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
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, lazy = false },
	{ "nvim-mini/mini.nvim", version = "*" },

	{ "stevearc/conform.nvim" },

	{ "neovim/nvim-lspconfig" },
	{ "mason-org/mason.nvim" },
	{ "mason-org/mason-lspconfig.nvim" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ "ibhagwan/fzf-lua" },
	{ "MeanderingProgrammer/render-markdown.nvim" },
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "skim"
			vim.g.vimtex_view_skim_sync = 1 -- forward search after compile
			vim.g.vimtex_view_skim_activate = 1 -- focus Skim on forward search
		end,
	},
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
require("mini.surround").setup()
require("mini.files").setup()
