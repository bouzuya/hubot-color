# Description
#   A Hubot script that convert the color code to rgb, hsl, and hex format.
#
# Dependencies:
#   "tinycolor2": "^1.0.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot color - convert the color code to rgb, hsl, and hex format
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  tinycolor = require 'tinycolor2'

  robot.respond /color\s+(.*?)\s*$/i, (res) ->
    color = res.match[1]
    c = tinycolor(color)
    s = unless c.isValid() then 'invalid' else """
      #{c.toRgbString()}, #{c.toHslString()}, #{c.toHexString()}
    """
    res.send "color #{color} is #{s}."
