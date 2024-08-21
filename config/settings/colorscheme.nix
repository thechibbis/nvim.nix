{
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      transparent_background = true;

      cmp = true;
      noice = true;
      neotree = true;
      harpoon = true;
      gitsigns = true;
      treesitter = true;
      treesitter_context = true;

      telescope.enabled = true;
      mini.enabled = true;
      indent_blankline.enabled = true;

      native_lsp = {
        enabled = true;
        inlay_hints.background = true;
        underlines = {
          errors = ["underline"];
          hints = ["underline"];
          information = ["underline"];
          warnings = ["underline"];
        };
      };
    };
  };
}
