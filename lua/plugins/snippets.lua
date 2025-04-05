return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },

    config = function()
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local l = require("luasnip.extras").lambda

        local postfix = require("luasnip.extras.postfix").postfix

        vim.keymap.set({ "i", "s" }, "<Tab>", function() ls.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<S-Tab>", function() ls.jump(-1) end, { silent = true })

        ls.add_snippets("all", {
            s("tod", {
                t("// TODO(nikonov): "),
                i(0),
            }),
        })

        ls.add_snippets("nasm", {
            s("tod", {
                t(";;; TODO: "),
                i(0),
            }),
            s("xxx", {
                t(";;;  XXX: "),
                i(0),
            }),
        })

        ls.add_snippets("go", {
            s("go", {
                t({ "go func(){", "" }),
                i(0),
                t({ "", "}()" }),
            }),
            s("pf", {
                t("log.Printf(\""),
                i(0),
                t("\")"),
            }),
            s("err", {
                t({ "if err != nil {", "" }),
                i(0, "panic(err)"),
                t({ "", "}" }),
            }),
            s("ew", {
                t("errors.Wrap(err, \""),
                i(0, "explain"),
                t("\")"),
            }),
            s("main", {
                t({ "package main", "", "func main() {", "" }),
                i(0, "// code"),
                t({ "", "}", "" }),
            }),
            s("testf", {
                t("func Test"),
                i(1, "Name"),
                t({ "(t *testing.T) {", "" }),
                i(0, "// test"),
                t({ "", "}", "" }),
            }),
            postfix({
                -- if err := call(); err != nil { ... }
                trig = ".e",
                match_pattern = "^(.*)$",
                snippetType = "autosnippet",
            }, {
                l("if err := " .. l.POSTFIX_MATCH .. "; err != nil{"),
                t({ "", "" }),
                i(0),
                t({ "", "}" }),
            }),
            postfix({
                -- if _, err := call(); err != nil { ... }
                trig = ".ee",
                match_pattern = "^(.*)$",
                snippetType = "autosnippet",
            }, {
                l("if _, err := " .. l.POSTFIX_MATCH .. "; err != nil{"),
                t({ "", "" }),
                i(0),
                t({ "", "}" }),
            }),
        })
    end,
}
