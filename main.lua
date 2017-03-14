
function love.load()
  player = {}
  player.x = 0
  player.y = 550
  player.bullets = {}
  player.cooldown = 0
  player.speed = 6
  function player.fire()
    if player.cooldown <= 0 then      
      player.cooldown = 20
      bullet = {}
      bullet.x = player.x + 35
      bullet.y = player.y
      table.insert(player.bullets, bullet)
    end
  end
  enemies_controller:spawnEnemy(100, 0)
  enemies_controller:spawnEnemy(0, 0)
end

enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
function enemies_controller:spawnEnemy(x, y)
  enemy = {}
  enemy.x = x
  enemy.y = y
  enemy.bullets = {}
  enemy.cooldown = 0
  enemy.speed = 6
  table.insert(self.enemies, enemy)
end


  --the colon is the same as enemy.fire(self) calls itself when firing
  function enemy:fire()
    if self.cooldown <= 0 then      
      self.cooldown = 20
      bullet = {}
      bullet.x = player.x + 35
      bullet.y = player.y
      table.insert(self.bullets, bullet)
    end
  end
function love.update(dt)
  player.cooldown = player.cooldown - 1
  
  if love.keyboard.isDown("right") then
    player.x = player.x + player.speed
  elseif love.keyboard.isDown("left") then
    player.x = player.x - player.speed
  end
  
  if love.keyboard.isDown("space") then
    player.fire()
  end
  
  for i,b in ipairs(player.bullets) do
    if b.y < -10 then
      table.remove(player.bullets, i)
    end  
    b.y = b.y - 10
  end
  
  for _,e in pairs (enemies_controller.enemies) do
    e.y = e.y + 1
  end
  
end

function love.draw()
  --draw the player
  love.graphics.setColor(0, 0, 255)
  love.graphics.rectangle("fill", player.x, player.y, 80, 20)
  
  --draw enemy
  love.graphics.setColor(255, 0 , 0)
  for _,e in pairs(enemies_controller.enemies) do
    love.graphics.rectangle("fill", e.x, e.y, 80, 20)
  end
  
  --draw the bullets
  love.graphics.setColor(255, 255, 255)
  for _,b in pairs(player.bullets) do
    love.graphics.rectangle("fill", b.x, b.y, 10, 10)
  end
end