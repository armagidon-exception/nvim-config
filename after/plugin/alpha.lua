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
    local file_explorer = require('utils.file_explorer')

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

    file_explorer.file_browser(run_selection)
end

local config_button = button('c', '  Configuration')
config_button.on_press = function ()
    local path = '~/.config/nvim/'
    path = vim.fs.normalize(path)
    vim.cmd('e ' .. path)
    vim.fn.chdir(path)
    vim.notify_once('Configuring...', vim.log.levels.INFO)
end


theme.section.buttons.val = {
    edit_file_button,
    button("SPC f f", "  Find file"),
    button("r", "  Recent"   , "<cmd>Telescope oldfiles<CR>"),
    config_button,
    button("q", "  Exit vim", "<cmd>wqa<cr>")
}

alpha.setup(theme.config)
