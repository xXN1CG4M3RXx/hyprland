-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/

-- HDMI-A-2 on the Left (0x0)
hl.monitor({
    output = "HDMI-A-2",
    mode = "1920x1080@144.0",
    position = "0x0",
    scale = 1
})

-- HDMI-A-1 on the Right (1920x0)
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@144.0",
    position = "1920x0",
    scale = 1
})
