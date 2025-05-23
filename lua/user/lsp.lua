local illuminate = require('illuminate')

local capabilities = require("blink.cmp").get_lsp_capabilities({
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true, -- needs fswatch on linux
      relativePatternSupport = true,
    },
  },
}, true)

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)


local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  illuminate.on_attach(client, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")



  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>dv', function()
    vim.cmd('vsplit')
    vim.lsp.buf.definition()
  end, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<A-n>', function() require "illuminate".next_reference { wrap = true } end, bufopts)
  vim.keymap.set('n', '<A-p>', function() require "illuminate".next_reference { wrap = true, reverse = true } end,
    bufopts)


  if client.server_capabilities.codeActionProvider and client.name ~= "lua_ls" then
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = "*.go",
      group = vim.api.nvim_create_augroup("LspGolangOrganizeImports." .. bufnr, {}),
      callback = function()
        organizeImports(500, client)
      end,
    })
  end


  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd([[
      hi def link LspReferenceRead CursorLine
      hi def link LspReferenceText CursorLine
      hi def link LspReferenceWrite CursorLine
			augroup lsp_document_highlight
				autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]])
  end
end


local lspconfig = require('lspconfig')


lspconfig.jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}


lspconfig.graphql.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.golangci_lint_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}


lspconfig.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.ts_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}


lspconfig.phpactor.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}


lspconfig.eslint.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}


lspconfig.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}


lspconfig.gopls.setup {
  cmd = { 'gopls' },
  -- for postfix snippets and analyzers
  capabilities = capabilities,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      gofumpt = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  on_attach = on_attach,
}

lspconfig.yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      keyOrdering = false,
      schemaStore = {
        url = "https://www.schemastore.org/api/json/catalog.json",
        enable = true,
      },
      schemas = schemas,
    },
  },
}

--vim.lsp.set_log_level("debug")
--
-- organize imports
-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-902680058
function organizeImports(timeoutms, client)
  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_range_params(win, client.offset_encoding or "utf-16")
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      elseif r.command and r.command.command then
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

local float_config = {
  focusable = true,
  style = "minimal",
  source = "if_many",
  border = "single",
}

-- setup diagnostics
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = float_config,
})

vim.lsp.buf.hover(float_config)
vim.lsp.buf.signature_help(float_config)
vim.highlight.priorities.semantic_tokens = 95
