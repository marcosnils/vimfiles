vim.opt.compatible = false
vim.opt.termsync = true
vim.opt.hidden = true
vim.opt.updatetime = 250
vim.opt.mouse = ""
vim.opt.inccommand = "nosplit"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.textwidth = 0
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.number = true
vim.opt.smoothscroll = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undodir"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.ruler = true
vim.opt.wildmenu = true
vim.opt.autoread = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.colorcolumn = "80"
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.spelllang = { "en_us" }
vim.opt.spellfile = vim.uv.os_homedir() .. "/.spell.add"
vim.opt.laststatus = 3
vim.opt.cursorline = true
vim.opt.grepprg = "rg --vimgrep --smart-case --follow"
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.shortmess:append("c")
vim.opt.timeoutlen = 300
vim.opt.winborder = "none"
vim.opt.gdefault = true
vim.opt.whichwrap = "<,>,[,],h,l"
vim.opt.showbreak = "..."
vim.opt.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<"
vim.opt.foldenable = false
vim.g.vim_json_conceal = 0

-- options from my previous config which I'm not sure I want to migrate
--vim.opt.linebreak = true
--vim.opt.formatoptions = "qrn1"
--vim.opt.winfixheight = true
--vim.opt.equalalways = false
--vim.opt.virtualedit = "block"
--vim.opt.sessionoptions = "buffers,curdir,folds,help,winpos,winsize,tabpages,unix,slash,localoptions"
--set complete+=k # need to figure a way to set this in lua

vim.hl.priorities.semantic_tokens = 10
vim.g.fugitive_legacy_commands = 0

vim.cmd([[
inoreabbrev descriptoin description
inoreabbrev fucn func
inoreabbrev sicne since
inoreabbrev emtpy empty
inoreabbrev udpate update
inoreabbrev dont don't
inoreabbrev wont won't
inoreabbrev cant can't
inoreabbrev lenght length
inoreabbrev Lenght Length
]])



vim.pack.add({
  -- UI
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/Lokaltog/vim-distinguished" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/stevearc/dressing.nvim" },
  { src = "https://github.com/rcarriga/nvim-notify" },
  { src = "https://github.com/famiu/bufdelete.nvim" },
  { src = "https://github.com/norcalli/nvim-colorizer.lua" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/akinsho/git-conflict.nvim" },
  -- telescope
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  --{ src = "https://github.com/nvim-telescope/telescope-github.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },

  -- CODING
  { src = "https://github.com/danymat/neogen" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/zbirenbaum/copilot.lua" },
  { src = "https://github.com/coder/claudecode.nvim" },
  { src = "https://github.com/linrongbin16/gitlinker.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/scrooloose/nerdcommenter.git" },
  { src = "https://github.com/giuxtaposition/blink-cmp-copilot" },
  { src = "https://github.com/mawkler/refjump.nvim" },
  { src = "https://github.com/stevearc/oil.nvim.git" },
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },

  -- tpope gang
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/tpope/vim-rhubarb" },
  { src = "https://github.com/tpope/vim-abolish" },
  { src = "https://github.com/tpope/vim-repeat" },
  { src = "https://github.com/tpope/vim-unimpaired" },
  { src = "https://github.com/tpope/vim-sleuth" },


  -- treesitter and friends
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/wansmer/treesj" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/kylechui/nvim-surround" },
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/RRethy/nvim-treesitter-endwise" },
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- remap search
keymap('n', '/', '/\\v', opts)
keymap('v', '/', '/\\v', opts)
-- Search word under cursor
keymap('n', ',', '/<C-R><C-W><CR>N',opts)

-- Clear highlight
keymap('n', '<leader><space>', ':noh<CR>', opts)

-- hardtabs
keymap('i', "<leader><Tab>", "<C-V><Tab>")


-- buffer kill
keymap("n", "<C-x>", ":Bdelete<CR>", opts)

-- system clipboard integration
keymap({ "n", "v" }, "<leader>y", '"+y', opts)

-- Creates new empty buffer
keymap('n', '<C-N>', ':enew<CR>', opts)

-- Cycles between windows
keymap('n', '<leader><tab>', '<C-W>w', opts)

-- List/Next/Previous buffers
keymap({ '', 'i' }, '<F3>', '<cmd>bp<CR>', opts)
keymap({ '', 'i' }, '<F4>', '<cmd>bn<CR>', opts)

-- Toggle between display line endings (list characters)
keymap({ '', 'i' }, '<F6>', function() vim.opt.list = not vim.opt.list:get() end, opts)

-- Select line without newline char in visual mode
keymap('n', '<leader>v', '0vg_', opts)

-- Indent/un-indent selected lines
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Unimpaired configuration (bubble lines up/down)
keymap('n', '<C-Up>', '[e', {remap=true})
keymap('n', '<C-Down>', ']e', {remap=true})
keymap('v', '<C-Up>', '[egv', {remap=true})
keymap('v', '<C-Down>', ']egv', {remap=true} )

-- Make cursor move as expected with wrapped lines
keymap('n', '<Up>', 'gk', { silent = true })
keymap('n', '<Down>', 'gj', { silent = true })
keymap('i', '<C-Up>', '<C-O>gk', { silent = true })
keymap('i', '<C-Down>', '<C-O>gj', { silent = true })

-- Remaps J to gJ to join lines without spaces
keymap('', 'J', 'gJ', {})

-- Replace
keymap('n', '<leader>r', [[:%s/\v/]], { desc = 'Global search and replace' })

-- Split vertical window and swltch to it
keymap('n', '<leader>s', ':vsplit<CR><C-w>l', opts)

-- Split horizontal window and switch to it
keymap('n', '<leader>h', ':split<CR>', opts)

-- Use sudo to save a file
keymap('c', 'w!!', [[w !sudo tee % >/dev/null]], { desc = 'Save with sudo' })

-- Paste from system clipboard without messing up indentation
keymap('n', '<leader>p', ':set paste<CR>"+p<CR>:set nopaste<CR>', { desc = 'Paste from system clipboard' })

-- copy the current file path
keymap("n", "<leader>py", ':let @" = expand("%:p")<CR>', opts)

-- Toggle between Wrap and no Wrap lines
keymap(
  { 'n', 'i' },
  '<F5>',
  function()
    vim.opt.wrap = not vim.opt.wrap:get()
    vim.cmd('set wrap?')
  end,
  opts
)

-- delete to blackhole
keymap({ "n", "v" }, "<leader>d", '"_d', opts)

-- git
keymap("n", "<leader>gd", ":Gitsign preview_hunk_inline<cr>", opts)

-- indent
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- If I visually select words and paste from clipboard, don't replace my
-- clipboard with the selected word, instead keep my old word in the
-- clipboard
keymap("v", "p", '"_dP', opts)


-- in insert mode, adds new undo points after more some chars:
for _, lhs in ipairs({ "-", "_", ",", ".", ";", ":", "/", "!", "?" }) do
  keymap("i", lhs, lhs .. "<c-g>u", opts)
end

vim.cmd("colorscheme distinguished")
-- https://github.com/nvim-lualine/lualine.nvim/issues/1312
vim.api.nvim_set_hl(0, "StatusLine", { reverse = false })
vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = false })

