local builder = require("build.builder")
vim.api.nvim_create_user_command("Run", function()
	local ft = vim.bo.filetype
	builder.execute(ft, require "configs.building.runconfig")
end, { desc = "Runs run config for given filetype" })

vim.api.nvim_create_user_command("Compile", function()
	local ft = vim.bo.filetype
	builder.execute(ft, require "configs.building.buildconfig")
end, { desc = "Builds from config for given filetype" })
