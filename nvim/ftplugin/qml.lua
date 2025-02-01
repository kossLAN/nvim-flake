if vim.fn.executable('qmlformat') ~= 1 then
  return
end

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
