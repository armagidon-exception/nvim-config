local cmp = require "cmp"
local lspkind = require "lspkind"

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
		completion = vim.tbl_extend("force", win_config, { max_width = 50, max_height = 50}),
		documentation = vim.tbl_extend("force", win_config, { max_width = 30, max_height = 50}),
	},
	experimental = {
		ghost_text = true,
	},
	mapping = cmp.mapping.preset.insert(require("configs.lsp.cmp").mappings),
	sources = cmp.config.sources {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
}
