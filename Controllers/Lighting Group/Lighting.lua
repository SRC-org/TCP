-------------------------------------------------
---- Copyright SRC 2026. All rights reserved ----
---- Written by programmer137                ----
-------------------------------------------------

-- don't copy into the game, only for the IDE
--[[
SW = require("Stormworks")
input = SW.input
output = SW.output
property = SW.property
]]

get = input.getBool
set = output.setBool
getnum = input.getNumber
setnum = output.setNumber
numprop = property.getNumber
boolprop = property.getBool

-- properties
autorun = boolprop("Automatic Running Lights")
headmd = numprop("Running Light Behavior")
-- 0: enable all lights, 1: disable high beams, 2: disable headlights, 3: disable running lights
fogmd = numprop("Fog Light Behavior")
revmd = numprop("Reversing Light Mode")
parkmd = numprop("Parking Light Mode")
shuntmd = numprop("Shunting Light Mode")
rgbrun = boolprop("Front RGB Lights")
tailrun = boolprop("Taillight Behavior")

frontrgb = {
  r = numprop("Front RGB Light (R)") / 255.0,
  g = numprop("Front RGB Light (G)") / 255.0,
  b = numprop("Front RGB Light (B)") / 255.0
}

rearrgb = {
  r = numprop("Rear RGB Light (R)") / 255.0,
  g = numprop("Rear RGB Light (G)") / 255.0,
  b = numprop("Rear RGB Light (B)") / 255.0
}

function setrgb(channel, rgb, condition)
  if condition then
    setnum(channel, rgb.r)
    setnum(channel + 1, rgb.g)
    setnum(channel + 2, rgb.b)
  end
end

-- channel mapping
lin = {
  head = 2,
  high = 3,
  work = 4,
  warn = 5,
  deco = 6,
  run = 10,
  fog = 11,
  ditch = 12,
  flash = 13,
  rev = 7,
  park = 8,
  shunt = 9
}

lout = {
  front = {
    run = 1,
    head = 2,
    tail = 3,
    high = 4,
    fog = 5,
    ditch = 6,
    rev = 7,
    warn = 8,
  },

  rear = {
    run = 9,
    head = 10,
    tail = 11,
    high = 12,
    fog = 13,
    ditch = 14,
    rev = 15,
    warn = 16
  },

  global = {
    run = 17,
    fog = 18,
    warn = 19,
    work = 20,
    deco = 21,
    flash = 22
  }
}

function onTick()
  lights = {}
  out = {}

  for light, ch in pairs(lin) do
    lights[light] = get(ch)
    out[light] = get(ch)
  end


  id          = getnum(32)
  len         = getnum(30)
  flipped     = get(32)
  is_front    = id == 1
  is_rear     = id == len
  front_clear = is_front and not flipped or is_rear and flipped
  rear_clear  = is_rear and not flipped or is_front and flipped
  reversed    = revmd == 1 and lights.rev


  out.run   = (lights.head and headmd ~= 1 or lights.run or autorun and get(30)) and
      not (fogmd == 3 and lights.fog) and not headmd == 0
  out.head  = headmd == 0 and lights.head or
      lights.head and not lights.run and not (fogmd >= 2 and lights.fog)
  out.tail  = (lights.head and not lights.run) or (lights.run or autorun and get(30)) and tailrun
  out.high  = lights.head and lights.high and not (fogmd >= 1 and lights.fog)
  out.ditch = lights.ditch
  out.rev   = lights.rev and revmd == 3


  both_head      = lights.shunt and shuntmd == 1 or lights.park and parkmd == 2
  both_tail      = lights.park and parkmd == 1
  both_head_tail = lights.rev and revmd == 2 or lights.park and parkmd == 3 or lights.shunt and shuntmd == 2


  front_enabled         = (reversed == flipped and not both_tail or both_head or both_head_tail) and front_clear
  rear_enabled          = (reversed ~= flipped and not both_tail or both_head or both_head_tail) and rear_clear
  front_enabled_flipped = (reversed ~= flipped and not both_head or both_tail or both_head_tail) and front_clear
  rear_enabled_flipped  = (reversed == flipped and not both_head or both_tail or both_head_tail) and rear_clear

  for light, channel in pairs(lout.global) do
    set(channel, out[light])
  end

  for light, channel in pairs(lout.front) do
    if light == "tail" or light == "rev" then
      set(channel, out[light] and front_enabled_flipped)
    else
      set(channel, out[light] and front_enabled)
    end
  end

  for i = 1, 6 do
    setnum(i, 0.0)
  end

  setrgb(1, rearrgb, out.tail and front_enabled_flipped)
  setrgb(1, frontrgb, (rgbrun and out.run or not rgbrun and out.head) and front_enabled)


  for light, channel in pairs(lout.rear) do
    if light == "tail" or light == "rev" then
      set(channel, out[light] and rear_enabled_flipped)
    else
      set(channel, out[light] and rear_enabled)
    end
  end

  setrgb(4, rearrgb, out.tail and rear_enabled_flipped)
  setrgb(4, frontrgb, (rgbrun and out.run or not rgbrun and out.head) and rear_enabled)
end
