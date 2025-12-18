if vim.g.did_load_snacks_plugin then
  return
end
vim.g.did_load_snacks_plugin = true

local Snacks = require('snacks')

Snacks.setup {
  dashboard = {
    enabled = true,
    sections = {
      { section = 'header' },
      { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
      { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
      { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
    },
  },
  explorer = {
    enabled = true,
    finder = 'explorer',
    sort = { fields = { 'sort' } },
    tree = true,
    supports_live = true,
    follow_file = true,
    focus = 'list',
    auto_close = false,
    jump = { close = false },
    layout = { preset = 'sidebar', preview = false },
    formatters = { file = { filename_only = true } },
    matcher = { sort_empty = true },
    config = function(opts)
      return require('snacks.picker.source.explorer').setup(opts)
    end,
    win = {
      list = {
        keys = {
          ['<BS>'] = 'explorer_up',
          ['a'] = 'explorer_add',
          ['d'] = 'explorer_del',
          ['r'] = 'explorer_rename',
          ['c'] = 'explorer_copy',
          ['y'] = 'explorer_yank',
          ['<c-c>'] = 'explorer_cd',
          ['.'] = 'explorer_focus',
        },
      },
    },
  },
  bufdelete = { enabled = true },
  bigfile = { enabled = true },
  picker = { enabled = true },
  indent = { enabled = true },
  notifier = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
}

-- Keymappings for various Snacks things
local keymap = vim.keymap

-- Picker keymaps
keymap.set('n', '<leader>sk', function()
  Snacks.picker.keymaps()
end, { desc = '[S]earch [K]eymaps' })

keymap.set('n', '<leader>sf', function()
  Snacks.picker.files()
end, { desc = '[S]earch [F]iles' })

keymap.set('n', '<leader>ss', function()
  Snacks.picker.pickers()
end, { desc = '[S]earch [S]elect Picker' })

keymap.set('n', '<leader>sw', function()
  Snacks.picker.grep_word()
end, { desc = '[S]earch current [W]ord' })

keymap.set('n', '<leader>sg', function()
  Snacks.picker.grep()
end, { desc = '[S]earch by [G]rep' })

keymap.set('n', '<leader>se', function()
  Snacks.picker.diagnostics()
end, { desc = '[S]earch [E]rrors' })

keymap.set('n', '<leader><leader>', function()
  Snacks.picker.buffers()
end, { desc = '[ ] Find existing buffers' })

-- Snacks file tree
keymap.set('n', '<leader>e', function()
  if type(Snacks.explorer) == 'function' then
    Snacks.explorer()
  else
    Snacks.picker.explorer()
  end
end, { desc = '[E]xplorer' })

-- Notifier
-- vim.notify = function(msg, level, opts)
--   local Snacks = rawget(_G, 'Snacks')
--   if Snacks and Snacks.notifier and Snacks.notifier.notify then
--     return Snacks.notifier.notify(msg, level, opts)
--   end
--   return vim.api.nvim_notify(msg, level or vim.log.levels.INFO, opts or {})
-- end
