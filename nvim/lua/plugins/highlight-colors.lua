return {
  'brenoprata10/nvim-highlight-colors',
  config = function()
    require('nvim-highlight-colors').setup {
      -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
      exclude_filetypes = {},
      exclude_buftypes = { 'terminal', 'text', 'lazy', 'mason' },
      ---@usage 'background'|'foreground'|'virtual'
      render = 'virtual',
      -- virtual_symbol = '■',
      -- virtual_symbol = '',
      virtual_symbol = '󱓻',

      enable_var_usage = true,
      enable_named_colors = true,
      enable_tailwind = true,
    }
  end,
}
