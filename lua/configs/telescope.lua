local telescope = require "telescope"
local t_actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local extras = {}

function extras.find_hidden_files()
	builtin.find_files { hidden = true }
end

function extras.browse_selected_dir()
	local action_state = require "telescope.actions.state"
	telescope.extensions.file_browser.file_browser {
		path = getmetatable(action_state.get_selected_entry()).cwd,
	}
end

function extras.search_git_files()
	builtin.git_files { recurse_submodules = false }
end

function extras.find_in_directory(promptnr)
	local action_state = require "telescope.actions.state"
	local picker = action_state.get_current_picker(promptnr)
	builtin.find_files {
		cwd = picker.finder.path,
	}
end

return extras
