vim.filetype.add {
	extension = {
		h = "c",
	},
}

vim.filetype.add {
	extension = {
		ejs = "html_ejs",
	},
}

vim.filetype.add {
	extension = {
		cs = function(path, bufnr)
			local mono_path = require("lspconfig.util").root_pattern "*.sln"(path)
			if mono_path then
				return "mono-cs"
			else
				return "cs"
			end
		end,
	},
}
