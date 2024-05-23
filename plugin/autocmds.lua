local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Remove whitespace on save
autocmd("BufWritePre", {
	pattern = "",
	command = ":%s/\\s\\+$//e",
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
	pattern = "",
	command = "set fo-=c fo-=r fo-=o",
})

autocmd("BufNew", {
    pattern =  "*",
    callback = function (event)
        local file = event.file
        if file == nil or #file == 0 then
            return
        end
        local parent_dir = vim.fn.fnamemodify(file, ":p:h")
        local buf = event.buf
        if buf == nil then
            vim.notify("Event somehow lacks buf id", vim.log.levels.ERROR)
            return
        end
        local lsps = vim.lsp.get_active_clients({bufnr=buf})
        if #lsps > 0 then
            return
        end
        vim.cmd.lcd(parent_dir)
    end
})
