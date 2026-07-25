return {
  { "ellisonleao/gruvbox.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },

  { "rose-pine/neovim", name = "rose-pine" },
  { "rebelot/kanagawa.nvim" },
  { "savq/melange-nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-frappe",
    },
  },

  {
    "LazyVim/LazyVim",
    opts = function()
      vim.keymap.set("n", "<leader>uc", function()
        require("lazyvim.util").telescope.colorscheme({ enable_preview = true })
      end, { desc = "Colorscheme with preview" })
    end,
  },
}
