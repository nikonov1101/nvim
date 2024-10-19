return {
    "RRethy/vim-illuminate",
    event = "VimEnter User",
    opts = {
        delay = 200,
        min_count_to_highlight = 2,
        large_file_cutoff = 2000,
        large_file_overrides = { providers = { "lsp" } },
    }
}