require("dressing").setup({ input = { insert_only = true } })

require("colorizer").setup()
local notify = require("notify")
notify.setup({
  render = "compact",
  stages = "static",
})
vim.notify = notify

local section_b = { "branch", "diff", { "diagnostics", sources = { "nvim_workspace_diagnostic" } } }
local section_c = { "%=", { "filename", file_status = false, path = 1 } }
require("lualine").setup({
  options = {
    theme = "iceberg_dark",
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '|', right = '|' },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_b = section_b,
    lualine_c = section_c,
  },
  inactive_sections = {
    lualine_c = section_c,
    lualine_x = { "location" },
  },
    tabline = {
    lualine_a = { 'buffers' },
    lualine_z = { 'tabs' }
  },
})

require("gitsigns").setup({})
require("git-conflict").setup({})

local float_config = {
  focusable = true,
  style = "minimal",
  source = "if_many",
  border = "single",
}

-- setup diagnostics
vim.diagnostic.config({
  --underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = float_config,
})


keymap("n", "<leader>xx", vim.diagnostic.setqflist, opts)

require("neogen").setup({ snippet_engine = "nvim" })
keymap("n", "gco", ":Neogen<cr>", opts)

require("conform").setup({
  formatters_by_ft = {
    css = { "prettier" },
    fish = { "fish_indent" },
    html = { "prettier", "injected" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    json = { "jq" },
    lua = { "stylua" },
    markdown = { "prettier", "injected" },
    sh = { "shfmt" },
    sql = { "pg_format", "sql_formatter" },
    templ = { "templ" },
    tf = { "terraform_fmt" },
    yaml = { "prettier" },
    ["_"] = { "trim_whitespace", "trim_newlines" },
    go = {"gofumpt", "gofmt", "injected"},
    rust = {"rustfmt"},
    zig = {"zigftm"},
  },
  format_after_save = {
    lsp_fallback = true,
    timeout_ms = 700,
  },
})

require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<C-j>",
      next = "<M-]>",
      prev = "<M-[>",
    }
  },
  panel = { enabled = false },
})

