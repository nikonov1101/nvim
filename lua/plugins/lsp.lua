return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "ckipp01/stylua-nvim",
        { "Bilal2453/luvit-meta", lazy = true },
        {
            -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
            -- used for completion, annotations and signatures of Neovim apis
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
        },
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "gopls",
                "clangd",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                ["gopls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.gopls.setup({
                        capabilities = capabilities,
                        single_file_support = true,
                        settings = {
                            gopls = {
                                usePlaceholders = false,
                                completeFunctionCalls = false,
                                symbolScope = "all",
                                symbolStyle = "dynamic",
                                symbolMatcher = "fastfuzzy",
                                importShortcut = "both",
                                hoverKind = "FullDocumentation", -- or "SynopsisDocumentation", "SingleLine"
                                completeUnimported = true,
                                experimentalPostfixCompletions = true,
                                staticcheck = true,
                                gofumpt = true,
                                diagnosticsDelay = "1s",
                                diagnosticsTrigger = "Edit",
                                analysisProgressReporting = true,
                                codelenses = {
                                    tidy = true,
                                    generate = true,
                                    upgrade_dependency = true,
                                },
                                semanticTokens = true,
                                hints = {
                                    assignVariableTypes = true,
                                    compositeLiteralFields = true,
                                    compositeLiteralTypes = true,
                                    constantValues = true,
                                    functionTypeParameters = true,
                                    parameterNames = true,
                                    rangeVariableTypes = true,
                                },
                                analyses = {
                                    unusedparams = true,
                                    unusedvariable = true,
                                    assign = true,
                                    atomic = true,
                                    bools = true,
                                    composites = true,
                                    copylocks = true,
                                    defers = true,
                                    deprecated = true,
                                    directive = true,
                                    embed = true,
                                    errorsas = true,
                                    fillreturns = true,
                                    httpresponse = true,
                                    ifaceassert = true,
                                    infertypeargs = true,
                                    loopclosure = true,
                                    lostcancel = true,
                                    nilfunc = true,
                                    nilness = true,
                                    nonewvars = true,
                                    noresultvalues = true,
                                    printf = true,
                                    shadow = false, -- MAYBE NOT
                                    shift = true,
                                    sigchanyzer = true,
                                    simplifycompositelit = true,
                                    simplifyrange = true,
                                    simplifyslice = true,
                                    sortslice = true,
                                    stdmethods = true,
                                    stringintconv = true,
                                    structtag = true,
                                    testinggoroutine = true,
                                    tests = true,
                                    timeformat = true,
                                    unmarshal = true,
                                    unreachable = true,
                                    unsafeptr = true,
                                    unusedresult = true,
                                    unusedwrite = true,
                                    useany = true,
                                },
                            },
                        },
                    })
                end,

                ["clangd"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.clangd.setup({
                        cmd = {
                            "clangd",
                            "--fallback-style=chromium",
                        },
                    })
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                end,
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            preselect = cmp.PreselectMode.None,
            formatting = {
                fields = { "abbr", "kind" },
            },
            completion = {
                -- auto-select the first option, expand by <CR>
                -- Intellij-like behaviour.
                completeopt = "menu,menuone,noinsert,fuzzy",
            },
            view = {
                -- native windows are compact and minimalistic
                -- entries = { name = "custom" },
                entries = { name = "native" },
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
            }),
            sources = cmp.config.sources({
                { name = "luasnip", priority = 9999, option = { show_autosnippets = true } },
                { name = "nvim_lsp_signature_help", priority = 400 }, -- function signatures
                { name = "nvim_lsp", priority = 300 },
                -- { name = "buffer", priority = 200 },
                { name = "path", priority = 100 },
            }),
            enable = function()
                -- disable completion in comments
                local context = require("cmp.config.context")
                return not context.in_treesitter_capture("comment")
                    and not context.in_syntax_group("Comment")
                    and not context.in_syntax_group("TSComment")
            end,
        })

        vim.diagnostic.config({
            virtual_text = true,
            update_in_insert = true,
            float = {
                focusable = false,
                scope = "line", -- or "cursor" to show only hovered
                border = "single",
                source = true,
                header = "",
                prefix = "",
            },
        })
    end,
}
