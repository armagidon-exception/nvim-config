function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

require("toggleterm").setup {
	open_mapping = [[<c-\>]],
	autochdir = true,
	start_in_insert = true,
	insert_mappings = true,
	terminal_mappings = true,
	persist_mode = false,
    direction = 'float',
}
