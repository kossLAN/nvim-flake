if vim.g.did_load_dropbar_plugin then
  return
end
vim.g.did_load_dropbar_plugin = true

local dropbar = require('dropbar.api')

vim.keymap.set('n', '<Leader>;', dropbar.pick, { desc = 'Pick symbols in winbar' })
vim.keymap.set('n', '[;', dropbar.goto_context_start, { desc = 'Go to start of current context' })
vim.keymap.set('n', '];', dropbar.select_next_context, { desc = 'Select next context' })
