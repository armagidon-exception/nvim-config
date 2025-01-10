local tools = {
	"isort",
	"prettier",
	"stylua",
	"shfmt",
	"taplo",
	"typstfmt",
	"hadolint",
	"shellcheck",
	"selene",
	"tflint",
	"yamllint",
	"ruff",
	"debugpy",
	"delve",
	"gofumpt",
	"goimports",
	"gomodifytags",
	"golangci-lint",
	"gotests",
	"iferr",
	"impl",
}

return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = true,
		opts = {
			ensure_installed = tools,
		},
		config = function(_, opts)
			local masoninstaller = require "mason-tool-installer"
			masoninstaller.setup(opts)
		end,
	},
}
