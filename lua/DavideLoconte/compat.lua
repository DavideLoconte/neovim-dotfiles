-- OS-specific variables, kept in one place instead of scattered if/else.
local sysname = vim.uv.os_uname().sysname

local M = {}

if sysname == "Linux" then
	M.vimtex_view_method = "zathura"
	M.clipboard_tool = "wl-clipboard/xclip"
	M.clipboard_bin = "xclip" -- also accepts wl-copy, checked separately below
elseif sysname == "Darwin" then
	M.vimtex_view_method = "skim"
	M.vimtex_view_skim_sync = 1 -- forward search after compile
	M.vimtex_view_skim_activate = 1 -- focus Skim on forward search
	M.clipboard_tool = "pbcopy (nativo)"
	M.clipboard_bin = "pbcopy"
else -- Windows
	M.vimtex_view_method = "general"
	M.vimtex_view_general_viewer = "SumatraPDF"
	M.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
	M.clipboard_tool = "win32yank"
	M.clipboard_bin = "win32yank"
end

return M
