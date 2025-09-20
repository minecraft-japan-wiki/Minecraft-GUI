local p = {}
local GuiUtils = require("Module:Gui")

local function MachineBase(f, title)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ir3-" .. string.lower(title),
        width = 94,
        height = 26,
        slots = {
            {
                x = 0,
                y = 4,
                value = args.input1 or args.input or args.slot1 or args[1]
            },
            {
                x = 68,
                y = 0,
                value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2],
                amount = args.amount,
                large = true
            },
        },
        images = {
            { x = 32, y = 6, width = 22, height = 15, file = "GUI IR3 Arrow Right Empty.png" },
            { x = 32, y = 6, width = 22, height = 15, file = "GUI IR3 Arrow Right Full.png", progress = "right" },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.AlloySmelter(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ir3-alloy-smelter",
        width = 102,
        height = 26,
        slots = {
            {
                x = 0,
                y = 4,
                value = args.input1 or args.input or args.slot1 or args[1],
                placeholder = "IR3Sprite:ingot slot"
            },
            {
                x = 18,
                y = 4,
                value = args.input2 or args.slot2 or args[2],
                placeholder = "IR3Sprite:dust slot"
            },
            {
                x = 76,
                y = 0,
                value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3],
                amount = args.amount,
                large = true
            },
        },
        images = {
            { x = 45, y = 6, width = 22, height = 15, file = "GUI IR3 Arrow Right Empty.png" },
            { x = 45, y = 6, width = 22, height = 15, file = "GUI IR3 Arrow Right Full.png", progress = "right" },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Spinning(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ir3-spinning",
        width = 94,
        height = 26,
        slots = {
            {
                x = 0,
                y = 4,
                value = args.input1 or args.input or args.slot1 or args[1]
            },
            {
                x = 68,
                y = 0,
                value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2],
                amount = args.amount,
                large = true
            },
        },
        images = {
            { x = 32, y = 6, width = 22, height = 15, file = "GUI IR3 Spinning Arrow Empty.png" },
            { x = 32, y = 6, width = 22, height = 15, file = "GUI IR3 Spinning Arrow Full.png", progress = "right" },
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
        name = "ir3-crusher",
        width = 143,
        height = 36,
        slots = {
            {
                x = 0,
                y = 4,
                value = args.input1 or args.input or args.slot1 or args[1]
            },
            {
                x = 65,
                y = 0,
                value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2],
                large = true
            },
            {
                x = 91,
                y = 0,
                value = args.output2 or args.target2 or args.slot3 or args[3],
                large = true
            },
            {
                x = 117,
                y = 0,
                value = args.output2 or args.target2 or args.slot3 or args[3],
                large = true
            },
        },
        images = {
            { x = 30, y = 6, width = 22, height = 15, file = "GUI IR3 Arrow Right Empty.png" },
            { x = 30, y = 6, width = 22, height = 15, file = "GUI IR3 Arrow Right Full.png", progress = "right" },
        },
        text = {
            { x = 65,  y = 28, size = 14, value = args.chance1 or args.text1 or args.chance or args.text or args[4], suffix = "%", animate = true, css = { color = "#808080" } },
            { x = 91,  y = 28, size = 14, value = args.chance2 or args.text2 or args[5],                             suffix = "%", animate = true, css = { color = "#808080" } },
            { x = 117, y = 28, size = 14, value = args.chance3 or args.text3 or args[6],                             suffix = "%", animate = true, css = { color = "#808080" } },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Smoker(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ir3-smoker",
        width = 43,
        height = 53,
        slots = {
            { x = 0,  y = 35, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 0,  y = 0,  value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2] },
            { x = 25, y = 25, value = args.input2 or args.fuel or args.slot3 or args[3] },
        },
        images = {
            { x = 2,  y = 19, width = 15, height = 15, file = "GUI IR3 Smoker Arrow Empty.png" },
            { x = 2,  y = 19, width = 15, height = 15, file = "GUI IR3 Smoker Arrow Full.png", progress = "up" },
            { x = 27, y = 10, width = 14, height = 14, file = "GUI IR3 Fire Empty.png" },
            { x = 27, y = 10, width = 14, height = 14, file = "GUI IR3 Fire Full.png",         progress = "down", reverse = true },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.CheeseMaker(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ir3-cheese-maker",
        width = 90,
        height = 48,
        slots = {
            { x = 0,  y = 30, value = args.input2 or args.slot2 or args[2] },
            { x = 64, y = 10, value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2], large = true },
        },
        tanks = {
            {
                x = 0,
                y = 0,
                width = 18,
                height = 18,
                value = args.input1 or args.tank1 or args.input or args.tank or args.slot1 or args[1] or
                    "IR3Sprite:Milk*250",
                max = 1000,
                background = false,
            },
        },
        images = {
            { x = 0,  y = 0,  width = 18, height = 18, file = "GUI IR3 Tank.png" },
            { x = 31, y = 15, width = 22, height = 15, file = "GUI IR3 Arrow Right Empty.png" },
            { x = 31, y = 15, width = 22, height = 15, file = "GUI IR3 Arrow Right Full.png", progress = "right" },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Loom(f)
    return MachineBase(f, "Loom")
end

function p.Extractor(f)
    return MachineBase(f, "Extractor")
end

return p
