local map = require "utils.mappings"
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local tele_builtin = require "telescope.builtin"
local lsp_signature = require "lsp_signature"

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

function settings.lsp_settings.on_attach(server_name, bufnr)
	local opts = { buffer = bufnr }
	map("n", "gD", vim.lsp.buf.declaration, merge(opts, { desc = "Show declaration" }))
	map("n", "gd", tele_builtin.lsp_definitions, merge(opts, { desc = "Show definitions" }))
	map("n", "K", vim.lsp.buf.hover, merge(opts, { desc = "Show lsp info" }))
	map("n", "gi", tele_builtin.lsp_implementations, merge(opts, { desc = "Show implemetation" }))
	map("n", "<C-k>", vim.lsp.buf.signature_help, merge(opts, { desc = "Signature help" }))
	map("n", "<leader>D", tele_builtin.lsp_type_definitions, merge(opts, { desc = "Show type definitions" }))
	map("n", "<leader>rn", ":IncRename ", merge(opts, { desc = "Rename" }))
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, merge(opts, { desc = "Show code actions" }))
	map("n", "<leader>ref", tele_builtin.lsp_references, merge(opts, { desc = "Show references" }))
	map("n", "<leader>lf", "<cmd>Format<cr>", merge(opts, { desc = "Format" }))
	map("n", "<leader>di", tele_builtin.diagnostics, merge(opts, { desc = "Show diagnostics" }))

	lsp_signature.on_attach({
		bind = true,
		handler_opts = {
			border = "none",
		},
		hint_prefix = "🤖 ",
		select_signature_key = "<M-n>",
		floating_window_off_x = 5, -- adjust float windows x position.
		floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
			local pumheight = vim.o.pumheight
			local winline = vim.fn.winline() -- line number in the window
			local winheight = vim.fn.winheight(0)

			-- window top
			if winline - 1 < pumheight then
				return pumheight
			end

			-- window bottom
			if winheight - winline < pumheight then
				return -pumheight
			end
			return 0
		end,
	}, bufnr)
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
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.abort(),
	["<CR>"] = cmp.mapping.confirm { select = true },
})

return vim.deepcopy(settings)
