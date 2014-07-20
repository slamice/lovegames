-- Player class
-- A simple Player object for use in the Platformer game.
 
Player = {}
states = {'fall','run','stand'}

-- Constructor
function Player:new()
    -- define our parameters here
    local object = {
        img = { hero = g.newImage("hero.png")},
        x = 100,
        y = 100,
--        xSpeed = 0,
--        ySpeed = 0,
--        state = "",
--        jumpSpeed = 0,
        speed = 400,
--        canJump = false
--        onground = false
        color = {255,255,255},

    }
    setmetatable(object, { __index = Player })
    return object
end
 
-- Movement functions
function Player:jump()
    if self.canJump then
        self.ySpeed = self.jumpSpeed
        self.canJump = false
    end
end
 
function Player:moveRight(dt)
    player.x = player.x - player.speed * dt
end
 
function Player:moveLeft(dt)
    player.x = player.x + player.speed * dt
end

function Player:hitFloor(maxY)
    self.y = maxY - self.height
    self.ySpeed = 0
    self.canJump = true
end
 
-- Update function
function Player:update(dt, gravity)
    -- update the player's position
    self.x = self.x + (self.xSpeed * dt)
    self.y = self.y + (self.ySpeed * dt)
    
    -- apply gravity
    self.ySpeed = self.ySpeed + (gravity * dt)
 
    -- update the player's state
    if not(self.canJump) then
        if self.ySpeed < 0 then
            self.state = "jump"
        elseif self.ySpeed > 0 then
            self.state = "fall"
        end
    else
        if self.xSpeed > 0 then
            self.state = "moveRight"
        elseif self.xSpeed < 0 then
            self.state = "moveLeft"
        else
            self.state = "stand"
        end
    end    
end