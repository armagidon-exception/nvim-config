local telescope = require("utils.importer").import "telescope"
if not telescope then
	return
end

local load_extension = function(name)
	require("utils.protection").pload(telescope.load_extension, name, function()
		vim.notify("Extension " .. name .. " is not found", vim.log.levels.ERROR)
	end)
end

local telescope_actions = require "telescope.actions"
local transform_mod = require("telescope.actions.mt").transform_mod

local custom_actions = {}

function custom_actions.open_find_files()
	vim.cmd "Telescope find_files"
end

function custom_actions.open_file_browser()
	vim.cmd "Telescope file_browser"
end

function custom_actions.move_selection_down(promptbfr)
	telescope_actions.toggle_selection(promptbfr)
	telescope_actions.move_selection_worse(promptbfr)
end

function custom_actions.move_selection_up(promptbfr)
	telescope_actions.move_selection_better(promptbfr)
	telescope_actions.toggle_selection(promptbfr)
end

function custom_actions.select(promptbfr)
    telescope_actions.toggle_selection(promptbfr)
end

custom_actions = transform_mod(custom_actions)

local default_remaps = {
	["<Tab>"] = telescope_actions.move_selection_next,
	["<S-Tab>"] = telescope_actions.move_selection_previous,
	["<C-n>"] = false,
	["<C-p>"] = false,
	["<Down>"] = custom_actions.move_selection_down,
	["<Up>"] = custom_actions.move_selection_up,
    ["="] = custom_actions.select
}

telescope.setup {
	defaults = {
		mappings = {
			i = default_remaps,
			n = default_remaps,
		},
		file_ignore_patterns = { "node_modules" },
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			cwd_to_path = true,
			path = "%:p:h",
			hijack_netrw = true,
			git_status = false,
			mappings = {
				n = {
					F = custom_actions.open_find_files,
				},
				i = {
					F = custom_actions.open_find_files,
				},
			},
		},
		["ui-select"] = {
			theme = "cursor",
		},
	},
	pickers = {
		buffers = {
			theme = "dropdown",
		},
		find_files = {
			mappings = {
				n = {
					F = custom_actions.open_file_browser,
				},
				i = {
					F = custom_actions.open_file_browser,
				},
			},
		},
		symbols = {
			theme = "dropdown",
		},
	},
}

load_extension "file_browser"
load_extension "fzf"
load_extension "projects"
load_extension "ui-select"

local mapper = require "utils.mapping"
local builtin = require "telescope.builtin"
local projects_ext = telescope.extensions.projects
local file_browser = telescope.extensions.file_browser

mapper.nmap("<leader>ff", builtin.find_files, {}, "Find files")
mapper.nmap("<leader>fip", builtin.live_grep, {}, "Find a string in files")
mapper.nmap("<leader>sym", builtin.symbols, {}, "Find icons")
mapper.nmap("<leader>prj", projects_ext.projects, {}, "Search projects")
mapper.nmap("<leader>fb", file_browser.file_browser, {}, "Open file browser")
mapper.nmap("<leader>bfs", builtin.buffers, {}, "Search buffers")
