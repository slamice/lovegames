require "Player"
require "/lib/helpers"
HC = require '/lib/HardonCollider'
g = love.graphics
f = love.filesystem
path = "/Users/slamice/Documents/development/Lua/lovegames/shadows/"
assets_path = ''

-- array to hold collision messages
local text = {}

-- this is called when two shapes collide
function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
    text[#text+1] = string.format("Colliding. mtv = (%s,%s)", 
                                    mtv_x, mtv_y)
end

-- this is called when two shapes stop colliding
function collision_stop(dt, shape_a, shape_b)
    text[#text+1] = "Stopped colliding"
end

-- Initial Load function
function love.load()
    h = Helpers
    Collider = HC(100, on_collision, collision_stop)

    img = { hero = g.newImage("hero.png")}
    pos = { 100 ,100 } -- these are the (random at game start) x/y coordinates of the unit
    speed = 200
    moveDir = { 0, 0 } -- movement direction: {-1,-1} would be 100% left and 100% up, {0,1} would be 100% right. We will add ways to change moveDir later.
    g.setBackgroundColor(255,255,255)

    local lines = lines_from(path.."level1.txt")


    circle = Collider:addCircle(pos[1],pos[2],20)

end
 
function love.update(dt)
  pos = {pos[1] + (moveDir[1] * speed * dt), 
         pos[2] + (moveDir[2] * speed * dt)}

  -- check for collisions
  -- Collider:update(dt)

end

function love.draw(dt)

  -- Player
  g.draw(img.hero, pos[1], pos[2])
  g.print("Player coordinates: x:"..pos[1]..", y:"..pos[2], 5, 25)
  
   -- print all line numbers and their contents
  for i in pairs(lines) do
    
      block = h:split(lines[i],',')

      -- draw the ground
      posx = block[1]
      posy = block[2]
      groundx = block[3]
      groundy = block[4]

      -- shapes can be drawn to the screen
      -- rect = g.rectangle("fill",posx,posy,groundx,groundy)
     rect = Collider:addRectangle(100,100,100,100)
     rect:draw('fill')
     g.setColor(0,0,0)
  end

   g.print(text)
end

function love.keypressed(key, unicode)
   if key == "up" then
      moveDir[2] = -5
   elseif key == "down" then
      moveDir[2] = 5
   elseif key == "right" then
      moveDir[1] = 5
   elseif key == "left" then
      moveDir[1] = -5
   end
end

function love.keyreleased(key, unicode)
   if key == "up" then
      moveDir[2] = 0
   elseif key == "down" then
      moveDir[2] = 0
   elseif key == "right" then
      moveDir[1] = 0
   elseif key == "left" then
      moveDir[1] = 0
   end
end