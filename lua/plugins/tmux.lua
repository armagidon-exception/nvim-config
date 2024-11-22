return {
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
		},
		keys = {
			{ "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
		},

		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end,
		config = function()
			local keymap = vim.keymap.set
			keymap("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
			keymap("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
			keymap("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })
			keymap("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })
		end,
	},
}
