return {
  "echasnovski/mini.surround",
  dependencies = {
    { "AstroNvim/astroui", opts = { icons = { Surround = "󰑤" } } },
    { "AstroNvim/astrocore" },
  },
  opts = {
    -- Setup similar to 'tpope/vim-surround'
    mappings = {
      add = "ys", -- Add surrounding in Normal and Visual modes
      delete = "ds", -- Delete surrounding
      find = "", -- Find surrounding (to the right)
      find_left = "", -- Find surrounding (to the left)
      highlight = "", -- Highlight surrounding
      replace = "cs", -- Replace surrounding
      update_n_lines = "", -- Update `n_lines`

      -- Add this only if you don't want to use extended mappings
      suffix_last = "",
      suffix_next = "",
    },
  },
  config = function(_, opts)
    require("mini.surround").setup(opts)

    -- Remap adding surrounding to Visual mode selection
    vim.keymap.del("x", "ys")
    vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

    -- Make special mapping for "add surrounding for line"
    vim.keymap.set("n", "yss", "ys_", { remap = true })
  end,
  specs = {
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { mini = true } },
    },
  },
}
