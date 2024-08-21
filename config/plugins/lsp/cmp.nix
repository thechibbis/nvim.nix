{
  plugins.cmp = {
    enable = true;

    settings = {
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "async_path"; }
        { name = "buffer"; }
        { name = "git"; }
      ];
      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<C-Space>" = "cmp.mapping.complete()";
      };
    };
  };

  plugins.cmp-buffer.enable = true;
  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-git.enable = true;
  plugins.cmp_luasnip.enable = true;
  plugins.cmp-async-path.enable = true;
}
