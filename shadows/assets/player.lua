--[[ Player ]]

hero_path = '/'

local width         = 50
local height        = 50
local img           = g.newImage(hero_path.."hero.png")
local speed         = 200

function Player:initialize(map, world, x,y)
  self.x = x
  self.y = y
  self.speed = speed
  self.world:add(self,x,y)
  self.map = map
  self.color = {0,0,0}
end

function Player:moveRight()
  self.x = self.x - self.speed * dt
end

function Player:moveLeft()
  player.x = player.x - player.speed * dt
end

function Player:moveLeft()
  player.x = player.x - player.speed * dt
end

function Player:draw()
  print('nothing')
end

return Player