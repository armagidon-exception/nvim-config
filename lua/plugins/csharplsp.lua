local extras = require 'extras.lspconfig'
return {
    {
        "Decodetalkers/csharpls-extended-lsp.nvim",
        dependencies = { "nvim-lspconfig", "telescope.nvim" },
        config = function()
            extras.manual_configs['csharp_ls'] = function()
                local lspconfig = require 'lspconfig'
                local telescope = require 'telescope'
                lspconfig['csharpls'].setup {
                    handlers = {
                        ["textDocument/definition"] = require('csharpls_extended').handler,
                        ["textDocument/typeDefinition"] = require('csharpls_extended').handler,
                    },
                }
                telescope.load_extension('csharpls_definition')
            end
        end
    },
}
