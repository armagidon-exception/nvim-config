local manual_configs = {}
local M = {}

function M.setup_autocmds()
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            M.setup_keymappings(event.buf)
        end,
    })
end

function M.setup_keymappings(bufnr)
    local tele_builtin = require "telescope.builtin"
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Show declaration" })
    vim.keymap.set("n", "gd", tele_builtin.lsp_definitions, { buffer = bufnr, desc = "Show definitions" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show hover" })
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Show implemetation" })
    vim.keymap.set("n", "<leader>D", tele_builtin.lsp_type_definitions,
        { buffer = bufnr, desc = "Show type definitions" })
    vim.keymap.set("n", "<leader>rn", function()
        return string.format(":IncRename %s", vim.fn.expand "<cword>")
    end, { desc = "Rename under the cursor", buffer = bufnr, expr = true })

    vim.keymap.set({ "n", "v" }, "<leader>ca", require("actions-preview").code_actions,
        { buffer = bufnr, desc = "Show code actions" })
    vim.keymap.set("n", "<leader>ref", tele_builtin.lsp_references, { buffer = bufnr, desc = "Show lsp references" })
    vim.keymap.set("n", "<leader>di", tele_builtin.diagnostics, { desc = "Show diagnostics", buffer = bufnr })
end

M.manual_configs = manual_configs

return M
