local osname = vim.loop.os_uname().sysname

if osname == "Windows_NT" then
    return {
        home = os.getenv("userprofile"),
        lldb_vscode = "C:\\Program Files\\LLVM\\bin\\lldb-vscode.exe",
    }
else 
    return {
        home = os.getenv("HOME"),
        lldb_vscode = '/opt/homebrew/opt/llvm/bin/lldb-vscode',
    } 
end
