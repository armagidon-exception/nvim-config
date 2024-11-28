local tbl = require "utils.table"
return {
    {
        "folke/lazydev.nvim",
        priority = 500,
        ft = "lua",
        dependencies = {
            { "Bilal2453/luvit-meta", lazy = true },
            {
                "nvim-cmp",
                opts = function(_, opts)
                    tbl.merge_onto(opts, { sources = { { name = "lazydev", group_index = 0 } } })
                end,
            },
        },
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "folke/neoconf.nvim" }, -- Json configuration for lua_ls
}
