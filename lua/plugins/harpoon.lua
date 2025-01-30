return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
  },
  config = function(_, opts)
    local harpoon = require("harpoon")
    harpoon:setup(opts)
  end,
  keys = {
    {
      "<leader>hs",
      function()
        local harpoon = require("harpoon")
        local function toggle_picker(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
          end

          Snacks.picker.select(file_paths, {
            prompt = "Harpoon",
          }, function(_, idx)
            harpoon:list():select(idx)
          end)
        end
        toggle_picker(harpoon:list())
      end,
      desc = "Search harpoons",
    },
    -- TODO: Figure out if there's an easy way to remove harpoons
    -- either from the current buffer if it is harpooned
    -- or from the Snacks picker above
    {
      "<leader>hh",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon file",
    },
    {
      "<leader>hf",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon quick menu",
    },
    {
      "<leader>hj",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon to file 1",
    },
    {
      "<leader>hk",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon to file 2",
    },
    {
      "<leader>hl",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon to file 3",
    },
    {
      "<leader>h;",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon to file 4",
    },
    {
      "<leader>h'",
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "Harpoon to file 5",
    },
  },
}
