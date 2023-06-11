local module = {}


local keymap = vim.keymap
local default_opts = { remap = false, silent = true }

function module.map(mode, key, command, opts, desc)
    mode = mode or 'n'
    key = key or ''
    command = command or function() end
    opts = opts or {}
    opts = vim.tbl_deep_extend("force", opts, default_opts)
    desc = desc or ''
    local wk = require'utils.importer'.import('which-key')
    if wk then 
        wk.register({ [key] = { command, desc } })
    else 
        keymap.set(mode, key, command, opts)
    end
end


-- Equivalent to nnoremap with some addtitional options
-- @param key: string - wtf
function module.nmap(key, command, opts, desc)
    module.map('n', key, command, opts, desc)
end

return module
