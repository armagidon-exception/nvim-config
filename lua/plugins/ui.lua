return {
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 10000,
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
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"nvim-telescope/telescope.nvim", config = function ()
                require('telescope').load_extension'noice'
			end
		},
	},

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local alpha = require "alpha"
			local theme = require "alpha.themes.dashboard"
			local button = function(c, l, f)
				if type(f) == "string" then
					return theme.button(c, l, f)
				else
					local b = theme.button(c, l)
					b.on_press = f
					return b
				end
			end

			theme.section.header.val = {
				[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⡀⠒⠒⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⢀⣤⣶⡾⠿⠿⠿⠿⣿⣿⣶⣦⣄⠙⠷⣤⡀⠀⠀⠀⠀]],
				[[⠀⠀⠀⣠⡾⠛⠉⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣿⣷⣄⠘⢿⡄⠀⠀⠀]],
				[[⠀⢀⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠐⠂⠠⢄⡀⠈⢿⣿⣧⠈⢿⡄⠀⠀]],
				[[⢀⠏⠀⠀⠀⢀⠄⣀⣴⣾⠿⠛⠛⠛⠷⣦⡙⢦⠀⢻⣿⡆⠘⡇⠀⠀]],
				[[⠀⠀⠀⠀⡐⢁⣴⡿⠋⢀⠠⣠⠤⠒⠲⡜⣧⢸⠄⢸⣿⡇⠀⡇⠀⠀]],
				[[⠀⠀⠀⡼⠀⣾⡿⠁⣠⢃⡞⢁⢔⣆⠔⣰⠏⡼⠀⣸⣿⠃⢸⠃⠀⠀]],
				[[⠀⠀⢰⡇⢸⣿⡇⠀⡇⢸⡇⣇⣀⣠⠔⠫⠊⠀⣰⣿⠏⡠⠃⠀⠀⢀]],
				[[⠀⠀⢸⡇⠸⣿⣷⠀⢳⡈⢿⣦⣀⣀⣀⣠⣴⣾⠟⠁⠀⠀⠀⠀⢀⡎]],
				[[⠀⠀⠘⣷⠀⢻⣿⣧⠀⠙⠢⠌⢉⣛⠛⠋⠉⠀⠀⠀⠀⠀⠀⣠⠎⠀]],
				[[⠀⠀⠀⠹⣧⡀⠻⣿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡾⠃⠀⠀]],
				[[⠀⠀⠀⠀⠈⠻⣤⡈⠻⢿⣿⣷⣦⣤⣤⣤⣤⣤⣴⡾⠛⠉⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⠀⠈⠙⠶⢤⣈⣉⠛⠛⠛⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			}

			local configurate = function()
				local path = vim.fs.normalize(vim.fn.stdpath "config" .. "")
				vim.cmd.e(path)
				vim.cmd.lcd(path)
				vim.notify_once("Configuring...", vim.log.levels.info)
			end

			theme.section.buttons.val = {
				button("spc f f", "  Find file", "<cmd>Telescope find_files<cr>"),
				button("r", "  Recent", "<cmd>telescope oldfiles<cr>"),
				button("c", "  Configuration", configurate),
				button("p", "󱀺  Projects", "<leader>prjs"),
				button("q", "  Exit vim", "<cmd>wqa<cr>"),
			}
			alpha.setup(theme.config)
		end,
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		config = function()
			local lualine = require "lualine"

			local function fetch_lsp()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end

			lualine.setup {
				options = {
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename", { fetch_lsp, icon = " LSP:" } },
					lualine_x = {
						"encoding",
						"fileformat",
						"filetype",
						{
							require("noice").api.status.mode.get,
							cond = require("noice").api.status.mode.has,
						},
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			}
		end,
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		config = function()
			local bufferline = require "bufferline"

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
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			marks = false,
			registers = false,
		},
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show { global = false }
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
