require "Player"
require "/lib/helpers"
HC = require '/lib/HardonCollider'
g = love.graphics
f = love.filesystem
path = "/Users/default/Documents/dev/lovegames/shadows/"
assets_path = ''

-- array to hold collision messages
local text = {}

-- this is called when two shapes collide
function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
    text = string.format("Colliding. mtv = (%s,%s)", mtv_x, mtv_y)
end

-- this is called when two shapes stop colliding
function collision_stop(dt, shape_a, shape_b)
    text = ""
end

-- Initial Load function
function love.load()
    h = Helpers
    Collider = HC(100, on_collision, collision_stop)
    player = Player:new()

    g.setBackgroundColor(255,255,255)

    local lines = lines_from(path.."level1.txt")


    circle = Collider:addCircle(player.x,player.y,20)

end
 
function love.update(dt)
  --[[ HERO ]]
  -- Move Hero
  pos = {player.x + (player.moveDir[1] * player.speed * dt), 
         player.y + (player.moveDir[2] * player.speed * dt)}


  --[[ COLLISIONS ]]
  -- check for collisions
  --Collider:update(dt)
end

function love.draw(dt)

  -- Player
  g.draw(player.img.hero, player.x, player.y)
  g.print("Player coordinates: x:"..player.x..", y:"..player.y, 5, 25)
  
   -- print all line numbers and their contents
  for i in pairs(lines) do
    
      block = h:split(lines[i],',')

      -- draw the ground
      posx = tonumber(block[1])
      posy = tonumber(block[2])
      groundx = tonumber(block[3])
      groundy = tonumber(block[4])

     rect = Collider:addRectangle(posx,posy,groundx,groundy)
     rect:draw('fill')
     g.setColor(0,0,0)
  end

end

function love.keypressed(key, unicode)
   if key == "up" then
      player.moveDir[2] = -5
   elseif key == "down" then
      player.moveDir[2] = 5
   elseif key == "right" then
      player.moveDir[1] = 5
   elseif key == "left" then
      player.moveDir[1] = -5
   end
end

function love.keyreleased(key, unicode)
   if key == "up" then
      player.moveDir[2] = 0
   elseif key == "down" then
      player.moveDir[2] = 0
   elseif key == "right" then
      player.moveDir[1] = 0
   elseif key == "left" then
      player.moveDir[1] = 0
   end
end