require("tokyonight").setup({
  style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be boldB
  on_highlights = function(hl, c)
    hl.TelescopeResultsDiffChange = {
        bg = nil,
        fg = c.gitSigns.change
    }
    hl.TelescopeResultsDiffDelete = {
        bg = nil,
        fg = c.gitSigns.delete,
    }
    hl.TelescopeResultsDiffAdd = {
        bg = nil,
        fg = c.gitSigns.add,
    }
    hl.TelescopeResultsDiffUntracked = {
        bg = nil,
        fg = '#2e0b09'
    }

  end
})

vim.cmd.colorscheme('tokyonight')
