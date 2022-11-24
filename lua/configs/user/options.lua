local M = {}

M.global = function()
    vim.opt.listchars = "tab:» ,nbsp:+,trail:·,extends:→,precedes:←"
end

return M
