local builder = require("building")
vim.api.nvim_create_user_command("Run", function()
	local ft = vim.bo.filetype
	builder.execute(ft, require "building.runconfig")
end, { desc = "Runs run config for given filetype" })

vim.api.nvim_create_user_command("Compile", function()
	local ft = vim.bo.filetype
	builder.execute(ft, require "building.buildconfig")
end, { desc = "Builds from config for given filetype" })
