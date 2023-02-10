local toggleterm_status, toggleterm = pcall(require, 'toggleterm')
if not toggleterm_status then
    return
end


toggleterm.setup {
    open_mapping = [[<c-\>]],
    direction = 'float',
    start_in_insert = true,
    autochdir = true,
}
