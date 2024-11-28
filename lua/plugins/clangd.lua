local extras = require 'extras.lspconfig'
local manual_configs = extras.manual_configs

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
        "compile_commands.json",
        "compile_flags.txt",
        ".clangd.json"
    }
    local lspconfig = require "lspconfig"

    lspconfig["clangd"].setup {
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

return {
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        opts = {
            ast = {
                role_icons = {
                    type = "",
                    declaration = "",
                    expression = "",
                    specifier = "",
                    statement = "",
                    ["template argument"] = "",
                },
                kind_icons = {
                    Compound = "",
                    Recovery = "",
                    TranslationUnit = "",
                    PackExpansion = "",
                    TemplateTypeParm = "",
                    TemplateTemplateParm = "",
                    TemplateParamObject = "",
                },
            },
        },
        config = function(_, opts)
            require("clangd_extensions").setup(opts)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local buf = event.bufnr
                    local group = vim.api.nvim_create_augroup("clangd_no_inlay_hints_in_insert", { clear = true })

                    vim.keymap.set("n", "<leader>lh", function()
                        if require("clangd_extensions.inlay_hints").toggle_inlay_hints() then
                            vim.api.nvim_create_autocmd("InsertEnter", {
                                group = group,
                                buffer = buf,
                                callback = require("clangd_extensions.inlay_hints").disable_inlay_hints,
                            })
                            vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
                                group = group,
                                buffer = buf,
                                callback = require("clangd_extensions.inlay_hints").set_inlay_hints,
                            })
                        else
                            vim.api.nvim_clear_autocmds { group = group, buffer = buf }
                        end
                    end, { buffer = buf, desc = "[l]sp [h]ints toggle" })
                end,
            })
        end,
    },
    {
        "nvim-cmp",
        opts = function(_, opts)
            require("utils.table").merge_onto(opts, {
                sorting = {
                    comparators = {
                        require "clangd_extensions.cmp_scores",
                    },
                },
            })
        end,
    },
}
