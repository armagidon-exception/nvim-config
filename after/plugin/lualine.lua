local status, lualine = pcall(require, 'lualine')
if not status then
    print("This module requires LuaLine to be installed")
    return
end


lualine.setup {
    options = {
        theme = 'carbonfox'
    }
}
