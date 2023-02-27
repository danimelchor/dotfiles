-- use hs.screen.allScreens() to get a list of all screens
ev = hs.eventtap.new({hs.eventtap.event.types.mouseMoved}, function(e)
    local screens = hs.screen.allScreens()
    local nearTop = false
    for _, screen in ipairs(screens) do
        local sf = screen:fullFrame()
        local loc = e:location()
        local offset = 6
        if loc.y < sf.y + offset and loc.y > sf.y - offset then
            nearTop = true
            break
        end
    end
    return nearTop
end):start()
