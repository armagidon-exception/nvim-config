local class = {}

function class.pload(loader, name, handler)
    loader = loader or function() end
    handler = handler or function() end
    name = name or ''

    local status, _ = pcall(loader, name)
    if not status then 
        handler(name, status)
    end
end

function class.pgit(git_function)
    git_function = git_function or function () print("Warning: nil git function passed") end
    local currentDir = vim.fn.getcwd()
    local git_exists = vim.fn.isdirectory(currentDir .. '/.git')
    if git_exists == 1 then
        git_function()
        print"Run"
    else
        print "Error: This directory does not have git repository initialized"
    end
end

return class
