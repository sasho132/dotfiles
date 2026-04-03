vim.pack.add {
  'https://github.com/OXY2DEV/markview.nvim',
}

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
