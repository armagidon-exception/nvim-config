local module = {}


local keymap = vim.keymap
local default_opts = { remap = false, silent = true }

function module.map(mode, key, command, opts)
    mode = mode or 'n'
    key = key or ''
    command = command or function() end
    opts = {}
    local opts = vim.tbl_deep_extend("force", opts, default_opts)
    keymap.set(mode, key, command, opts)
end



-- Equivalent to nnoremap with some addtitional options
-- @param key: string - wtf
function module.nmap(key, command, opts)
    module.map('n', key, command, opts)
end

return module
