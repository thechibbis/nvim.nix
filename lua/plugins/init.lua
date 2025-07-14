return {
  {
    'stevearc/oil.nvim',
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      require('oil').setup()
      vim.keymap.set('n', '<leader>pv', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
  {
    'elixir-tools/elixir-tools.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local elixir = require 'elixir'

      elixir.setup {
        nextls = { enable = false },
        elixirls = {
          enable = true,
          settings = {
            dialyzerEnabled = true,
            suggestSpecs = true,
          },
        },
        projectionist = {
          enable = false,
        },
      }
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}
