local notify = require "notify"
notify.setup {
	timeout = 10000,
}

require("noice").setup {
	routes = {
		{
			filter = {
				event = "notify",
				find = "No information available",
			},
			opts = { skip = true },
		},
	},
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		signature = {
			enabled = true,
		},
	},
	health = {
		checker = true,
	},
	cmdline = {
		format = {
			IncRename = {
				pattern = "^:%s*IncRename%s+",
				icon = " ",
				conceal = true,
				opts = {
					relative = "cursor",
					size = { min_width = 20 },
					position = {
						col = 0,
						row = -3,
					},
				},
			},
		},
	},
	messages = {
		enabled = true,
		view = "notify", -- default view for messages
		view_error = "mini", -- view for errors
		view_warn = "notify", -- view for warnings
		view_history = "messages", -- view for :messages
		view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
	},
	views = {
		cmdline_popup = {
			position = {
				row = "50%",
				col = "50%",
			},
			size = {
				width = 60,
				height = "auto",
			},
		},
		popupmenu = {
			relative = "editor",
			position = {
				row = "70%",
				col = "50%",
			},
			size = {
				width = 60,
				height = "20%",
			},
			border = {
				style = "rounded",
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
			},
		},
	},
	presets = {
		long_message_to_split = true,
		lsp_doc_border = true,
	},
}
