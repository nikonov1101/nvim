return {
    cmd = { "clangd", "--background-index" , "--fallback-style=chromium" },
    root_markers = { "compile_commands.json", "compile_flags.txt" , ".clang-format"},
    filetypes = { "c", "cpp" },
}
