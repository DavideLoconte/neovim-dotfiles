--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.g.mapleader = ","
vim.g.localleader = "\\"

-- IMPORTS
require('vars')      -- Variables
require('opts')      -- Options
require('keys')      -- Keymaps
require('plug')      -- Pluginso

local treesitter_configs = require 'nvim-treesitter.configs'

treesitter_configs.setup {
    ensure_installed = {"c", "go", "json", "html", "latex", "scala", "kotlin", "lua", "rust", "bash", "javascript", "java", "python", "cpp", "c_sharp" }, 
    highlight = {
        enable = true,
    },
    indent = {
	    enable = true,
    }	
}

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.setup()

