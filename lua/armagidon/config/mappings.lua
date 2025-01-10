local keymap = vim.keymap.set

keymap("t", "<Esc>", "<c-\\><c-n>")
keymap("n", "i", "<Insert>")
keymap("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
keymap("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = false })
keymap("n", "<A-q>", vim.cmd.bdelete, { desc = "Close tab" })
keymap("n", "<A-e>", vim.cmd.q, { desc = "Close window" })
keymap("n", "<C-Enter>", vim.cmd.vsplit, { desc = "Open window in vertical split" })
keymap("n", "<C-S-Enter>", vim.cmd.split, { desc = "Open window in horizontal split" })
keymap("n", "<C-Up>", "<cmd>resize +2<cr>")
keymap("n", "<C-Down>", "<cmd>resize -2<cr>")

keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>")
keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>")

keymap("v", ">", ">gv")
keymap("v", "<", "<gv")
keymap("i", "<A-0>", "<esc>l")

keymap("n", "u", function()
	local coords = vim.fn.getpos "."
	local row = coords[2]
	local col = coords[3]
	vim.cmd.undo()
	local height = vim.fn.line "$"
	if height >= row then
		vim.api.nvim_win_set_cursor(0, { row, col - 1 })
	end
end)

keymap("n", "<C-R>", function()
	local coords = vim.fn.getpos "."
	local row = coords[2]
	local col = coords[3]
	vim.cmd.redo()
	local height = vim.fn.line "$"
	if height >= row then
		vim.api.nvim_win_set_cursor(0, { row, col - 1 })
	end
end)

keymap("n", "[[", "<cmd>copen<cr>", { desc = "Open quickfix list" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		local nvim_create_cmd = vim.api.nvim_create_user_command

		keymap("n", "[b", "<cmd>cnext<cr>", { desc = "Go to next item in quickfix list" })
		keymap("n", "]b", "<cmd>cprevious<cr>", { desc = "Go to previous item in quickfix list" })
		keymap("n", "]]", "<cmd>cclose<cr>", { desc = "Close quickfix list" })

		nvim_create_cmd("QFClear", function()
			vim.fn.setqflist {}
		end, {})
	end,
})

local function next_buffer()
	if vim.g.ft_scroll_ignore[vim.bo.filetype] then
		return
	end
	pcall(vim.cmd.bn)
end

local function prev_buffer()
	if vim.g.ft_scroll_ignore[vim.bo.filetype] then
		return
	end
	pcall(vim.cmd.bp)
end

keymap("n", "<Tab>", next_buffer, { desc = "Go to next tab" })
keymap("n", "<S-Tab>", prev_buffer, { desc = "Go to previous tab" })
