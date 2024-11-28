local lualine_extras = require "extras.lualine"
local tbl = require "utils.table"
return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local extras = require "extras.lspconfig"
            extras.setup_autocmds()
            for _, setup in pairs(extras.manual_configs) do
                if setup then
                    setup()
                end
            end
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            tbl.merge_onto(opts, {
                sections = {
                    lualine_c = {
                        lualine_extras.get_lsp_widget(),
                    },
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            local mason = require "mason"
            mason.setup {
                ui = {
                    check_outdated_packages_on_open = true,
                    border = "none",
                    width = 0.6,
                    height = 0.6,
                    icons = {
                        package_installed = "👍",
                        package_pending = "💫",
                        package_uninstalled = "😵",
                    },
                },
            }
        end,
    }, -- LSP package manager
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            local mason_lsp = require "mason-lspconfig"
            local lspconfig = require "lspconfig"

            mason_lsp.setup {
                ensure_installed = { "lua_ls" },
                automatic_installation = true,
                handlers = {
                    function(servername)
                        local extras = require "extras.lspconfig"
                        if extras.manual_configs[servername] then
                            return
                        end
                        lspconfig[servername].setup {}
                    end,
                },
            }
        end,
    },
}
