Rect = {}
Rect.__index = Rect

function Rect.new(x, y, width, height)
  local obj = {
    x = x,
    y = y,
    width = width,
    height = height,
  }
  setmetatable(obj, Rect)
  return obj
end

function Rect:draw(mode, borderRadius)
  mode = mode or "fill"
  borderRadius = borderRadius or 0
  love.graphics.rectangle(mode, self.x, self.y, self.width, self.height, borderRadius, borderRadius)
end

function Rect:contains(x, y)
  return x > self.x and y > self.y and x < self.x + self.width and y < self.y + self.height
end

function Rect:intersects(r)
  return self:contains(r.x, r.y) or
    self:contains(r.x + r.width, r.y) or
    self:contains(r.x, r.y + r.height) or
    self:contains(r.x + r.width, r.y + r.height)
end