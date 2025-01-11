return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			require("lazy.core.loader").add_to_rtp(plugin)
			require "nvim-treesitter.query_predicates"
		end,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		opts = {
			ensure_installed = {
				"lua",
				"python",
				"c",
				"cpp",
				"yaml",
				"json",
				"toml",
				"bash",
				"html",
				"css",
				"javascript",
				"typescript",
				"markdown",
				"markdown_inline",
				"vim",
				"regex",
				"jsonc",
				"query",
			},
			auto_install = true,
			sync_install = false,
			modules = {},
			ignore_install = {},
			highlight = {
				enable = true,
				disable = {},
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn", -- set to `false` to disable one of the mappings
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			indent = {
				enable = true,
			},
		},
		opts_extend = {
			"highlight.disable",
			"ensure_installed",
		},
		config = function(_, opts)
			local ts_configs = require "nvim-treesitter.configs"
			ts_configs.setup(opts)
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			opts = function(_, opts)
				opts.autotag = { enable = true }
			end,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			opts = function(_, opts)
				opts.textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = { query = "@function.outer", desc = "Around function" },
							["if"] = { query = "@function.inner", desc = "Inside function" },
							["aC"] = { query = "@class.outer", desc = "Around class" },
							["iC"] = { query = "@class.inner", desc = "Inside class" },
							["ic"] = { query = "@comment.inner", desc = "Inside comment" },
							["ac"] = { query = "@comment.outer", desc = "Around comment" },
							["l="] = { query = "@assignment.lhs", desc = "Left-hand side of assignment" },
							["r="] = { query = "@assignment.rhs", desc = "Right-hand side of assignment" },
							["i="] = { query = "@assignment.inner", desc = "Inside of assignment" },
							["a="] = { query = "@assignment.outer", desc = "Outside of assignment" },
							["aa"] = { query = "@parameter.outer", desc = "Outer part of parameter" },
							["ia"] = { query = "@parameter.inner", desc = "Inner part of parameter" },
							["ai"] = { query = "@conditional.outer", desc = "Outer part of conditional" },
							["ii"] = { query = "@conditional.inner", desc = "Inner part of conditional" },
							["al"] = { query = "@loop.outer", desc = "Outer part of loop" },
							["il"] = { query = "@loop.inner", desc = "Inner part of loop" },
						},
						selection_modes = {
							["@class.outer"] = "<c-v>",
							["@class.inner"] = "<c-v>",
						},
						include_surrounding_whitespace = false,
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>na"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>pa"] = "@parameter.inner",
						},
					},
				}
			end,
		},
	},
}
