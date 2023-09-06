local mason = require'mason'
local mason_lsp = require'mason-lspconfig'
local lsp_cfgs = require'configs.lsp'
local lspconfig = require'lspconfig'

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

require("neodev").setup()

mason_lsp.setup {
    ensure_installed = { "lua_ls" },
    automatic_installation = true,
    handlers = {
        function(server_name)
            lspconfig[server_name].setup(lsp_cfgs.get_handler(server_name))
        end
    }
}
