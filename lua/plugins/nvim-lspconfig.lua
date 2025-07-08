return {
  'neovim/nvim-lspconfig',
  keys = {
    { 'K', '<cmd>lua vim.lsp.buf.hover()<CR>' },
    { '<leader>vgd', '<cmd>lua vim.lsp.buf.definition()<CR>' },
    { '<leader>vws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>' },
    { '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<CR>' },
    { '[d', '<cmd>lua vim.diagnostic.goto_next()<CR>' },
    { ']d', '<cmd>lua vim.diagnostic.goto_prev()<CR>' },
    { '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<CR>' },
    { '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<CR>' },
    { '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>' },
    { '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', mode = 'i' },
  },
  opts = {
    nixd = {
      settings = {
        nixd = {
          nixpkgs = {
            -- in the extras set of your package definition:
            -- nixdExtras.nixpkgs = ''import ${pkgs.path} {}''
            expr = nixCats.extra 'nixdExtras.nixpkgs' or [[import <nixpkgs> {}]],
          },
          options = {
            -- If you integrated with your system flake,
            -- you should use inputs.self as the path to your system flake
            -- that way it will ALWAYS work, regardless
            -- of where your config actually was.
            nixos = {
              -- nixdExtras.nixos_options = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.configname.options''
              expr = nixCats.extra 'nixdExtras.nixos_options',
            },
            -- If you have your config as a separate flake, inputs.self would be referring to the wrong flake.
            -- You can override the correct one into your package definition on import in your main configuration,
            -- or just put an absolute path to where it usually is and accept the impurity.
            ['home-manager'] = {
              -- nixdExtras.home_manager_options = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").homeConfigurations.configname.options''
              expr = nixCats.extra 'nixdExtras.home_manager_options',
            },
          },
          formatting = {
            command = { 'nixfmt' },
          },
          diagnostic = {
            suppress = {
              'sema-escaping-with',
            },
          },
        },
      },
    },
    servers = {
      elixirls = {
        cmd = { 'elixir-ls' },
        keys = {
          {
            '<leader>cp',
            function()
              local params = vim.lsp.util.make_position_params()
              LazyVim.lsp.execute {
                command = 'manipulatePipes:serverid',
                arguments = { 'toPipe', params.textDocument.uri, params.position.line, params.position.character },
              }
            end,
            desc = 'To Pipe',
          },
          {
            '<leader>cP',
            function()
              local params = vim.lsp.util.make_position_params()
              LazyVim.lsp.execute {
                command = 'manipulatePipes:serverid',
                arguments = { 'fromPipe', params.textDocument.uri, params.position.line, params.position.character },
              }
            end,
            desc = 'From Pipe',
          },
        },
      },
    },
  },
}
