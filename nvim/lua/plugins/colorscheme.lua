return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    require('catppuccin').setup {
      flavor = 'mocha',
      background = { -- :h background
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = true,
      no_italic = true,
      default_integrations = true,
      integrations = {
        cmp = true,
        dap = true,
        gitsigns = true,
        treesitter = true,
        notify = true,
        telescope = {
          enabled = true,
        },
        markdown = true,
        mason = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        dashboard = true,
        dap_ui = true,
        noice = true,
        which_key = true,
      },
    }
    vim.cmd.colorscheme 'catppuccin'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