---@module 'blink.cmp'
---@type blink.cmp.Config
require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ['<Enter>'] = { 'accept', 'fallback' },
    ['<C-space>'] = { "show", "show_documentation", "hide_documentation" },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  signature = { enabled = true },
  cmdline = {
    enabled = true,
    sources = function()
      local type = vim.fn.getcmdtype()
      if type == "/" or type == "?" then
        return { "buffer" }
      end
      if type == ":" then
        return { "cmdline" }
      end
      return {}
    end,
    completion = {
      menu = {
        draw = {
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "kind" },
          },
        },
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "copilot" },
    providers = {
      lsp = {
        min_keyword_length = 0,
        score_offset = 0,
      },
      path = {
        min_keyword_length = 0,
      },
      snippets = {
        min_keyword_length = 2,
      },
      buffer = {
        min_keyword_length = 5,
        max_items = 5,
      },
      copilot = {
        name = "copilot",
        module = "blink-cmp-copilot",
        score_offset = -10000,
        min_keyword_length = 0,
        async = true,
        override = {
          -- copilot complete on space, new line, etc as well...
          get_trigger_characters = function(self)
            local trigger_characters = self:get_trigger_characters()
            vim.list_extend(trigger_characters, { "\n", "\t", " " })
            return trigger_characters
          end,
        },
        transform_items = function(_, items)
          local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
          local kind_idx = #CompletionItemKind + 1
          CompletionItemKind[kind_idx] = "Copilot"
          for _, item in ipairs(items) do
            item.kind = kind_idx
          end
          return items
        end,
      },
    },
  },
  completion = {
    accept = { auto_brackets = { enabled = true } },
    keyword = {
      range = "full",
    },
    trigger = {
      show_on_insert_on_trigger_character = true,
      show_on_trigger_character = true,
      show_on_keyword = true,
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      treesitter_highlighting = false,
    },
    menu = {
      draw = {
        columns = {
          { "kind_icon", "label", gap = 1 },
          { "kind" },
        },
      },
    },
  },
})

local function copen()
  if vim.fn.getqflist({ size = 0 }).size > 1 then
    vim.cmd("copen")
  else
    vim.cmd("cclose")
  end
end

local function cclear()
  vim.fn.setqflist({}, "r")
end

-- Opens the directory of the current file in Finder/file explorer.
vim.api.nvim_create_user_command("Finder", "!open %:h", {})

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    -- Check if the buffer has a stored position
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
  group = vim.api.nvim_create_augroup("RestoreCursor", { clear = true }),
})

vim.api.nvim_create_autocmd({
  "BufEnter",
  "CursorHold",
  "CursorHoldI",
  "FocusGained",
}, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  command = "startinsert",
})

-- ensure the parent folder exists, so it gets properly added to the lsp
-- context and everything just works.
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*",
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
      vim.cmd([[ :e % ]])
    end
  end,
})

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.txt" },
  callback = function()
    if vim.o.filetype == "help" then
      vim.cmd.wincmd("L")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "git",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local buf_opts = { noremap = true, silent = true, buffer = bufnr }
    keymap("n", "gq", ":silent! close<cr>", buf_opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fugitive",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()

    local function async_git(args, success_msg, error_msg)
      vim.system({ "git", unpack(args) }, {}, function(obj)
        vim.schedule(function()
          if obj.code == 0 then
            vim.notify(success_msg, vim.log.levels.INFO)
          else
            vim.notify(error_msg, vim.log.levels.ERROR)
          end
        end)
      end)
    end

    vim.cmd("normal )k=")

    local buf_opts = { noremap = true, silent = true, buffer = bufnr }
    keymap("n", "gp", function()
      async_git({ "push", "--quiet" }, "Pushed!", "Push failed!")
      vim.cmd("silent! close")
    end, buf_opts)

    keymap("n", "gP", function()
      async_git({ "pull", "--rebase" }, "Pulled!", "Pull failed!")
      vim.cmd("silent! close")
    end, buf_opts)

    keymap("n", "go", function()
      async_git({ "ppr" }, "Pushed and opened PR URL!", "Failed to push or open PR")
      vim.cmd("silent! close")
    end, buf_opts)

    keymap("n", "cc", ":silent! Git commit -s<cr>", buf_opts)
    keymap("n", "gq", ":silent! close<cr>", buf_opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 72
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help" },
  callback = function()
    keymap("n", "<leader>q", ":bdelete<CR>", {
      buffer = vim.api.nvim_get_current_buf(),
      noremap = true,
      silent = true,
    })
  end,
})

