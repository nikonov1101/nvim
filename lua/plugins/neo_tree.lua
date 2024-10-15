return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    tabs_layout = "active",
    add_blank_line_at_top = false,
    use_popups_for_input = false,
    source_selector = {
      winbar = false,
      statusline = false,

      sources = {
        { source = "filesystem" },
        { source = "git_status" },
        { source = "document_symbols" },
      },
    },
    default_component_configs = {
      name = {
        trailing_slash = true,
      },
      git_status = {
        symbols = {
          untracked = "??",
          unstaged = "M",
          modified = "",
        },
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          --".DS_Store",
          --"thumbs.db"
        },
      },
    },
    document_symbols = {
      follow_cursor = true,
    },
    window = {
      position = "left",
      width = 34,
      mappings = {
        ["n"] = "add",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
      },
    },
  },
}
