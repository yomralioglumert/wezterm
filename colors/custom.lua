-- A custom vibrant color palette with lots of pink, orange, and green!
local vibrant = {
   pink      = '#FF1E89', -- vibrant pink
   orange    = '#FF7A00', -- vibrant orange
   green     = '#32FF6A', -- neon green
   red       = '#FF3A5C', -- bright red
   yellow    = '#FFE600', -- bright yellow
   purple    = '#B239FF', -- electric purple
   cyan      = '#00E5FF', -- neon cyan
   blue      = '#0070FF', -- electric blue
   
   text      = '#F0F0F0',
   subtext1  = '#D0D0D0',
   subtext0  = '#A0A0A0',
   overlay2  = '#707070',
   overlay1  = '#505050',
   overlay0  = '#404040',
   surface2  = '#2A2A2A',
   surface1  = '#1E1E1E',
   surface0  = '#141414',
   base      = '#0C0C0C',
   mantle    = '#080808',
   crust     = '#040404',
}

local colorscheme = {
   foreground = vibrant.text,
   background = vibrant.base,
   cursor_bg = vibrant.pink,
   cursor_border = vibrant.pink,
   cursor_fg = vibrant.base,
   selection_bg = vibrant.surface2,
   selection_fg = vibrant.text,
   
   -- We're injecting our super vibrant colors into the terminal's standard palette
   ansi = {
      vibrant.surface1, -- black
      vibrant.red,      -- red
      vibrant.green,    -- green
      vibrant.yellow,   -- yellow
      vibrant.blue,     -- blue
      vibrant.pink,     -- magenta
      vibrant.cyan,     -- cyan
      vibrant.subtext0, -- white
   },
   brights = {
      vibrant.overlay0, -- black
      '#FF6382',        -- bright red
      '#66FF9F',        -- bright green
      '#FFEE5E',        -- bright yellow
      '#4D9CFF',        -- bright blue
      '#FF5EAE',        -- bright magenta (pink)
      '#5EF0FF',        -- bright cyan
      vibrant.text,     -- white
   },
   tab_bar = {
      background = 'rgba(0, 0, 0, 0.6)',
      active_tab = {
         bg_color = vibrant.surface2,
         fg_color = vibrant.pink,
      },
      inactive_tab = {
         bg_color = vibrant.surface0,
         fg_color = vibrant.subtext1,
      },
      inactive_tab_hover = {
         bg_color = vibrant.surface1,
         fg_color = vibrant.text,
      },
      new_tab = {
         bg_color = vibrant.base,
         fg_color = vibrant.text,
      },
      new_tab_hover = {
         bg_color = vibrant.mantle,
         fg_color = vibrant.text,
         italic = true,
      },
   },
   visual_bell = vibrant.orange,
   indexed = {
      [16] = vibrant.orange,
      [17] = vibrant.pink,
   },
   scrollbar_thumb = vibrant.surface2,
   split = vibrant.pink,
   compose_cursor = vibrant.orange,
}

return colorscheme
