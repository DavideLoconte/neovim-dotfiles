-- Leaders must be set before lazy.nvim loads plugins
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("DavideLoconte.plugin")
require("DavideLoconte.opts")
require("DavideLoconte.remap")
require("DavideLoconte.lsp")
