return {
  'olimorris/codecompanion.nvim',
  opts = {},
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('codecompanion').setup {
      vim.keymap.set({ 'n', 'v' }, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true }),
      vim.keymap.set({ 'n', 'v' }, '<M-t>', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true }),
      vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true }),

      strategies = {
        chat = {
          adapter = 'openai',
        },
        inline = {
          adapter = 'openai',
        },
        cmd = {
          adapter = 'deepseek',
        },
      },

      adapters = {
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            schema = {
              model = {
                default = 'gpt-4.1-mini',
              },
            },
            env = {
              api_key = 'cmd:cat -s ~/Documents/openai-api-key',
            },
          })
        end,

        deepseek = function()
          return require('codecompanion.adapters').extend('deepseek', {
            schema = {
              model = {
                deepseek = 'deepseek-coder',
              },
            },
            env = {
              api_key = 'cmd:cat -s ~/Documents/deepseek-api-key',
            },
          })
        end,

        gemini = function()
          return require('codecompanion.adapters').extend('gemini', {
            schema = {
              model = {
                gemini = 'gemini-2.5-flash-preview-05-20',
              },
            },
            env = {
              api_key = 'cmd:cat -s ~/Documents/gemini-api-key',
            },
          })
        end,
      },
    }
  end,
}