local get_gopls = function(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, c in ipairs(clients) do
    if c.name == "gopls" then
      return c
    end
  end
  return nil
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()

    vim.opt_local.formatoptions:append("jo")
    vim.opt_local.makeprg = "go build ./..."
    vim.opt_local.errorformat = "%A%f:%l:%c: %m,%-G%.%#"

    vim.api.nvim_buf_create_user_command(bufnr, "GoModTidy", function()
      local gopls = get_gopls(bufnr)
      if gopls == nil then
        return
      end

      vim.cmd([[ noautocmd wall ]])

      local uri = vim.uri_from_bufnr(bufnr)
      local arguments = { { URIs = { uri } } }

      local err = gopls:request_sync("workspace/executeCommand", {
        command = "gopls.tidy",
        arguments = arguments,
      }, 30000, bufnr)

      if err ~= nil and type(err[1]) == "table" then
        vim.notify("go mod tidy: " .. vim.inspect(err), vim.log.levels.ERROR)
        return
      end
    end, { desc = "go mod tidy" })

    local buf_opts = { noremap = true, silent = true, buffer = bufnr }
    keymap("n", "<F6>", vim.cmd.GoModTidy, buf_opts)
    keymap("n", "<F7>", function()
      cclear()
      vim.fn.jobstart("golangci-lint run --max-issues-per-linter=0 --max-same-issues=0 --new", {
        stdout_buffered = true,
        on_stdout = function(_, data)
          if data and #data > 1 then
            vim.schedule(function()
              vim.fn.setqflist({}, " ", { lines = data })
              copen()
            end)
          end
        end,
      })
    end, buf_opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:remove("ct")
  end,
})

require("plugins.syntax")

local treesj = require("treesj")
treesj.setup({ use_default_keymaps = false })
keymap("n", "<leader>st", treesj.toggle, opts)

local telescope = require("telescope")
telescope.setup({
  defaults = {
    pickers = {
      find_files = {
        theme = "get_dropdown",
      },
    },
    prompt_prefix = "   ",
    selection_caret = " ❯ ",
    entry_prefix = "   ",
    multi_icon = "+ ",
    path_display = { "filename_first" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--sort=path",
    },
  },
})
--telescope.load_extension("gh")

local function theme(iopts)
  return require("telescope.themes").get_dropdown(iopts)
end

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", function()
  builtin.find_files(theme({
    find_command = {
      "rg", "--hidden", "--files", "--smart-case", "--glob=!.git"
    },
  }))
end, opts)

keymap("n", "<C-F>o", function()
  builtin.oldfiles(theme({
    only_cwd = true,
  }))
end, opts)

keymap("n", "<C-F>f", function()
  builtin.live_grep(theme())
end, opts)

keymap("n", "<C-F>b", function()
  builtin.buffers(theme())
end, opts)

keymap("n", "<C-F>d", function()
  builtin.diagnostics(theme())
end, opts)

keymap("n", "gr", function()
  builtin.lsp_references(theme())
end, opts)

keymap("n", "gk", function()
  builtin.keymaps(theme())
end, opts)

keymap("n", "<leader>ls", function()
  builtin.lsp_document_symbols(theme())
end, opts)

keymap("n", "<leader>lS", function()
  builtin.lsp_dynamic_workspace_symbols(theme())
end, opts)

keymap("n", "<space>D", function()
  builtin.lsp_type_definitions(theme())
end, opts)

keymap("n", "gi", function()
  builtin.lsp_implementations(theme())
end, opts)

keymap("n", "<C-F>h", function()
  builtin.help_tags(theme())
end, opts)

keymap("n", "<leader>fc", function()
  builtin.commands(theme())
end, opts)

keymap("n", "<C-F>r", function()
  builtin.resume(theme())
end, opts)


keymap("n", "<C-F>q", function()
  builtin.quickfix(theme())
end, opts)

keymap("n", "<C-F>c", function()
  builtin.current_buffer_fuzzy_find(theme())
end, opts)

--keymap("n", "<leader>ghi", function()
--  telescope.extensions.gh.issues(theme())
--end, opts)
--

-- claude
require("claudecode").setup {
  terminal_cmd = "~/.claude/local/claude",
  terminal = {
    provider = "none"
  }
}

keymap('v', "<leader>as", "<cmd>ClaudeCodeSend<cr>", opts)
keymap('n', "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", opts)

require "gitlinker".setup()

keymap(
  { "n", 'v' },
  "<leader>gy",
  require("gitlinker").link,
  { silent = true, noremap = true, desc = "GitLink" }
)
keymap(
  { "n", 'v' },
  "<leader>gY",
  function()
    require("gitlinker").link({ action = require("gitlinker.actions").system })
  end,
  { silent = true, noremap = true, desc = "GitLink!" }
)

require("refjump").setup({
  keymaps = {
    enable = true,
    next = "<M-n>",
    prev = "<M-p>",
  },
  highlights = {
     enable = false,
  }
})

require("oil").setup({
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true
  }
})
keymap({ "n", "v", "i" }, "<F1>", require("oil").toggle_float)

require("plugins.lsp")


