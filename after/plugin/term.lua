function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

require("toggleterm").setup {
	open_mapping = [[<c-\>]],
	autochdir = true,
	start_in_insert = true,
	insert_mappings = true,
	terminal_mappings = true,
	persist_mode = false,
	direction = "float",
}

vim.api.nvim_create_user_command("VTerm", function(context)
    vim.cmd("TermExec cmd='"..context.args.."' direction='vertical' size=100")
end, { desc = "Runs command in vertically split terminal", force = true, nargs = "+" })
