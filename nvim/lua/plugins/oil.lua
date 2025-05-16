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
      float = {
        -- Padding around the floating window
        padding = 2,
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0,
        max_height = 0,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = 'auto',
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
    }
  end,
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
}
