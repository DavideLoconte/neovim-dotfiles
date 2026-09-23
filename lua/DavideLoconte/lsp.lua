local servers = {
	"clangd", -- C, C++
	"ruff",
	"pyright", -- Python
	"ts_ls", -- JavaScript, TypeScript
	"rust_analyzer", -- Rust
	"html", -- HTML
	"cssls", -- CSS
	"marksman", -- Markdown
	"texlab", -- LaTeX
	"cmake", -- CMake
	"lua_ls", -- Lua
	"bashls", -- Bash
	"jsonls", -- JSON
	"yamlls", -- YAML
	"jdtls", -- Java
	"copilot", -- GitHub Copilot inline suggestions, sign in with :LspCopilotSignIn
}

-- Install lsps
require("mason").setup({})

require("mason-lspconfig").setup({
	ensure_installed = servers,
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"clang-format", -- C, C++
		"prettier", -- JavaScript, TypeScript, HTML, CSS, Markdown, JSON, YAML
		"stylua", -- Lua
		"shfmt", -- Bash
		"cmakelang", -- CMake
		"latexindent", -- LaTeX
		"google-java-format", -- Java
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

-- Pyright type-checks only, ruff owns lint and format
vim.lsp.config.pyright = {
	settings = {
		pyright = { disableOrganizeImports = true },
		python = { analysis = { ignore = { "*" } } },
	},
}

-- Enable lsps
vim.lsp.enable(servers)

-- Sort completions: exact-case prefix match, then any-case prefix, then the
-- rest; ties keep the server's own ranking (sortText)
local function prefix_rank(item, prefix)
	local lsp_item = vim.tbl_get(item, "user_data", "nvim", "lsp", "completion_item") or {}
	local text = lsp_item.filterText or item.word
	if vim.startswith(text, prefix) then
		return 0
	elseif vim.startswith(text:lower(), prefix:lower()) then
		return 1
	end
	return 2
end

local function compare_completions(a, b)
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local prefix = vim.api.nvim_get_current_line():sub(1, col):match("[%w_]*$")
	local ra, rb = prefix_rank(a, prefix), prefix_rank(b, prefix)
	if ra ~= rb then
		return ra < rb
	end
	local ia = vim.tbl_get(a, "user_data", "nvim", "lsp", "completion_item") or {}
	local ib = vim.tbl_get(b, "user_data", "nvim", "lsp", "completion_item") or {}
	return (ia.sortText or ia.label or a.word) < (ib.sortText or ib.label or b.word)
end

-- Enable autocomplete
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and vim.lsp.completion then
			vim.lsp.completion.enable(true, client.id, event.buf, {
				autotrigger = true,
				cmp = compare_completions,
			})
		end
	end,
})
vim.o.completeopt = "menuone,noselect,fuzzy"
vim.o.pumheight = 10

-- autotrigger only fires on server trigger characters ("." "->"...);
-- 'autocomplete' opens the menu on every keypress, LSP (omnifunc) first,
-- then at most 5 words from each buffer source
vim.o.autocomplete = true
vim.o.complete = "o,.^5,w^5,b^5"

-- Copilot ghost text
vim.lsp.inline_completion.enable()

-- Tab: accept Copilot suggestion, else next menu item, else a real Tab
vim.keymap.set("i", "<Tab>", function()
	if vim.lsp.inline_completion.get() then
		return
	end
	return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
	return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true })

-- Enable autoformat
require("conform").setup({
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
		python = { "ruff_format" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		rust = { "rustfmt" },
		html = { "prettier" },
		css = { "prettier" },
		markdown = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		tex = { "latexindent" },
		cmake = { "cmake_format" },
		lua = { "stylua" },
		sh = { "shfmt" },
		java = { "google-java-format" },
	},
	format_on_save = { lsp_format = "fallback", timeout_ms = 1000 },
})
