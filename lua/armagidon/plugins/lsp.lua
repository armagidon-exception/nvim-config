return {
	{
		"williamboman/mason.nvim",
		config = function(_, opts)
			local mason = require "mason"
			mason.setup(opts)
		end,
		lazy = true,
	},
}
