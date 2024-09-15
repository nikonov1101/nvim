return {
  "klen/nvim-test",
  config = function()
    require("nvim-test").setup {
      termOpts = {
        direction = "vertical",
        width = 60,
        go_back = true,
        stopinsert = "auto",
        keep_one = true,
      },
    }
  end,
}
