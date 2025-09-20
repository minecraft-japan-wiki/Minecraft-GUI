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
        name = "ic2-" .. string.lower(title),
        width = 82,
        height = 54,
        scale = 2,
        slots = {
            { x = 0,  y = 0,  value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 56, y = 14, value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2], large = true },
            { x = 0,  y = 36, value = args.input2 or args.battery or args.slot3 or args[3] },
        },
        images = {
            { x = 1,  y = 20, width = 14, height = 14, file = "GUI IC2 Energy.png" },
            { x = 24, y = 18, width = 24, height = 17, file = "GUI IC2 " .. title .. " Progress.png" },
            { x = 24, y = 18, width = 24, height = 17, file = "GUI IC2 " .. title .. " Progress Full.png", progress = "right" },
        },
        gauges = {
            {
                x = 1,
                y = 20,
                width = 14,
                height = 14,
                file = "GUI IC2 Energy Full.png",
                value = tonumber(args.energy) or 100,
                max = 100,
                direction = "down"
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Furnace(f)
    return MachineBase(f, "Furnace")
end

function p.Compressor(f)
    return MachineBase(f, "Compressor")
end

function p.Extractor(f)
    return MachineBase(f, "Extractor")
end

function p.Macerator(f)
    return MachineBase(f, "Macerator")
end

function p.Recycler(f)
    return MachineBase(f, "Recycler")
end

function p.Canner(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local battery = args.input3 or args.battery or args.slot4 or args[4]
    local energy = tonumber(args.energy)

    local px = 0
    if battery or energy ~= nil then
        px = 25
    end

    local gui = GuiUtils.new({
        name = "ic2-canner",
        width = 72 + px,
        height = 54,
        scale = 2,
        slots = {
            { x = 0 + px,  y = 0,  value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 0 + px,  y = 36, value = args.input2 or args.can or args.slot2 or args[2] },
            { x = 46 + px, y = 14, value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3], large = true },
        },
        images = {
            { x = 6 + px, y = 20, width = 34, height = 13, file = "GUI IC2 Canner Progress.png" },
            { x = 6 + px, y = 20, width = 34, height = 13, file = "GUI IC2 Canner Progress Full.png", progress = "right" },
        },
        border = args.border,
        padding = args.padding,
    })

    if px > 0 then
        gui:insertSlot({ x = 0, y = 36, value = battery })
            :insertGauge({
                x = 2,
                y = 11,
                width = 14,
                height = 14,
                file = "GUI IC2 Energy Full.png",
                value = energy or 100,
                max = 100,
                direction = "down"
            })
            :insertImage({ x = 2, y = 11, width = 14, height = 14, file = "GUI IC2 Energy.png" })
    end

    return tostring(gui)
end

function p.Electrolyzer(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ic2-electrolyzer",
        width = 76,
        height = 18,
        scale = 2,
        slots = {
            { x = 0,  y = 0, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 58, y = 0, value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2] },
        },
        images = {
            { x = 22, y = 0, width = 32, height = 17, file = "GUI IC2 Electrolyzer Progress.png" },
            { x = 26, y = 0, width = 24, height = 17, file = "GUI IC2 Electrolyzer Progress Full.png", progress = "right" },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

return p
