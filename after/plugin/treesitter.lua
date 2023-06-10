local treesitter_status, treesitter = pcall(require, 'nvim-treesitter')

if not treesitter_status then
    print("This module requires TreeSitter to be installed")
    return
end

local configs = require'nvim-treesitter.configs'

configs.setup {
    ensure_installed = { "lua" },
    sync_install = true,
    auto_install = true,
    -- Modules
    highlight = {
        enable = true,
    },
    indent = {
        enabled = true,
    }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.ejs = {
  install_info = {
    url = "~/.config/nvim/tree-sitter-ejs/", -- local path or git repo
    files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "ejs",
}
