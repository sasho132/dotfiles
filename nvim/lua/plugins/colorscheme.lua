return {
  {
    ---------------------------------
    -- Catppuccin colorscheme -------
    ---------------------------------
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
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
      }
      vim.cmd 'colorscheme catppuccin'
    end,
  },
  {
    ---------------------------------
    -- Rose-pine colorscheme --------
    ---------------------------------
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },
        highlight_groups = {
          NormalMode = { fg = '#1f1d2e', bg = '#9ccfd8', bold = true },
          InsertMode = { fg = '#1f1d2e', bg = '#31748f', bold = true },
          VisualMode = { fg = '#1f1d2e', bg = '#eb6f92', bold = true },
          ReplaceMode = { fg = '#1f1d2e', bg = '#ebbcba', bold = true },
          CmdLineMode = { fg = '#1f1d2e', bg = '#f6c177', bold = true },
          TerminalMode = { fg = '#1f1d2e', bg = '#908caa', bold = true },
          OtherMode = { fg = '#1f1d2e', bg = '#6e6a86', bold = true },
          Visual = { fg = '#908caa', bg = '#9ccfd8' },
          StatusLine = { fg = '#e0def4', bg = '#1f1d2e' },
          StatusLineNC = { fg = '#908caa', bg = '#1f1d2e' },
          LazyNormal = { fg = '#e0def4', bg = '#1f1d2e' },
          fzf = { fg = '#e0def4', bg = 'none' },
          Blink = { fg = '#e0def4', bg = 'none' },
          MasonNormal = { fg = '#e0def4', bg = '#1f1d2e' },
        },
      }
      -- vim.cmd 'colorscheme rose-pine'
    end,
  },
  {
    ------------------------------
    -- Kanagawa colorscheme ------
    ------------------------------
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        undercurl = true,
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
        statementStyle = { bold = true },
        typeStyle = { bold = true },
        transparent = true,
        terminalColors = true,

        overrides = function(colors)
          local theme = colors.theme
          return {
            -- This will make floating windows look nicer with default borders.
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            -- More uniform colors for the popup menu.
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
          }
        end,
      }
      -- vim.cmd 'colorscheme kanagawa'
    end,
  },
}
