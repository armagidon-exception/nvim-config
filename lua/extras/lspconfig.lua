local tele_builtin = require "telescope.builtin"

local manual_configs = {}
local M = {}

function M.setup_autocmds()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(event)
			M.setup_keymappings(event.buf)
		end,
	})
end

function M.setup_keymappings(bufnr)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Show declaration" })
	vim.keymap.set("n", "gd", tele_builtin.lsp_definitions, { buffer = bufnr, desc = "Show definitions" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show hover" })
	vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Show implemetation" })
	vim.keymap.set(
		"n",
		"<leader>D",
		tele_builtin.lsp_type_definitions,
		{ buffer = bufnr, desc = "Show type definitions" }
	)
	vim.keymap.set("n", "<leader>rn", function()
		return string.format(":IncRename %s", vim.fn.expand "<cword>")
	end, { desc = "Rename under the cursor", buffer = bufnr, expr = true })

	vim.keymap.set(
		{ "n", "v" },
		"<leader>ca",
		require("actions-preview").code_actions,
		{ buffer = bufnr, desc = "Show code actions" }
	)
	vim.keymap.set("n", "<leader>ref", tele_builtin.lsp_references, { buffer = bufnr, desc = "Show lsp references" })
	vim.keymap.set("n", "<leader>di", tele_builtin.diagnostics, { desc = "Show diagnostics", buffer = bufnr })
end

manual_configs["csharp_ls"] = function()
	local lspconfig = require "lspconfig"
	lspconfig["csharp_ls"].setup {
		handlers = {
			["textDocument/definition"] = require("csharpls_extended").handler,
		},
	}
end

manual_configs["clangd"] = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client and client.name == "clangd" then
				vim.keymap.set(
					"n",
					"<leader>ch",
					"<cmd>ClangdSwitchSourceHeader<cr>",
					{ desc = "Switch Source/Header (C/C++)" }
				)
			end
		end,
	})

	local root_files = {
		"Makefile",
		"configure.ac",
		"configure.in",
		"config.h.in",
		"meson.build",
		"meson_options.txt",
		"build.ninja",
	}
	local lspconfig = require "lspconfig"
	lspconfig["clangd"].setup {
		on_attach = function(client, bufnr)
			client.server_capabilities.signatureHelpProvider = false
		end,
		root_dir = function(fname)
			return require("lspconfig.util").root_pattern(unpack(root_files))(fname)
				or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname)
				or require("lspconfig.util").find_git_ancestor(fname)
		end,

		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--header-insertion=iwyu",
			"--completion-style=detailed",
			"--function-arg-placeholders",
			"--fallback-style=llvm",
		},
	}
end

M.manual_configs = manual_configs

return M
