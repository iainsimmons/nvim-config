return {
  "kevinhwang91/nvim-ufo",
  event = "BufRead",
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
    },
    {
      "K",
      function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
    },
  },
  dependencies = {
    { "kevinhwang91/promise-async" },
  },
  config = function()
    -- Fold options
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.o.foldcolumn = "1" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    require("ufo").setup()
  end,
}
