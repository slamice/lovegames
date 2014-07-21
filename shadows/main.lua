require "/lib/helpers"
HC = require '/lib/HardonCollider'
g = love.graphics
path = "/Users/slamice/Documents/development/Lua/lovegames/shadows/"
assets_path = ''

rects = {}

-- array to hold collision messages
local text = ''

-- this is called when two shapes collide
function on_collide(dt, shape_a, shape_b)
    print("hitting")
end


-- Initial Load function
function love.load()
  h = Helpers
  Collider = HC(100, on_collide)
  player = {
    img = g.newImage("hero.png"),
    x = 100,
    y = 100,
--    xSpeed = 0,
--    ySpeed = 0,
--    state = "",
--    jumpSpeed = 0,
    speed = 400,
--    canJump = false
--    onground = false
    color = {255,255,255},
    coll = Collider:addCircle(100,100,50,50)
  }

  g.setBackgroundColor(255,255,255)

   -- print all line numbers and their contents
  for i in pairs(lines_from(path.."level1.txt")) do
    
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
    player.x = player.x - player.speed * dt
    player.coll:moveTo(player.x,player.y)

  elseif love.keyboard.isDown("right") then
    player.x = player.x + player.speed * dt
    player.coll:moveTo(player.x,player.y)

  elseif love.keyboard.isDown("down") then
    player.y = player.y + player.speed * dt
    player.coll:moveTo(player.x,player.y)

  end

  --[[ COLLISIONS ]]
  -- check for collisions
  Collider:update(dt)
end

function love.draw(dt)

  -- Player
  g.draw(player.img, player.x, player.y)

--  g.draw(coll.circle, coll.x, coll.y)
  --player.coll:draw('fill')
  g.print("Player coordinates: x:"..player.x..", y:"..player.y, 5, 25)
  
  for k, v in pairs(rects) do
     v:draw('fill')
     g.setColor(0,0,0)
  end

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