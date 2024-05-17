local bufferline = require "bufferline"
if not bufferline then
	return
end

vim.opt.termguicolors = true

bufferline.setup {
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
			return " " .. icon .. count
		end,
		always_show_bufferline = false,

		custom_filter = function(ft)
			if ft == "TelescopePrompt" then
				return false
			end
			return true
		end,
	},
}
