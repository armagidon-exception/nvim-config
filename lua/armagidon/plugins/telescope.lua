return {
	{
		"tsakirist/telescope-lazy.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").load_extension "lazy"
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		config = function()
			local telescope = require "telescope"
			telescope.load_extension "fzf"
		end,
	},
	-- {
	-- 	"nvim-telescope/telescope-file-browser.nvim",
	-- 	dependencies = { "nvim-telescope/telescope.nvim" },
	-- 	config = function()
	-- 		local telescope = require "telescope"
	-- 		telescope.load_extension "file_browser"
	-- 		vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", { desc = "Open file browser" })
	-- 	end,
	-- },
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			local telescope = require "telescope"
			telescope.load_extension "ui-select"
		end,
	},
	{
		"nvim-telescope/telescope-symbols.nvim",
		keys = { { "<leader>sym" } },
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			vim.keymap.set("n", "<leader>sym", "<cmd>Telescope symbols<cr>", { desc = "Emoji pack" })
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		opts = function(_, opts)
			local themes = require "telescope.themes"

            return vim.tbl_deep_extend("force", opts, {
				defaults = {
					file_ignore_patterns = { "node_modules" },
					mappings = {
						i = {},
						n = {},
					},
					preview = {},
				},
				pickers = {
					live_grep = {
						theme = "dropdown",
					},
					symbols = {
						theme = "dropdown",
					},
					buffers = {
						theme = "dropdown",
					},
					find_files = {
						mappings = {},
					},
					man_pages = {
						sections = { "1", "2", "3", "4", "5", "6", "7", "8", "L" },
					},
				},
				extensions = {
					["ui-select"] = {
						themes.get_dropdown {},
					},
				},
            })
		end,
		config = function(_, opts)
			local telescope = require "telescope"
			telescope.setup(opts)
			vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Search for string" })
			vim.keymap.set("n", "<leader>bfs", "<cmd>Telescope buffers<cr>", { desc = "Show all buffers" })
			vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Search for help tag" })
			vim.keymap.set("n", "<leader>man", "<cmd>Telescope man_pages<cr>", { desc = "Open man pages" })
		end,
	},
}
