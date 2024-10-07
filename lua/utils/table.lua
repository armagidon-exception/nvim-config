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

return M
