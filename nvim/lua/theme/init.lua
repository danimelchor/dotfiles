local components = {
    "dashboard"
}

for _,v in pairs(components) do
    require("theme." .. v)
end
