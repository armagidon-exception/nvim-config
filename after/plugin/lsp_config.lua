local mason_status, mason = pcall(require, 'mason')
local mason_lspconfig_status, mason_lspconfig = pcall(require, 'mason-lspconfig')
local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
local cmp_status, cmp = pcall(require, 'cmp')
local mapper = require'utils.mapping'

if not mason_status or not mason_lspconfig_status or not lspconfig_status or not cmp_status then
    return
end


vim.opt.completeopt = "menu,menuone,noselect"

local kindicons = {
    Text = "𝜯",
    Method = "μ",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "",
            package_uninstalled = "📥"
        }
    }
})

mason_lspconfig.setup {
    ensure_installed = {'sumneko_lua'},
    automatic_installation = true,
}


cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end, {"i","s","c",}),
        ['<S-Tab>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end, {'i', 's', 'c'}),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
    formatting = {
        fields = {'kind', 'abbr', 'menu' },
        format = require'lspkind'.cmp_format {
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                nvim_lua = '[NvimLua]',
                path = '[Path]',
            }),
            symbol_map = kindicons
        }
    }
}

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    },
    {
        { name = 'cmdline' }
    }),
})






local telescope_status, telescope = pcall(require, 'telescope.builtin')


local on_attach = function(_, bufnr)
    if telescope_status then
        mapper.nmap('<leader>ref', telescope.lsp_references, { buffer = bufnr })
        mapper.nmap('<leader>gi', telescope.lsp_implementations, { buffer = bufnr })
        mapper.nmap('<leader>td', telescope.lsp_type_definitions, { buffer = bufnr })
        mapper.nmap('<leader>gD', telescope.lsp_definitions, { buffer = bufnr })
        mapper.nmap('<leader>di', telescope.diagnostics, {buffer = bufnr})
    end
    mapper.nmap('<leader>gd', vim.lsp.buf.declaration, { buffer = bufnr })
    mapper.nmap('<leader>K', vim.lsp.buf.hover, { buffer = bufnr })
    mapper.nmap('<S-p>', vim.lsp.buf.signature_help, { buffer = bufnr })
    mapper.nmap('<leader>rn', vim.lsp.buf.rename, { buffer = bufnr })
    mapper.nmap('<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })

    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
    })
end


-- Setup Lua with nvim integration
local neodev = require'neodev'
neodev.setup()

mason_lspconfig.setup_handlers {
    function(server_name)
        local capabilities = require'cmp_nvim_lsp'.default_capabilities()
        lspconfig[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
        }
    end
}



