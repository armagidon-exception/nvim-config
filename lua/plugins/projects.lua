return {
	"ahmedkhalf/project.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope.nvim",
			config = function()
				require("telescope").load_extension "projects"
			end,
		},
	},
	opts = {
		detection_methods = { "pattern", "lsp" },
		manual_mode = false,
		scope_chdir = "tab",
	},
	config = function(project_nvim, opts)
		require("project_nvim").setup(opts)
	end,
	keys = {
		{
			"<leader>prjs",
			"<cmd>Telescope projects theme=dropdown<cr>",
			desc = "Open projects",
		},
	},
}
