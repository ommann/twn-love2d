--flux = require 'path.to.flux'

local function skip(t, n)
  for i = 1,n do
    table.remove(t, 1)
  end

  return t
end

--foo = tween(...) or tween(...):set("foo")
function set(self, name, object)
  local scope = object or _G

  scope[name] = self

  return self
end

flux._twnr = function(self, ...)
  local args = {...}

  local tween = nil

  local mode = nil
  if type(args[1]) == "table" and self.obj == nil then mode = "root" end
  if type(args[1]) == "table" and self.obj ~= nil then mode = "branch" end
  if type(args[1]) ~= "table"                     then mode = "leaf" end

  local index, first = nil, 2
  if mode == "leaf" then first = 1 end

  local obj, time, vars, ease = nil, nil, nil, nil
  if mode ~= "leaf" then obj = args[1] end

  for i = first,#args do
    index = i

    if type(args[i]) == "number" and time     then error("unexpected second time argument", 2) end
    if type(args[i]) == "string" and ease     then error("unexpected second easing argument", 2) end
    if type(args[i]) == "table"  and not time then error("expected time argument before table argument", 2) end

    if type(args[i]) == "number" then time = args[i] end
    if type(args[i]) == "string" then ease = args[i] end
    if type(args[i]) == "table"  then vars = args[i] end

    if mode == "root" and time and vars then
      tween = flux.to(obj, time, vars):ease(ease or "linear")

      break
    end

    if mode == "branch" and time and vars then
      tween = self:after(obj, time, vars):ease(ease or "linear")

      break
    end

    if mode == "leaf" and time and vars then
      tween = self:after(time, vars):ease(ease or "linear")

      break
    end

    if mode == "root" and time and ease == "wait" then
      tween = flux.to(obj, time, {})

      break
    end

    if mode == "branch" and time and ease == "wait" then
      tween = self:after(obj, time, {})

      break
    end

    if mode == "leaf" and time and ease == "wait" then
      tween = self:after(time, {})

      break
    end
  end

  if tween == nil                   then error("wrong number of arguments", 2) end
  if type(args[index+1]) == "table" then error("unexpected second object argument", 2) end

  if index < #args then
    return flux._twnr( tween, unpack( skip(args, index) ) )
  else
    getmetatable(tween).__call = flux._twnr
    tween.set = set

    return tween
  end
end

getmetatable(flux).__call = flux._twnr
--return flux
