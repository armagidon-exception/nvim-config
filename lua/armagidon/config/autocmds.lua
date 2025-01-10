local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "highlight on yank",
})

-- -- Remove whitespace on save
-- autocmd("BufWritePre", {
-- 	command = ":%s/\\s\\+$//e",
-- })

-- Don't auto commenting new lines
autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove { "c", "r", "o" }
	end,
	desc = "Disable new line comment",
})

autocmd("FileType", {
	pattern = {
		"grug-far",
		"help",
		"man",
		"qf",
		"query",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
	desc = "close certain windows with q",
})

autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, "\"")
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	desc = "go to last loc when opening a buffer",
})

-- autocmd("WinClosed", {
-- 	callback = function(event)
-- 		local current_windows = vim.api.nvim_tabpage_list_wins(0)
-- 		local collapse = true
-- 		for _, winid in pairs(current_windows) do
-- 			local bufnr = vim.api.nvim_win_get_buf(winid)
-- 			local ft = vim.bo[bufnr].filetype
-- 			if not vim.g.noneditable_filetypes[ft] and winid ~= event.file then
-- 				collapse = false
-- 				break
-- 			end
-- 		end
-- 		if collapse then
-- 			for _, winid in pairs(current_windows) do
-- 				local bufnr = vim.api.nvim_win_get_buf(winid)
-- 				local ft = vim.bo[bufnr].filetype
-- 				if vim.g.noneditable_filetypes[ft] then
-- 					vim.api.nvim_win_close(winid, true)
-- 				end
-- 			end
-- 		end
-- 	end,
-- })
