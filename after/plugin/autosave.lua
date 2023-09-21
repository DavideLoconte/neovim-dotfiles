local autosave = require('autosave')

autosave.setup {
    write_all_buffers = true,
    prompt_message = nil,
    conditions = {
        exists = false,
        modifiable = true
    },
}
