local M = {
  hl = {},
  colors = {
    slate = {
      [50] = "f8fafc",
      [100] = "f1f5f9",
      [200] = "e2e8f0",
      [300] = "cbd5e1",
      [400] = "94a3b8",
      [500] = "64748b",
      [600] = "475569",
      [700] = "334155",
      [800] = "1e293b",
      [900] = "0f172a",
      [950] = "020617",
    },

    gray = {
      [50] = "f9fafb",
      [100] = "f3f4f6",
      [200] = "e5e7eb",
      [300] = "d1d5db",
      [400] = "9ca3af",
      [500] = "6b7280",
      [600] = "4b5563",
      [700] = "374151",
      [800] = "1f2937",
      [900] = "111827",
      [950] = "030712",
    },

    zinc = {
      [50] = "fafafa",
      [100] = "f4f4f5",
      [200] = "e4e4e7",
      [300] = "d4d4d8",
      [400] = "a1a1aa",
      [500] = "71717a",
      [600] = "52525b",
      [700] = "3f3f46",
      [800] = "27272a",
      [900] = "18181b",
      [950] = "09090B",
    },

    neutral = {
      [50] = "fafafa",
      [100] = "f5f5f5",
      [200] = "e5e5e5",
      [300] = "d4d4d4",
      [400] = "a3a3a3",
      [500] = "737373",
      [600] = "525252",
      [700] = "404040",
      [800] = "262626",
      [900] = "171717",
      [950] = "0a0a0a",
    },

    stone = {
      [50] = "fafaf9",
      [100] = "f5f5f4",
      [200] = "e7e5e4",
      [300] = "d6d3d1",
      [400] = "a8a29e",
      [500] = "78716c",
      [600] = "57534e",
      [700] = "44403c",
      [800] = "292524",
      [900] = "1c1917",
      [950] = "0a0a0a",
    },

    red = {
      [50] = "fef2f2",
      [100] = "fee2e2",
      [200] = "fecaca",
      [300] = "fca5a5",
      [400] = "f87171",
      [500] = "ef4444",
      [600] = "dc2626",
      [700] = "b91c1c",
      [800] = "991b1b",
      [900] = "7f1d1d",
      [950] = "450a0a",
    },

    orange = {
      [50] = "fff7ed",
      [100] = "ffedd5",
      [200] = "fed7aa",
      [300] = "fdba74",
      [400] = "fb923c",
      [500] = "f97316",
      [600] = "ea580c",
      [700] = "c2410c",
      [800] = "9a3412",
      [900] = "7c2d12",
      [950] = "431407",
    },

    amber = {
      [50] = "fffbeb",
      [100] = "fef3c7",
      [200] = "fde68a",
      [300] = "fcd34d",
      [400] = "fbbf24",
      [500] = "f59e0b",
      [600] = "d97706",
      [700] = "b45309",
      [800] = "92400e",
      [900] = "78350f",
      [950] = "451a03",
    },

    yellow = {
      [50] = "fefce8",
      [100] = "fef9c3",
      [200] = "fef08a",
      [300] = "fde047",
      [400] = "facc15",
      [500] = "eab308",
      [600] = "ca8a04",
      [700] = "a16207",
      [800] = "854d0e",
      [900] = "713f12",
      [950] = "422006",
    },

    lime = {
      [50] = "f7fee7",
      [100] = "ecfccb",
      [200] = "d9f99d",
      [300] = "bef264",
      [400] = "a3e635",
      [500] = "84cc16",
      [600] = "65a30d",
      [700] = "4d7c0f",
      [800] = "3f6212",
      [900] = "365314",
      [950] = "1a2e05",
    },

    green = {
      [50] = "f0fdf4",
      [100] = "dcfce7",
      [200] = "bbf7d0",
      [300] = "86efac",
      [400] = "4ade80",
      [500] = "22c55e",
      [600] = "16a34a",
      [700] = "15803d",
      [800] = "166534",
      [900] = "14532d",
      [950] = "052e16",
    },

    emerald = {
      [50] = "ecfdf5",
      [100] = "d1fae5",
      [200] = "a7f3d0",
      [300] = "6ee7b7",
      [400] = "34d399",
      [500] = "10b981",
      [600] = "059669",
      [700] = "047857",
      [800] = "065f46",
      [900] = "064e3b",
      [950] = "022c22",
    },

    teal = {
      [50] = "f0fdfa",
      [100] = "ccfbf1",
      [200] = "99f6e4",
      [300] = "5eead4",
      [400] = "2dd4bf",
      [500] = "14b8a6",
      [600] = "0d9488",
      [700] = "0f766e",
      [800] = "115e59",
      [900] = "134e4a",
      [950] = "042f2e",
    },

    cyan = {
      [50] = "ecfeff",
      [100] = "cffafe",
      [200] = "a5f3fc",
      [300] = "67e8f9",
      [400] = "22d3ee",
      [500] = "06b6d4",
      [600] = "0891b2",
      [700] = "0e7490",
      [800] = "155e75",
      [900] = "164e63",
      [950] = "083344",
    },

    sky = {
      [50] = "f0f9ff",
      [100] = "e0f2fe",
      [200] = "bae6fd",
      [300] = "7dd3fc",
      [400] = "38bdf8",
      [500] = "0ea5e9",
      [600] = "0284c7",
      [700] = "0369a1",
      [800] = "075985",
      [900] = "0c4a6e",
      [950] = "082f49",
    },

    blue = {
      [50] = "eff6ff",
      [100] = "dbeafe",
      [200] = "bfdbfe",
      [300] = "93c5fd",
      [400] = "60a5fa",
      [500] = "3b82f6",
      [600] = "2563eb",
      [700] = "1d4ed8",
      [800] = "1e40af",
      [900] = "1e3a8a",
      [950] = "172554",
    },

    indigo = {
      [50] = "eef2ff",
      [100] = "e0e7ff",
      [200] = "c7d2fe",
      [300] = "a5b4fc",
      [400] = "818cf8",
      [500] = "6366f1",
      [600] = "4f46e5",
      [700] = "4338ca",
      [800] = "3730a3",
      [900] = "312e81",
      [950] = "1e1b4b",
    },

    violet = {
      [50] = "f5f3ff",
      [100] = "ede9fe",
      [200] = "ddd6fe",
      [300] = "c4b5fd",
      [400] = "a78bfa",
      [500] = "8b5cf6",
      [600] = "7c3aed",
      [700] = "6d28d9",
      [800] = "5b21b6",
      [900] = "4c1d95",
      [950] = "2e1065",
    },

    purple = {
      [50] = "faf5ff",
      [100] = "f3e8ff",
      [200] = "e9d5ff",
      [300] = "d8b4fe",
      [400] = "c084fc",
      [500] = "a855f7",
      [600] = "9333ea",
      [700] = "7e22ce",
      [800] = "6b21a8",
      [900] = "581c87",
      [950] = "3b0764",
    },

    fuchsia = {
      [50] = "fdf4ff",
      [100] = "fae8ff",
      [200] = "f5d0fe",
      [300] = "f0abfc",
      [400] = "e879f9",
      [500] = "d946ef",
      [600] = "c026d3",
      [700] = "a21caf",
      [800] = "86198f",
      [900] = "701a75",
      [950] = "4a044e",
    },

    pink = {
      [50] = "fdf2f8",
      [100] = "fce7f3",
      [200] = "fbcfe8",
      [300] = "f9a8d4",
      [400] = "f472b6",
      [500] = "ec4899",
      [600] = "db2777",
      [700] = "be185d",
      [800] = "9d174d",
      [900] = "831843",
      [950] = "500724",
    },

    rose = {
      [50] = "fff1f2",
      [100] = "ffe4e6",
      [200] = "fecdd3",
      [300] = "fda4af",
      [400] = "fb7185",
      [500] = "f43f5e",
      [600] = "e11d48",
      [700] = "be123c",
      [800] = "9f1239",
      [900] = "881337",
      [950] = "4c0519",
    },
  },
}

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

    require("mini.basics").setup({
      options = {
        -- Basic options ('number', 'ignorecase', and many more)
        basic = true,

        -- Extra UI features ('winblend', 'cmdheight=0', ...)
        extra_ui = false,

        -- Presets for window borders ('single', 'double', ...)
        win_borders = "default",
      },

      -- Mappings. Set to `false` to disable.
      mappings = {
        -- Basic mappings (better 'jk', save with Ctrl+S, ...)
        basic = true,

        -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
        -- Supply empty string to not create these mappings.
        option_toggle_prefix = "",

        -- Window navigation with <C-hjkl>, resize with <C-arrow>
        windows = true,

        -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
        move_with_alt = false,
      },

      -- Autocommands. Set to `false` to disable
      autocommands = {
        -- Basic autocommands (highlight on yank, start Insert in terminal, ...)
        basic = true,

        -- Set 'relativenumber' only in linewise and blockwise Visual mode
        relnum_in_visual_mode = false,
      },

      -- Whether to disable showing non-error feedback
      silent = false,
    })

    require("mini.bracketed").setup()

    require("mini.comment").setup({
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })

    local hi = require("mini.hipatterns")
    hi.setup({
      highlighters = {
        hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
        shorthand = {
          pattern = "()#%x%x%x()%f[^%x%w]",
          group = function(_, _, data)
            ---@type string
            local match = data.full_match
            local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
            local hex_color = "#" .. r .. r .. g .. g .. b .. b

            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
          extmark_opts = { priority = 2000 },
        },
        base16_slashes = {
          pattern = function()
            local filepath = vim.api.nvim_buf_get_name(0)
            local base16_match = string.find(filepath, "base16[_-]shell")
            if base16_match == nil then
              return
            end
            return "()%x%x/%x%x/%x%x()"
          end,
          group = function(_, _, data)
            ---@type string
            local match = data.full_match
            local r, g, b = match:sub(1, 2), match:sub(4, 5), match:sub(7, 8)
            local hex_color = "#" .. r .. g .. b

            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
          extmark_opts = { priority = 2000 },
        },
        tailwind = {
          pattern = function()
            local ft = { "typescriptreact", "javascriptreact", "css", "javascript", "typescript", "html", "svelte", "astro" }
            if not vim.tbl_contains(ft, vim.bo.filetype) then
              return
            end
            return "%f[%w:-]()[%w:-]+%-[a-z%-]+%-%d+()%f[^%w:-]"
          end,
          group = function(_, _, m)
            ---@type string
            local match = m.full_match
            ---@type string, number
            local color, shade = match:match("[%w-]+%-([a-z%-]+)%-(%d+)")
            ---@diagnostic disable-next-line: cast-local-type
            shade = tonumber(shade)
            local bg = vim.tbl_get(M.colors, color, shade)
            if bg then
              local hl = "MiniHipatternsTailwind" .. color .. shade
              if not M.hl[hl] then
                M.hl[hl] = true
                local bg_shade = shade == 500 and 950 or shade < 500 and 900 or 100
                local fg = vim.tbl_get(M.colors, color, bg_shade)
                vim.api.nvim_set_hl(0, hl, { bg = "#" .. bg, fg = "#" .. fg })
              end
              return hl
            end
          end,
          extmark_opts = { priority = 2000 },
        },
      },
    })

    require("mini.icons").setup()

    require("mini.operators").setup({
      -- Each entry configures one operator.
      -- `prefix` defines keys mapped during `setup()`: in Normal mode
      -- to operate on textobject and line, in Visual - on selection.

      -- Evaluate text and replace with output
      evaluate = {
        prefix = "g=",

        -- Function which does the evaluation
        func = nil,
      },

      -- Exchange text regions
      exchange = {
        prefix = "gx",

        -- Whether to reindent new text to match previous indent
        reindent_linewise = true,
      },

      -- Multiply (duplicate) text
      multiply = {
        prefix = "gm",

        -- Function which can modify text before multiplying
        func = nil,
      },

      -- Replace text with register
      replace = {
        prefix = "gr",

        -- Whether to reindent new text to match previous indent
        reindent_linewise = true,
      },

      -- Sort text
      sort = {
        prefix = "go",

        -- Function which does the sort
        func = nil,
      },
    })

    require("mini.statusline").setup({
      use_icons = vim.g.have_nerd_font,
      content = {
        active = function()
          -- Show macro recording message in statusline
          -- From https://www.reddit.com/r/neovim/comments/1djkwif/show_recording_macros_message_in_ministatusline
          local check_macro_recording = function()
            if vim.fn.reg_recording() ~= "" then
              return "Recording @" .. vim.fn.reg_recording()
            else
              return ""
            end
          end

          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          -- local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location = MiniStatusline.section_location({ trunc_width = 200 })
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
          local macro = check_macro_recording()

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFilename", strings = { macro } },
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          })
        end,
      },
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

    require("mini.tabline").setup({
      format = function(buf_id, label)
        local suffix = vim.bo[buf_id].modified and "* " or ""
        return MiniTabline.default_format(buf_id, label) .. suffix
      end,
    })

    -- Set Highlights
    -- Colors for base16-vice:
    -- base00 = '#17191e', base01 = '#22262d', base02 = '#3c3f4c', base03 = '#383a47',
    -- base04 = '#555e70', base05 = '#8b9cbe', base06 = '#b2bfd9', base07 = '#f4f4f7',
    -- base08 = '#ff29a8', base09 = '#85ffe0', base0A = '#f0ffaa', base0B = '#0badff',
    -- base0C = '#8265ff', base0D = '#00eaff', base0E = '#00f6d9', base0F = '#ff3d81'

    local function highlight(hl_name, opts)
      vim.api.nvim_set_hl(0, hl_name, opts)
    end

    -- mini.statusline
    highlight("MiniStatuslineModeNormal", { fg = "#0badff", bg = "#22262d" }) -- Normal mode.
    highlight("MiniStatuslineModeInsert", { fg = "#85ffe0", bg = "#22262d" }) -- Insert mode.
    highlight("MiniStatuslineModeVisual", { fg = "#f0ffaa", bg = "#22262d" }) -- Visual mode.
    highlight("MiniStatuslineModeReplace", { fg = "#ff3d81", bg = "#22262d" }) -- Replace mode.
    highlight("MiniStatuslineModeCommand", { fg = "#8265ff", bg = "#22262d" }) -- Command mode.
    highlight("MiniStatuslineModeOther", { fg = "#00eaff", bg = "#22262d" }) -- other modes (like Terminal, etc.).
    -- mini.tabline
    highlight("MiniTablineCurrent", { fg = "#00eaff", bg = "#3c3f4c", italic = true, bold = true })
    highlight("MiniTablineModifiedCurrent", { fg = "#00eaff", bg = "#3c3f4c", italic = true, bold = true })
    -- MiniTablineVisible - buffer is visible (displayed in some window).
    -- MiniTablineHidden - buffer is hidden (not displayed).
    -- MiniTablineModifiedVisible - buffer is modified and visible.
    -- MiniTablineModifiedHidden - buffer is modified and hidden.
  end,
}
