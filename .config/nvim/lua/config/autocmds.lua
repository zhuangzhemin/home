-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "skill"},
  callback = function()
    vim.opt_local.foldnestmax = 2
    vim.opt_local.foldmethod = "indent"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "xml", "lua"},
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = { "*.bean", "*.beancount"},
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.iskeyword:append(":")
    vim.opt_local.iskeyword:append("-")
    vim.opt_local.filetype = "beancount"
    vim.cmd("setlocal iskeyword+=:")
    vim.cmd("setlocal iskeyword+=-")
  end,
})

-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   pattern = {"*"},
--   callback = function(event)
--     local buf = event.buf
--     if vim.bo[buf].filetype == "lazyterm" then
--       return
--     end
--     vim.cmd("lcd %:p:h")
--   end
-- })
