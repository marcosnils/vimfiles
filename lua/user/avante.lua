require('avante_lib').load()
require('avante').setup({
  provider = "claude37",
  -- cursor_applying_provider = "groq",
  -- behaviour = {
  --   enable_cursor_planning_mode = true,
  -- },
  vendors = {
    claude37 = {
      __inherited_from = "claude",
      model = "claude-3-7-sonnet-20250219",
    },
  },
  disabled_tools = { "python" },
})
