local osname = vim.loop.os_uname().sysname

if osname == "Windows_NT" then
    return {
        home = os.getenv("userprofile"),
        lldb_comapt = "C:\\Program Files\\LLVM\\bin\\lldb-dap.exe",
    }
else
    return {
        home = os.getenv("HOME"),
        lldb_compat = '/opt/homebrew/opt/llvm/bin/lldb-dap',
    }
end
