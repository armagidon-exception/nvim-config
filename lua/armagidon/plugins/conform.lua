return {
	{
		"zapling/mason-conform.nvim",
		lazy = true,
		opts = {
			ensure_installed = { "stylua", "prettier", "latexindent", "clang-format", "autopep8", "xmlformat" },
		},
        dependencies = { "williamboman/mason.nvim" },
		config = function(_, opts)
			local masonconform = require "mason-conform"
			masonconform.setup(opts)
		end,
	},
	{
		"stevearc/conform.nvim",
        dependencies = {"zapling/mason-conform.nvim"},
		event = { "BufReadPre", "BufNewFile", "InsertLeave" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				cs = { "clangformat" },
				python = { "autopep8" },
				java = { "clangformat" },
				tex = { "latexindent" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "prettier" },
				html = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				xml = { "xmlformat" },
				["_"] = { "trim_whitespace" },
			},
			formatters = {
				stylua = { prepend_args = { "--quote-style", "ForceDouble", "--call-parentheses", "None" } },
			},
		},
		config = function(_, opts)
			require "mason-conform"
			local conform = require "conform"
			conform.setup(opts)

			vim.keymap.set({ "n", "v" }, "<leader>lf", function()
				conform.format({ lsp_fallback = true, async = false, timeout_ms = 500 }, function(err, did_edit)
					if did_edit then
						vim.notify "Formatting completed!"
					end

					if err then
						vim.notify(tostring(err), vim.log.levels.ERROR)
					end
				end)
			end, { desc = "Format current file" })
		end,
	},
}
