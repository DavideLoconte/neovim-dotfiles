local dap = require('dap')

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<C-y>", dap.continue)
vim.keymap.set("n", "<C-u>", dap.step_over)
vim.keymap.set("n", "<C-i>", dap.step_into)
vim.keymap.set("n", "<C-o>", dap.repl.open)

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

dap.adapters.lldb = {
  type = 'executable',
  command = '/opt/homebrew/opt/llvm/bin/lldb-vscode',
  name = 'lldb'
}

dap.configurations.cpp = {
    {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
    return coroutine.create(function(coro)
    local opts = {}
    pickers
      .new(opts, {
        prompt_title = "Path to executable",
        finder = finders.new_oneshot_job({ "fd",  "--no-ignore", "--type", "x" }, {}),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(buffer_number)
          actions.select_default:replace(function()
            actions.close(buffer_number)
            coroutine.resume(coro, action_state.get_selected_entry()[1])
          end)
          return true
        end,
      })
      :find()
    end)
    end,
    stopOnEntry = false,
    args = {},
    },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

