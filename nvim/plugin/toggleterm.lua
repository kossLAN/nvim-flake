require('toggleterm').setup {
  open_mapping = [[<c-t>]],
  direction = 'float',
  persist_mode = false,
  auto_scroll = false,
}

-- Allow for 10 terminal spawns mapped to NumKeys.
for i = 0, 9 do
  vim.api.nvim_set_keymap(
    'n',
    '<leader>tt' .. i,
    '<CMD>ToggleTerm ' .. i .. '<CR>',
    { noremap = true, silent = true }
  )
end
