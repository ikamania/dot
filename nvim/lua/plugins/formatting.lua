return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        python = { "ruff_format" },
      },
      formatters = {
        ["clang-format"] = {
          -- Fall back to 4-space indentation when the project has no .clang-format
          prepend_args = function(_, ctx)
            local found = vim.fs.find({ ".clang-format", "_clang-format" }, {
              path = ctx.dirname,
              upward = true,
            })[1]
            if not found then
              return { "-style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4}" }
            end
            return {}
          end,
        },
      },
    },
  },
}
