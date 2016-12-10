flux = require 'flux'
       require 'twn'

love.load = function()
  circle = {x = 100, y = 100, r = 10}

  flux(circle, 1,               {x = 200, y = 200}):set("first")(
               1, "elasticout", {y = 300},
               1, "quadout",    {x = 300})

  first(4, "elasticinout", {r = 100})
end

love.update = function(dt)
  flux.update(dt)
end

love.draw = function()
  love.graphics.circle("fill", circle.x, circle.y, circle.r)
end
