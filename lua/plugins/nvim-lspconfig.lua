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
    servers = {
      nixd = {
        settings = {
          nixd = {
            nixpkgs = {
              expr = nixCats.extra 'nixdExtras.nixpkgs' or [[import <nixpkgs> {}]],
            },
            options = {
              nixos = {
                expr = nixCats.extra 'nixdExtras.nixos_options',
              },
              ['home-manager'] = {
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
      nil_ls = {
        enabled = false,
      },
      tailwindcss = {
        root_dir = function(_fname)
          return vim.loop.cwd()
        end,
        settings = {
          tailwindCSS = {
            classAttributes = { 'class', 'className' },
            includeLanguages = { heex = 'hmtl', elixir = 'hmtl', eex = 'hmtl' },
          },
        },
      },
      emmet_language_server = {
        filetypes = {
          'html',
          'css',
          'scss',
          'javascript',
          'typescript',
          'vue',
          'svelte',
          'php',
          'twig',
          'blade',
          'markdown',
          'yaml',
          'toml',
          'json',
          'nix',
          'elixir',
          'eelixir',
          'heex',
          'eex',
        },
      },
    },
  },
}
