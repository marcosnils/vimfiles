-- This is required to not have cue files marked as `cuesheet`
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
        pattern = {"*.cue"},
        command = "set filetype=cue",
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.cue = {
  install_info = {
    url = "https://github.com/eonpatapon/tree-sitter-cue", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"},
    branch = "main"
  },
  filetype = "cue", -- if filetype does not agrees with parser name
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },
  highlight = {
    indent = {
      enable = false,
      disable = {"yaml"},
    },
    enable = true,
    additional_vim_regex_highlighting = false,
    custom_captures = {
      --- cue
      ["operator.default"] = "Statement",
      ["operator.regexp"] = "Statement",
      ["operator.unify"] = "Statement",
      ["operator.disjunct"] = "Label",
      ["definition"] = "Bold"
    }
  }
}
