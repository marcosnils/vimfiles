local builtin = require('telescope.builtin')

local theme = require("telescope.themes").get_dropdown()

vim.keymap.set("n", "<C-p>", function()
  local opts = theme
  opts.find_command = { "rg", "--hidden", "--files", "--smart-case", "--glob=!.git" },
      builtin.find_files(opts)
end, opts)

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-F>f', function() builtin.live_grep(theme) end, opts)
vim.keymap.set('n', '<C-F>b', function() builtin.buffers(theme) end, opts)
vim.keymap.set('n', '<C-F>r', function() builtin.resume(theme) end, opts)
vim.keymap.set('n', '<C-F>c', function() builtin.current_buffer_fuzzy_find(theme) end, opts)
vim.keymap.set('n', '<C-F>d', function() builtin.diagnostics(theme) end, opts)
vim.keymap.set("n", "<C-F>s", require("user.telescope-multi"), opts)
vim.keymap.set('n', '<C-F>h', function() builtin.help_tags(theme) end, opts)
vim.keymap.set('n', 'gr', function() builtin.lsp_references(theme) end, opts)
vim.keymap.set('n', 'gk', function() builtin.keymaps(theme) end, opts)
vim.keymap.set('n', "<leader>ls", function() builtin.lsp_document_symbols(theme) end, opts)
vim.keymap.set('n', "<leader>lS", function() builtin.lsp_dynamic_workspace_symbols(theme) end, opts)
vim.keymap.set('n', '<space>D', function() builtin.lsp_type_definitions(theme) end, opts)
vim.keymap.set('n', 'gi', function() builtin.lsp_implementations(theme) end, opts)
--
require('telescope').setup({
  defaults = {
    pickers = {
      find_files = {
        theme = "dropdown",
      },
    },
  },
  vimgrep_arguments = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "--hidden",
    "--glob=!.git",
  },
  -- other configuration values here
})
