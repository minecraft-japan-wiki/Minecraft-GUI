local p = {}
local GuiUtils = require("Module:Gui")

function p.AlloyKiln(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-alloy-kiln",
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

function p.ArcFurnace(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-arc-furnace",
        width = 128,
        height = 54,
        scale = 2,
        slots = {
            { x = 8,  y = 0,  value = args.input1 or args.input or args.slot1 or args[1], },
            { x = 0,  y = 18, value = args.input2 or args.slot2 or args[2], },
            { x = 18, y = 18, value = args.input3 or args.slot3 or args[3], },
            { x = 0,  y = 36, value = args.input4 or args.slot4 or args[4], },
            { x = 18, y = 36, value = args.input5 or args.slot5 or args[5], },
            { x = 68, y = 0,  value = args.output1 or args.target1 or args.output or args.target or args.slot6 or args[6] },
            { x = 88, y = 0,  value = args.output2 or args.target2 or args.slot7 or args[7], },
            { x = 68, y = 36, value = args.output3 or args.target3 or args.slot8 or args[8], },
        },
        images = {
            { x = 41, y = 11, width = 22, height = 15, file = "GUI IE Arc Furnace Arrow.png" },
        },
        text = {
            {
                x = 107,
                y = 6,
                size = 14,
                value = args.chance1 or args.text1 or args.chance or args.text or args[9],
                suffix = "%",
                animate = true,
                css = { color = "#808080" }
            },
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
            { x = 63, y = 44, value = args.output2 or args.target2 or args.slot4 or args[4],                               background = false },
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

function p.MetalPress(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-metal-press",
        width = 100,
        height = 46,
        scale = 2,
        slots = {
            { x = 0,  y = 12, value = args.input1 or args.crop or args.input or args.slot1 or args[1] },
            { x = 82, y = 12, value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2] },
            { x = 56, y = 0,  value = args.input2 or args.mold or args.slot3 or args[3] },
        },
        images = {
            { x = 22, y = 5, width = 34, height = 41, file = "GUI IE Metal Press.png" }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.CokeOven(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-coke-oven",
        width = 123,
        height = 55,
        scale = 2,
        slots = {
            { x = 2,  y = 18, value = args.input1 or args.input or args.slot1 or args[1],                                  background = false },
            { x = 54, y = 14, value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2], background = false, large = true },
        },
        images = {
            { x = 0,  y = 0,  width = 123, height = 55, file = "GUI IE Coke Oven Base.png" },
            { x = 33, y = 21, width = 9,   height = 12, file = "GUI IE Blast Furnace Fire.png", progress = "up", reverse = true, duration = 10 },
        },
        tanks = {
            {
                x = 102,
                y = 3,
                width = 18,
                height = 49,
                max = 12500,
                value = args.output2 or args.tank1 or args.tank or args.slot3 or args[3],
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Crusher(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-crusher",
        width = 130,
        height = 40,
        scale = 2,
        slots = {
            { x = 0,  y = 13, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 76, y = 3,  value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2] },
            { x = 76, y = 21, value = args.output2 or args.target2 or args.slot3 or args[3] },
        },
        images = {
            { x = 22, y = 0, width = 51, height = 40, file = "GUI IE Crusher.png" }
        },
        text = {
            {
                x = 96,
                y = 27,
                size = 14,
                value = args.chance1 or args.text1 or args.chance or args.text or args[4],
                suffix = "%",
                animate = true,
                css = { color = "#808080" }
            },
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
            { x = 61,  y = 33, value = args.input1 or args.input or args.crop or args.slot1 or args[1],                     background = false },
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

function p.Workbench(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-workbench",
        width = 176,
        height = 63,
        scale = 2,
        slots = {
            { x = 80,  y = 18, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 98,  y = 18, value = args.input2 or args.slot2 or args[2] },
            { x = 116, y = 18, value = args.input3 or args.slot3 or args[3] },
            { x = 80,  y = 36, value = args.input4 or args.slot4 or args[4] },
            { x = 98,  y = 36, value = args.input5 or args.slot5 or args[5] },
            { x = 116, y = 36, value = args.input6 or args.slot6 or args[6] },
            { x = 24,  y = 5,  value = args.input7 or args.blueprint or args.slot7 or args[7] },
            { x = 140, y = 14, value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[8] },
        },
        images = {
            { x = 0, y = 0, width = 176, height = 63, file = "GUI IE Workbench Base.png" }
        },
        text = {
            {
                x = 96,
                y = 27,
                size = 14,
                value = args.chance1 or args.text1 or args.chance or args.text or args[4],
                suffix = "%",
                animate = true,
                css = { color = "#808080" }
            },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.BottlingMachine(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-bottling-machine",
        width = 118,
        height = 54,
        scale = 2,
        slots = {
            { x = 0,   y = 0,  value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 0,   y = 18, value = args.input2 or args.slot2 or args[2] },
            { x = 0,   y = 36, value = args.input3 or args.slot3 or args[3] },
            { x = 100, y = 0,  value = args.output1 or args.target1 or args.output or args.target or args.slot5 or args[5] },
            { x = 100, y = 18, value = args.output2 or args.target2 or args.slot6 or args[6] },
            { x = 100, y = 36, value = args.output3 or args.target3 or args.slot7 or args[7] },
        },
        images = {
            { x = 45, y = 6, width = 43, height = 37, file = "GUI IE Bottling Machine.png" }
        },
        tanks = {
            {
                x = 23,
                y = 0,
                width = 18,
                height = 54,
                max = 1000,
                value = args.input4 or args.tank1 or args.tank or args.slot4 or args[4],
                background = true,
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Squeezer(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-squeezer",
        width = 125,
        height = 65,
        scale = 2,
        slots = {
            { x = 0,  y = 22, value = args.input1 or args.input or args.slot1 or args[1],                                  background = false },
            { x = 18, y = 22, value = args.input2 or args.slot2 or args[2],                                                background = false },
            { x = 36, y = 22, value = args.input3 or args.slot3 or args[3],                                                background = false },
            { x = 54, y = 22, value = args.input4 or args.slot4 or args[4],                                                background = false },
            { x = 0,  y = 40, value = args.input5 or args.slot5 or args[5],                                                background = false },
            { x = 18, y = 40, value = args.input2 or args.slot6 or args[6],                                                background = false },
            { x = 36, y = 40, value = args.input3 or args.slot7 or args[7],                                                background = false },
            { x = 54, y = 40, value = args.input4 or args.slot8 or args[8],                                                background = false },
            { x = 83, y = 40, value = args.output1 or args.target1 or args.output or args.target or args.slot9 or args[9], background = false },
        },
        images = {
            { x = 0, y = 0, width = 125, height = 65, file = "GUI IE Squeezer Base.png" }
        },
        tanks = {
            {
                x = 104,
                y = 8,
                width = 18,
                height = 49,
                max = 250,
                value = args.output2 or args.tank1 or args.tank or args.slot10 or args[10],
                background = false,
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Refinery(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-refinery",
        width = 125,
        height = 57,
        scale = 2,
        slots = {
            { x = 66, y = 10, value = args.input3 or args.slot3 or args[3], background = false },
        },
        images = {
            { x = 0, y = 0, width = 125, height = 57, file = "GUI IE Refinery Base.png" }
        },
        tanks = {
            {
                x = 6,
                y = 4,
                width = 18,
                height = 49,
                max = 100,
                value = args.input1 or args.input or args.tank1 or args.tank or args.slot1 or args[1],
                background = false,
            },
            {
                x = 33,
                y = 4,
                width = 18,
                height = 49,
                max = 100,
                value = args.input2 or args.tank2 or args.slot2 or args[2],
                background = false,
            },
            {
                x = 102,
                y = 4,
                width = 18,
                height = 49,
                max = 100,
                value = args.output1 or args.target1 or args.output or args.target or args.tank3 or args.slot4 or args
                    [4],
                background = false,
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Fermenter(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-fermenter",
        width = 125,
        height = 65,
        scale = 2,
        slots = {
            { x = 1,  y = 12, value = args.input1 or args.input or args.slot1 or args[1],                                  background = false },
            { x = 19, y = 12, value = args.input2 or args.slot2 or args[2],                                                background = false },
            { x = 37, y = 12, value = args.input3 or args.slot3 or args[3],                                                background = false },
            { x = 55, y = 12, value = args.input4 or args.slot4 or args[4],                                                background = false },
            { x = 1,  y = 30, value = args.input5 or args.slot5 or args[5],                                                background = false },
            { x = 19, y = 30, value = args.input2 or args.slot6 or args[6],                                                background = false },
            { x = 37, y = 30, value = args.input3 or args.slot7 or args[7],                                                background = false },
            { x = 55, y = 30, value = args.input4 or args.slot8 or args[8],                                                background = false },
            { x = 84, y = 46, value = args.output1 or args.target1 or args.output or args.target or args.slot9 or args[9], background = false },
        },
        images = {
            { x = 0, y = 0, width = 125, height = 65, file = "GUI IE Fermenter Base.png" }
        },
        tanks = {
            {
                x = 105,
                y = 15,
                width = 18,
                height = 49,
                max = 250,
                value = args.output2 or args.tank1 or args.tank or args.slot10 or args[10],
                background = false,
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Mixer(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ie-mixer",
        width = 136,
        height = 60,
        scale = 2,
        slots = {
            { x = 0,  y = 0,  value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 18, y = 0,  value = args.input2 or args.slot2 or args[2] },
            { x = 0,  y = 18, value = args.input3 or args.slot3 or args[3] },
            { x = 18, y = 18, value = args.input4 or args.slot4 or args[4] }
        },
        images = {
            { x = 40, y = 0, width = 74, height = 60, file = "GUI IE Mixer Base.png" }
        },
        tanks = {
            {
                x = 47,
                y = 2,
                width = 60,
                height = 49,
                max = 2000,
                value = args.input5 or args.tank1 or args.tank or args.slot5 or args[5],
                background = false,
            },
            {
                x = 118,
                y = 2,
                width = 18,
                height = 49,
                max = 2000,
                value = args.output1 or args.target1 or args.output or args.target or args.tank2 or args.slot6 or args
                    [6],
                background = true,
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

return p
