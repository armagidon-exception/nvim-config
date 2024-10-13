local M = {}

function M.set_in(src, keys, value)
	local c = src
	for i = 1, #keys - 1, 1 do
		local key = keys[i]
		if not c[key] then
			c[key] = {}
		end
		c = c[key]
	end
	c[keys[#keys]] = value
end

function M.insert_in(src, keys, value, unpack)
	local c = src
	unpack = unpack or false
	for i = 1, #keys, 1 do
		local key = keys[i]
		if not c[key] then
			c[key] = {}
		end
		c = c[key]
	end
	if unpack then
		for _, v in pairs(value) do
			table.insert(c, v)
		end
	else
		table.insert(c, value)
	end
end

function M.merge_onto(dest, src)
	for _, v in ipairs(src) do
		table.insert(dest, vim.deepcopy(v))
	end

	for k, v in pairs(src) do
		if type(k) ~= "number" then
			if dest[k] == nil then
				dest[k] = vim.deepcopy(v)
			elseif type(dest[k]) ~= "table" then
				error(string.format("Key %s: Cannot merge types %s and %s", k, type(dest[k]), type(v)))
			else
				M.merge_onto(dest[k], v)
			end
		end
	end
end

return M
