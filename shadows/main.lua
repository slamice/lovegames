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

function love.load()
    -- initialize library
    Collider = HC(100, on_collision, collision_stop)

    -- add a rectangle to the scene
    rect = Collider:addRectangle(200,400,400,20)

    -- add a circle to the scene
    mouse = Collider:addCircle(400,300,20)
    mouse:moveTo(love.mouse.getPosition())
end

function love.update(dt)
    -- move circle to mouse position
    mouse:moveTo(love.mouse.getPosition())

    -- rotate rectangle
    rect:rotate(dt)

    -- check for collisions
    Collider:update(dt)

    while #text > 40 do
        table.remove(text, 1)
    end
end

function love.draw()
    -- print messages
    for i = 1,#text do
        love.graphics.setColor(255,255,255, 255 - (i-1) * 6)
        love.graphics.print(text[#text - (i-1)], 10, i * 15)
    end

    -- shapes can be drawn to the screen
    love.graphics.setColor(255,255,255)
    rect:draw('fill')
    mouse:draw('fill')
end