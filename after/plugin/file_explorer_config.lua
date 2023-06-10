local mapper = require('utils.mapping')
local telescope_status, telescope = pcall(require, 'telescope')

if not telescope_status then
    return
end


telescope.setup({
    extensions = {
        file_browser = {
            theme = "dropdown",
            path = "%:p:h",
            hijack_netrw = true,
            hidden = true,
            mappings = {
                n = {
                    F = function (_)
                        local file_explorer_status, file_explorer = pcall(require, 'utils.file_explorer')
                        if not file_explorer_status then
                            return
                        end
                        file_explorer.find_files()
                    end
                }
            }
        },
    }
})
telescope.load_extension 'file_browser'

local file_explorer_status, file_explorer = pcall(require, 'utils.file_explorer')
if file_explorer_status then
    mapper.nmap('<leader>fb', function () file_explorer.file_browser() end, {}, 'Open browser')
end

