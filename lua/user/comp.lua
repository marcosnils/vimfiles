local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip.loaders.from_vscode").lazy_load()

-- commeting before removing
--local check_backspace = function()
--local col = vim.fn.col "." - 1
--return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
--end

-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
    --["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    --["<C-e>"] = cmp.mapping {
    --i = cmp.mapping.abort(),
    --c = cmp.mapping.close(),
    --},
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    --["<Tab>"] = cmp.mapping(function(fallback)
    --if cmp.visible() then
    --cmp.select_next_item()
    --elseif luasnip.expandable() then
    --luasnip.expand()
    --elseif luasnip.expand_or_jumpable() then
    --luasnip.expand_or_jump()
    --elseif check_backspace() then
    --fallback()
    --else
    --fallback()
    --end
    --end, {
    --"i",
    --"s",
    --}),
    --["<S-Tab>"] = cmp.mapping(function(fallback)
    --if cmp.visible() then
    --cmp.select_prev_item()
    --elseif luasnip.jumpable(-1) then
    --luasnip.jump(-1)
    --else
    --fallback()
    --end
    --end, {
    --"i",
    --"s",
    --}),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
    { name = "path" },
  },
  --experimental = {
  --ghost_text = false,
  --native_menu = false,
  --},
}
