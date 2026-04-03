vim.pack.add {
  'https://github.com/supermaven-inc/supermaven-nvim',
}

require('supermaven-nvim').setup {
  disable_inline_completion = false, -- disable inline completion for use with cmp
  keymaps = {
    accept_suggestion = '<Tab>', -- key to accept the current suggestion
  },
  log_level = 'info',
  disable_keymaps = false, -- disables built in keymaps for more manual control
}
