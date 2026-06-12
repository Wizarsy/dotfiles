local x = "ola"

local patterns = { "Minecraft Launcher", "Extension:.*" }
  for _, v in ipairs(patterns) do
    local result = string.find(x, v)
    if  result ~= nil then
      print(x)
      break
    end
  end