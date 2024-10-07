return {
    {
        "folke/lazydev.nvim",
        priority = 500,
        ft = "lua",
        dependencies = {
            { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
            {                                        -- optional completion source for require statements and module annotations
                "hrsh7th/nvim-cmp",
                opts = function(_, opts)
                    opts.sources = opts.sources or {}
                    table.insert(opts.sources, {
                        name = "lazydev",
                        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                    })
                end,
            },
        },
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },                                        -- For neovim docs
    { "folke/neoconf.nvim", priority = 500 }, -- Json configuration for lua_ls
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        dependencies = {
            { "Decodetalkers/csharpls-extended-lsp.nvim" },
        },
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java", "class" },
    }, -- Adapter plugin for jdtls
    {
        "ranjithshegde/ccls.nvim",
        ft = { "c", "cpp", "objc", "objcpp", "opencl" },
        config = function()
            local util = require "lspconfig.util"
            local server_config = {
                filetypes = { "c", "cpp", "objc", "objcpp", "opencl" },
                root_dir = function(fname)
                    return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".ccls", "Makefile")(
                            fname)
                        or util.find_git_ancestor(fname)
                end,
                init_options = {
                    cache = {
                        directory = vim.fs.normalize "~/.cache/ccls/",
                    }
                },
            }
            require("ccls").setup { lsp = { lspconfig = server_config } }
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            local lspconfig = require "lspconfig"

            local function fetch_lsp()
                local msg = "No Active Lsp"
                local buf_ft = vim.bo.filetype
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                    return msg
                end

                for _, client in ipairs(clients) do
                    local config = lspconfig[client.name]
                    if config and config.filetypes and vim.fn.index(config.filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return msg
            end

            require("utils.table").insert_in(opts, { "sections", 'lualine_c' }, { fetch_lsp, icon = " LSP:" })
        end,
    }
}
