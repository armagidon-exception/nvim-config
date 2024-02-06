local cmp = require "cmp"

local select_next_item = cmp.mapping(function(fallback)
	if cmp.visible() then
		cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
	else
		fallback()
	end
end, { "i" })

local select_prev_item = cmp.mapping(function(fallback)
	if cmp.visible() then
		cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
	else
		fallback()
	end
end, { "i" })

local mappings = {
	["<Tab>"] = select_next_item,
	["<S-Tab>"] = select_prev_item,
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-b>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-e>"] = cmp.mapping.abort(),
	["<CR>"] = cmp.mapping.confirm { select = true },
}

local module = {
	mappings = mappings,
}

return module
