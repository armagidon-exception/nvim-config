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

vim.api.nvim_create_user_command("Root", function ()
    local file = vim.fn.expand('%')
    if vim.fn.isdirectory(file) == 1 then
        vim.fn.chdir(file)
    elseif vim.fn.filereadable(file) then
        local parent = vim.fs.dirname(file)
        vim.fn.chdir(parent)
    else
        vim.notify('Cannot cd to non file', vim.log.levels.ERROR)
    end
end, {})
