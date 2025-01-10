return {
	{
		"rcarriga/nvim-notify",
		lazy = true,
		opts = {
			timeout = 2000,
			render = "wrapped-compact",
			max_width = 50,
		},
	},
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>fb",
				"<cmd>Yazi<cr>",
				desc = "Open Yazi in current file",
			},
			{
				"<leader>fcw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open Yazi in working directory",
			},
		},
		opts = {
			open_for_directories = true,
			floating_window_scaling_factor = 0.7,
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
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
                hover = {
                    size = {
                        max_width = 50,
                        max_height = 20,
                    }
                },
                signature_help = {
                    size = {
                        max_width = 50,
                        max_height = 20,
                    },
                    position = {row = 10, col = 1},
                },
				cmdline_popup = {
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
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
				long_message_to_split = false,
				lsp_doc_border = true,
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"nvim-telescope/telescope.nvim",
		},
		config = function(_, opts)
			require("noice").setup(opts)
			require("telescope").load_extension "noice"
		end,
	},
	{
		"catgoose/nvim-colorizer.lua",
		cmd = "ColorizerToggle",
		opts = {},
	},

	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },

	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	{
		"hiphish/rainbow-delimiters.nvim",
		lazy = false,
		init = function()
			local rainbow_delimiters = require "rainbow-delimiters"

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},
}
