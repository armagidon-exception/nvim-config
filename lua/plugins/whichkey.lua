return {

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			marks = false,
			registers = false,
			spec = {
				{ "<leader>o", group = "overseer" },
			},
		},
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show { global = false }
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
