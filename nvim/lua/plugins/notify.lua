return {
  'rcarriga/nvim-notify',
  config = function()
    vim.notify = require 'notify'
    require('notify').setup {
      merge_duplicates = true,
      render = 'default',
      timeout = 3000,
      stages = 'static',
    }
  end,
}
