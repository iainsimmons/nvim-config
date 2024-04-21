return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  config = function()
    require("mini.ai").setup({
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]parenthen
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      n_lines = 500,
    })

    require("mini.surround").setup({
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - gsaiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - gsd'   - [S]urround [D]elete [']quotes
      -- - gsr)'  - [S]urround [R]eplace [)] [']
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    })

    require("mini.bracketed").setup()

    require("mini.comment").setup({
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })

    require("mini.files").setup({
      content = {
        filter = function(entry)
          return entry.name ~= ".DS_Store" and entry.name ~= ".git" and entry.name ~= ".direnv"
        end,
        sort = function(entries)
          -- technically can filter entries here too, and checking gitignore for _every entry individually_
          -- like I would have to in `content.filter` above is too slow. Here we can give it _all_ the entries
          -- at once, which is much more performant.
          local all_paths = table.concat(
            vim.tbl_map(function(entry)
              return entry.path
            end, entries),
            "\n"
          )
          local output_lines = {}
          local job_id = vim.fn.jobstart({ "git", "check-ignore", "--stdin" }, {
            stdout_buffered = true,
            on_stdout = function(_, data)
              output_lines = data
            end,
          })

          -- command failed to run
          if job_id < 1 then
            return entries
          end

          -- send paths via STDIN
          vim.fn.chansend(job_id, all_paths)
          vim.fn.chanclose(job_id, "stdin")
          vim.fn.jobwait({ job_id })
          return require("mini.files").default_sort(vim.tbl_filter(function(entry)
            return not vim.tbl_contains(output_lines, entry.path)
          end, entries))
        end,
      },
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = true,
      },
    })
    local show_dotfiles = true
    local filter_show = function()
      return true
    end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, ".")
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      require("mini.files").refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle Hidden Files" })
      end,
    })
  end,
  keys = {
    {
      "<leader>e",
      function()
        local MiniFiles = require("mini.files")
        if not MiniFiles.close() then
          MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
        end
      end,
      desc = "Toggle mini.files (Directory of Current File)",
    },
    {
      "<leader>fm",
      function()
        local MiniFiles = require("mini.files")
        if not MiniFiles.close() then
          require("mini.files").open(vim.uv.cwd(), true)
        end
      end,
      desc = "Toggle mini.files (cwd)",
    },
  },
}
