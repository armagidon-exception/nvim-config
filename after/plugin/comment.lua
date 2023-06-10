local comment_status, comment = pcall(require, 'nvim_comment')
if not comment_status then
    vim.notify("This module requires nvim_comment plugin", vim.log.levels.ERROR)
    return
end

comment.setup()
