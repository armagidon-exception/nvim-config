return {
	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
		opts = {
			ast = {
				role_icons = {
					type = "",
					declaration = "",
					expression = "",
					specifier = "",
					statement = "",
					["template argument"] = "",
				},
				kind_icons = {
					Compound = "",
					Recovery = "",
					TranslationUnit = "",
					PackExpansion = "",
					TemplateTypeParm = "",
					TemplateTemplateParm = "",
					TemplateParamObject = "",
				},
			},
		},
		config = function(_, opts)
			require("clangd_extensions").setup(opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					-- local client = vim.lsp.get_client_by_id(event.data.client_id)
					local buf = event.bufnr
					require("clangd_extensions.inlay_hints").setup_autocmd()
					require("clangd_extensions.inlay_hints").set_inlay_hints()

					local group = vim.api.nvim_create_augroup("clangd_no_inlay_hints_in_insert", { clear = true })

					vim.keymap.set("n", "<leader>lh", function()
						if require("clangd_extensions.inlay_hints").toggle_inlay_hints() then
							vim.api.nvim_create_autocmd("InsertEnter", {
								group = group,
								buffer = buf,
								callback = require("clangd_extensions.inlay_hints").disable_inlay_hints,
							})
							vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
								group = group,
								buffer = buf,
								callback = require("clangd_extensions.inlay_hints").set_inlay_hints,
							})
						else
							vim.api.nvim_clear_autocmds { group = group, buffer = buf }
						end
					end, { buffer = buf, desc = "[l]sp [h]ints toggle" })
				end,
			})
		end,
	},
	{
		"iguanacucumber/magazine.nvim",
		opts = function(_, opts)
			require("utils.table").merge_onto(opts, {
				sorting = {
					comparators = {
						require "clangd_extensions.cmp_scores",
					},
				},
			})
		end,
	},
}
