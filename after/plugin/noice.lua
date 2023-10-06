require("noice").setup {
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
                        row = -3
                    },
				},
			},
		},
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
	},
}
