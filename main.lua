require "rect"

local img = love.graphics.newImage("cosmos.png")
img:setWrap("repeat", "repeat")
local width, height = love.graphics.getDimensions()
local quad = love.graphics.newQuad(0, 0, width, height, img:getWidth(), img:getHeight())
local screen = Rect.new(0, 0, width - 40, height - 40)


local spaceship = love.graphics.newImage("spaceship.png")
local ufo = love.graphics.newImage("target.png")

local dude = Rect.new(0,0, 64, 64)
local score = 0

local targets = {}

for i = 1, 10, 1 do
  table.insert(targets, {
    rect = Rect.new(math.random(0, width - 40), math.random(0, height - 40), 40, 40),
    dirX = math.random(-1, 1),
    dirY = math.random(-1, 1),
  })
end

function love.draw()
  love.graphics.setColor({1, 1, 1, 1})
  love.graphics.draw(img, quad, 0, 0, 0, 1, 1)	

  local x, y = love.mouse.getPosition()
  dude.x = x - 32
  dude.y = y - 32

  love.graphics.setColor({0, 1, 0, 1})
  for _, target in pairs(targets) do
    -- move by x and y amount in given direction
    -- check for edge
    -- change direction if at edge
    local newX = target.rect.x + target.dirX
    local newY = target.rect.y + target.dirY

    if screen:contains(newX, newY) then
      target.rect.x = newX
      target.rect.y = newY
    else
      if newX >= screen.width or newX <= 0 then
        target.dirX = -target.dirX
      end

      if newY >= screen.height or newY <= 0 then
        target.dirY = -target.dirY
      end
    end
    
    if target.rect:intersects(dude) then
      target.rect:draw("fill")
      love.graphics.draw(ufo, target.rect.x, target.rect.y)
    else
      love.graphics.draw(ufo, target.rect.x, target.rect.y)
      target.rect:draw("line")
    end
  end

  love.graphics.setColor({1, 1, 1, 1})
  love.graphics.draw(spaceship, dude.x, dude.y)

  love.graphics.setColor({1, 1, 1, 1})
  love.graphics.print("Score: "..score, 10, 10)
end

function love.mousepressed(x, y)
  local miss = true
  for index, target in pairs(targets) do
    if target.rect:intersects(dude) then
      target.rect.x = math.random(0, width - target.rect.width);
      target.rect.y = math.random(0, height - target.rect.height);

      score = score + 100
      miss = false
      
      table.remove(targets, index)
    end
  end

  if miss == true then
    score = score - 100
  end
end