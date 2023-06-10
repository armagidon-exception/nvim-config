local telescope_status, telescope = pcall(require, 'telescope')

if not telescope_status then
    error('Telescope is not installed')
end

local file_browser_status, file_browser  = pcall(function ()
    return telescope.extensions.file_browser
end)

if not file_browser_status then
    error('Telescope file_browser is not installed')
end

local M = {}


function M.file_browser(attach_mappings)
    attach_mappings = attach_mappings or function () end
    file_browser.file_browser({
        attach_mappings = function (prompt_bufnr, map)
            map('n', 'F', function ()
                M.find_files(attach_mappings)
            end)
            attach_mappings(prompt_bufnr, map)
            return true
        end
    })
end

function M.find_files(attach_mappings)
    attach_mappings = attach_mappings or function () end
    require('telescope.builtin').find_files({
        attach_mappings = function (prompt_bufnr, map)
            map('n', 'F', function ()
                M.file_browser(attach_mappings)
            end)
            attach_mappings(prompt_bufnr, map)
            return true
        end
    })
end


return M
