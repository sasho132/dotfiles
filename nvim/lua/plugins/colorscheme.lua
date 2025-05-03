return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,

  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      ransparent_background = true,
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
}
