return {
  'nvimtools/none-ls.nvim',
  optional = true,
  opts = function(_, opts)
    local nls = require 'null-ls'
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.diagnostics.credo.with {
        condition = function(utils)
          return utils.root_has_file '.credo.exs'
        end,
      },
    })
  end,
}
