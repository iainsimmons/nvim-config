return {
  {
    "esmuellert/vscode-diff.nvim",
    cmd = { "CodeDiff" },
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      { "<leader>gd", "<cmd>CodeDiff<CR>", desc = "CodeDiff", silent = true },
    },
  },
  {
    "mistweaverco/diffconflicts.nvim",
    event = "VeryLazy",
    cmd = { "DiffConflicts", "DiffConflictsShowHistory", "DiffConflictsWithHistory" },
    opts = {
      -- Optional configuration
      commands = {
        -- Command to open the diff conflicts view, default is "DiffConflicts"
        -- set to nil to disable the command
        diff_conflicts = "DiffConflicts",
        -- Command to show the history of conflicts, default is "DiffConflictsShowHistory"
        -- set to nil to disable the command
        show_history = "DiffConflictsShowHistory",
        -- Command to resolve conflicts with history, default is "DiffConflictsWithHistory"
        -- set to nil to disable the command
        with_history = "DiffConflictsWithHistory",
      },
      -- Quality-of-life options
      qol = {
        -- After saving (:w), automatically close the diff view and jump to the next
        -- conflict in the file (if any).
        advance_on_save = true,
        -- If no conflicts remain after saving, quit Neovim (:qa). This is useful
        -- when running from `git mergetool` / `jj resolve`.
        quit_on_done = true,
      },
    },
  },
}
