local excluded_filetypes = {
	TelescopePrompt = true,
}
return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
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
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
		end,
	},
}
