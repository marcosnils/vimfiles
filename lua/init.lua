require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}

require('lualine').setup{
  options = {
    icons_enabled = false,
    theme = 'iceberg_dark',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '|', right = '|'},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      {
        "filename",
        file_status = false,
        path = 1,
      },
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_z = {'tabs'}
  },
  extensions = {}
}

require('mason').setup()
require('mason-lspconfig').setup({
   ensure_installed = { "gopls", "golangci_lint_ls" }
})
