require "Player"
require "/lib/helpers"
g = love.graphics
f = love.filesystem
path = "/Users/slamice/Documents/development/Lua/lovegames/shadows/"
assets_path = ''

-- Initial Load function
function love.load()
    img = { hero = love.graphics.newImage("hero.png")}
    pos = { 100 ,100 } -- these are the (random at game start) x/y coordinates of the unit
    speed = 200
    moveDir = { 0, 0 } -- movement direction: {-1,-1} would be 100% left and 100% up, {0,1} would be 100% right. We will add ways to change moveDir later.
    love.graphics.setBackgroundColor(255,255,255)
end
 
function love.update(dt)

   pos = {pos[1] + (moveDir[1] * speed * dt), pos[2] + (moveDir[2] * speed * dt)}
end

function love.draw(dt)
--[[
    local lines = lines_from(path.."level1.txt")

    -- print all line numbers and their contents
    for k,v in pairs(lines) do
      
        block = h:split(v,',')

        -- draw the ground
        posx = block[1]
        posy = block[2]
        groundx = block[3]
        groundy = block[4]

        -- shapes can be drawn to the screen
        g.setColor(groundColor)
        rect = collider:addRectangle(200,400,groundx,groundy)
        rect:draw('fill')
       -- g.rectangle(posx, posy, groundx, groundy)
        g.print("Floor coordinates: x:"..groundx..", y:"..groundy, 5, 35)
    end
]]

   love.graphics.draw(img.hero, pos[1], pos[2])
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