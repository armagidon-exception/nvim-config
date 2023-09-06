local ts_configs = require'nvim-treesitter.configs'

require("nvim-treesitter.install").prefer_git = true

ts_configs.setup {
    ensure_installed = {"lua"},
    auto_install = true,

    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = {
        enable = true
    },
    autotag = {
        enable = true,
    }
}
