-- Remap leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Map neovim functions
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "jj", "<ESC>")
vim.keymap.set("n", "<leader>h", vim.diagnostic.open_float)

-- Search mapping
local fzf = require("fzf-lua")

local file_icons = true

-- Resolve the current buffer's directory at call time, not config load.
local function file_dir()
	return vim.b.netrw_curdir or vim.fn.expand("%:p:h")
end

vim.keymap.set("n", "<leader>ff", function()
	fzf.files({
		cwd = file_dir(),
		file_icons = false,
	})
end)

vim.keymap.set("n", "<leader>fh", function()
	fzf.files({
		cwd = "~",
		file_icons = file_icons,
	})
end)

vim.keymap.set("n", "<leader>fg", function()
	fzf.git_files({
		cwd = file_dir(),
		file_icons = file_icons,
	})
end)

vim.keymap.set("n", "<leader>gg", function()
	fzf.live_grep({
		cwd = file_dir(),
		file_icons = file_icons,
	})
end)

vim.keymap.set("n", "<leader>rh", function()
	fzf.live_grep({
		cwd = "~",
		file_icons = file_icons,
	})
end)
