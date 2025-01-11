local project_types = {
	{
		type = "C",
		generate = function(project_path)
			vim.notify "Generating C project"
			vim.system(
				{ "sh", string.format("%s/scripts/project_generator.sh", vim.fn.stdpath "config"), "C", project_path },
				{},
				function(obj)
					if obj.code > 0 then
						vim.notify("ERROR while executing the script", vim.log.levels.ERROR)
						vim.notify(obj.stderr, vim.log.levels.ERROR)
					else
						vim.notify(obj.stdout)
						vim.notify "DONE"
					end
				end
			)
		end,
	},
	{
		type = "C++",
		generate = function(project_path)
			vim.notify "Generating C++ project"
			vim.system(
				{ "sh", string.format("%s/scripts/project_generator.sh", vim.fn.stdpath "config"), "C++", project_path },
				{},
				function(obj)
					if obj.code > 0 then
						vim.notify("ERROR while executing the script", vim.log.levels.ERROR)
						vim.notify(obj.stderr, vim.log.levels.ERROR)
					else
						vim.notify(obj.stdout)
						vim.notify "DONE"
					end
				end
			)
		end,
	},
	{
		type = "python",
		generate = function(project_path)
			error "Not implemented yet"
		end,
	},
	{
		type = "Codeforces",
		generate = function(project_path)
			error "Not implemented yet"
		end,
	},
}

local function promnt_project_create()
	local project_path = vim.fn.input("Project directory: ", vim.fn.fnamemodify(vim.fn.expand "%", ":p:h"), "dir")
	local pickers = require "telescope.pickers"
	local finders = require "telescope.finders"
	local actions = require "telescope.actions"
	local state = require "telescope.actions.state"
	local telescope_config = require("telescope.config").values

	if project_path == "" then
		return
	end

	if vim.fn.isdirectory(project_path) == 1 then
		vim.notify("directory already exists", vim.log.levels.ERROR)
		return
	end

	local finder = finders.new_table {
		results = project_types,
		entry_maker = function(entry)
			return {
				display = function(entry)
					return entry.name
				end,
				name = entry.type,
				generate = entry.generate,
				ordinal = entry.type,
			}
		end,
	}

	local project_actions = require "telescope._extensions.project.actions"

	local picker = pickers.new(require("telescope.themes").get_dropdown(), {
		results_title = "Options",
		prompt_title = "Project type",
		finder = finder,
		previewer = false,
		sorter = telescope_config.generic_sorter {},
		attach_mappings = function(prompt_bufnr, map)
			local on_project_selected = function()
				local selected_entry = state.get_selected_entry(prompt_bufnr)
				if selected_entry == nil then
					actions.close(prompt_bufnr)
					return
				end

				actions.close(prompt_bufnr)
				selected_entry.generate(project_path)

				project_actions.add_project_path(project_path)
			end
			actions.select_default:replace(on_project_selected)
			return true
		end,
	})

	picker:find()
end
return {
	{
		"nvim-telescope/telescope-project.nvim",
		event = { "VeryLazy" },
		keys = {
			{
				"<leader>prjs",
				"<cmd>Telescope project<cr>",
				desc = "Open projects",
			},
		},
		dependencies = {
			{
				"nvim-telescope/telescope.nvim",
				opts = function(_, opts)
					if not opts.extensions then
						opts.extensions = {}
					end
					opts.extensions.project = {
						theme = "dropdown",
						mappings = {
							n = {
								cc = promnt_project_create,
							},
						},
					}
				end,
			},
		},
		config = function(_, opts)
			require("telescope").load_extension "project"
		end,
	},
}
