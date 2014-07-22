--[[
-- Map class
-- Maps and draws a level with obstacles and the player.
-- Map:reset() restarts the map. It can be done when the player dies, or manually.
--]]

-- libs
local window   = require 'love.window'
local player   = require 'assets.player'
local bump     = require 'lib.bump'

-- LEVELS PATH
local path     = '/assets/levels/'


local player   = require 'assets.player'
local map      = {}
local boxes    = {}
local g        = love.graphics

function map:new(w, h)
  self.width = w
  self.height = h
  self.world = bump.newWorld()
  self.player = player:initialize(self.world, 0, 0, 50, 50)
  map:loadLevel()
--  window.setMode(width, height, {resizable=true, vsync=false, minwidth=400, minheight=300})
end

function map:draw()
  player:draw()
  map:drawLevel()
end

function map:loadLevel()

  p = path.."level1.txt"
  for i in pairs(lines_from(p)) do

    line = h:split(lines[i],',')

    print(line)
    -- draw the ground
    box = {
        l = tonumber(line[1]),
        t = tonumber(line[2]),    
        w = tonumber(line[3]),
        h = tonumber(line[4])
    }

    box = self.world:add(box,box.l,box.t,box.w,box.h)

    table.insert(boxes,box)
  end
end

function map:drawLevel()
  for box in pairs(boxes) do
    g.setColor(255,0,0,70)
    g.rectangle("fill", box.l, box.t, box.w, box.h)
  end
end

function map:reset()
    print('nothing')
end

function map:update(dt)
  player:update(dt)
end

return map