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
          local items = {}
          for idx, item in ipairs(harpoon_files.items) do
            local formatted = vim.fs.basename(item.value)
            table.insert(items, {
              file = item.value,
              formatted = formatted,
              text = idx .. " " .. formatted,
              idx = idx,
              item = item,
            })
          end
          Snacks.picker.pick({
            source = "select",
            items = items,
            format = Snacks.picker.format.ui_select("File", #items),
            title = "Harpoon",
            layout = {
              preview = false,
              layout = {
                height = math.floor(math.min(vim.o.lines * 0.8 - 10, #items + 2) + 0.5) + 10,
              },
            },
            actions = {
              confirm = function(picker, item)
                picker:close()
                vim.schedule(function()
                  harpoon:list():select(item.idx)
                end)
              end,
              harpoon_delete = function(picker, item)
                picker:close()
                vim.schedule(function()
                  harpoon:list():remove_at(item.idx)
                end)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<C-d>"] = { "harpoon_delete", mode = { "n", "i" } },
                },
              },
              list = { keys = { ["dd"] = "harpoon_delete" } },
            },
          })
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
