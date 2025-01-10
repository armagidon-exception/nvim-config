local function export()
	local telescope = require "telescope"
	local action_state = require "telescope.actions.state"
	local t_actions = require "telescope.actions"
	local builtin = require "telescope.builtin"
	local extras = {}

	function extras.find_hidden_files()
		builtin.find_files { hidden = true }
	end

	function extras.browse_selected_dir()
		telescope.extensions.file_browser.file_browser {
			path = getmetatable(action_state.get_selected_entry()).cwd,
		}
	end

	function extras.search_git_files()
		builtin.git_files { recurse_submodules = false }
	end

	function extras.find_in_directory(promptnr)
		local picker = action_state.get_current_picker(promptnr)
		builtin.find_files {
			cwd = picker.finder.path,
		}
	end

	extras.mime_hook = function(filepath, bufnr, opts)
		local is_image = function(filepath)
			local image_extensions = { "png", "jpg" } -- Supported image formats
			local ext = vim.fn.fnamemodify(filepath, ":e")
			return vim.tbl_contains(image_extensions, ext)
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

	extras.select_prev = function(promptnr)
		t_actions.toggle_selection(promptnr)
		t_actions.move_selection_previous(promptnr)
	end

	extras.select_next = function(promptnr)
		t_actions.toggle_selection(promptnr)
		t_actions.move_selection_next(promptnr)
	end

	extras.execute_shell_command = function(promptnr)
		local stream = require "utils.stream"
		local picker = action_state.get_current_picker(promptnr)
		local finder = picker.finder
		local cwd = finder.path or error "This finder does not support command execution"
		local input = vim.fn.input { prompt = "Enter command: " }

		if #input == 0 then
			return
		end

		local function reload()
			picker:refresh(finder, { reset_prompt = true })
		end

		local paths = stream.table_map(picker:get_multi_selection(), function(val)
			return val[1]
		end)

		local TELESCOPE_SELECTION = table.concat(paths, " ")

		vim.fn.jobstart(input, {
			env = {
				TELESCOPE_SELECTION = TELESCOPE_SELECTION,
			},
			cwd = cwd,
			detach = 0,
			on_stdout = function(n, stdout)
				vim.notify(table.concat(stdout, "\n"), vim.log.INFO)
				reload()
			end,
			on_stderr = function(id, stderr)
				vim.notify(table.concat(stderr, "\n"), vim.log.ERROR)
				reload()
			end,
			stdout_buffered = true,
			stderr_buffered = true,
		})
	end

	extras.mappings = {}

	extras.mappings._defaults = {
		normal = {
			["<Tab>"] = t_actions.move_selection_next,
			["<S-Tab>"] = t_actions.move_selection_previous,
			["="] = t_actions.toggle_selection,
			["K"] = extras.select_prev,
			["J"] = extras.select_next,
			["<Up>"] = t_actions.nop,
			["<Down>"] = t_actions.nop,
			["q"] = t_actions.close,
		},
	}

	extras.mappings._file_browser = {
		normal = {
			F = extras.find_in_directory,
			x = extras.browse_selected_dir,
		},
	}

	extras.mappings._find_files = {
		normal = {
			["<C-h>"] = extras.find_hidden_files,
			F = extras.browse_selected_dir,
			g = extras.search_git_files,
		},
	}

	extras.mappings = setmetatable(extras.mappings, {
		__index = function(self, key)
			if string.find(key, "^_") then
				error "accessing private field"
			end
			local t_actions = require "telescope.actions"

			local mappings = rawget(self, string.format("_%s", key))
				or error(string.format("Mappings group %s was not found", key))

			mappings = vim.tbl_deep_extend("force", rawget(self, "_defaults"), mappings)

			return setmetatable(mappings, {
				__index = function(t, k)
					return rawget(t, k) or {}
				end,
			})
		end,
	})

	return extras
end

return {
	"nvim-telescope/telescope.nvim",
	opts = function(_, opts)
		local extras = export()
		opts.defaults.mappings.i = extras.mappings.defaults.insert
		opts.defaults.mappings.n = extras.mappings.defaults.normal
		opts.defaults.preview.mime_hook = extras.mime_hook

		opts.pickers.find_files.mappings.n = extras.mappings.find_files.normal
		opts.pickers.find_files.mappings.i = extras.mappings.find_files.insert

		opts.extensions.file_browser.mappings.n = extras.mappings.file_browser.normal
		opts.extensions.file_browser.mappings.i = extras.mappings.file_browser.insert
	end,
}
