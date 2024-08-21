{
  globalOpts = {
    number = true;
    relativenumber = true;

    signcolumn = "yes";

    ignorecase = true;    
    smartcase = true;    

    tabstop = 4;
    shiftwidth = 4;
    softtabstop = 0;
    expandtab = true;
    smarttab = true;

    clipboard = "unnamedplus";
  };
  
  globals.mapleader = " ";

  imports = [ 
    ./keymaps.nix 
    ./colorscheme.nix
  ];
}
