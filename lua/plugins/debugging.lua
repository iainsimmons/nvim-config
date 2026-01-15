---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

local icons = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = ".>",
}

return {
  "mfussenegger/nvim-dap",
  enabled = true,
  recommended = true,
  desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

  dependencies = {
    {
      "Joakker/lua-json5",
      build = "./install.sh",
      config = function()
        table.insert(vim._so_trails, "/?.dylib")
      end,
    },
    -- fancy UI for the debugger
    {
      "rcarriga/nvim-dap-ui",
      enabled = false,
      dependencies = { "nvim-neotest/nvim-nio" },
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },

    {
      "igorlfs/nvim-dap-view",
      ---@module 'dap-view'
      ---@type dapview.Config
      ---@diagnostic disable-next-line: assign-type-mismatch
      config = function()
        local opts = {
          winbar = {
            show = true,
            -- You can add a "console" section to merge the terminal with the other views
            sections = { "scopes", "watches", "breakpoints", "repl", "threads", "exceptions", "console" },
            default_section = "scopes",
            controls = { enabled = true },
          },
          windows = {
            terminal = {
              hide = {
                "javascript",
                "typescript",
                "javascriptreact",
                "typescriptreact",
              },
            },
          },
        }

        vim.api.nvim_create_autocmd({ "FileType" }, {
          pattern = { "dap-view", "dap-view-term", "dap-repl" }, -- dap-repl is set by `nvim-dap`
          callback = function(evt)
            vim.keymap.set("n", "q", "<C-w>q", { buffer = evt.buf })
          end,
        })

        local dap, dv = require("dap"), require("dap-view")
        dap.listeners.before.attach["dap-view-config"] = function()
          dv.open()
        end
        dap.listeners.before.launch["dap-view-config"] = function()
          dv.open()
        end
        dap.listeners.before.event_terminated["dap-view-config"] = function()
          dv.close(true)
        end
        dap.listeners.before.event_exited["dap-view-config"] = function()
          dv.close(true)
        end

        dv.setup(opts)
      end,
    },

    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },

    -- which key integration
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<leader>d"] = { name = "+debug" },
        },
      },
    },

    -- mason.nvim integration
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },

    -- VsCode launch.json parser
    {
      "folke/neoconf.nvim",
    },
  },

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    -- { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    { "<leader>dJ", function()
      -- create launch.json for JS debugging, after prompting for the localhost port number
      vim.ui.input({prompt = "localhost port: "}, function (port)
        local f = assert(io.open(".vscode/launch.json", "w"))
        local launch = {
          version = "0.2.0",
          configurations = {
            {
              type = "chrome",
              request = "launch",
              name = 'Start Chrome with "localhost:' .. port .. '"',
              url = "http://localhost:" .. port,
              webRoot = "${workspaceFolder}",
              skipFiles = {"${workspaceFolder}/node_modules/**/*.js"},
              userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
            }
          }
        }
        f:write(vim.json.encode(launch))
        f:close()

        -- format with jq
        local obj = vim.system({"jq", ".", ".vscode/launch.json"}, { text = true }):wait()
        f = assert(io.open(".vscode/launch.json", "w"))
        f:write(obj.stdout)
        f:close()
      end)
    end, desc = "Initialise debug launch.json for JS"},
  },

  config = function()
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(icons) do
      sign = type(sign) == "table" and sign or { sign }
      ---@diagnostic disable-next-line: assign-type-mismatch
      vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] })
    end

    -- setup dap config by VsCode launch.json file
    local js_based_languages = { "typescript", "javascript", "typescriptreact" }

    for _, language in ipairs(js_based_languages) do
      require("dap").configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "chrome",
          request = "launch",
          name = 'Start Chrome with "localhost:3000"',
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = 'Start PWA Chrome with "localhost"',
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
        },
      }
    end
  end,
}
