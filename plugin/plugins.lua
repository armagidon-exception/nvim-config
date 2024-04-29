local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local packer_config = {
	display = {
		open_fn = function()
			local result, win, buf = require("packer.util").float {
				border = {
					{ "╭", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╮", "FloatBorder" },
					{ "│", "FloatBorder" },
					{ "╯", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╰", "FloatBorder" },
					{ "│", "FloatBorder" },
				},
			}
			vim.api.nvim_win_set_option(win, "winhighlight", "NormalFloat:Normal")
			return result, win, buf
		end,
	},
}

local function install_plugins(use)
	use "wbthomason/packer.nvim"

	use "catppuccin/nvim"

	-- Telescope stuff
	use "nvim-telescope/telescope.nvim"
	use {
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	}
	use "nvim-telescope/telescope-file-browser.nvim"
	use "nvim-telescope/telescope-ui-select.nvim"
	use "nvim-telescope/telescope-symbols.nvim"

	use "nvim-lua/plenary.nvim"

	use "nvim-tree/nvim-web-devicons"

	-- Project manager
	use "ahmedkhalf/project.nvim"

	-- Startup screen
	use "goolord/alpha-nvim"

	-- Treesitter
	use "nvim-treesitter/nvim-treesitter"
	use "nvim-treesitter/playground"
	use "windwp/nvim-ts-autotag"
	use "nvim-treesitter/nvim-treesitter-textobjects"

	use "hiphish/rainbow-delimiters.nvim"

	-- Surround
	use "kylechui/nvim-surround"

	-- Commentary
	use "numToStr/Comment.nvim"

	-- Autopairs
	use "windwp/nvim-autopairs"

	-- Which key
	use "folke/which-key.nvim"

	-- Live Server
	use "barrett-ruth/live-server.nvim"

	-- Hightlight hex color codes
	use "norcalli/nvim-colorizer.lua"

	-- Status line
	use "nvim-lualine/lualine.nvim"

	-- Bufferline
	use "akinsho/bufferline.nvim"

	use "akinsho/toggleterm.nvim"

	-- LSP
	use "neovim/nvim-lspconfig" -- Collection of lsp configs
	use "williamboman/mason.nvim" -- LSP package manager
	use "williamboman/mason-lspconfig.nvim" -- Hook for Mason and lsp config
	use "hrsh7th/cmp-nvim-lsp" -- Completion
	use "hrsh7th/cmp-buffer" -- Completion source for buffer
	use "hrsh7th/cmp-path" -- Completion source for file system
	use "hrsh7th/cmp-cmdline" -- Completion source for commands
	use "hrsh7th/nvim-cmp" --  Completion
	--use "yioneko/nvim-cmp" -- Completion optimized
	use "L3MON4D3/LuaSnip" -- Snippets
	use "rafamadriz/friendly-snippets" -- Snippet pack
	use "saadparwaiz1/cmp_luasnip" -- Integration with cmp
	use "folke/neodev.nvim" -- For neovim docs
	use "folke/neoconf.nvim" -- Json configuration for lua_ls
	use "folke/trouble.nvim" -- Pretty diagnostics
	use "onsails/lspkind.nvim" -- Kind Icons
	use "ray-x/lsp_signature.nvim" -- Method signature
	-- use "mhartington/formatter.nvim" -- Formatters
	use "stevearc/conform.nvim" -- Formatters
	use "mfussenegger/nvim-lint" -- Linter
	use "Decodetalkers/csharpls-extended-lsp.nvim"
	use "smjonas/inc-rename.nvim" -- Incremental renaming
	use "aznhe21/actions-preview.nvim" -- Code actions menu
	use "mfussenegger/nvim-jdtls" -- Adapter plugin for jdtls

	-- UI
	use "MunifTanjim/nui.nvim"
	use "rcarriga/nvim-notify"
	use "folke/noice.nvim"

    use 'michaelrommel/nvim-silicon'

	if packer_bootstrap then
		require("packer").sync()
	end
end

return require("packer").startup { install_plugins, config = packer_config }
