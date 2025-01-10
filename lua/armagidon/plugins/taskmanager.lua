return {
	{
		"stevearc/overseer.nvim",
		cmd = {
			"OverseerOpen",
			"OverseerClose",
			"OverseerToggle",
			"OverseerSaveBundle",
			"OverseerLoadBundle",
			"OverseerDeleteBundle",
			"OverseerRunCmd",
			"OverseerRun",
			"OverseerInfo",
			"OverseerBuild",
			"OverseerQuickAction",
			"OverseerTaskAction",
			"OverseerClearCache",
            "Make",
		},
		opts = {
			dap = false,
			task_list = {
				bindings = {
					["<C-h>"] = false,
					["<C-j>"] = false,
					["<C-k>"] = false,
					["<C-l>"] = false,
				},
				direction = "left",
			},
			form = {
				win_opts = {
					winblend = 0,
				},
			},
			confirm = {
				win_opts = {
					winblend = 0,
				},
			},
			task_win = {
				win_opts = {
					winblend = 0,
				},
			},
		},
        -- stylua: ignore
        keys = {
            { "<leader>ow", "<cmd>OverseerToggle<cr>",      desc = "Task list" },
            { "<leader>oo", "<cmd>OverseerRun<cr>",         desc = "Run task" },
            { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
            { "<leader>oi", "<cmd>OverseerInfo<cr>",        desc = "Overseer Info" },
            { "<leader>ob", "<cmd>OverseerBuild<cr>",       desc = "Task builder" },
            { "<leader>ot", "<cmd>OverseerTaskAction<cr>",  desc = "Task action" },
            { "<leader>oc", "<cmd>OverseerClearCache<cr>",  desc = "Clear cache" },
        },
		config = function(plugin, opts)
			require("overseer").setup(opts)

			vim.api.nvim_create_user_command("Make", function(params)
				-- Insert args at the '$*' in the makeprg
				local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
				if num_subs == 0 then
					cmd = cmd .. " " .. params.args
				end
				local task = require("overseer").new_task {
					cmd = vim.fn.expandcmd(cmd),
					components = {
						{ "on_output_quickfix", open = not params.bang, open_height = 8 },
						"unique",
						"default",
					},
				}
				task:start()
			end, {
				desc = "Run your makeprg as an Overseer task",
				nargs = "*",
				bang = true,
			})
		end,
	},
}
