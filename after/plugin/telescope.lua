local protection = require'utils.protection'
local mapper = require'utils.mapping'
local telescope_status, telescope = pcall(require, 'telescope')

if not telescope_status then
    return
end


local actions = require'telescope.actions'
telescope.setup {
    defaults = {
        preview = {
            mime_hook = function(filepath, bufnr, opts)
                local is_image = function(filepath)
                    local image_extensions = {'png','jpg'}   -- Supported image formats
                    local split_path = vim.split(filepath:lower(), '.', {plain=true})
                    local extension = split_path[#split_path]
                    return vim.tbl_contains(image_extensions, extension)
                end
                if is_image(filepath) then
                    local term = vim.api.nvim_open_term(bufnr, {})
                    local function send_output(_, data, _ )
                        for _, d in ipairs(data) do
                            vim.api.nvim_chan_send(term, d..'\r\n')
                        end
                    end
                    vim.fn.jobstart(
                    {
                        'catimg', filepath  -- Terminal image viewer command
                    },
                    {on_stdout=send_output, stdout_buffered=true, pty=true})
                else
                    require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
                end
            end
        },
        mappings = {
            i = {
                ['<Tab>'] = actions.move_selection_next,
                ['<S-Tab>'] = actions.move_selection_previous,
                ["<Up>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<Down>"] = actions.toggle_selection + actions.move_selection_better,
            },
            n = {
                ['<Tab>'] = actions.move_selection_next,
                ['<S-Tab>'] = actions.move_selection_previous,
                ["<Up>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<Down>"] = actions.toggle_selection + actions.move_selection_better,
            }
        },
    },
    pickers = {
        find_files = {
            prompt_prefix = '🔍',
        },
        buffers = {
            theme = 'dropdown',
        },
    },
    extensions = {
        file_browser = {
            theme = "dropdown",
            path = "%:p:h",
            hijack_netrw = true,
        }
    },
    ['ui-select'] = {
        require'telescope.themes'.get_cursor {}
    }
}



telescope.load_extension 'file_browser'
telescope.load_extension 'fzf'
telescope.load_extension 'ui-select'


local builtin = require'telescope.builtin'
local file_browser = telescope.extensions.file_browser

mapper.nmap('<leader>ff', builtin.find_files)
mapper.nmap('<leader>fb', file_browser.file_browser)
mapper.nmap('<leader>bfs', builtin.buffers)
mapper.nmap('<leader>fip', builtin.live_grep)
