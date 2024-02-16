return {
	mappings = function(bufnr)
		if vim.bo.filetype == "markdown" then
			return {
				{
					mode = "v",
					keys = "gbo",
					command = "<Plug>(nvim-surround-visual)mbold<cr>",
					opts = {
						buffer = bufnr,
						desc = "Make bold",
					},
				},
				{
					mode = "n",
					keys = "gbo",
					command = "<Plug>(nvim-surround-normal)mbold<cr>",
					opts = {
						buffer = bufnr,
						desc = "Make bold",
					},
				},
				{
					mode = "n",
					keys = "gbi",
					command = "<Plug>(nvim-surround-normal)mitalic<cr>",
					opts = {
						buffer = bufnr,
						desc = "Make italic",
					},
				},
				{
					mode = "v",
					keys = "gbi",
					command = "<Plug>(nvim-surround-visual)mitalic<cr>",
					opts = {
						buffer = bufnr,
						desc = "Make italic",
					},
				},
				{
					mode = "v",
					keys = "<leader>ico",
					command = "<Plug>(nvim-surround-visual)mcode<cr>",
					opts = {
						buffer = bufnr,
						desc = "Insert code",
					},
				},
			}
		end
		return {}
	end,
}
