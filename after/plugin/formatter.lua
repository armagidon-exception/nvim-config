local formatter = require "conform"

require("conform").setup {
	formatters_by_ft = {
		lua = { "stylua" },
		cs = { "clangformat" },
		python = { "autopep8" },
		java = { "clangformat" },
		tex = { "latexindent" },
		c = { "clangformat" },
		cpp = { "clangformat" },
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
		stylua = {
			prepend_args = { "--quote-style", "ForceDouble", "--call-parentheses", "None" },
		},
		latexindent = {
			prettier = {
				"-m",
				"--yaml=\"oneSentencePerLine:manipulateSentences:1\"",
			},
		},
	},
}

local mapper = require "utils.mappings"

mapper.create_mappings {
	{
		mode = { "n", "v" },
		keys = "<leader>lf",
		command = function()
			formatter.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			}, function(err, did_edit)
				if did_edit then
					vim.notify "Formatting completed!"
				end
				if err then
					vim.notify(tostring(err), vim.log.levels.ERROR)
				end
			end)
		end,
		opts = {
			desc = "Format",
		},
	},
}
