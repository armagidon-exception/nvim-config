return {
	{
		"akinsho/toggleterm.nvim",
		keys = {
			"<c-\\>",
		},
		opts = {
			open_mapping = [[<c-\>]],
			autochdir = true,
			start_in_insert = true,
			insert_mappings = false,
			terminal_mappings = true,
			persist_mode = false,
			direction = "float",
			on_open = function(terminal)
				local map = require "utils.mappings"
				local buf = terminal.bufnr
				map.create_mappings {
					{
						mode = "t",
						keys = "<esc>",
						command = "<c-\\><c-n>",
						opts = { buffer = buf },
					},
					{
						mode = "n",
						keys = "q",
						command = function()
							terminal:toggle()
						end,
						opts = { buffer = buf },
					},
					{
						mode = "t",
						keys = "<c-\\>",
						command = function()
							terminal:toggle()
						end,
						opts = { buffer = buf },
					},
				}
			end,
		},
	},
}
