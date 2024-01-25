-- This is required to not have cue files marked as `cuesheet`
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.cue" },
  command = "set filetype=cue",
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.cue = {
  install_info = {
    url = "https://github.com/eonpatapon/tree-sitter-cue", -- local path or git repo
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main"
  },
  filetype = "cue", -- if filetype does not agrees with parser name
}

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "bash",
    "help",
    "css",
    "dockerfile",
    "fish",
    "go",
    "gomod",
    "gowork",
    "graphql",
    "hcl",
    "html",
    "javascript",
    "cue",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "rust",
    "scss",
    "toml",
    "json",
    "vim",
    "yaml",
  },

  highlight = {
    enable = true,
  },


  textobjects = {
    enable = true,
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]]"] = "@function.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
      },
    },
  },

  indent = {
    enable = false,
    disable = { "yaml" },
  },
}

-- disables json conceal in treesitter
vim.treesitter.query.set("json", "highlights", [[
(true) @boolean
(false) @boolean
(null) @constant.builtin
(number) @number
(pair key: (string) @label)
(pair value: (string) @string)
(array (string) @string)
(string_content (escape_sequence) @string.escape)
(ERROR) @error
"," @punctuation.delimiter
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
]])