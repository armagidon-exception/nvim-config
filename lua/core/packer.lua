local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local packer_config = {
    display = {
        open_fn = function()
            local result, win, buf = require("packer.util").float {
                border = {
                    { "╭", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "╮", "FloatBorder" },
                    { "│", "FloatBorder" },
                    { "╯", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "╰", "FloatBorder" },
                    { "│", "FloatBorder" },
                },
            }
            vim.api.nvim_win_set_option(win, "winhighlight", "NormalFloat:Normal")
            return result, win, buf
        end,
    },
}

local function install_plugins(use)
    use "wbthomason/packer.nvim"

    -- Color scheme
    use "folke/tokyonight.nvim"

    -- Status line
    use "nvim-lualine/lualine.nvim"

    -- Icons
    use "nvim-tree/nvim-web-devicons"

    -- Projects
    use "ahmedkhalf/project.nvim"

    -- Terminal
    use "akinsho/toggleterm.nvim"

    -- Greeter
    use "goolord/alpha-nvim"

    -- Bufferline
    use "akinsho/bufferline.nvim"

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope-file-browser.nvim"
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    }
    use "nvim-telescope/telescope-ui-select.nvim"
    use "nvim-telescope/telescope-symbols.nvim"

    -- Treesitter
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/playground"

    -- Surround
    use "kylechui/nvim-surround"
    -- Commentary
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use "numToStr/Comment.nvim"
    -- Autopairs
    use "windwp/nvim-autopairs"

    -- Autotags
    use "windwp/nvim-ts-autotag"

    -- Which key
    use "folke/which-key.nvim"

    -- LSP
    use "neovim/nvim-lspconfig"          -- Collection of lsp configs
    use "williamboman/mason.nvim"        -- LSP package manager
    use "williamboman/mason-lspconfig.nvim" -- Hook for Mason and lsp config
    use "hrsh7th/cmp-nvim-lsp"           -- Completion
    use "hrsh7th/cmp-buffer"             -- Completion source for buffer
    use "hrsh7th/cmp-path"               -- Completion source for file system
    use "hrsh7th/cmp-cmdline"            -- Completion source for commands
    use "hrsh7th/nvim-cmp"               --  Completion
    use "jose-elias-alvarez/null-ls.nvim" -- hooking into lsp
    use "jay-babu/mason-null-ls.nvim"    -- Bridge for mason and null-ls
    use "dcampos/nvim-snippy"            -- Snippets
    use "dcampos/cmp-snippy"             -- Snippets
    use "folke/neodev.nvim"              -- For neovim docs
    use "folke/neoconf.nvim"             -- Json configuration for lua_ls
    use "folke/trouble.nvim"             -- Pretty diagnostics
    use "onsails/lspkind.nvim"           -- Kind Icons
    use "ray-x/lsp_signature.nvim"       -- Method signature

    if packer_bootstrap then
        require("packer").sync()
    end
end

return require("packer").startup { install_plugins, config = packer_config }
