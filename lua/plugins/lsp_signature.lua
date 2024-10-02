return {
  "ray-x/lsp_signature.nvim",

  opts = {
    bind = false, -- This is mandatory to disable auto-popup
    floating_window = true, -- Show signature in a floating window
    toggle_key_flip_floatwin_setting = true,
    hint_enable = false, -- Disable virtual hint
    toggle_key = "<C-k>", -- No toggle key binding
    always_trigger = false,
    doc_lines = 10, -- Show 2 lines of signature docs
    handler_opts = {
      border = "rounded", -- Optional: border for floating window
    },
  },
  config = function(_, opts) require("lsp_signature").setup(opts) end,
}
