return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"folke/noice.nvim",
	},
	opts = function(_, opts)
		local noice = require "noice"
		local noice_status = noice.api.status.command
		table.insert(
			opts.sections.lualine_x,
			{ color = { bg = "#414650", fg = "#fff" }, noice_status.get, cond = noice_status.has }
		)
	end,
}
