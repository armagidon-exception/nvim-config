return {
    cs = {"dotnet", "run"},
    markdown = {'sh', vim.fn.stdpath('config') .. '/scripts/preview_markdown.sh', "$FILE"}
}
