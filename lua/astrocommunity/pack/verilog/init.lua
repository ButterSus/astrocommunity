vim.cmd [[
function! CustomSystemVerilogIndent()
  let line = getline(v:lnum)

  " If line starts with a closing delimiter, handle it manually
  if line =~ '^\s*[)\]}]'
    let char = matchstr(line, '[)\]}]')
    let open = char == ')' ? '(' : char == ']' ? '[' : char == '}' ? '{' : ''

    " Try to find matching opener
    if open !=# ''
      let [match_lnum, _] = searchpairpos(open, '', char, 'bnW')
      if match_lnum > 0
        return indent(match_lnum)
      endif
    endif
  endif

  " Fallback to original indent logic
  return SystemVerilogIndent()
endfunction
]]

-- Set indentexpr to our wrapper, buffer-locally, for verilog/systemverilog files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "verilog", "systemverilog" },
  callback = function() vim.bo.indentexpr = "CustomSystemVerilogIndent()" end,
})

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
    end,
  },
}
