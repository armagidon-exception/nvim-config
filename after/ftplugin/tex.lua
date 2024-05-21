vim.api.nvim_create_user_command("LatexView", function()
    local file = vim.fn.expand "%"
	vim.cmd.Compile()
	local enter_code = vim.api.nvim_replace_termcodes(
		string.format("<cmd>!xreader $(filename %s).pdf &<cr>", file),
		false,
		false,
		true
	)
	vim.api.nvim_feedkeys(enter_code, "t", true)
end, {})
