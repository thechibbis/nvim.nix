-- NOTE: this just gives nixCats global command a default value
-- so that it doesnt throw an error if you didnt install via nix.
-- usage of both this setup and the nixCats command is optional,
-- but it is very useful for passing info from nix to lua so you will likely use it at least once.
require('nixCatsUtils').setup {
  non_nix_value = true,
}

-- NOTE: You might want to move the lazy-lock.json file
local function getlockfilepath()
  if require('nixCatsUtils').isNixCats and type(nixCats.settings.unwrappedCfgPath) == 'string' then
    return nixCats.settings.unwrappedCfgPath .. '/lazy-lock.json'
  else
    return vim.fn.stdpath 'config' .. '/lazy-lock.json'
  end
end
local lazyOptions = {
  lockfile = getlockfilepath(),
}

-- Set treesitter parser install directory to a writable location
vim.opt.runtimepath:append(vim.fn.expand '~/.nvim/data/treesitter')

-- NOTE: this the lazy wrapper. Use it like require('lazy').setup() but with an extra
-- argument, the path to lazy.nvim as downloaded by nix, or nil, before the normal arguments.
require('nixCatsUtils.lazyCat').setup(nixCats.pawsible { 'allPlugins', 'start', 'lazy.nvim' }, {
  { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
  -- disable mason.nvim while using nix
  -- precompiled binaries do not agree with nixos, and we can just make nix install this stuff for us.
  { 'mason-org/mason-lspconfig.nvim', enabled = require('nixCatsUtils').lazyAdd(true, false) },
  { 'mason-org/mason.nvim', enabled = require('nixCatsUtils').lazyAdd(true, false) },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        tailwindcss = {
          filetypes_exclude = { 'markdown' },
          filetypes_include = { 'typescriptreact', 'javascriptreact' },
        },
      },
      setup = {
        tailwindcss = function(_, opts)
          opts.filetypes = opts.filetypes or {}

          -- Add default filetypes
          vim.list_extend(opts.filetypes, vim.lsp.config.tailwindcss.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          -- Additional settings for Phoenix projects
          opts.settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = 'html-eex',
                eelixir = 'html-eex',
                heex = 'html-eex',
              },
            },
          }

          -- Add additional filetypes
          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = require('nixCatsUtils').lazyAdd ':TSUpdate',
    opts_extend = require('nixCatsUtils').lazyAdd(nil, false),
    opts = {
      -- nix already ensured they were installed, and we would need to change the parser_install_dir if we wanted to use it instead.
      -- so we just disable install and do it via nix.
      parser_install_dir = vim.fn.expand '~/.nvim/data/treesitter',
      auto_install = false,
      ignore_install = { 'all' },
    },
  },
  {
    'folke/lazydev.nvim',
    opts = {
      library = {
        { path = (nixCats.nixCatsPath or '') .. '/lua', words = { 'nixCats' } },
      },
    },
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {
      styles = {
        transparency = true,
      },
    },
    config = function(_, opts)
      require('rose-pine').setup(opts)
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
  -- import/override with your plugins
  { import = 'lazyvim.plugins.extras.ai.copilot-chat' },
  { import = 'lazyvim.plugins.extras.ai.copilot-native' },
  { import = 'lazyvim.plugins.extras.ai.sidekick' },

  { import = 'lazyvim.plugins.extras.coding.blink' },
  { import = 'lazyvim.plugins.extras.coding.luasnip' },
  { import = 'lazyvim.plugins.extras.coding.mini-comment' },
  { import = 'lazyvim.plugins.extras.coding.mini-surround' },

  { import = 'lazyvim.plugins.extras.editor.illuminate' },
  { import = 'lazyvim.plugins.extras.editor.neo-tree' },
  { import = 'lazyvim.plugins.extras.editor.refactoring' },
  { import = 'lazyvim.plugins.extras.editor.telescope' },

  { import = 'lazyvim.plugins.extras.formatting.biome' },
  { import = 'lazyvim.plugins.extras.formatting.biome' },

  { import = 'lazyvim.plugins.extras.lang.docker' },
  { import = 'lazyvim.plugins.extras.lang.go' },
  { import = 'lazyvim.plugins.extras.lang.nix' },
  { import = 'lazyvim.plugins.extras.lang.rust' },
  { import = 'lazyvim.plugins.extras.lang.tailwind' },
  { import = 'lazyvim.plugins.extras.lang.toml' },
  { import = 'lazyvim.plugins.extras.lang.typescript' },
  { import = 'lazyvim.plugins.extras.lang.yaml' },

  { import = 'lazyvim.plugins.extras.lsp.none-ls' },

  { import = 'lazyvim.plugins.extras.ui.indent-blankline' },

  { import = 'plugins' },
}, lazyOptions)
