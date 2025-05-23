require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ['<Enter>'] = { 'accept', 'fallback' },
    ['<C-space>'] = { "show", "show_documentation", "hide_documentation" },
  },
  appearance = {
    --use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  signature = { enabled = true },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    -- Disable cmdline completions
  },
  completion = {
    accept = { auto_brackets = { enabled = true } },
    list = { selection = { preselect = false, auto_insert = true } },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      treesitter_highlighting = true,
    },
  },
})
