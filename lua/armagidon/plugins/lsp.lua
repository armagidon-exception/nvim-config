return {
	{
		"williamboman/mason.nvim",
		config = function(_, opts)
			local mason = require "mason"
			mason.setup(opts)
		end,
		lazy = true,
	},
	{
		"aznhe21/actions-preview.nvim",
		event = "LspAttach",
		dependency = {
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			telescope = require("telescope.themes").get_dropdown {},
		},
        init = function ()       
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
                    end
                    map("<leader>ca", require("actions-preview").code_actions, "LSP code actions", { "n", "v" })
                end,
            })
        end,
		config = function(_, opts)
			require("actions-preview").setup(opts)
		end,
	},
}
