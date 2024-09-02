local module = {}

function module.table_map(tbl, mapper)
	tbl = tbl or error()
	mapper = mapper or error()

	local ret = {}

	for _, value in ipairs(tbl) do
		table.insert(ret, mapper(value))
	end

	return ret
end

return module
