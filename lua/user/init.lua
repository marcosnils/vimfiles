require('user.lsp')

require('user.comp')
require('user.copilot')
require('user.treesitter')
require('user.conform')
require('user.undotree')
require('user.telescope')
require("gitsigns").setup()
require("user.avante")


require("ibl").setup()

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'iceberg_dark',
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '|', right = '|' },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {
      {
        "filename",
        file_status = false,
        path = 1,
      },
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = { 'buffers' },
    lualine_z = { 'tabs' }
  },
  extensions = {}
}

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { "gopls@v0.14.2", "golangci_lint_ls" }
})

require "gitlinker".setup()

vim.keymap.set(
  { "n", 'v' },
  "<leader>gy",
  require("gitlinker").link,
  { silent = true, noremap = true, desc = "GitLink" }
)
vim.keymap.set(
  { "n", 'v' },
  "<leader>gY",
  function()
    require("gitlinker").link({ action = require("gitlinker.actions").system })
  end,
  { silent = true, noremap = true, desc = "GitLink!" }
)
