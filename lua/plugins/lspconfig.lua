return {
	{ "folke/lazydev.nvim", priority = 500, event = { "BufReadPost", "BufNewFile" } }, -- For neovim docs
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
					return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".ccls")(fname)
						or util.find_git_ancestor(fname)
				end,
				init_options = {
					cache = {
						directory = vim.env.XDG_CACHE_HOME .. "/ccls/",
					},
				},
			}
			require("ccls").setup { lsp = { lspconfig = server_config } }
		end,
	},
}
