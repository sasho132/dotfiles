return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'echasnovski/mini.nvim' },

  config = function()
    local separators = {
      blank = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      arrow = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      saparated = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
    }

    require('lualine').setup {
      options = {
        icons_enabled = vim.g.have_nerd_font,
        theme = 'catppuccin',
        component_separators = separators.blank.component_separators,
        section_separators = separators.blank.section_separators,
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
