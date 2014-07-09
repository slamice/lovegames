function love.load()
    path = "/Users/default/Documents/dev/lovegames/shadows/"
    g = love.graphics
    f = love.filesystem
    playerColor = {255,0,128}
    groundColor = {25,200,25}
    
    -- instantiate our player and set initial values
    require "Player"
    p = Player:new()

    -- Get helper functions
    require "Helpers"
    h = Helpers
    
    p.x = 300
    p.y = 300
    p.width = 25
    p.height = 40
    p.jumpSpeed = -800
    p.runSpeed = 500
    
    gravity = 1800
    
    yFloor = 500
end
 
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
 
    -- stop the player when they hit the borders
    if p.x > 800 - p.width then p.x = 800 - p.width end
    if p.x < 0 then p.x = 0 end
    if p.y < 0 then p.y = 0 end
    if p.y > yFloor - p.height then
        p:hitFloor(yFloor)
    end
end
 
function love.draw()
    -- round down our x, y values
    local x = math.floor(p.x)
    local y = math.floor(p.y)
    
    -- draw the player shape
    g.setColor(playerColor)
    g.rectangle("fill", x, y, p.width, p.height)



--[[    love.filesystem:open(file)
    g.print("array: "..file:read(), 5, 40)

    if file then
]]       


    local lines = lines_from(path.."level1.txt")

    -- print all line numbers and their contents
    for k,v in pairs(lines) do
      
        block = h:split(v,',')

        -- draw the ground
        groundx = block[1]
        groundy = block[2]

        print(groundy)
        g.setColor(groundColor)
        g.rectangle("fill", 200, yFloor, groundx, groundy)
        g.print("Floor coordinates: x:"..groundx..", y:"..groundy, 5, 35)
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