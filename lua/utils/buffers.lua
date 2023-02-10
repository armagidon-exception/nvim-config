local function get_buffers(options)
    local buffers = {}
    options = options or {}
    local len = 0
    local options_listed = options.listed or false
    local vim_fn = vim.fn
    local buflisted = vim_fn.buflisted

    for buffer = 1, vim_fn.bufnr('$') do
        if not options_listed or buflisted(buffer) ~= 1 then
            len = len + 1
            buffers[len] = buffer
        end
    end

    return buffers
end


return {get_buffers = get_buffers}
