local mapper = require "utils.mappings"

mapper.create_mappings {
	{
		mode = "t",
		keys = "<Esc>",
		command = "<c-\\><c-n>",
	},
	{
		mode = "n",
		keys = "i",
		command = "<Insert>",
	},
	{
		mode = "v",
		keys = "J",
		command = ":m '>+1<CR>gv=gv",
		opts = { silent = true },
	},
	{

		mode = "v",
		keys = "K",
		command = ":m '<-2<CR>gv=gv",
		opts = { silent = true },
	},
	{
		mode = "n",
		keys = "<C-d>",
		command = "<C-d>zz",
	},
	{
		mode = "n",
		keys = "<C-u>",
		command = "<C-u>zz",
	},
	{
		mode = "n",
		keys = "<leader>x",
		command = "<cmd>!chmod +x %<CR>",
		opts = { silent = false },
	},
	{
		mode = "n",
		keys = "<A-q>",
		command = vim.cmd.bdelete,
		opts = { desc = "Close tab" },
	},
	{
		mode = "n",
		keys = "<A-e>",
		command = vim.cmd.q,
		opts = { desc = "Close window" },
	},
	{
		mode = "n",
		keys = "<Tab>",
		command = vim.cmd.bnext,
		opts = { desc = "Go to next tab" },
	},
	{
		mode = "n",
		keys = "<S-Tab>",
		command = vim.cmd.bprevious,
		opts = { desc = "Go to previous tab" },
	},
	{
		mode = "n",
		keys = "<C-Enter>",
		command = vim.cmd.vsplit,
		opts = { desc = "Open window in vertical split" },
	},
	{
		mode = "n",
		keys = "<C-S-Enter>",
		command = vim.cmd.split,
		opts = { desc = "Open window in horizontal split" },
	},
	{
		mode = "n",
		keys = "<C-Up>",
		command = "<cmd>resize +2<cr>",
	},
	{
		mode = "n",
		keys = "<C-Down>",
		command = "<cmd>resize -2<cr>",
	},

	{
		mode = "n",
		keys = "<C-Right>",
		command = "<cmd>vertical resize +2<cr>",
	},
	{
		mode = "n",
		keys = "<C-Left>",
		command = "<cmd>vertical resize -2<cr>",
	},

	{
		mode = "v",
		keys = ">",
		command = ">gv",
	},
	{
		mode = "v",
		keys = "<",
		command = "<gv",
	},
	{
		mode = "i",
		keys = "<A-0>",
		command = "<esc>l",
	},
	{
		mode = "n",
		keys = "<leader>r",
		command = function()
			local filename = vim.fn.expand "%:p:h"
			if vim.fn.isdirectory(filename) == 1 then
				vim.cmd.lcd(filename)
				vim.notify("Root folder has been set to " .. filename)
			end
		end,
	},
	{
		mode = "n",
		keys = "u",
		command = function()
			local coords = vim.fn.getpos "."
			local row = coords[2]
			local col = coords[3]
			vim.cmd.undo()
            local height = vim.fn.line('$')
            if height >= row then
                vim.api.nvim_win_set_cursor(0, { row, col - 1 })
            end
		end,
	},
	{
		mode = "n",
		keys = "<C-r>",
		command = function()
			local coords = vim.fn.getpos "."
			local row = coords[2]
			local col = coords[3]
			vim.cmd.redo()
            local height = vim.fn.line('$')
            if height >= row then
                vim.api.nvim_win_set_cursor(0, { row, col - 1 })
            end
		end,
	},
}
