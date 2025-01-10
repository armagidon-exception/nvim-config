return {
	{
		"lervag/vimtex",
		ft = { "latex", "tex" },
		init = function()
			vim.g.vimtex_compiler_enabled = 0
		end,
	},
}
