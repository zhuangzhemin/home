local wk = require("which-key")
wk.register({
  m = {
    name = "Misc",
    c = { "<cmd>'a,'by<cr>", "Copy from mark a to mark b" },
    x = { "<cmd>'a,'bd<cr>", "Delete from mark a to mark b" },
  },
  z = {
    name = "Fold",
  },
}, { prefix = "<leader>" })

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}
