HC = require '/lib/HardonCollider'

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
    require "Player"
    require "/lib/helpers"

    -- initialize library
    collider = HC(100, on_collision, collision_stop)

    path = "/path/here"
    g = love.graphics
    f = love.filesystem
    playerColor = {255,0,128}
    groundColor = {25,200,25}
    
    -- instantiate our player and set initial values
    p = Player:new()

    -- Get helper functions
    h = Helpers

    p.x = 575
    p.y = 300
    p.width = 25
    p.height = 40
    p.jumpSpeed = -800
    p.runSpeed = 500
    
    gravity = 1800
    
    yFloor = 500
end
 
-- Update stuff
function love.update(dt)
    if love.keyboard.isDown("right") then
        p:moveRight()
    end
    if love.keyboard.isDown("left") then
        p:moveLeft()
    end
    
    -- if the x key is pressed...
    if love.keyboard.isDown("x") then
    -- make the player jump
        p:jump()
    end
 
    -- update the player's position
    p:update(dt, gravity)
 
    while #text > 40 do
        table.remove(text, 1)
    end

    -- stop the player when they hit the borders
    if p.x > 800 - p.width then p.x = 800 - p.width end
    if p.x < 0 then p.x = 0 end
    if p.y < 0 then p.y = 0 end
    if p.y > yFloor - p.height then
        p:hitFloor(yFloor)
    end
end

-- Draw
function love.draw()
    -- round down our x, y values
    local x = math.floor(p.x)
    local y = math.floor(p.y)

    g.setColor(playerColor)
    rect = collider:addRectangle(x, y, p.width, p.height)
    rect:draw('fill')


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

            -- print messages
    for i = 1,#text do
        g.setColor({25,89,90})
        g.setColor(255,255,255, 255 - (i-1) * 6)
        g.print(text[#text - (i-1)], 10, i * 15)
    end

    -- debug information
    g.setColor(255, 255, 255)

    local isTrue = ""
    g.print("Player coordinates: ("..x..","..y..")", 5, 5)
    g.print("Current state: "..p.state, 5, 20)

end
 
function love.keyreleased(key)
    if key == "escape" then
        love.event.push("q")   -- actually causes the app to quit
    end
    if (key == "right") or (key == "left") then
        p:stop()
    end
end