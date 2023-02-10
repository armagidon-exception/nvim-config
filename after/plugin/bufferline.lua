local bufferline_status, bufferline = pcall(require, 'cokeline')
local get_hex = require('cokeline/utils').get_hex
if not bufferline_status then
    return
end


vim.cmd('colorscheme carbonfox')
bufferline.setup({
    components = {
        {
            text = '',
            fg = get_hex('ColorColumn', 'bg'),
            bg = get_hex('Normal', 'bg'),
        },
        {
            text = function(buffer)
                return buffer.devicon.icon
            end,
            fg = function(buffer)
                return buffer.devicon.color
            end,
        },
        {
            text = function(buffer) return buffer.filename .. ' ' end,
        },
        {
            text = '',
            fg = get_hex('ColorColumn', 'bg'),
            bg = get_hex('Normal', 'bg'),
        },
    },
    default_hl = {
        fg = function(buffer)
            return
            buffer.is_focused
            and get_hex('Normal', 'fg')
            or get_hex('Comment', 'fg')
        end,
        bg = get_hex('ColorColumn', 'bg'),
    },
})
