local npairs = require("nvim-autopairs")
npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string', 'comment'},-- it will not add a pair on that treesitter node
    }
})

local ts_conds = require('nvim-autopairs.ts-conds')
