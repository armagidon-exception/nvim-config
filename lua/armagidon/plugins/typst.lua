return {
	"chomosuke/typst-preview.nvim",
	-- lazy = false, -- or ft = 'typst'
	ft = "typst",
	-- version = "1.*",
	opts = {
		dependencies_bin = {
			websocat = "/usr/bin/websocat",
			tinymist = vim.fn.expand "~/.local/share/nvim/mason/bin/tinymist",
		},
		get_root = function(path_of_main_file)
			local root = os.getenv "TYPST_ROOT"
			if root then
				return root
			end
			local clients = vim.lsp.get_clients { bufnr = 0 }
			for _, client in ipairs(clients) do
				if client.root_dir then
					return client.root_dir
				end
			end
			return vim.fn.fnamemodify(path_of_main_file, ":p:h")
		end,
		get_main_file = function(main_buffer)
			local dir = vim.fn.fnamemodify(main_buffer, ":p:h")
			local clients = vim.lsp.get_clients { bufnr = 0 }
			for _, client in ipairs(clients) do
				if client.root_dir then
					if dir == client.root_dir then
						return main_buffer
					else
						return vim.split(vim.fn.glob(string.format("%s/*.typ", client.root_dir)), "\n")[1]
					end
				end
			end
			return main_buffer
		end,
	}, -- lazy.nvim will implicitly calls `setup {}`
}
