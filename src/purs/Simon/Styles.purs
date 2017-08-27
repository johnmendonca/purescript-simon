module Simon.Styles 
  ( styledButton
  ) where

import Prelude

import Simon.Colors (Color(..))

import CSS (backgroundColor, display, height, width)
import CSS as CSS
import CSS.Color (blue, desaturate, green, red, yellow)
import CSS.Display (inlineBlock)
import CSS.Size (px)
import Pux.DOM.HTML.Attributes (style)
import Text.Smolder.Markup (Attribute)

styledButton :: Color → Boolean → Attribute
styledButton color active =
  let
    cssColor = convertColor color
    bgColor  =
      if active
      then desaturate 0.5 cssColor
      else cssColor
  in
    style do
      backgroundColor bgColor
      height $ px 200.0
      width $ px 200.0
      display inlineBlock

convertColor :: Color → CSS.Color
convertColor Red    = red
convertColor Blue   = blue
convertColor Green  = green
convertColor Yellow = yellow
