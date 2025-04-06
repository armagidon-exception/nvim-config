return {
	{
		"OXY2DEV/markview.nvim",
		-- lazy = false, -- Recommended
		ft = "markdown", -- If you decide to lazy-load anyway
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd({ "BufFilePost", "BufNew", "BufNewFile", "FileType" }, {
				pattern = { "*" },
				callback = function()
					if vim.bo.filetype ~= "markdown" then
						return
					end

					vim.keymap.set(
						"n",
						"<leader>sp",
						"<cmd>Markview splitToggle<cr>",
						{ buffer = vim.api.nvim_get_current_buf(), desc = "Toggle split mode" }
					)
				end,
			})
			require("markview").setup {
				preview = {
					enable = true,
					modes = { "n", "no", "c" },
					hybrid_modes = {},
					splitview_winopts = { split = "left" },
				},
			}
		end,
	},
}
