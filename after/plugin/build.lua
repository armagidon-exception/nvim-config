local Terminal = require("toggleterm.terminal").Terminal

local run_cmds = {
	cs = {
		cmd = "dotnet run",
		src_dir_patterns = { ".git", "*.csproj" },
	},
    lua = {
        cmd = "lua %",
        src_dir_patterns = { ".git", ".luarc.json" }
    }
}

local build_cmds = {}

vim.api.nvim_create_user_command("Run", function()
	local ft = vim.bo.filetype
	local config = run_cmds[ft]
	if not config then
		vim.notify("This filetype does not have run config", vim.log.levels.WARN)
		return
	end
	local bufnr = vim.api.nvim_get_current_buf()
	local client = vim.lsp.get_active_clients({ bufnr = bufnr })[1]
	local lsp_util = require "lspconfig.util"

	local root_dir
	if client then
		root_dir = client.config.root_dir
	else
		root_dir = lsp_util.root_pattern(config.src_dir_patterns)(vim.fn.expand "%") or vim.fs.dirname "%"
	end
	Terminal:new({
		cmd = 'time ' .. vim.fn.expand(config.cmd),
		dir = root_dir,
        on_close = function (term)
            vim.fn.chanclose(term.job_id)
        end
	}):toggle()
end, { desc = "Runs run config for given filetype" })
