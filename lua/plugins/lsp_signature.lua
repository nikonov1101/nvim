return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {
    hint_enable = false, -- virtual hint enable
    hint_prefix = "?? ", -- Panda for parameter
    hint_inline = function() return false end,
  },
  config = function(_, opts) require("lsp_signature").setup(opts) end,
}
