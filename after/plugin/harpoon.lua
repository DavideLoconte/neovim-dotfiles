local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end)
