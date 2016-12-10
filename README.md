# Twn
Monkeypatch for the tweening library known as flux created by rxi for love2d.

Twn adds \_\_call-metamethods to the flux-module and to the objects it creates.

Twn will not alter the existing functionality of the flux-module.

# Usage
Previously used
```lua
flux.to(object, time, changes)
```
Can now be alternatively accomplished
```lua
flux.to(object, time, changes)
```
Easing can be set as an optional argument
```lua
flux.to(object, time, easing, changes)
```

Tweens can be chained effortlessly by adding more arguments.
```lua
flux.to(object1, time1, ease1, changes1, object2, time2, ease2, changes2) --... and so on
```

Only the first object argument is mandatory. Following tweens will assume the that same object is used.
If the easing-argument is left out "linear" will be used. This is an inconsistency with the flux.to-function that defaults to "quadout".
```lua
--start with "linear" end with "quadout"
flux.to(object, time1, changes1, object2, time2, "quadout", changes2) --... and so on
```
