local wk = require('which-key')

wk.setup {
  -- preset = 'helix',
}

wk.add {
  { '<leader>c', group = '[C]ode' },
  { '<leader>d', group = '[D]ebugger/Document' },
  { '<leader>r', group = '[R]ename' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>w', group = '[W]orkspace' },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>g', group = '[G]it' },
  { '<leader>p', group = '[P]eek' },
  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
}
