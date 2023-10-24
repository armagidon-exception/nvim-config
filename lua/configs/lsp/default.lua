local map = require "utils.mappings"
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local tele_builtin = require "telescope.builtin"


local settings = {
	lsp_settings = {
		capabilities = capabilities,
	},
	cmp = {
		mappings = {},
	},
}

local function merge(...)
	return vim.tbl_deep_extend("force", ...)
end

function settings.lsp_settings.on_attach(_, bufnr)
	local opts = { buffer = bufnr }
	map("n", "gD", vim.lsp.buf.declaration, merge(opts, { desc = "Show declaration" }))
	map("n", "gd", tele_builtin.lsp_definitions, merge(opts, { desc = "Show definitions" }))
	map("n", "K", vim.lsp.buf.hover, merge(opts, { desc = "Show lsp info" }))
	map("n", "gi", tele_builtin.lsp_implementations, merge(opts, { desc = "Show implemetation" }))
	map("n", "<leader>k", vim.lsp.buf.signature_help, merge(opts, { desc = "Signature help" }))
	map("n", "<leader>D", tele_builtin.lsp_type_definitions, merge(opts, { desc = "Show type definitions" }))
	map("n", "<leader>rn", ":IncRename ", merge(opts, { desc = "Rename" }))
	map({ "n", "v" }, "<leader>ca", require'actions-preview'.code_actions, merge(opts, { desc = "Show code actions" }))
	map("n", "<leader>ref", tele_builtin.lsp_references, merge(opts, { desc = "Show references" }))
	map("n", "<leader>lf", "<cmd>Format<cr>", merge(opts, { desc = "Format" }))
	map("n", "<leader>di", tele_builtin.diagnostics, merge(opts, { desc = "Show diagnostics" }))
end

local cmp = require "cmp"
settings.cmp.mappings["<Tab>"] = cmp.mapping(function(fallback)
	if cmp.visible() then
		cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
	else
		fallback()
	end
end, { "i" })

settings.cmp.mappings["<S-Tab>"] = cmp.mapping(function(fallback)
	if cmp.visible() then
		cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
	else
		fallback()
	end
end, { "i" })

settings.cmp.mappings = merge(settings.cmp.mappings, {
	["<C-b>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-Space>"] = cmp.mapping.complete({}),
	["<C-e>"] = cmp.mapping.abort(),
	["<CR>"] = cmp.mapping.confirm { select = true },
})

return vim.deepcopy(settings)
