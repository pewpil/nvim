return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    keys = {
      { "<leader>rs", function() require("kulala").run() end, desc = "Send request" },
      { "<leader>rt", function() require("kulala").toggle_view() end, desc = "Toggle headers/body" },
      { "<leader>rp", function() require("kulala").jump_prev() end, desc = "Jump to previous request" },
      { "<leader>rn", function() require("kulala").jump_next() end, desc = "Jump to next request" },
      { "<leader>rc", function() require("kulala").copy() end, desc = "Copy as cURL" },
      { "<leader>re", function() require("kulala").set_selected_env() end, desc = "Set environment" },
    },
    opts = {},
  },
}
