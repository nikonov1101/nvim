return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
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
      },
    },
    window = {
      mappings = {
        ["n"] = "add",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
      },
    },
  },
}
