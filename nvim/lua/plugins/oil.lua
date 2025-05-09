return {
  'stevearc/oil.nvim',

  config = function()
    require('oil').setup {
      columns = { 'icon' },
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = false,
      view_options = {
        show_hidden = true,
      },

      -- Open parent directory in current window
      vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' }),

      -- is_hidden_file = function(name, bufnr)
      --   return vim.startswith(name, '.')
      -- end,
      --
      -- is_always_hidden = function(name, bufnr)
      --   return false
      -- end,
    }
  end,
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
}
