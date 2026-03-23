local p = {}
local GuiUtils = require("Module:Gui")

function p.Rolling(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local targetArg = args.output1 or args.target1 or args.output or args.target or args.slot10 or args[10]

    local gui = GuiUtils.new({
        name = "railcraft-rolling",
        width = 116,
        height = 54,
        scale = 2,
        slots = {
            { x = 0,  y = 0,  value = args.input1 or args.input or args.slot1 or args.A1 or args[1] },
            { x = 18, y = 0,  value = args.input2 or args.slot2 or args.B1 or args[2] },
            { x = 36, y = 0,  value = args.input3 or args.slot3 or args.C1 or args[3] },
            { x = 0,  y = 18, value = args.input4 or args.slot4 or args.A2 or args[4] },
            { x = 18, y = 18, value = args.input5 or args.slot5 or args.B2 or args[5] },
            { x = 36, y = 18, value = args.input6 or args.slot6 or args.C2 or args[6] },
            { x = 0,  y = 36, value = args.input7 or args.slot7 or args.A3 or args[7] },
            { x = 18, y = 36, value = args.input8 or args.slot8 or args.B3 or args[8] },
            { x = 36, y = 36, value = args.input9 or args.slot9 or args.C3 or args[9] },
            { x = 90, y = 14, value = targetArg,                                                            large = true },
            { x = 63, y = 10, value = args.preview1 or args.preview or args.slot11 or args[11] or targetArg },
        },
        images = {
            { x = 60, y = 30, width = 25, height = 12, file = "GUI RC Rolling Progress.png" },
            { x = 60, y = 30, width = 25, height = 12, file = "GUI RC Rolling Progress Full.png", progress = "right" },
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
        name = "railcraft-blast-furnace",
        width = 82,
        height = 54,
        scale = 2,
        slots = {
            { x = 0,  y = 0,  value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 0,  y = 36, value = args.input2 or args.fuel or args.slot2 or args[2] },
            { x = 56, y = 0,  value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3], amount = args.amount, large = true },
            { x = 60, y = 36, value = args.output2 or args.target2 or args.slot4 or args[4] }
        },
        images = {
            { file = "GUI Furnace Fire.png",           x = 1,  y = 20, width = 15, height = 15 },
            { file = "GUI Furnace Arrow.png",          x = 25, y = 19, width = 22, height = 16 },
            { file = "GUI Furnace Progress Fire.png",  x = 1,  y = 20, width = 15, height = 15, reverse = true },
            { file = "GUI Furnace Progress Arrow.png", x = 25, y = 19, width = 22, height = 16, progress = "right", duration = 20 },
        },
        text = {
            {
                x = 22,
                y = 40,
                size = 16,
                value = args.duration or args.time or args.text1 or args.text or args[5],
                suffix = " " .. (args.unit or "s"),
                animate = true,
                css = { color = "#808080" }
            }
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
        name = "railcraft-coke-oven",
        width = 124,
        height = 49,
        scale = 2,
        slots = {
            { x = 0,  y = 19, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 42, y = 15, value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2], amount = args.amount, large = true },
        },
        images = {
            { file = "GUI Furnace Fire.png",            x = 1,  y = 3,  width = 15, height = 15 },
            { file = "GUI Furnace Arrow.png",           x = 19, y = 21, width = 22, height = 16 },
            { file = "GUI Furnace Progress Fire.png",   x = 1,  y = 3,  width = 15, height = 15, reverse = true },
            { file = "GUI Furnace Progress Arrow.png",  x = 19, y = 21, width = 22, height = 16, progress = "right",         duration = 30 },
            { file = "GUI RC Coke Oven Tank Scale.png", x = 74, y = 0,  width = 50, height = 49, css = { ["z-index"] = "2" } },
        },
        tanks = {
            {
                x = 74,
                y = 0,
                width = 50,
                height = 49,
                max = 10000,
                value = args.output2 or args.target2 or args.tank1 or args.tank or args.slot3 or args[3]
            },
        },
        text = {
            {
                x = 2,
                y = 39,
                size = 16,
                value = args.duration or args.time or args.text1 or args.text or args[4],
                suffix = " " .. (args.unit or "s"),
                animate = true,
                css = { color = "#808080" }
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.CokeOvenTank(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "railcraft-tank",
        width = 77,
        height = 53,
        scale = 2,
        slots = {
            { x = 59, y = 0,  value = args.input2 or args.slot2 or args[2],                                                background = false },
            { x = 59, y = 35, value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3], background = false },
        },
        images = {
            { file = "GUI RC Coke Oven Tank Scale.png", x = 0,  y = 2,  width = 50, height = 49, css = { ["z-index"] = "2" } },
            { file = "GUI RC Tank Slot.png",            x = 59, y = 0,  width = 18, height = 18 },
            { file = "GUI RC Tank Slot.png",            x = 59, y = 35, width = 18, height = 18 },
        },
        tanks = {
            {
                x = 0,
                y = 2,
                width = 50,
                height = 49,
                max = 10000,
                value = args.input1 or args.input or args.tank1 or args.tank or args.slot1 or args[1],
            },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.RockCrusher(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "railcraft-rock-crusher",
        width = 144,
        height = 54,
        scale = 2,
        slots = {
            { x = 0,   y = 0,  value = args.input1 or args.input or args.slot1 or args.A1 or args[1] },
            { x = 18,  y = 0,  value = args.input2 or args.slot2 or args.B1 or args[2] },
            { x = 36,  y = 0,  value = args.input3 or args.slot3 or args.C1 or args[3] },
            { x = 0,   y = 18, value = args.input4 or args.slot4 or args.A2 or args[4] },
            { x = 18,  y = 18, value = args.input5 or args.slot5 or args.B2 or args[5] },
            { x = 36,  y = 18, value = args.input6 or args.slot6 or args.C2 or args[6] },
            { x = 0,   y = 36, value = args.input7 or args.slot7 or args.A3 or args[7] },
            { x = 18,  y = 36, value = args.input8 or args.slot8 or args.B3 or args[8] },
            { x = 36,  y = 36, value = args.input9 or args.slot9 or args.C3 or args[9] },

            { x = 90,  y = 0,  value = args.output1 or args.target1 or args.output or args.target or args.slot10 or args.D1 or args[10] },
            { x = 108, y = 0,  value = args.output2 or args.target2 or args.slot11 or args.E1 or args[11] },
            { x = 126, y = 0,  value = args.output3 or args.target3 or args.slot12 or args.F1 or args[12] },
            { x = 90,  y = 18, value = args.output4 or args.target4 or args.slot13 or args.D2 or args[13] },
            { x = 198, y = 18, value = args.output5 or args.target5 or args.slot14 or args.E2 or args[14] },
            { x = 126, y = 18, value = args.output6 or args.target6 or args.slot15 or args.F2 or args[15] },
            { x = 90,  y = 36, value = args.output7 or args.target7 or args.slot16 or args.D3 or args[16] },
            { x = 108, y = 36, value = args.output8 or args.target8 or args.slot17 or args.E3 or args[17] },
            { x = 126, y = 36, value = args.output9 or args.target9 or args.slot18 or args.F3 or args[18] },
        },
        images = {
            { file = "GUI RC Rock Crusher Progress.png",      x = 58, y = 1, width = 29, height = 52 },
            { file = "GUI RC Rock Crusher Progress Full.png", x = 58, y = 1, width = 29, height = 52, progress = "right" },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

return p
