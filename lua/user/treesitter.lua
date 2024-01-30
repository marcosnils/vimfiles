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
