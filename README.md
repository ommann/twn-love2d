# Twn
Monkeypatch for the tweening library known as [flux](https://github.com/rxi/flux) created by rxi for love2d.

Twn adds \_\_call-metamethods to the flux-module and to the objects it creates.

Twn will not alter the existing functionality of the flux-module.

# Usage
Twn assumes that flux is required to a variable "flux".
```lua
flux = require 'flux'
       require 'twn'
```
Previously used.
```lua
flux.to(object, time, changes)
```
Can now be alternatively accomplished.
```lua
flux(object, time, changes)
```
Easing can be set as an optional argument.
```lua
flux(object, time, easing, changes)
```
Tweens can be chained effortlessly by adding more arguments.
```lua
flux(object1, time1, ease1, changes1, object2, time2, ease2, changes2) --... and so on
```
Only the first object argument is mandatory. Following tweens will assume the that same object is used.
If the easing-argument is left out "linear" will be used. This is an *inconsistency* with the flux.to-function that defaults to "quadout".
```lua
--start with "linear" end with "quadout"
flux(object, time1, changes1, time2, "quadout", changes2) --... and so on
```

To help sequence tweens Twn provides set-method that can be used to store the returned object to global scope or to a provided table.
```lua
--endless chain of tweens can also include assignments
flux(object1, time1, changes1):set("global_variable")(time2, changes2):set("field", table)

global_variable(time3, changes3, "quadout")
table.field(object2, time4, changes4)
```

# Example
```lua
flux = require 'flux'
       require 'twn'

love.load = function()
  circle = {x = 100, y = 100, r = 10}

  flux(circle, 1,               {x = 200, y = 200}):set("step_one")(
               1, "elasticout", {y = 300},
               1, "quadout",    {x = 300})

  step_one(4, "elasticinout", {r = 100})
end

love.update = function(dt)
  flux.update(dt)
end

love.draw = function()
  love.graphics.circle("fill", circle.x, circle.y, circle.r)
end
```
