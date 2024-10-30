local dap = require('dap')
local compat = require('DavideLoconte.compat')

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<C-j>", dap.step_over)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<C-o>", dap.repl.open)

dap.adapters.lldb = {
  type = 'executable',
  command = compat.lldb_dap, -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.cpp = {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
