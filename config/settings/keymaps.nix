let 
  tbuiltin = "require(\"telescope.builtin\")";
in
{
  keymaps = [
    {
      action = "<cmd>Telescope find_files<cr>";
      key = "<leader>pf";
    }
    {
      action = "<cmd>Telescope git_files<cr>";
      key = "<C-p>";
    }
    {
      action = "<cmd>Telescope help_tags<cr>";
      key = "<leader>vh";
    }
    {
      action = "<cmd>Telescope colorscheme<cr>";
      key = "<leader>ch";
    }
    {
      action = "<cmd>Oil<cr>";
      key = "<leader>pv";
    }
  ];
}
