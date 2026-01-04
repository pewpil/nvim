return {
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = false, -- Try disabling build if it's trying to build rocks
    rocks = {
      hererocks = false,
    },
    config = function()
      require("rest-nvim").setup({
        client = "curl",
        env_file = ".env",
        encode_url = true,
        skip_ssl_verification = false,
        custom_dynamic_variables = {},
        logs = {
          level = "info",
          save = true,
        },
      })
    end,
    keys = {
      {
        "<leader>rr",
        "<cmd>Rest run<cr>",
        desc = "Run request under cursor",
      },
      {
        "<leader>rl",
        "<cmd>Rest run last<cr>",
        desc = "Re-run last request",
      },
    },
  },
}
