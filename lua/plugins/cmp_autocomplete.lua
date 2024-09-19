local cmp = require "cmp"

cmp.setup {
  completion = {
    -- auto-select the first option, expand by <CR>
    -- Intellij-like behaviour.
    completeopt = "menu,menuone,noinsert",
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm { select = true },
  },
  view = {
    -- native vindows are compact and minimalistic
    entries = { name = "native" },
  },
}

return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
}
