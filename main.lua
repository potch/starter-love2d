require "rect"

local img = love.graphics.newImage("cosmos.png")
img:setWrap("repeat", "repeat")
local width, height = love.graphics.getDimensions()
local quad = love.graphics.newQuad(0, 0, width, height, img:getWidth(), img:getHeight())

local r = Rect.new(100, 100, 200, 200)

function love.draw()
  love.graphics.setColor({1, 1, 1, 1})
  love.graphics.draw(img, quad, 0, 0, 0, 1, 1)	

  local x, y = love.mouse.getPosition()
  local dude = Rect.new(x - 20, y - 20, 40, 40)

  love.graphics.setColor({0, 1, 0, 1})
  if r:intersects(dude) then
    r:draw("fill")
  else
    r:draw("line")
  end

  love.graphics.setColor({1, 0, 0, 1})
  dude:draw("fill")
end