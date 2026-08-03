-- Line numbering
vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
	callback = function()
		vim.opt.relativenumber = true
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
	callback = function()
		vim.opt.relativenumber = false
	end,
})

-- Cursor
vim.opt.guicursor = ""
vim.opt.nu = true

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

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80,100,120"

vim.opt.clipboard = "unnamedplus"

vim.diagnostic.config({
	virtual_lines = false,
})

vim.opt.encoding = "utf-8"
