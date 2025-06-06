local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    css = { "prettier" },
    go = { "gofumpt", "gofmt", "injected" },
    html = { "prettier", "injected" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { 'prettierd', "prettier", stop_after_first = true },
    json = { "jq" },
    lua = { "stylua" },
    markdown = { "prettier", "injected" },
    nix = { "nixpkgs_fmt" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    sql = { "pg_format", "sql_formatter" },
    tf = { "terraform_fmt" },
    zig = { "zigfmt" },
    python = { "ruff_format" },
    ["_"] = { "trim_whitespace" },
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
