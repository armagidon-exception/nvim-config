local autopairs_status, autopairs = pcall(require, 'nvim-autopairs')
local cmp_status, cmp = pcall(require, 'cmp')

if not cmp_status or not autopairs_status then
    return
end
local cmp_autopairs = require'nvim-autopairs.completion.cmp'

autopairs.setup({
    check_ts =  true,
    enable_check_bracket_line = false,
})

if not _G.nvim_autopairs_cmp_setup then
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    _G.nvim_autopairs_cmp_setup = true
end
