local lsp_signature_status, lsp_signature = pcall(require, 'lsp_signature')

if not lsp_signature_status then
    return
end

lsp_signature.setup({
    bind = true,
    handle_opts = {
        border = 'rounded'
    },
    fix_pos = true,
    floating_window_off_x = 5,
    floating_window_off_y = function()
        local pumheight = vim.o.pumheight
        local winline = vim.fn.winline()
        local winheight = vim.fn.winheight(0)

        if winline - 1 < pumheight then
            return pumheight
        end

        if winheight - winline < pumheight then
            return -pumheight
        end
        return 0
    end,
})
