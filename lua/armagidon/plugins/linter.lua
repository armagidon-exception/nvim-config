return {
	{
		"mfussenegger/nvim-lint",
		dependencies = { "rshkarin/mason-nvim-lint" },
		event = { "BufWritePost", "BufReadPost", "InsertLeave" },
		opts = { linters_by_ft = { dockerfile = { "hadolint" }, lua = { "selene" }, yaml = { "yamllint" } } },
		config = function(_, opts)
			local lint = require "lint"
			lint.linters_by_ft = opts.linters_by_ft
			local lint_augroup = vim.api.nvim_create_augroup("linting", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	{
		"rshkarin/mason-nvim-lint",
        lazy = true,
		opts = {
			ensure_installed = { "selene" },
		},
		config = function(_, opts)
			require("mason-nvim-lint").setup(opts)
		end,
	},
}
