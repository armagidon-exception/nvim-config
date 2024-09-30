local signs = {
	Error = { text = "" },
	Warn = { text = "" },
	Info = { text = "" },
	Hint = { text = "󰌶" },
}

for diag, sign in pairs(signs) do
	vim.fn.sign_define("DiagnosticSign" .. diag, {
		text = sign.text or "",
		texthl = sign.texthl or ("DiagnosticSign" .. diag),
		linehl = sign.linehl or "",
		numhl = sign.numhl or ("DiagnosticSign" .. diag),
	})
end

vim.diagnostic.config {
	virtual_text = false,
	underline = true,
	serverity_sort = true,
}
