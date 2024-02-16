local mappings = {}

function mappings.markdown(bufnr)
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

return {
	mappings = function(bufnr)
		local maps = mappings[vim.bo.filetype]
		if maps then
			return maps(bufnr)
		end
		return {}
	end,
}
