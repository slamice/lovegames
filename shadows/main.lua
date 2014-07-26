local map      = require 'lib.map'
local g        = love.graphics


width = 800
height = 600

-- [[ Load ]]
function love.load()
  g.setBackgroundColor(255,255,255)
	map:new(width, height)
end

-- [[ Update ]]
function love.update(dt)
  map:update(dt)
end

-- [[ Draw ]]
function love.draw()
  map:draw()
end