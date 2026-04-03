vim.pack.add {
  'https://github.com/rcarriga/nvim-notify',
}

require('notify').setup {
  merge_duplicates = true,
  render = 'default',
  timeout = 3000,
  stages = 'static',
}
