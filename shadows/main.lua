require "Player"
require "/lib/helpers"
HC = require '/lib/HardonCollider'
g = love.graphics
f = love.filesystem
path = "/Users/slamice/Documents/development/Lua/lovegames/shadows/"
assets_path = ''

rects = {}

-- array to hold collision messages
local text = ''

-- this is called when two shapes collide
function on_collide(dt, shape_a, shape_b)
    text = string.format("Colliding")
end


-- Initial Load function
function love.load()
    h = Helpers
    Collider = HC(100, on_collide)
    player = Player:new()

    g.setBackgroundColor(255,255,255)

    local lines = lines_from(path.."level1.txt")

   -- print all line numbers and their contents
  for i in pairs(lines) do
    
      block = h:split(lines[i],',')

      -- draw the ground
      posx = tonumber(block[1])
      posy = tonumber(block[2])
      groundx = tonumber(block[3])
      groundy = tonumber(block[4])

     rect = Collider:addRectangle(posx,posy,groundx,groundy)

     table.insert(rects,rect)
  end

end
 
function love.update(dt)
  --[[ HERO ]]
  -- Move Hero
  if love.keyboard.isDown("left") then
    player:moveRight(dt)
  elseif love.keyboard.isDown("right") then
    player:moveLeft(dt)
  end

  --[[ COLLISIONS ]]
  -- check for collisions
  Collider:update(dt)
end

function love.draw(dt)

  -- Player
  g.draw(player.img.hero, player.x, player.y)
  g.print("Player coordinates: x:"..player.x..", y:"..player.y, 5, 25)
  
  for k, v in pairs(rects) do
     v:draw('fill')
     g.setColor(0,0,0)
  end


  --if text ~= '' then print(text) end

end

--[[function love.keypressed(key, unicode)
   if key == "right" then
      player.x = player.x + 10
   elseif key == "left" then
      player.x = player.x - 10
   end
end

function love.keyreleased(key, unicode)
   if key == "down" then
      player.y = player.y + 10
   elseif key == "right" then
      player.x = player.x + 10
   elseif key == "left" then
      player.x = player.x - 10
   end
end]]