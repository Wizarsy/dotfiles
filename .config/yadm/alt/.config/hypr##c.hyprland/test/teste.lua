-- local x = "ola"

-- local patterns = { "Minecraft Launcher", "Extension:.*" }
--   for _, v in ipairs(patterns) do
--     local result = string.find(x, v)
--     if  result ~= nil then
--       print(x)
--       break
--     end
--   end

-- if string.match("FPS: 0.00 | Vulkan | 0.0.42-19689 | Demon's Souls [BLUS30443]", "%[%w+%]") then
--   print("match")
-- end


-- local f = io.popen("lspci -kd ::03xx", "r")

-- if f ~= nil then
--   local m = string.match(f:read("a"), "Kernel driver in use: (%w+)")
--   print(m)
-- end

-- local x = "xe"

-- if x == "xe" or x == "i915" or x == "nouveau" or x == "dxgkrnl" or x == "amdgpu" then
--   print(x)
-- end

-- if io.open("/usr/lib/libGL.so", "r") then
--   print("ok")
-- end
-- local uid = io.popen("id -u " .. os.getenv("USER"), "r")
-- if uid then
--   local xdg_runtime_dir = (os.getenv("XDG_RUNTIME_DIR") or ("/run/user/" .. uid:read("l")))
--   local ssh_sock = io.popen("command find " .. xdg_runtime_dir .. " -maxdepth 1 -name 'ssh-agent.*' -print0 -quit")
--   if ssh_sock then
--     print(ssh_sock:read("l"))
--   end
-- end

-- local display_controller = io.popen("lspci -kd ::03xx", "r")
-- if display_controller then
--   local driver = string.match(display_controller:read("a"), "Kernel driver in use: (%w+)")
--   display_controller:close()
--   if driver == "nvidia" then
--     print(driver)
--   elseif driver == "xe" or driver == "i915" or driver == "nouveau" or driver == "dxgkrnl" or driver == "amdgpu" then
--     print(driver)
--     if driver == "i915" or driver == "xe" then
--       print(driver)
--       if io.open("/usr/lib/dri/iHD_drv_video.so", "r") then
--         print(driver)
--       else
--         print(driver)
--       end
--     elseif driver == "dxgkrnl" then
--       print(driver)
--     elseif driver == "amdgpu" then
--       print(driver)
--     end
--   end
-- end


-- local t = {"a", "b", "c"}
-- print(#t)

-- table.insert(t, "1")

-- print(#t)

-- print(#t)
