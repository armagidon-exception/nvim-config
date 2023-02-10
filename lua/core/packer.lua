local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer_config = {
    display = {
        open_fn = function()
            local result, win, buf = require('packer.util').float {
                border = {
                    { '╭', 'FloatBorder' },
                    { '─', 'FloatBorder' },
                    { '╮', 'FloatBorder' },
                    { '│', 'FloatBorder' },
                    { '╯', 'FloatBorder' },
                    { '─', 'FloatBorder' },
                    { '╰', 'FloatBorder' },
                    { '│', 'FloatBorder' },
                },
            }
            vim.api.nvim_win_set_option(win, 'winhighlight', 'NormalFloat:Normal')
            return result, win, buf
        end,
    },
}


local function install_plugins(use)
    use 'wbthomason/packer.nvim'

    -- Theme
    use "EdenEast/nightfox.nvim"

    -- Tree sitter
    use 'nvim-treesitter/nvim-treesitter'

    -- Multiple cursors
    use 'mg979/vim-visual-multi'

    -- Lualine
    use 'nvim-lualine/lualine.nvim'

    -- Icons
    use 'nvim-tree/nvim-web-devicons'

    -- Terminal
    use 'akinsho/toggleterm.nvim'

    -- Telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/plenary.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    use 'nvim-telescope/telescope-ui-select.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-telescope/telescope-symbols.nvim'


    -- LSP
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"
    use "folke/neodev.nvim"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-nvim-lua"
    use 'onsails/lspkind.nvim'

    -- Autopairs
    use "windwp/nvim-autopairs"

    -- Bufferline
    use 'noib3/nvim-cokeline'

    -- Greeter menu
    use 'goolord/alpha-nvim'

    if packer_bootstrap then
        require('packer').sync()
    end
end

return require('packer').startup({install_plugins, config = packer_config})
