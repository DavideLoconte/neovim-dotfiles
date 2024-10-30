vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('n', '<C-s>', ":w!<CR>")
vim.keymap.set('n', '<C-f>', ":ClangFormat<CR>")


vim.keymap.set("i", "<C-space>", function() return vim.fn['codeium#Accept']() end, { expr = true })
vim.keymap.set("i", "<C-h>", function() return vim.fn['codeium#Clear']() end, { expr = true })
vim.keymap.set("i", "<C-j>", function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
vim.keymap.set("i", "<C-k>", function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
