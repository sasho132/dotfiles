vim.pack.add({
    'https://github.com/catppuccin/nvim.git'
})

require('catppuccin').setup({
    flavour = 'mocha',
    float = {
      transparent = true, -- enable transparent floating windows
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
      blink_cmp = {
        style = 'bordered',
      },
      blink_indent = true,
      mini = {
        enabled = true,
        indentscope_color = '',
      },
    },
    custom_highlights = {
      NormalMode = { fg = '#1e1e2e', bg = '#a6e3a1', bold = true },
      InsertMode = { fg = '#1e1e2e', bg = '#89b4fa', bold = true },
      VisualMode = { fg = '#1e1e2e', bg = '#b4befe', bold = true },
      ReplaceMode = { fg = '#1e1e2e', bg = '#f38ba8', bold = true },
      CmdLineMode = { fg = '#1e1e2e', bg = '#f9e2af', bold = true },
      TerminalMode = { fg = '#0e0e1e', bg = '#89dceb', bold = true },
      OtherMode = { fg = '#1e1e2e', bg = '#a6adc8', bold = true },
      StatusLine = { fg = '#cdd6f4', bg = '#1e1e2e' },
      StatusLineNC = { fg = '#45475a', bg = '#1e1e2e' },
      LazyNormal = { fg = '#cdd6f4', bg = 'none' },
      fzf = { fg = '#cdd6f4', bg = 'none' },
      Blink = { fg = '#e0def4', bg = 'none' },
      MasonNormal = { fg = '#cdd6f4', bg = 'none' },
    },
})

vim.cmd.colorscheme('catppuccin')
