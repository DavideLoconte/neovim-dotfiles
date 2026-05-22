-- Install lsps
require("mason").setup({})

require("mason-lspconfig").setup({
	ensure_installed = {
		"clangd", -- C, C++
		"ruff",
		"pyright", -- Python
		"ts_ls", -- JavaScript, TypeScript
		"rust_analyzer", -- Rust
		"html", -- HTML
		"cssls", -- CSS
		"marksman", -- Markdown
		"texlab", -- LaTeX
		"esbonio", -- reStructuredText
		"cmake", -- CMake
		"lua_ls", -- Lua
		"bashls", -- Bash
		"jsonls", -- JSON
		"yamlls", -- YAML
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"clang-format", -- C, C++
		"prettier", -- JavaScript, TypeScript, HTML, CSS, Markdown, JSON, YAML
		"stylua", -- Lua
		"shfmt", -- Bash
		"cmakelang", -- CMake
		"latexindent", -- LaTeX
	},
})

-- Specific lua config
vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}

-- Enable lsps
vim.lsp.enable({
	"clangd", -- C, C++
	"ruff",
	"pyright",
	"uv", -- Python
	"ts_ls", -- JavaScript, TypeScript
	"rust_analyzer", -- Rust
	"html", -- HTML
	"cssls", -- CSS
	"marksman", -- Markdown
	"texlab", -- LaTeX
	"esbonio", -- reStructuredText
	"cmake", -- CMake
	"lua_ls", -- Lua
	"bashls", -- Bash
	"jsonls", -- JSON
	"yamlls", -- YAML
})

-- Enable autocomplete
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and vim.lsp.completion then
			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
		end
	end,
})
vim.o.completeopt = "menuone,noselect,fuzzy"

-- Enable autoformat
require("conform").setup({
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
		python = { "ruff_format" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		rust = { "rustfmt" },
		html = { "prettier" },
		css = { "prettier" },
		markdown = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		tex = { "latexindent" },
		rst = { "rstfmt" },
		cmake = { "cmake_format" },
		lua = { "stylua" },
		sh = { "shfmt" },
	},
	{},
})

-- Auto format on save (overrides the :w :wa :wq commands).
-- Auto format will not be triggered by autosave
vim.api.nvim_create_user_command("FormatWrite", function()
	require("conform").format({ lsp_fallback = true, async = false })
	vim.cmd("write")
end, {})

vim.api.nvim_create_user_command("FormatWriteQuit", function()
	require("conform").format({ lsp_fallback = true, async = false })
	vim.cmd("wq")
end, {})

vim.api.nvim_create_user_command("FormatWriteAll", function()
	require("conform").format({ lsp_fallback = true, async = false })
	vim.cmd("wa")
end, {})

vim.keymap.set("ca", "wa", "FormatWriteAll")
vim.keymap.set("ca", "wq", "FormatWriteQuit")
vim.keymap.set("ca", "w", "FormatWrite")
