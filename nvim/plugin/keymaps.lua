if vim.g.did_load_keymaps_plugin then
  return
end
vim.g.did_load_keymaps_plugin = true

local keymap = vim.keymap

-- Yank from current position till end of current line
keymap.set('n', 'Y', 'y$', { silent = true, desc = '[Y]ank to end of line' })

-- Clear highlights on search when pressing <Esc> in normal mode
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Buffer list navigation
keymap.set('n', '[b', vim.cmd.bprevious, { silent = true, desc = 'previous [b]uffer' })
keymap.set('n', ']b', vim.cmd.bnext, { silent = true, desc = 'next [b]uffer' })
keymap.set('n', '[B', vim.cmd.bfirst, { silent = true, desc = 'first [B]uffer' })
keymap.set('n', ']B', vim.cmd.blast, { silent = true, desc = 'last [B]uffer' })

-- Remap Esc to switch to normal mode and Ctrl-Esc to pass Esc to terminal
keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'switch to normal mode' })
keymap.set('t', '<C-Esc>', '<Esc>', { desc = 'send Esc to terminal' })

-- Window Resizing
keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-Up>', '<cmd>resize -2<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-Down>', '<cmd>resize +2<CR>', { noremap = true, silent = true })

--- Disabled keymaps [enable at your own risk]

-- Automatic management of search highlight
-- XXX: This is not so nice if you use j/k for navigation
-- (you should be using <C-d>/<C-u> and relative line numbers instead ;)
--
-- local auto_hlsearch_namespace = vim.api.nvim_create_namespace('auto_hlsearch')
-- vim.on_key(function(char)
--   if vim.fn.mode() == 'n' then
--     vim.opt.hlsearch = vim.tbl_contains({ '<CR>', 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char))
--   end
-- end, auto_hlsearch_namespace)
