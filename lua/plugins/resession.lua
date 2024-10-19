-- local resession = require "resession"
--
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     -- Only load the session if nvim was started with no args
--     if vim.fn.argc(-1) == 0 then
--       -- Save these to a different directory, so our manual sessions don't get polluted
--       resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = false })
--     end
--   end,
--   nested = true,
-- })
--
-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   callback = function() resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = true }) end,
-- })

return {
  "stevearc/resession.nvim",
  lazy = false,
  priority = 42,
  opts = {
    extensions = {
      quickfix = {},
    },
  },
}
