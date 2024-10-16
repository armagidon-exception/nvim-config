local tbl = require "utils.table"
return {

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		lazy = false,

		init = function()
			vim.opt.termguicolors = true
		end,
		opts = function(_, opts)
			local excluded_filetypes = {
				TelescopePrompt = true,
			}
			tbl.merge_onto(opts, {
				options = {
					mode = "buffers",
					diagnostics = "nvim_lsp",
					color_icons = true,
					show_close_icon = false,
					show_buffer_close_icons = false,
					right_mouse_command = nil,
					left_mouse_command = nil,
					diagnostics_update_in_insert = false,
					themable = true,
					diagnostics_indicator = function(count, level)
						local icon = level:match "error" and " " or ""
						return string.format(" %s %s", icon, count)
					end,
					always_show_bufferline = false,
					custom_filter = function(ft)
						return not excluded_filetypes[ft]
					end,
				},
			})
		end,
		config = function(_, opts)
			local bufferline = require "bufferline"
			bufferline.setup(opts)
		end,
	},
}
