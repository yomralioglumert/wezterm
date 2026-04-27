-- Neon-noir palette: lively accents over a calmer dark base.
local vibrant = {
   pink = '#FF4FD8',
   coral = '#FF6B7A',
   orange = '#FFB86B',
   green = '#57E389',
   yellow = '#F9E076',
   purple = '#B877FF',
   cyan = '#4FE9F5',
   blue = '#60A5FA',

   text = '#F6F3FF',
   subtext1 = '#D6D0EA',
   subtext0 = '#ADA7C7',
   overlay2 = '#7D7896',
   overlay1 = '#625D78',
   overlay0 = '#49445E',
   surface2 = '#37324A',
   surface1 = '#29243A',
   surface0 = '#1D192B',
   base = '#100E1A',
   mantle = '#0B0A12',
   crust = '#07060B',
}

local colorscheme = {
   foreground = vibrant.text,
   background = vibrant.base,
   cursor_bg = vibrant.pink,
   cursor_border = vibrant.pink,
   cursor_fg = vibrant.crust,
   selection_bg = '#3E335F',
   selection_fg = vibrant.text,

   ansi = {
      vibrant.surface1,
      vibrant.coral,
      vibrant.green,
      vibrant.yellow,
      vibrant.blue,
      vibrant.purple,
      vibrant.cyan,
      vibrant.subtext1,
   },
   brights = {
      vibrant.overlay1,
      '#FF8A9A',
      '#8CFFB8',
      '#FFF2A6',
      '#8CC7FF',
      '#D5A6FF',
      '#8FF7FF',
      vibrant.text,
   },
   tab_bar = {
      background = 'rgba(7, 6, 11, 0.72)',
      active_tab = {
         bg_color = vibrant.surface2,
         fg_color = vibrant.text,
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
         bg_color = vibrant.mantle,
         fg_color = vibrant.purple,
      },
      new_tab_hover = {
         bg_color = vibrant.surface1,
         fg_color = vibrant.text,
         italic = true,
      },
   },
   visual_bell = vibrant.orange,
   indexed = {
      [16] = vibrant.orange,
      [17] = vibrant.pink,
      [18] = vibrant.surface0,
      [19] = vibrant.surface1,
      [20] = vibrant.surface2,
      [21] = vibrant.purple,
   },
   scrollbar_thumb = vibrant.surface2,
   split = vibrant.purple,
   compose_cursor = vibrant.orange,
}

return colorscheme
