--[[
-- Map class
-- Maps and draws a level with obstacles and the player.
-- Map:reset() restarts the map. It can be done when the player dies, or manually.
--]]
local window   = require 'love.window'
local player   = require 'player.lua'
local bump     = require 'lib.bump'

function Map:new(width, height)
  self.width = width
  self.height = height
  self.world = bump.newWorld()
--  window.setMode(width, height, {resizable=true, vsync=false, minwidth=400, minheight=300})
end

function Map:draw(l,t,w,h)
    print('nothing')
end

function Map:reset()
    print('nothing')
end