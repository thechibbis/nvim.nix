{
  plugins.lsp = {
    enable = true;
    inlayHints = true;

    servers = {
      lua-ls.enable = true;
      nixd.enable = true;
      gopls.enable = true;

      rust-analyzer = {
        enable = true;

        installRustc = true;
        installCargo = true;

        settings.check.command = "clippy";
      };
    };
  };

  imports = [ 
    ./format.nix 
    ./lspkind.nix 
    ./lspsaga.nix 
    ./lsplines.nix 
    ./lspstatus.nix
    ./keymaps.nix
    ./cmp.nix
  ];
}
