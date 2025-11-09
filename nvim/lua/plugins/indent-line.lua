return {
  'saghen/blink.indent',
  --- @module 'blink.indent'
  --- @type blink.indent.Config
  opts = {
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
  },
}
