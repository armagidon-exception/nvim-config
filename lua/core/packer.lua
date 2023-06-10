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

    -- Color scheme
    use 'folke/tokyonight.nvim'
    
    -- Status line
    use 'nvim-lualine/lualine.nvim'
    
    -- Icons
    use 'nvim-tree/nvim-web-devicons'

    -- Projects
    use "ahmedkhalf/project.nvim"

    -- Terminal
    use "akinsho/toggleterm.nvim"

    -- Greeter
    use 'goolord/alpha-nvim'

    -- Bufferline
    use 'akinsho/bufferline.nvim'

    -- Telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/plenary.nvim'
    use "nvim-telescope/telescope-file-browser.nvim"
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    use 'nvim-telescope/telescope-ui-select.nvim'
    use 'nvim-telescope/telescope-symbols.nvim'

    -- Treesitter
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/playground'

    -- Surround
    use "kylechui/nvim-surround"
    
    -- Commentary
    use "terrortylor/nvim-comment"
    
    -- Autopairs
    
    -- Autotags
    use 'windwp/nvim-ts-autotag'

    if packer_bootstrap then
        require('packer').sync()
    end
end

return require('packer').startup({install_plugins, config = packer_config})
