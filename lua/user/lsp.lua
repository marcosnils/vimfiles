local illuminate = require('illuminate')
local ms = require("vim.lsp.protocol").Methods

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


vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { buffer = event.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<leader>dv', function()
      vim.cmd('vsplit')
      vim.lsp.buf.definition()
    end, bufopts)
    vim.keymap.set('n', '<leader>dh', function()
      vim.cmd('split')
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
  end,
})

require('illuminate').configure({})



local lspconfig = require('lspconfig')

lspconfig.jsonls.setup({})
lspconfig.graphql.setup({})
lspconfig.golangci_lint_ls.setup({})
lspconfig.pyright.setup({})
lspconfig.ts_ls.setup({})
lspconfig.eslint.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.lua_ls.setup({})

lspconfig.gopls.setup({
  cmd = { 'gopls' },
  -- for postfix snippets and analyzers
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
})

lspconfig.yamlls.setup({
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
})



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

-- Checks if the given buffer has any lsp clients that support the given method.
--
---@param bufnr number Buffer number
---@param method string Method name
---@return boolean
local has_clients_with_method = function(bufnr, method)
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = method })
  return #clients > 0
end

-- Format code and organize imports (if supported) (async).
--
---@async
---@param client vim.lsp.Client
---@param bufnr number
---@type fun(client: vim.lsp.Client, bufnr: number)
local organize_imports = function(client, bufnr)
  ---@type lsp.Handler
  ---@diagnostic disable-next-line: unused-local
  local handler = function(err, result, context, config)
    if err then
      -- ignore errors
      return
    end
    for _, r in pairs(result or {}) do
      if r.edit then
        local enc = client.offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      elseif r.command and r.command.command then
        client:exec_cmd(r.command, { bufnr = bufnr })
      end
    end
    vim.cmd([[noautocmd write]])
  end

  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_range_params(win, client.offset_encoding or "utf-16")
  params.context = { only = { "source.organizeImports" } }
  client:request(ms.textDocument_codeAction, params, handler, bufnr)
end


---@param bufnr number
---@param method string
---@param apply fun(client: vim.lsp.Client, bufnr: number)
---@param filter? fun(client: vim.lsp.Client): boolean?
local on_clients = function(bufnr, method, apply, filter)
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = method })
  if not filter then
    filter = function()
      return true
    end
  end
  for _, client in ipairs(clients) do
    if filter(client) then
      apply(client, bufnr)
    end
  end
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    ---@type fun(client: vim.lsp.Client): boolean?
    local filter = function(client)
      -- lua_ls freaks out when you ask it to organize imports.
      return client.name ~= "lua_ls"
    end
    on_clients(bufnr, ms.textDocument_codeAction, organize_imports, filter)
  end,
  group = group,
})

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
  callback = function()
    if has_clients_with_method(0, ms.textDocument_codeLens) then
      vim.lsp.codelens.refresh({ bufnr = 0 })
    end
  end,
  group = group,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    if has_clients_with_method(0, ms.textDocument_documentHighlight) then
      vim.lsp.buf.document_highlight()
    end
  end,
  group = group,
})

vim.api.nvim_create_autocmd({ "CursorMoved" }, {
  callback = function()
    if has_clients_with_method(0, ms.textDocument_documentHighlight) then
      vim.lsp.buf.clear_references()
    end
  end,
  group = group,
})
