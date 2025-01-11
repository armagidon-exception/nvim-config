return {
	{
		"lervag/vimtex",
		ft = { "latex", "tex" },
		init = function()
			vim.g.vimtex_compiler_enabled = 0
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.highlight = vim.tbl_deep_extend("force", opts.highlight or {}, {
				disable = { "latex", "tex" },
			})
		end,
	},
}
