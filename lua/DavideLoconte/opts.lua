-- Color scheme
vim.cmd([[set background=dark]])
vim.cmd([[colorscheme gruvbox]])

-- Transparent background, reapplied on every colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		for _, group in ipairs({ "Normal", "NormalFloat", "FloatBorder", "SignColumn", "EndOfBuffer" }) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
	end,
})
vim.cmd([[doautocmd ColorScheme]])

-- Line numbering: absolute while typing, relative otherwise
vim.opt.nu = true
vim.opt.relativenumber = true

vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
	callback = function()
		vim.wo.relativenumber = true
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
	callback = function()
		vim.wo.relativenumber = false
	end,
})

-- Cursor
vim.opt.guicursor = ""

-- Tab behaviour
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

-- ponytail: replaces whitespace.nvim
vim.opt.list = true
vim.opt.listchars = { trail = "·", nbsp = "␣" }

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "100"

vim.opt.clipboard = "unnamedplus"

-- Flash what was yanked
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.diagnostic.config({
	virtual_lines = false,
})
