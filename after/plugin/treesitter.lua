local treesitter_configs = require 'utils.importer'.import('nvim-treesitter.configs')
if not treesitter_configs then return end

treesitter_configs.setup {
    ensure_installed = { "lua", "query" },
    auto_install = true,
    highlight = {
        enabled = true
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
