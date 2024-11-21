return {
	-- Surround
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup {}
		end,
	},

	-- Commentary
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			mappings = {
				extra = false,
			},
		},
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			ts_config = {
				lua = { "string", "comment" }, -- it will not add a pair on that treesitter node
			},
		},
	},

	-- Hightlight hex color codes
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufNewFile", "BufReadPost" },
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"michaelrommel/nvim-silicon",
		cmd = "Silicon",
		opts = {
			{
				font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
				theme = "Dracula",
				background = "#94e2d5",
				window_title = function()
					return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
				end,
			},
		},
	},
}
