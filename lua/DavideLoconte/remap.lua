vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('n', '<C-s>', ":w!<CR>")
vim.keymap.set('n', '<C-f>', ":ClangFormat<CR>")
