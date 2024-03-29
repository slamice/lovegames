--[[ Player ]]

local g      = love.graphics
local player = {}
local world  = {}

function player:initialize(newWorld, l,t,w,h)
  self.l = l
  self.t = t
  self.w = w
  self.h = h
  self.img = g.newImage("/assets/hero.png")
  world = newWorld 
  world:add(self,l,t,w,h)
  self.onGround = false
  self.speed = 200
  self.gravity = 1
  self.canJump = true
  self.fall_velocity = 100
  --self.map = map
  self.color = {0,0,0}
end

function player:update(dt)
  local dx, dy = 0, 0
  
  if love.keyboard.isDown('right') then
    dx = self.speed * dt
  elseif love.keyboard.isDown('left') then
    dx = -self.speed * dt
  end
  if love.keyboard.isDown('up') and self.onGround == true then
    dy = dy - self.speed * dt * 12
  end

  cols, len = world:check(player)

  if len == 0 then
    self.onGround = false
  end

--[[  if love.keyboard.isDown('down') then
    dy = self.speed * dt
]]

  dy = dy + (self.gravity * self.fall_velocity * dt)

  if dx ~= 0 or dy ~= 0 then
    local future_l, future_t = player.l + dx, player.t + dy
    local cols, len = world:check(player, future_l, future_t)
    if len == 0 then
      player.l, player.t = future_l, future_t
      world:move(player, future_l, future_t)
    else
      local col, tl, tt, sl, st
      while len > 0 do
        self.onGround = true
        col = cols[1]
        tl,tt,_,_,sl,st = col:getSlide()
        player.l, player.t = tl, tt
        world:move(player, tl, tt)
        cols, len = world:check(player, sl, st)
        if len == 0 then
          player.l, player.t = sl, st
          world:move(player, sl, st)
        end
      end
    end
  end
end

-- Return the number of collisions
function player:getCols()
  local collisions, len = world:check(B)
  assert(len == 0)
end

function player:draw()
  --self.world:draw(self.img, player.l, player.t)
  g.draw(player.img, player.l, player.t)
end

return player