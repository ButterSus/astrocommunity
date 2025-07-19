return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "verilog" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "verible" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "verible" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require "lint"

      -- Configure linters by filetype
      lint.linters_by_ft = {
        systemverilog = { "verilator" },
        verilog = { "verilator" },
      }

      -- Optional: Customize verilator arguments
      lint.linters.verilator.args = {
        "--lint-only",
        "--Wall",
      }

      -- Auto-lint on these events
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function() lint.try_lint() end,
      })
    end,
  },
}
