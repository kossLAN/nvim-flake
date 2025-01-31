if vim.fn.executable('qmlformat') ~= 1 then
  return
end

-- Stupid conform doesn't support qmlformat, and I don't want to download a
-- whole new fucking plugin so uh yea this is it ig.
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.qml',
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local cmd = string.format('qmlformat -i "%s"', filename)

    local output = vim.fn.system(cmd)
    local error_code = vim.v.shell_error

    if error_code ~= 0 then
      vim.notify(
        string.format('qmlformat failed (code %d):\nCommand: %s\nOutput: %s', error_code, cmd, output),
        vim.log.levels.ERROR
      )
    end

    vim.api.nvim_buf_set_option(bufnr, 'modified', false)
    vim.cmd('edit!')
  end,
})
