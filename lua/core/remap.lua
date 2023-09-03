local keymap = vim.keymap

local opts = { silent = true, noremap = true }

local function get_buffers(options)
	options = options or {}
	local buffers = {}
	local len = 0
	local options_listed = options.listed
	local vim_fn = vim.fn
	local buflisted = vim_fn.buflisted

	for buffer = 1, vim_fn.bufnr "$" do
		if not options_listed or buflisted(buffer) ~= 1 then
			len = len + 1
			buffers[len] = buffer
		end
	end

	return buffers
end

keymap.set("n", "i", "<Insert>", opts)
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

keymap.set("n", "J", "mzJ`z", opts)
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

keymap.set("n", "<A-q>", function()
    local n = 0
	for i, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
            n = i
		end
	end
	vim.cmd.bdelete()
    if n == 2 then
        vim.cmd('Alpha')
    end
end, opts)
keymap.set("n", "<A-e>", "<cmd>q<cr>", opts)
keymap.set("n", "<A-h>", "<cmd>bp<cr>", opts)
keymap.set("n", "<A-l>", "<cmd>bn<cr>", opts)
keymap.set("n", "<C-Enter>", "<cmd>vsplit<cr>")
keymap.set("n", "<C-S-Enter>", "<cmd>split<cr>")

keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", opts)
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", opts)

keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opts)
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", opts)

keymap.set("v", ">", ">gv", opts)
keymap.set("v", "<", "<gv", opts)
keymap.set("n", "o", "o<ESC>", opts)
keymap.set("n", "O", "O<ESC>", opts)
keymap.set("v", "dd", '"_d', opts)
keymap.set("n", "dd", '"_dd', opts)

keymap.set("v", "<leader>st", function()
	require "core.surrounds"()
end, opts)
