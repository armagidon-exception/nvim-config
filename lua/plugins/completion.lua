return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" }, -- Completion
			{ "hrsh7th/cmp-buffer" }, -- Completion source for buffer
			{ "hrsh7th/cmp-path" }, -- Completion source for file system
			{ "hrsh7th/cmp-cmdline" }, -- Completion source for commands
			{ "L3MON4D3/LuaSnip" }, -- Snippets
			{ "rafamadriz/friendly-snippets" }, -- Snippet pack
			{ "saadparwaiz1/cmp_luasnip" }, -- Integration with cmp
			{ "onsails/lspkind.nvim" }, -- Kind Icons
		},
		config = function()
			local cmp = require "cmp"
			local lspkind = require "lspkind"

			local select_next_item = cmp.mapping(function(fallback)
				return cmp.visible() and cmp.select_next_item { behavior = cmp.SelectBehavior.Select } or fallback()
			end, { "i" })

			local select_prev_item = cmp.mapping(function(fallback)
				return cmp.visible() and cmp.select_prev_item { behavior = cmp.SelectBehavior.Select } or fallback()
			end, { "i" })

			local mappings = {
				["<Tab>"] = select_next_item,
				["<S-Tab>"] = select_prev_item,
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm { select = true },
			}

			require("luasnip.loaders.from_vscode").lazy_load()

			local win_config = cmp.config.window.bordered()

			cmp.setup {
				performance = {
					max_view_entries = 20,
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					format = lspkind.cmp_format {
						mode = "symbol",
						maxwidth = 30,
						ellipsis_char = "...",
						menu = {},
					},
				},
				window = {
					completion = vim.tbl_extend("force", win_config, { max_width = 50, max_height = 50 }),
					documentation = vim.tbl_extend("force", win_config, { max_width = 30, max_height = 50 }),
				},
				experimental = {
					ghost_text = true,
				},
				mapping = cmp.mapping.preset.insert(mappings),
				sources = cmp.config.sources {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
			}

		end,
	}, -- Completion
}
