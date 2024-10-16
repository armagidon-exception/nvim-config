return {
	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { { "folke/noice.nvim" } },
		opts = function(_, opts)
			local tbl_utils = require "utils.table"
			local noice = require "noice"

			local noice_status = noice.api.status.mode

			tbl_utils.merge_onto(opts, {
				options = {
					component_separators = { left = "", right = "" },
					section_separators = { left = "|", right = "|" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_x = { "encoding", "fileformat", "filetype", { noice_status.get, cond = noice_status.has } },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},
}
