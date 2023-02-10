local function set_cwd_from_params()
    local first_argument = vim.v.argv[2]
    if not first_argument then return end

    if first_argument == '.' then
        first_argument = vim.fn.getcwd()
    elseif first_argument == '..' then
        local curr = vim.fn.getcwd()
        first_argument = tostring(vim.fs.dirname(curr))
    end
    if vim.fn.isdirectory(first_argument) == 1 then
        vim.fn.chdir(first_argument)
    else
        local parent = tostring(vim.fs.dirname(first_argument))
        vim.fn.chdir(parent)
    end
end

if not _G.cwd_parent_set then
    set_cwd_from_params()
    _G.cwd_parent_set = true
end
