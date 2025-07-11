-- NOTE: this just gives nixCats global command a default value
-- so that it doesnt throw an error if you didnt install via nix.
-- usage of both this setup and the nixCats command is optional,
-- but it is very useful for passing info from nix to lua so you will likely use it at least once.
require('nixCatsUtils').setup {
  non_nix_value = true,
}

local servers = {}
if require('nixCatsUtils').isNixCats then
  -- nixd requires some configuration.
  -- luckily, the nixCats plugin is here to pass whatever we need!
  -- we passed this in via the `extra` table in our packageDefinitions
  -- for additional configuration options, refer to:
  -- https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
else
end

-- Check if we used nix, only run mason if we did not
if require('nixCatsUtils').isNixCats then
  for server_name, cfg in pairs(servers) do
    -- This gets provided a default configuration by nvim-lspconfig
    -- and then ours gets tbl_deep_extend'ed into it
    vim.lsp.config(server_name, cfg)
    vim.lsp.enable(server_name)
  end
else
  require('mason').setup()
  local mason_lspconfig = require 'mason-lspconfig'
  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }
  mason_lspconfig.setup_handlers {
    function(server_name)
      local server = servers[server_name] or {}
      vim.lsp.config(server_name, server)
      vim.lsp.enable(server_name)
    end,
  }
end

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

-- NOTE: this the lazy wrapper. Use it like require('lazy').setup() but with an extra
-- argument, the path to lazy.nvim as downloaded by nix, or nil, before the normal arguments.
require('nixCatsUtils.lazyCat').setup(nixCats.pawsible { 'allPlugins', 'start', 'lazy.nvim' }, {
  { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },

  { import = 'lazyvim.plugins.extras.editor.neo-tree' },

  { import = 'lazyvim.plugins.extras.coding.blink' },
  { import = 'lazyvim.plugins.extras.coding.luasnip' },
  { import = 'lazyvim.plugins.extras.ai.supermaven' },

  { import = 'lazyvim.plugins.extras.lsp.none-ls' },

  { import = 'lazyvim.plugins.extras.lang.rust' },
  { import = 'lazyvim.plugins.extras.lang.go' },
  { import = 'lazyvim.plugins.extras.lang.docker' },
  { import = 'lazyvim.plugins.extras.lang.nix' },
  { import = 'lazyvim.plugins.extras.lang.elixir' },
  { import = 'lazyvim.plugins.extras.lang.toml' },
  { import = 'lazyvim.plugins.extras.lang.sql' },

  { import = 'lazyvim.plugins.extras.ui.treesitter-context' },
  -- disable mason.nvim while using nix
  -- precompiled binaries do not agree with nixos, and we can just make nix install this stuff for us.
  { 'williamboman/mason-lspconfig.nvim', enabled = require('nixCatsUtils').lazyAdd(true, false) },
  { 'williamboman/mason.nvim', enabled = require('nixCatsUtils').lazyAdd(true, false) },
  {
    'nvim-treesitter/nvim-treesitter',
    build = require('nixCatsUtils').lazyAdd ':TSUpdate',
    opts_extend = require('nixCatsUtils').lazyAdd(nil, false),
    opts = {
      -- nix already ensured they were installed, and we would need to change the parser_install_dir if we wanted to use it instead.
      -- so we just disable install and do it via nix.
      ensure_installed = require('nixCatsUtils').lazyAdd(
        { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'rust', 'go', 'elixir', 'nix' },
        false
      ),
      auto_install = require('nixCatsUtils').lazyAdd(true, false),
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
  -- import/override with your plugins
  { import = 'plugins' },
}, lazyOptions)
