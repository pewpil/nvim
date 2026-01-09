return {
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    build = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
         "lunarmodules/lua-mimetypes",
         name = "mimetypes",
         build = false,
         init = function()
            local lazy_path = vim.fn.stdpath("data") .. "/lazy"
            package.path = package.path .. ";" .. lazy_path .. "/mimetypes/?.lua;" .. lazy_path .. "/mimetypes/?/init.lua"
         end
      },
      {
         "manoelcampos/xml2lua",
         name = "xml2lua",
         build = false,
         init = function()
             local lazy_path = vim.fn.stdpath("data") .. "/lazy"
             package.path = package.path .. ";" .. lazy_path .. "/xml2lua/?.lua;" .. lazy_path .. "/xml2lua/?/init.lua"
         end
      }
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
