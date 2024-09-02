return {

    { "wbthomason/packer.nvim",        lazy = false },

    { "catppuccin/nvim",               lazy = false },

    -- Telescope stuff
    { "nvim-telescope/telescope.nvim", lazy = false },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    },
    { "nvim-telescope/telescope-file-browser.nvim",  lazy = false },
    { "nvim-telescope/telescope-ui-select.nvim",     lazy = false },
    { "nvim-telescope/telescope-symbols.nvim",       lazy = false },

    { "nvim-lua/plenary.nvim",                       lazy = false },

    { "nvim-tree/nvim-web-devicons",                 lazy = false },

    -- Project manager
    { "ahmedkhalf/project.nvim",                     lazy = false },

    -- Startup screen
    { "goolord/alpha-nvim",                          lazy = false },

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter",             lazy = false },
    { "windwp/nvim-ts-autotag",                      lazy = false },
    { "nvim-treesitter/nvim-treesitter-textobjects", lazy = false },

    { "hiphish/rainbow-delimiters.nvim",             lazy = false },

    -- Surround
    { "kylechui/nvim-surround",                      lazy = false },

    -- Commentary
    { "numToStr/Comment.nvim",                       lazy = false },

    -- Autopairs
    { "windwp/nvim-autopairs",                       lazy = false },

    -- Which key
    { "folke/which-key.nvim",                        lazy = false },

    -- Live Server
    { "barrett-ruth/live-server.nvim",               lazy = false },

    -- Hightlight hex color codes
    { "norcalli/nvim-colorizer.lua",                 lazy = false },

    -- Status line
    { "nvim-lualine/lualine.nvim",                   lazy = false },

    -- Bufferline
    { "akinsho/bufferline.nvim",                     lazy = false },

    { "akinsho/toggleterm.nvim",                     lazy = false },

    -- LSP
    { "neovim/nvim-lspconfig",                       lazy = false }, -- Collection of lsp configs
    { "williamboman/mason.nvim",                     lazy = false }, -- LSP package manager
    { "williamboman/mason-lspconfig.nvim",           lazy = false }, -- Hook for Mason and lsp config
    { "hrsh7th/cmp-nvim-lsp",                        lazy = false }, -- Completion
    { "hrsh7th/cmp-buffer",                          lazy = false }, -- Completion source for buffer
    { "hrsh7th/cmp-path",                            lazy = false }, -- Completion source for file system
    { "hrsh7th/cmp-cmdline",                         lazy = false }, -- Completion source for commands
    { "hrsh7th/nvim-cmp",                            lazy = false }, -- Completion
    --{ "yioneko/nvim-cmp", lazy = false}, -- Completion optimized
    { "L3MON4D3/LuaSnip",                            lazy = false }, -- Snippets
    { "rafamadriz/friendly-snippets",                lazy = false }, -- Snippet pack
    { "saadparwaiz1/cmp_luasnip",                    lazy = false }, -- Integration with cmp
    { "folke/neodev.nvim",                           lazy = false }, -- For neovim docs
    { "folke/neoconf.nvim",                          lazy = false }, -- Json configuration for lua_ls
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },                                                            -- Pretty diagnostics
    { "onsails/lspkind.nvim",                     lazy = false }, -- Kind Icons
    -- { "mhartington/formatter.nvim", lazy = false}, -- Formatters
    { "stevearc/conform.nvim",                    lazy = false }, -- Formattersplugi
    { "mfussenegger/nvim-lint",                   lazy = false }, -- Linter
    { "Decodetalkers/csharpls-extended-lsp.nvim", lazy = false },
    { "smjonas/inc-rename.nvim",                  lazy = false }, -- Incremental renaming
    { "aznhe21/actions-preview.nvim",             lazy = false }, -- Code actions menu
    { "mfussenegger/nvim-jdtls",                  lazy = false }, -- Adapter plugin for jdtls

    -- UI
    { "MunifTanjim/nui.nvim",                     lazy = false },
    { "rcarriga/nvim-notify",                     lazy = false },
    { "folke/noice.nvim",                         lazy = false },

    { "michaelrommel/nvim-silicon",               lazy = false },

    { "tpope/vim-fugitive",                       lazy = false },
}
