return {
	{
		"folke/lazydev.nvim",
		priority = 500,
		ft = "lua",
		dependencies = {
			{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
			{ -- optional completion source for require statements and module annotations
				"hrsh7th/nvim-cmp",
				opts = function(_, opts)
					opts.sources = opts.sources or {}
					table.insert(opts.sources, {
						name = "lazydev",
						group_index = 0, -- set group index to 0 to skip loading LuaLS completions
					})
				end,
			},
		},
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	}, -- For neovim docs
	{ "folke/neoconf.nvim", priority = 500 }, -- Json configuration for lua_ls
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			{ "Decodetalkers/csharpls-extended-lsp.nvim" },
		},
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java", "class" },
	}, -- Adapter plugin for jdtls
	{
		"ranjithshegde/ccls.nvim",
		ft = { "c", "cpp", "objc", "objcpp", "opencl" },
		config = function()
			local util = require "lspconfig.util"
			local server_config = {
				filetypes = { "c", "cpp", "objc", "objcpp", "opencl" },
				root_dir = function(fname)
					return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".ccls", "Makefile")(fname)
						or util.find_git_ancestor(fname)
				end,
				init_options = { cache = {
					directory = vim.fs.normalize "~/.cache/ccls/",
				} },
			}
			require("ccls").setup { lsp = { lspconfig = server_config } }
		end,
	},
}
