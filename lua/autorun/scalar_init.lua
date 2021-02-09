if SERVER then
    for _, f in pairs(file.Find("scalar/*", "LUA")) do
        AddCSLuaFile("scalar/" .. f)
    end
else
    Scalar = Scalar or {Data = {}}
    for _, f in pairs(file.Find("scalar/*", "LUA")) do
        include("scalar/" .. f)
    end
end
