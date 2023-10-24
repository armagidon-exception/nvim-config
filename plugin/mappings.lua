local map = require'utils.mappings'

map("n","i","<Insert>")
map("v","J",":m '>+1<CR>gv=gv")
map("v","K",":m '<-2<CR>gv=gv")

--map("n","J","mzJ`z")
map("n","<C-d>","<C-d>zz")
map("n","<C-u>","<C-u>zz")
--map("n","n","nzzzv")
--map("n","N","Nzzzv")
map("n","<leader>x","<cmd>!chmod +x %<CR>")

map("n","<A-q>",vim.cmd.bdelete)
map("n","<A-e>","<cmd>q<cr>")
map("n","<A-h>","<cmd>BufferLineCyclePrev<cr>")
map("n","<A-l>","<cmd>BufferLineCycleNext<cr>")
map("n", "<C-Enter>", "<cmd>vsplit<cr>")
map("n", "<C-S-Enter>", "<cmd>split<cr>")

map("n","<C-h>","<C-w>h")
map("n","<C-j>","<C-w>j")
map("n","<C-k>","<C-w>k")
map("n","<C-l>","<C-w>l")

map("n","<C-Up>","<cmd>resize +2<cr>")
map("n","<C-Down>","<cmd>resize -2<cr>")

map("n","<C-Right>","<cmd>vertical resize +2<cr>")
map("n","<C-Left>","<cmd>vertical resize -2<cr>")

map("v",">",">gv")
map("v","<","<gv")
--[[ map("n","o","o<ESC>")
map("n","O","O<ESC>") ]]
map("n", "o", "oa<BS><ESC>")
map("n", "O", "Oa<BS><ESC>")
map("v","dd",'"_d')
map("n","dd",'"_dd')

map("i", "<A-0>", "<esc>l")
