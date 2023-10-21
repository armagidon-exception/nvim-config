local map = require "utils.mappings"

require("toggleterm").setup {
	open_mapping = [[<c-\>]],
	autochdir = true,
	start_in_insert = true,
	insert_mappings = false,
	terminal_mappings = true,
	persist_mode = false,
	direction = "float",
	on_open = function(terminal)
		local buf = terminal.bufnr
		map("t", "<esc>", "<c-\\><c-n>", { buffer = buf })
		map("n", "q", function()
			terminal:toggle()
		end, { buffer = buf })
		map("t", "<c-\\>", function()
			terminal:toggle()
		end, { buffer = buf })
	end,
}
