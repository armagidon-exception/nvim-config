return {
	"ahmedkhalf/project.nvim",
    event = {"VeryLazy"},
	-- event = { "BufReadPost", "BufNewFile" },
	keys = {
        {
            "<leader>prjs",
            "<cmd>Telescope projects<cr>",
            desc = "Open projects",
        },
	},
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
}
