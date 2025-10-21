return {
  {
    -- Catppuccin colorscheme
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        float = {
          transparent = false, -- enable transparent floating windows
          solid = false, -- use solid styling for floating windows, see |winborder|
        },
        transparent_background = true,
        no_italic = true,
        default_integrations = true,
        integrations = {
          fzf = true,
          gitsigns = true,
          treesitter = true,
          notify = true,
          mason = true,
          blink_cmp = true,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
        },
      }
      vim.cmd 'colorscheme catppuccin'
    end,
  },
  {
    -- Rose-pine colorscheme
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },
      }
      -- vim.cmd 'colorscheme rose-pine'
    end,
  },
}
