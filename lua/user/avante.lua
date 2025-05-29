require('avante_lib').load()
require('avante').setup({
  provider = "claude",
  -- cursor_applying_provider = "groq",
  -- behaviour = {
  --   enable_cursor_planning_mode = true,
  -- },
  claude = {
    model = "claude-sonnet-4-20250514",
  },
  disabled_tools = { "python" },
})
