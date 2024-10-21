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
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())


        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "gopls",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["gopls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.gopls.setup {
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
                                hints = {
                                    assignVariableTypes = true,
                                    compositeLiteralFields = true,
                                    compositeLiteralTypes = true,
                                    constantValues = true,
                                    functionTypeParameters = false,
                                    parameterNames = false,
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
                                    shadow = true, -- MAYBE NOT
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
                                annotations = {
                                    bounds = true,
                                    escape = true,
                                    inline = true,
                                    -- 'nil' = true,
                                },
                            },
                        },
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            preselect = cmp.PreselectMode.None,
            formatting = { fields = { "kind", "abbr", "menu" }, },
            completion = {
                -- auto-select the first option, expand by <CR>
                -- Intellij-like behaviour.
                completeopt = "menu,menuone,noinsert",
            },
            view = {
                -- native vindows are compact and minimalistic
                entries = { name = "native" },
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm { select = true },
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'luasnip',                 option = { show_autosnippets = true }, priority = 9999 },
                { name = 'nvim_lsp_signature_help', priority = 3 }, -- function signatures
                { name = 'nvim_lsp',                priority = 2 },
                { name = 'buffer',                  priority = 1 },
            })
        })

        vim.diagnostic.config({
            update_in_insert = true,
            float = {
                focusable = false,
                scope = "line", -- or "cursor" to show only hovered
                border = "single",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
