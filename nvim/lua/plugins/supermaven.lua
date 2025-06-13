return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      disable_inline_completion = false, -- disable inline completion for use with cmp
      keymaps = {
        accept_suggestion = 'M-y',
        clear_suggestion = '<M-]>',
        accept_word = '<M-j>',
      },
      log_level = 'info',
      disable_keymaps = false, -- disables built in keymaps for more manual control
    }
  end,
}
