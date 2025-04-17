
local x, y
function love.draw()
  x, y = love.mouse.getPosition()
  love.graphics.setColor({1, 0, 0, 1})
  love.graphics.rectangle("fill", x - 8, y - 8, 16, 16)
end