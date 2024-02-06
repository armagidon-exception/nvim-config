local cmp = require "cmp"
local lspkind = require "lspkind"

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup {
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format {
			mode = "symbol",
			maxwidth = 50,
			ellipsis_char = "...",
		},
	},
	window = {
		completion = cmp.config.window.bordered "rounded",
		documentation = cmp.config.window.bordered "rounded",
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
