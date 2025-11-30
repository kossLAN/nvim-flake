require('toggleterm').setup {
  open_mapping = nil,
  direction = 'float',
  persist_mode = false,
  auto_scroll = false,
}

-- Allow for 10 terminal spawns mapped to NumKeys.
for i = 0, 9 do
  vim.api.nvim_set_keymap('n', '<C-' .. i .. '>', '<CMD>ToggleTerm ' .. i .. '<CR>', { noremap = true, silent = true })

  vim.api.nvim_set_keymap(
    'i',
    '<C-' .. i .. '>',
    '<Esc><CMD>ToggleTerm ' .. i .. '<CR>',
    { noremap = true, silent = true }
  )

  vim.api.nvim_set_keymap(
    't',
    '<C-' .. i .. '>',
    '<C-\\><C-n><CMD>ToggleTerm ' .. i .. '<CR>',
    { noremap = true, silent = true }
  )
end
