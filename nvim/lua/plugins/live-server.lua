return {
  {
    "ngtuonghy/live-server-nvim",
    event = "VeryLazy",
    build = ":LiveServerInstall", -- Installs necessary dependencies
    config = function()
      require("live-server-nvim").setup({
        -- Optional: customize the default port, e.g., port = 8080
      })
    end,
  },
}
