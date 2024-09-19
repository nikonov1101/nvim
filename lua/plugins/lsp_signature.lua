return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",

  opts = {
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    floating_window_above_cur_line = false, -- Set this to false so the popup appears below the line.
    floating_window_off_y = -2, -- Adjust the Y offset if needed to fine-tune its position.
    floating_window = true, -- Use floating window instead of virtual text.

    hint_enable = false, -- virtual hint enable
    hint_prefix = "?? ", -- Panda for parameter
    hint_inline = function() return false end,
  },
  config = function(_, opts) require("lsp_signature").setup(opts) end,
}
