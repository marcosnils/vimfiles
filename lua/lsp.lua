local nvim_lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local illuminate = require('illuminate')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  illuminate.on_attach(client, bufnr)

  -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<A-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
  buf_set_keymap('n', '<A-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})


  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  if client.resolved_capabilities.document_formatting then
		vim.cmd([[
			augroup formatting
				autocmd! * <buffer>
				autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
				autocmd BufWritePre <buffer> lua organizeImports(1000)
			augroup END
		]])
	end

  	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
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


nvim_lsp.jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}



nvim_lsp["golangci_lint_ls"].setup({
  init_options = {
    command = { 'golangci-lint', 'run', '--out-format', 'json' },
  }
})


nvim_lsp.gopls.setup {
  cmd = {'gopls'},
  -- for postfix snippets and analyzers
  capabilities = capabilities,
      settings = {
        gopls = {
          experimentalPostfixCompletions = true,
          analyses = {
            unusedparams = true,
            shadow = true,
         },
         staticcheck = true,
        },
      },
  on_attach = on_attach,
}

nvim_lsp["yamlls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemaStore = {
        url = "https://www.schemastore.org/api/json/catalog.json",
        enable = true,
      },
      schemas = schemas,
    },
  },
})

--vim.lsp.set_log_level("debug")
--
-- organize imports
-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-902680058
function organizeImports(timeoutms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, 'UTF-8')
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end
