local opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')

local ivy = require("telescope.themes").get_ivy({ layout_config = { height = 15 } })



vim.keymap.set("n", "<C-p>", function()
  local opts = ivy
  opts.find_command = { "rg", "--hidden", "--files", "--smart-case", "--glob=!.git" },
      builtin.find_files(opts)
end, opts)

vim.keymap.set('n', '<C-F>f', function() builtin.live_grep(ivy) end, opts)
vim.keymap.set('n', '<C-F>b', function() builtin.buffers(ivy) end, opts)
vim.keymap.set('n', '<C-F>r', function() builtin.resume(ivy) end, opts)
vim.keymap.set('n', '<C-F>c', function() builtin.current_buffer_fuzzy_find(ivy) end, opts)
vim.keymap.set('n', '<C-F>d', function() builtin.diagnostics(ivy) end, opts)
vim.keymap.set("n", "<C-F>s", require("user.telescope-multi"), opts)
--vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
--
require('telescope').setup({
  defaults = {
    pickers = {
      find_files = {
        theme = "ivy",
      },
    },
  },
  -- other defaults configuration here
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
