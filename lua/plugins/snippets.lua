local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("all", {
    s("tod", {
        t("// TODO(nikonov): "),
        i(0),
    }),
})

ls.add_snippets("go", {
    s("pf", {
        t("log.Printf(\""),
        i(0),
        t("\")"),
    }),
    s("err", {
        t("if err != nil {"),
        i(0, " panic(err)"),
        t("}"),
    }),
    s("ew", {
        t("errors.Wrap(err, \""),
        i(0, "explain"),
        t("\")"),
    }),
})

return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
}
