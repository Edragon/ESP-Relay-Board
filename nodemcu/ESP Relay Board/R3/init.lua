files = file.list()

if files["main.lc"] then
    dofile("main.lc")
else
    dofile("main.lua")
end
