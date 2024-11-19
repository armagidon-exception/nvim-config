local keymap = vim.keymap.set
local nvim_create_cmd = vim.api.nvim_create_user_command

keymap("n", "[b", "<cmd>cnext<cr>", { desc = "Go to next item in quickfix list" })
keymap("n", "]b", "<cmd>cprevious<cr>", { desc = "Go to previous item in quickfix list" })
keymap("n", "[[", "<cmd>copen<cr>", { desc = "Open quickfix list" })
keymap("n", "]]", "<cmd>cclose<cr>", { desc = "Close quickfix list" })

nvim_create_cmd("QFClear", function ()
    vim.fn.setqflist({})
end, {})
