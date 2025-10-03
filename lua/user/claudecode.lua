local opts = { noremap = true, silent = true }
require("claudecode").setup {
  terminal_cmd = "~/.claude/local/claude",
  terminal = {
    provider = "none"
  }
}

vim.keymap.set('v', "<leader>as", "<cmd>ClaudeCodeSend<cr>", opts)
vim.keymap.set('n', "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", opts)

--keys = {
--{ "<leader>a",  nil,                              desc = "AI/Claude Code" },
--{ "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
--{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
--{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
--{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
--{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
--{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
--{ "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
---- Diff management
--{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept diff" },
--{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Deny diff" },
--},
