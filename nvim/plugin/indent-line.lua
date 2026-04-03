vim.pack.add {
  'https://github.com/saghen/blink.indent',
}

require('blink.indent').setup {
  static = {
    enabled = true,
    char = '│',
    -- char = '┆ ',
  },
  scope = {
    enabled = true,
    char = '│',
    -- char = '┆ ',
    highlights = { 'BlinkIndentScope' },
  },
}
