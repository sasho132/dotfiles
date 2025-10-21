return {
  'OXY2DEV/markview.nvim',
  lazy = false,

  -- For blink.cmp's completion source
  dependencies = {
    'saghen/blink.cmp',
  },

  config = function()
    local presets = require 'markview.presets'

    require('markview').setup {
      markdown = {
        headings = presets.headings.simple,
        horizontal_rules = presets.horizontal_rules.thin,
      },

      preview = {
        icon_provider = 'mini', -- "mini" or "devicons"
      },
    }
  end,
}
