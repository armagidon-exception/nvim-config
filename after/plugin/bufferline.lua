local bufferline = require'utils.importer'.import('bufferline')
if not bufferline then return end

vim.opt.termguicolors = true
bufferline.setup {
    options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        color_icons = true,
        show_close_icon = false,
        show_buffer_close_icons = false,
        right_mouse_command = nil,
        left_mouse_command = nil,
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or ""
            return " " .. icon .. count
        end
    }        
}

