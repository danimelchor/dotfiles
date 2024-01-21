return {
  -- Harpoon
  {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
    config = function()
      require("harpoon"):setup({
        settings = {
          save_on_toggle = true,
        }
      })
    end,
    keys = {
      {
        '<leader>h',
        function()
          require("harpoon"):list():append()
        end,
        desc = "Harpoon list"
      },
      {
        '<C-e>',
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon quick menu"
      },
      unpack((
        function()
          local keys = {}
          for i = 1, 9 do
            table.insert(keys, {
              string.format("<leader>%d", i),
              function()
                require("harpoon"):list():select(i)
              end,
              desc = string.format("Harpoon select %d", i)
            })
          end
          return keys
        end
      )())
    }
  },
}
