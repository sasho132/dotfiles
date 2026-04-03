vim.pack.add {
  'https://github.com/saghen/blink.cmp',
  'https://github.com/rafamadriz/friendly-snippets',
}

require('blink.cmp').setup {
  -- Avoid the Rust fuzzy matcher binary requirement when using vim.pack.add.
  fuzzy = {
    implementation = 'lua',
  },

  -- 'default' for mappings similar to built-in completion
  -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
  -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
  -- See the full "keymap" documentation for information on defining your own keymap.
  keymap = { preset = 'default' },

  completion = {
    menu = {
      draw = {
        -- components = {
        --   kind_icon = {
        --     text = function(ctx)
        --       local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
        --       return kind_icon
        --     end,
        --     -- (optional) use highlights from mini.icons
        --     highlight = function(ctx)
        --       local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
        --       return hl
        --     end,
        --   },
        --   kind = {
        --     -- (optional) use highlights from mini.icons
        --     highlight = function(ctx)
        --       local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
        --       return hl
        --     end,
        --   },
        -- },
        columns = {
          { 'kind_icon', 'label', gap = 1 },
          { 'kind', 'label_description' },
        },
      },
    },
    documentation = {
      auto_show = false,
      auto_show_delay_ms = 500,
      treesitter_highlighting = false,
    },
  },

  appearance = {
    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    -- Useful for when your theme doesn't support blink.cmp
    -- Will be removed in a future release
    use_nvim_cmp_as_default = true,
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono',

    kind_icons = {
      Text = '󰉿',
      Method = '󰊕',
      Function = '󰊕',
      Constructor = '󰒓',

      Field = '󰜢',
      Variable = '󰆦',
      Property = '󰖷',

      Class = '󱡠',
      Interface = '󱡠',
      Struct = '󱡠',
      Module = '󰅩',

      Unit = '󰪚',
      Value = '󰦨',
      Enum = '󰦨',
      EnumMember = '󰦨',

      Keyword = '󰻾',
      Constant = '󰏿',

      Snippet = '󱄽',
      Color = '󰏘',
      File = '󰈔',
      Reference = '󰬲',
      Folder = '󰉋',
      Event = '',
      Operator = '󰪚',
      TypeParameter = '󰬛',
    },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
}
