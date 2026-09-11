-- HDMI-A-2 on the Left (0x0)
hl.monitor({ output = "HDMI-A-2", mode = "1920x1080@144.0", position = "0x0", scale = 1 })

-- HDMI-A-1 on the Right (1920x0)
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@144.0", position = "1920x0", scale = 1 })

-- Read dock state and configure eDP-1 dynamically
local f = io.open("/tmp/hypr_docked", "r")
if f then
    f:close()
    -- Docked: Disable internal screen
    hl.monitor({
        output = "eDP-1",
        disabled = true
    })
else
    -- Undocked / Switched away: Enable internal screen
    hl.monitor({
        output = "eDP-1",
        mode = "1920x1200@60.0",
        position = "3840x0",
        scale = 1.5
    })
end
