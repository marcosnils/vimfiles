require("lsp_autocommands").setup()

local capabilities = require("blink.cmp").get_lsp_capabilities({
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true, -- needs fswatch on linux
      relativePatternSupport = true,
    },
  },
}, true)

-- setup diagnostics
vim.diagnostic.config({
  --underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = float_config,
})


---@param client vim.lsp.Client LSP client
---@param bufnr number Buffer number
---@diagnostic disable: unused-local
local on_attach = function(client, bufnr)
  --- Add a normal keymap.
  ---@param lhs string Keymap
  ---@param rhs function Action
  local keymap = function(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, {
      noremap = true,
      silent = true,
      buffer = bufnr,
    })
  end

  local telescope = function(action)
    return function()
      local theme = require("telescope.themes").get_dropdown()
      require("telescope.builtin")["lsp_" .. action](theme)
    end
  end

  keymap("gd", telescope("definitions"))
  keymap("grr", telescope("references"))
  keymap("gO", telescope("document_symbols"))
  keymap("gri", telescope("implementations"))
  keymap("gD", vim.lsp.buf.declaration)
  keymap("K", vim.lsp.buf.hover)
  keymap("<C-k>", vim.lsp.buf.hover)
  keymap("<leader>D", telescope("type_definitions"))
  keymap("grl", vim.lsp.codelens.run)
  keymap("<space>e", vim.diagnostic.open_float)
  keymap('<space>rn', vim.lsp.buf.rename)
  keymap('ga', vim.lsp.buf.code_action)
  keymap('<space>f', function() vim.lsp.buf.format { async = true } end)
  keymap('[d', vim.diagnostic.goto_prev)
  keymap(']d', vim.diagnostic.goto_next)
  keymap("<leader>dv", function()
    vim.cmd("vsplit | lua vim.lsp.buf.definition()")
  end)
  keymap("<leader>dh", function()
    vim.cmd("split | lua vim.lsp.buf.definition()")
  end)
  keymap('K', function() vim.lsp.buf.hover(float_config) end)
  keymap('<C-k>', function() vim.lsp.buf.signature_help(float_config) end)
  keymap('<space>wa', vim.lsp.buf.add_workspace_folder)
  keymap('<space>wr', vim.lsp.buf.remove_workspace_folder)
  keymap('<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders))
  end)

end

local lspconfig = vim.lsp.config
local lspenable = vim.lsp.enable
require("lspconfig.ui.windows").default_options.border = "none"
lspconfig('gopls',{
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = true,
        generate = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
      },
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
        nilness = true,
        unusedparams = true,
        unusedvariable = true,
        unusedwrite = true,
        useany = true,
      },
      staticcheck = true,
      directoryFilters = { "-.git", "-node_modules" },
      semanticTokens = true,
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
})
lspenable('gopls')

lspconfig('ts_ls',{
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    javascript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
})
lspenable('ts_ls')

for _, lsp in ipairs({
  "bashls",
  "clangd",
  "cssls",
  "jsonls",
  "pylsp",
  "rust_analyzer",
  "taplo",
  "templ",
  "terraformls",
  "tflint",
  "zls",
}) do
  lspconfig(lsp,{
    on_attach = on_attach,
    capabilities = capabilities,
  })
  lspenable(lsp)
end

for _, lsp in ipairs({ "html", "htmx" }) do
  lspconfig(lsp,{
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "html", "templ" },
  })
  lspenable(lsp)
end

lspconfig('tailwindcss',{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ", "javascript" },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        templ = "html",
      },
    },
  },
})
lspenable('tailwindcss')

lspconfig('yamlls',{
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemaStore = {
        url = "https://www.schemastore.org/api/json/catalog.json",
        enable = true,
      },
    },
  },
})
lspenable('yamlls')

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";", {})
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig('lua_ls',{
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      telemetry = { enable = false },
      hint = {
        enable = true,
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})
lspenable('lua_ls')
