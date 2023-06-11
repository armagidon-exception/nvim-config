local treesitter_configs = require 'utils.importer'.import('nvim-treesitter.configs')
if not treesitter_configs then return end

treesitter_configs.setup {
    ensure_installed = { "lua", "query" },
    auto_install = true,
    highlight = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = false,
            node_decremental = "grm",
        },
    },
    indent = {
        enable = true
    },
    autotag = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
    },
}



local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.ejs = {
    install_info = {
        url = "~/.config/nvim/local_parsers/tree-sitter-ejs/",
        files = { "src/parser.c" }, 
        requires_generate_from_grammar = false, 
    },
    filetype = "ejs",
}
