install.packages( c("hexSticker" , "showtext"))

library(hexSticker) # Create Hexagon Sticker in R
library(showtext) # Using Fonts More Easily in R Graphs

## Loading Google fonts (http://www.google.com/fonts)
font_add_google( "Inconsolata" , "incon")

sticker(
  # Subplot (image)
  subplot = "logo/covid19.png" , # Image name
  s_y = 0.8 , # Position of the sub plot (y )
  s_x = 1.05 , # Position of the sub plot (x )
  s_width = .5 , # Width of the sub plot
  s_height=0.01 , # Height of the sub plot
  # Font
  package = "covid-19" , # Package name
  p_size = 20 ,# Font size of the text
  p_y = 1.5 , # Position of the font (y)
  p_x = 1 , # Position of the font (x)
  p_family = "incon", # Defines font
  # Spotlight
  spotlight = TRUE, # Enables spotlight
  l_y=0.8 , # Position of spotlight (y)
  l_x=0.7 , # Position of spotlight (x)
  # Sticker colors
  h_fill = "#5d8aa6", # Color for background
  h_color = "#2A5773", # Color for border
  dpi=300 , # Resolution: Sets DPI
  filename = "logo.png")

## add logo to package
usethis:: use_logo("logo.png")
