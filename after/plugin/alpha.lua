local alpha_status, alpha = pcall(require, 'alpha')

if not alpha_status then
    return
end

local theme = require('alpha.themes.dashboard')
local button = theme.button


theme.section.header.val = {
    [[                                                  ]],
    [[                                                  ]],
    [[                                                  ]],
    [[                                                  ]],
    [[              ......      ..   .....              ]],
    [[            ..        .........     .             ]],
    [[           ..     .::....            .            ]],
    [[           .                                      ]],
    [[          .                                ..     ]],
    [[          .                           .      .:   ]],
    [[                                     .:.       ~  ]],
    [[                               ...:.           ^: ]],
    [[     .    .                  ^.    :           ~. ]],
    [[   ..     .       ..         :     ...        :~  ]],
    [[  ^       ^                  .......         ^^   ]],
    [[ ^.        .............::::::..          .^^.    ]],
    [[ ^:            ........                .:~^.      ]],
    [[  ~.                               .:^~:.         ]],
    [[   :^.                       ..:^^^:.             ]],
    [[     .^^::..        ...::^~~^^:.                  ]],
    [[         ...::::::::::...                         ]],
    [[                                                  ]],
    [[                                                  ]],
    [[                                                  ]],
}



local edit_file_button = button('e', 'פֿ  Edit file', '<cmd>')

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
edit_file_button.on_press = function ()
    local telescope_status, telescope = pcall(require, 'telescope')
    if not telescope_status then
        return
    end
    local file_browser = telescope.extensions.file_browser

    local function run_selection(prompt_bufnr, map)
        actions.select_default:replace_if(function ()
            local selection = action_state.get_selected_entry()
            return vim.fn.isdirectory(selection[1]) ~= 1
        end, function ()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.fn.chdir(vim.fs.dirname(selection[1]))
            vim.notify_once('Editing file ' .. vim.fn.resolve(selection[1]), vim.log.levels.INFO)
            vim.cmd('e ' .. selection[1])
        end)
        return true
    end

    file_browser.file_browser({attach_mappings = run_selection})
end


theme.section.buttons.val = {
    edit_file_button,
    button("SPC f f", "  Find file"),
    button("r", "  Recent"   , "<cmd>Telescope oldfiles<CR>"),
    button('c', '  Configuration', '<cmd>e ~/.config/nvim/<cr>'),
    button("q", "  Exit vim", "<cmd>wqa<cr>")
}

alpha.setup(theme.config)
