local g = vim.g
g.mapleader = " "
g.maplocalleader = " "
local mapper = require "utils.mappings"

mapper.create_mappings {
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
		command = vim.cmd.tabclose,
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
		keys = "<A-h>",
		command = vim.cmd.bprevious,
		opts = { desc = "Go to previous buffer" },
	},
	{
		mode = "n",
		keys = "<A-l>",
		command = vim.cmd.bnext,
		opts = { desc = "Go to next buffer" },
	},
	{
		mode = "n",
		keys = "<Tab>",
		command = vim.cmd.tabnext,
		opts = { desc = "Go to next tab" },
	},
	{
		mode = "n",
		keys = "<S-Tab>",
		command = vim.cmd.tabprevious,
		opts = { desc = "Go to previous tab" },
	},
	{
		mode = "n",
		keys = "<leader>nt",
		command = vim.cmd.tabnew,
		opts = { silent = false, desc = "Create new tab" },
	},
	{
		mode = "n",
		keys = "<leader>bd",
		command = vim.cmd.bdelete,
		opts = { silent = false, desc = "Delete buffer" },
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
		keys = "<C-h>",
		command = "<C-w>h",
	},
	{
		mode = "n",
		keys = "<C-j>",
		command = "<C-w>j",
	},
	{
		mode = "n",
		keys = "<C-k>",
		command = "<C-w>k",
	},
	{
		mode = "n",
		keys = "<C-l>",
		command = "<C-w>l",
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
		mode = "n",
		keys = "o",
		command = "oa<BS><ESC>",
	},
	{
		mode = "n",
		keys = "O",
		command = "Oa<BS><ESC>",
	},
	{
		mode = "i",
		keys = "<A-0>",
		command = "<esc>l",
	},
}
