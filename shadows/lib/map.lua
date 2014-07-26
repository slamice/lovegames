--[[
-- Map class
-- Maps and draws a level with obstacles and the player.
-- Map:reset() restarts the map. It can be done when the player dies, or manually.
--]]

-- libs
local helper   = require 'lib.helpers'
local window   = require 'love.window'
local player   = require 'assets.player'
local bump     = require 'lib.bump'

-- LEVELS PATH
local path     = '/Users/slamice/Documents/development/lua/lovegames/shadows/assets/levels/'

-- Variables
local map      = {}
local blocks   = {}
local world    = {}
local g        = love.graphics

function map:new(w, h)
  self.width = w
  self.height = h
  world = bump.newWorld()
  self.player = player:initialize(world, 0, 0, 50, 50)
  map:loadLevel()
--  window.setMode(width, height, {resizable=true, vsync=false, minwidth=400, minheight=300})
end

function map:draw()
  player:draw()
  for _,block in ipairs(blocks) do
    g.setColor(0,0,0)
    g.rectangle("fill", block.l, block.t, block.w, block.h)
  end
end

local function addBlock(l,t,w,h)
  local block = {l=l,t=t,w=w,h=h}
  blocks[#blocks+1] = block
  world:add(block, l,t,w,h)
end

function map:loadLevel()

  p = path.."level1.txt"
  for i in pairs(lines_from(p)) do

    line = split(lines[i],',')

    -- Read block coordinates ffrom file 
    addBlock(tonumber(line[1]), tonumber(line[2]),    
             tonumber(line[3]), tonumber(line[4]))
  end
  --helper.print_r(boxes)
end

function map:reset()
    print('nothing')
end

function map:update(dt)
  player:update(dt)
end

return map