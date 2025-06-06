if vim.g.did_load_telescope_plugin then
  return
end
vim.g.did_load_telescope_plugin = true

local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local builtin = require('telescope.builtin')

local layout_config = {
  vertical = {
    width = function(_, max_columns)
      return math.floor(max_columns * 0.99)
    end,
    height = function(_, _, max_lines)
      return math.floor(max_lines * 0.99)
    end,
    prompt_position = 'bottom',
    preview_cutoff = 0,
  },
}

vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>se', builtin.diagnostics, { desc = '[S]earch [E]rrors' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sd', ':Telescope file_browser<CR>', { desc = 'Search [D]irectory' })

telescope.setup {
  defaults = {
    path_display = {
      'truncate',
    },
    layout_strategy = 'vertical',
    layout_config = layout_config,
    mappings = {
      i = {
        ['<C-q>'] = actions.send_to_qflist,
        ['<C-l>'] = actions.send_to_loclist,
        -- ['<esc>'] = actions.close,
        ['<C-s>'] = actions.cycle_previewers_next,
        ['<C-a>'] = actions.cycle_previewers_prev,

        -- Multi File select
        ['<CR>'] = function(pb)
          local picker = action_state.get_current_picker(pb)
          local multi = picker:get_multi_selection()
          actions.select_default(pb) -- the normal enter behaviour
          for _, j in pairs(multi) do
            if j.path ~= nil then    -- is it a file -> open it as well:
              vim.cmd(string.format('%s %s', 'edit', j.path))
            end
          end
        end,
      },
      n = {
        q = actions.close,
      },
    },
    preview = {
      treesitter = true,
    },
    history = {
      path = vim.fn.stdpath('data') .. '/telescope_history.sqlite3',
      limit = 1000,
    },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    vimgrep_arguments = {
      'rg',
      '-L',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
    file_browser = {
      hijack_netrw = true,
      hidden = true,
      respect_gitignore = false,
      mappings = {
        ['n'] = {
          ['a'] = require('telescope._extensions.file_browser.actions').create,
          ['r'] = require('telescope._extensions.file_browser.actions').rename,
          ['d'] = require('telescope._extensions.file_browser.actions').remove,
          ['h'] = require('telescope._extensions.file_browser.actions').goto_parent_dir,
          ['N'] = require('telescope._extensions.file_browser.actions').create,
        },
      },
    },
  },
}

telescope.load_extension('fzy_native')
telescope.load_extension('file_browser')
-- telescope.load_extension('smart_history')
