local p = {}
local GuiUtils = require("Module:Gui")

function p.AlloySmelter(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-alloy-smelter",
        width = 113,
        height = 61,
        scale = 2,
        slots = {
            { x = 5,  y = 4,  value = args.input1 or args.input or args.slot1 or args[1],                                  background = false },
            { x = 33, y = 4,  value = args.input2 or args.slot2 or args[2],                                                background = false },
            { x = 33, y = 4,  value = args.input3 or args.fuel or args.slot3 or args[3],                                   background = false },
            { x = 83, y = 18, value = args.output1 or args.target1 or args.output or args.target or args.slot4 or args[4], large = true,      background = false },
        },
        images = {
            { x = 0,  y = 0,  width = 113, height = 61, file = "GUI IE Alloy Smelter Base.png" },
            { x = 52, y = 23, width = 22,  height = 16, file = "GUI IE Alloy Smelter Progress.png", progress = "right", duration = 10 },
            { x = 24, y = 25, width = 9,   height = 12, file = "GUI IE Alloy Smelter Fire.png",     progress = "up",    reverse = true, duration = 10 },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.BlastFurnace(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-blast-furnace",
        width = 89,
        height = 65,
        scale = 2,
        slots = {
            { x = 3,  y = 8,  value = args.input1 or args.input or args.slot1 or args[1],                                  background = false },
            { x = 3,  y = 44, value = args.input2 or args.fuel or args.slot2 or args[2],                                   background = false },
            { x = 59, y = 4,  value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3], large = true,      background = false },
            { x = 63, y = 44, value = args.output2 or args.target2 or args[4],                                             background = false },
        },
        images = {
            { x = 0,  y = 0,  width = 89, height = 65, file = "GUI IE Blast Furnace Base.png" },
            { x = 28, y = 27, width = 22, height = 16, file = "GUI IE Blast Furnace Progress.png", progress = "right", duration = 10 },
            { x = 8,  y = 29, width = 9,  height = 12, file = "GUI IE Blast Furnace Fire.png",     progress = "up",    reverse = true, duration = 10 },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.GardenCloche(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-garden-cloche",
        width = 176,
        height = 77,
        scale = 2,
        slots = {
            { x = 61,  y = 33, value = args.input1 or args.crop or args.input or args.slot1 or args[1],                     background = false },
            { x = 61,  y = 53, value = args.input2 or args.soil or args.slot2 or args[2],                                   background = false },
            { x = 7,   y = 58, value = args.input3 or args.fertilizer or args.slot3 or args[3],                             background = false },
            { x = 115, y = 33, value = args.output1 or args.target1 or args.output or args.target or args.slot5 or args[5], background = false },
            { x = 133, y = 33, value = args.output2 or args.target2 or args.slot6 or args[6],                               background = false },
            { x = 115, y = 51, value = args.output3 or args.target3 or args.slot7 or args[7],                               background = false },
            { x = 133, y = 51, value = args.output4 or args.target4 or args.slot8 or args[8],                               background = false },
        },
        tanks = {
            {
                x = 7,
                y = 7,
                width = 18,
                height = 49,
                max = 4000,
                value = args.input4 or args.tank or args.slot4 or args[4],
            }
        },
        gauges = {
            {
                x = 158,
                y = 22,
                width = 7,
                height = 46,
                file = "GUI IE Energy Gauge.png",
                value = tonumber(args.energy) or tonumber(args[9]) or 16000,
                max = 16000,
                direction = "up"
            },
            {
                x = 30,
                y = 22,
                width = 7,
                height = 46,
                file = "GUI IE Fertilizer Gauge.png",
                value = 1,
                max = 1,
                direction = "up"
            }
        },
        images = {
            { x = 0,   y = 0,  width = 176, height = 77, file = "GUI IE Garden Cloche Base.png" },
            { x = 101, y = 36, width = 12,  height = 12, file = "GUI IE Garden Cloche Progress.png",  progress = "right", duration = 10 },
            { x = 6,   y = 6,  width = 20,  height = 51, file = "GUI IE Garden Cloche Tank Gauge.png" },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

return p
