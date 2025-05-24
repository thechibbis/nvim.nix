return {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- disable the keymap to grep files
      {"<leader>/", false},
      -- change a keymap
      { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },

      -- add a keymap to browse plugin files
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
}