local cmp = require'cmp'
local lsp_cfgs = require'configs.lsp.default'
local lspkind = require('lspkind')

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
        }),
    },
    window = {

    },
    experimental = {
        ghost_text = true,
    },
    mapping = cmp.mapping.preset.insert( lsp_cfgs.cmp.mappings),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = "path" },
    }),
})


cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})


cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
            { name = 'cmdline' }
        })
})
