require('user.lsp')

require('user.comp')
require('user.copilot')
require('user.treesitter')
require('user.conform')
require('user.undotree')
require('user.telescope')
require('user.claudecode')
-- removing avante for now. Trying coder/claudecode.nvim
--require("user.avante")


require("gitsigns").setup()
require("oil").setup({
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true
  }
})
vim.keymap.set({ "n", "v", "i" }, "<F1>", require("oil").toggle_float)

vim.keymap.set("n", "<leader>gd", function()
  vim.cmd.Gitsigns("preview_hunk")
end, {
  noremap = true,
  silent = true,
  desc = "Git preview hunk",
})

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
  ensure_installed = { "gopls@v0.14.2", "golangci_lint_ls" },
  automatic_enable = false
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

vim.keymap.set("n", "<C-x>", ":bd <cr>", {
  noremap = true,
  silent = true,
  --buffer = vim.api.nvim_get_current_buf(),
  desc = "Close buffer",
})
