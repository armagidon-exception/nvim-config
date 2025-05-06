return {
	"yunusey/codeforces-nvim",
	dependencies = { "nvim-lua/plenary.nvim" }, -- optional, used for testing
	config = function()
		require("codeforces-nvim").setup {
			use_term_toggle = false,
			cf_path = vim.fn.expand "~/Documents/CP/",
			timeout = 15000,
			extractor_path = vim.fn.expand "~/.cargo/bin/codeforces-extractor",
            extension = 'c',
			compiler = {
				cpp = { "g++", "@.cpp", "-o", "@" },
				py = {},
				c = { "gcc", "-ggdb", "-pedantic", "-Wall", "@.c", "-o", "@", "-fsanitize=address,undefined" },
			},
			run = {
				cpp = { "@" },
				c = { "@" },
				py = { "python3", "@.py" },
			},
			notify = function(title, message, type)
				local notify = require "notify"
				if message == nil then
					notify(title, type, {
						render = "minimal",
					})
				else
					notify(message, type, {
						title = title,
					})
				end
			end,
		}
	end,
}
