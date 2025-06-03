return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope.nvim", optional = true },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings

        maps.n["<Leader>a"] = { function() require("harpoon"):list():add() end, desc = "Add file" }
        maps.n["<Leader><Leader>"] = {
          function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
          desc = "Toggle quick menu",
        }
        maps.n["<C-x>"] = {
          function()
            vim.ui.input({ prompt = "Harpoon mark index: " }, function(input)
              local num = tonumber(input)
              if num then require("harpoon"):list():select(num) end
            end)
          end,
          desc = "Goto index of mark",
        }
        maps.n["<C-p>"] = { function() require("harpoon"):list():prev() end, desc = "Goto previous mark" }
        maps.n["<C-n>"] = { function() require("harpoon"):list():next() end, desc = "Goto next mark" }
        if require("astrocore").is_available "telescope.nvim" then
          maps.n["<Leader>fi"] = { "<Cmd>Telescope harpoon marks<CR>", desc = "Show marks in Telescope" }
        elseif require("astrocore").is_available "snacks.nvim" then
          -- https://github.com/folke/snacks.nvim/discussions/1058#discussioncomment-12450702
          local normalize_list = function(t)
            local normalized = {}
            for _, v in pairs(t) do
              if v ~= nil then table.insert(normalized, v) end
            end
            return normalized
          end
          local harpoon = require "harpoon"
          maps.n["<leader>fi"] = {
            function()
              require("snacks").picker {
                finder = function()
                  local file_paths = {}
                  local list = normalize_list(harpoon:list().items)
                  for _, item in ipairs(list) do
                    table.insert(file_paths, { text = item.value, file = item.value })
                  end
                  return file_paths
                end,
                win = {
                  input = {
                    keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
                  },
                  list = {
                    keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
                  },
                },
                actions = {
                  harpoon_delete = function(picker, item)
                    local to_remove = item or picker:selected()
                    harpoon:list():remove { value = to_remove.text }
                    harpoon:list().items = normalize_list(harpoon:list().items)
                    picker:find { refresh = true }
                  end,
                },
              }
            end,
            desc = "Find marks (harpoon)",
          }
        end
        -- maps.n[prefix .. "t"] = {
        --   function()
        --     vim.ui.input({ prompt = term_string .. " window number: " }, function(input)
        --       local num = tonumber(input)
        --       if num then require("harpoon").term.gotoTerminal(num) end
        --     end)
        --   end,
        --   desc = "Go to " .. term_string .. " window",
        -- }
      end,
    },
  },
  specs = {
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { harpoon = true } },
    },
  },
}
