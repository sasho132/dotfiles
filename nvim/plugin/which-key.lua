vim.pack.add {
  'https://github.com/folke/which-key.nvim',
}

require('which-key').setup {
  preset = 'modern',
  plugins = {
    spelling = {
      enabled = true,
      seggestions = 20,
    },
  },
  dalay = 0,
  vim.keymap.set('', '<leader>?', 'Buffer Local Keymaps (which-key)'),
}
