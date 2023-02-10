local keymap = vim.keymap


local opts = {silent = true, noremap  = true}
keymap.set('n', 'i', '<Insert>', opts)
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

keymap.set('n','J', "mzJ`z", opts)
keymap.set('n',"<C-d>", "<C-d>zz", opts)
keymap.set('n',"<C-u>", "<C-u>zz", opts)
keymap.set('n','n', 'nzzzv', opts)
keymap.set('n','N', 'Nzzzv', opts)
keymap.set('n','<leader>x', '<cmd>!chmod +x %<CR>', opts)

keymap.set('n', '<A-x>', '<cmd>bdelete<cr>')
keymap.set('n', '<A-h>', '<cmd>bp<cr>')
keymap.set('n', '<A-l>', '<cmd>bn<cr>')


keymap.set('n', '<C-h>', '<C-w>h')
keymap.set('n', '<C-j>', '<C-w>j')
keymap.set('n', '<C-k>', '<C-w>k')
keymap.set('n', '<C-l>', '<C-w>l')

keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>')
keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>')

keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>')
keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>')


keymap.set('v', ">", ">gv")
keymap.set('v', "<", "<gv")
