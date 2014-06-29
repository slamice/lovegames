function love.load()
 hero = {} -- new table for the hero
 hero.x = 300    -- x,y coordinates of the hero
 hero.y = 450
 hero.speed = 200
 acc = 9.8
 time = 0
 fps = 20
end

function love.update(dt)
 if love.keyboard.isDown("left") then
   hero.x = hero.x - hero.speed*dt
 elseif love.keyboard.isDown("right") then
   hero.x = hero.x + hero.speed*dt		
 end

 if hero.y >= 460 then
   hero.y = 460
	 acc = 0
 else
  time = time + 1 / fps;
  hero.y = math.pow(time, 2) * acc
 end

 if hero.x > 800 then
	 hero.x= 800 - hero.w
 end
end

function love.draw()
	-- let's draw some ground
 love.graphics.setColor(0,255,0,255)
 love.graphics.rectangle("fill", 0, 465, 800, 150)

 -- let's draw our hero
 love.graphics.setColor(255,255,0,255)
 love.graphics.rectangle("fill", hero.x,hero.y, 30, 15)
end