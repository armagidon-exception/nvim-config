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

extras.mime_hook = function(filepath, bufnr, opts)
	local is_image = function(filepath)
		local image_extensions = { "png", "jpg" } -- Supported image formats
		local split_path = vim.split(filepath:lower(), ".", { plain = true })
		local extension = split_path[#split_path]
		return vim.tbl_contains(image_extensions, extension)
	end
	if is_image(filepath) then
		local term = vim.api.nvim_open_term(bufnr, {})
		local function send_output(_, data, _)
			for _, d in ipairs(data) do
				vim.api.nvim_chan_send(term, d .. "\r\n")
			end
		end
		vim.fn.jobstart({
			"catimg",
			filepath, -- Terminal image viewer command
		}, { on_stdout = send_output, stdout_buffered = true, pty = true })
	else
		require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
	end
end

return extras
