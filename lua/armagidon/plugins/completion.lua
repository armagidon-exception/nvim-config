return {
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"saghen/blink.compat",
				optional = true,
				opts = {},
			},
		},
		version = "v0.*",
		opts = {
			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },

				["<Tab>"] = {
					function(cmp)
						return cmp.select_next()
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = {
					function(cmp)
						return cmp.select_prev()
					end,
					"snippet_backward",
					"fallback",
				},

				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },

				["<C-f>"] = { "scroll_documentation_up", "fallback" },
				["<C-b>"] = { "scroll_documentation_down", "fallback" },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					lsp = {
						min_keyword_length = function(ctx)
							return ctx.trigger.kind == "manual" and 0 or 2 -- trigger when invoking with shortcut
						end,
						score_offset = 0,
					},
					path = {
						min_keyword_length = 0,
					},
					snippets = {
						min_keyword_length = 2,
					},
					buffer = {
						min_keyword_length = 5,
						max_items = 5,
					},
				},
			},
			signature = {
				enabled = false,
				window = {
					max_width = 50,
					max_height = 20,
                    border = "rounded",
				},
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 250,
					treesitter_highlighting = true,
					window = { border = "rounded", max_width = 50, max_height = 20 },
				},
				list = {
					selection = { preselect = false, auto_insert = true },
				},
				trigger = {
					show_on_insert_on_trigger_character = false,
					show_on_accept_on_trigger_character = false,
				},
				menu = {
					border = "rounded",
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } },
					},
				},
				ghost_text = {
					enabled = true,
				},
			},
		},
		opts_extend = {
			"sources.default",
			"sources.compat",
		},
		config = function(_, opts)
			-- setup compat sources and provider
			local enabled = opts.sources.default
			for _, source in ipairs(opts.sources.compat or {}) do
				opts.sources.providers[source] = vim.tbl_deep_extend(
					"force",
					{ name = source, module = "blink.compat.source" },
					opts.sources.providers[source] or {}
				)
				if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
					table.insert(enabled, source)
				end
			end

			-- check if we need to override symbol kinds
			for _, provider in pairs(opts.sources.providers or {}) do
				---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
				if provider.kind then
					require("blink.cmp.types").CompletionItemKind[provider.kind] = provider.kind
					---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
					local transform_items = provider.transform_items
					---@param ctx blink.cmp.Context
					---@param items blink.cmp.CompletionItem[]
					provider.transform_items = function(ctx, items)
						items = transform_items and transform_items(ctx, items) or items
						for _, item in ipairs(items) do
							item.kind = provider.kind or item.kind
						end
						return items
					end
				end
			end

			require("blink.cmp").setup(opts)
		end,
	},
	{
		"folke/lazydev.nvim",
		priority = 500,
		ft = "lua",
		dependencies = {
			{ "Bilal2453/luvit-meta", lazy = true },
		},
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "folke/neoconf.nvim", ft = "lua" }, -- Json configuration for lua_ls
	{
		"saghen/blink.cmp",
		opts = {
			sources = {
				default = { "lazydev" },
				providers = {
					lsp = {
						-- dont show LuaLS require statements when lazydev has items
						fallbacks = { "buffer" },
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
					},
				},
			},
		},
	},
}
