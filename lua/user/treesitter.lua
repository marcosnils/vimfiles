require 'nvim-treesitter.configs'.setup {

  auto_install = true,
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
[
  (true)
  (false)
] @boolean

(null) @constant.builtin

(number) @number

(pair
  key: (string) @property)

(pair
  value: (string) @string)

(array
  (string) @string)

[
  ","
  ":"
] @punctuation.delimiter

[
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket


(escape_sequence) @string.escape

]])
