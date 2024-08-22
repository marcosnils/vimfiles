local opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')
vim.keymap.set("n", "<C-p>", function()
  builtin.find_files({
    find_command = { "rg", "--hidden", "--files", "--smart-case", "--glob=!.git" },
  })
end, opts)
vim.keymap.set('n', '<C-F>f', builtin.live_grep, {})
vim.keymap.set('n', '<C-F>b', builtin.buffers, {})
--vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
--
require('telescope').setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        preview_height = 0.3,
        width = 0.8,
        height = 0.8
      }

      -- other layout configuration here
    },
    -- other defaults configuration here
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
