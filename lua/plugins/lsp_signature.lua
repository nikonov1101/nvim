-- show references with Telescope, much better to see the context
vim.lsp.handlers["textDocument/references"] = function(_, _, _) require("telescope.builtin").lsp_references() end
vim.lsp.handlers["textDocument/implementation"] = function(_, _, _) require("telescope.builtin").lsp_implementations() end

-- tune up parameters to Go LSP
require("lspconfig").gopls.setup {
  single_file_support = true,
  settings = {
    gopls = {
      symbolScope = "all",
      symbolStyle = "Dynamic",
      symbolMatcher = "FastFuzzy",
      importShortcut = "Both",
      hoverKind = "FullDocumentation", -- or "SynopsisDocumentation", "SingleLine"
      completeUnimported = true,
      usePlaceholders = false,
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
      staticcheck = true,
      gofumpt = true,
      diagnosticsDelay = "1s",
      diagnosticsTrigger = "Edit",
      analysisProgressReporting = true,
      annotations = {
        bounds = true,
        escape = true,
        inline = true,
        -- 'nil' = true,
      },
    },
  },
}

return {
  "ray-x/lsp_signature.nvim",

  opts = {
    bind = false, -- This is mandatory to disable auto-popup
    floating_window = true, -- Show signature in a floating window
    toggle_key_flip_floatwin_setting = true,
    hint_enable = false, -- Disable virtual hint
    toggle_key = "<C-k>", -- No toggle key binding
    always_trigger = false,
    doc_lines = 10, -- Show 2 lines of signature docs
    handler_opts = {
      border = "rounded", -- Optional: border for floating window
    },
  },
}
