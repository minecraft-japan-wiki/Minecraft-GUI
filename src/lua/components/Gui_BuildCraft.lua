local p = {}
local GuiUtils = require("Module:Gui")

function p.IntegrationTable(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local output = args.output1 or args.target1 or args.output or args.target or args.slot10 or args[10]

    local gui = GuiUtils.new({
        name = "bc-integration-table",
        width = 151,
        height = 72,
        scale = 2,
        slots = {
            { x = 21, y = 23, value = args.input1 or args.input or args.slot1 or args[1], large = true },
            { x = 25, y = 2,  value = args.input2 or args.slot2 or args[2] },
            { x = 50, y = 2,  value = args.input3 or args.slot3 or args[3] },
            { x = 50, y = 27, value = args.input4 or args.slot4 or args[4] },
            { x = 50, y = 52, value = args.input5 or args.slot5 or args[5] },
            { x = 25, y = 52, value = args.input6 or args.slot6 or args[6] },
            { x = 0,  y = 52, value = args.input7 or args.slot7 or args[7] },
            { x = 0,  y = 27, value = args.input8 or args.slot8 or args[8] },
            { x = 0,  y = 2,  value = args.input9 or args.slot9 or args[9] },
            {
                x = 115,
                y = 23,
                value = output,
                amount = args.amount,
                large = true
            },
            { x = 82, y = 14, value = args.preview or args.slot11 or args[11] or output, amount = 1 }
        },
        images = {
            { x = 71,  y = 31, width = 41, height = 10, file = "GUI BC Integration Table Arrow.png" },
            { x = 145, y = 0,  width = 6,  height = 72, file = "GUI BC Energy Gauge Empty.png" },
            { x = 146, y = 1,  width = 4,  height = 70, file = "GUI BC Energy Gauge Full.png",      progress = "up" },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.AssemblyTable(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local energy = tonumber(args.energy)
    local unit = args.unit or "RF"

    local text = {}
    local heightAppend = 0
    if energy ~= nil then
        table.insert(text, {
            x = 36,
            y = 74,
            height = 10,
            size = 18,
            value = tostring(energy) .. " " .. tostring(unit),
            animate = false,
        })
        heightAppend = 12
    end

    local gui = GuiUtils.new({
        name = "bc-assembly-table",
        width = 116,
        height = 72 + heightAppend,
        scale = 2,
        slots = {
            { x = 0,  y = 0,  value = args.input1 or args.input or args.A1 or args.slot1 or args[1] },
            { x = 18, y = 0,  value = args.input2 or args.B1 or args.slot2 or args[2] },
            { x = 36, y = 0,  value = args.input3 or args.C1 or args.slot3 or args[3] },
            { x = 0,  y = 18, value = args.input4 or args.A2 or args.slot4 or args[4] },
            { x = 18, y = 18, value = args.input5 or args.B2 or args.slot5 or args[5] },
            { x = 36, y = 18, value = args.input6 or args.C2 or args.slot6 or args[6] },
            { x = 0,  y = 36, value = args.input7 or args.A3 or args.slot7 or args[7] },
            { x = 18, y = 36, value = args.input8 or args.B3 or args.slot8 or args[8] },
            { x = 36, y = 36, value = args.input9 or args.C3 or args.slot9 or args[9] },
            { x = 0,  y = 54, value = args.input10 or args.A4 or args.slot10 or args[10] },
            { x = 18, y = 54, value = args.input11 or args.B4 or args.slot11 or args[11] },
            { x = 36, y = 54, value = args.input12 or args.C4 or args.slot12 or args[12] },

            { x = 80, y = 0,  value = args.output1 or args.target1 or args.output or args.target or args.slot13 or args[13] },
            { x = 98, y = 0,  value = args.output2 or args.target2 or args.slot14 or args[14] },
            { x = 80, y = 18, value = args.output3 or args.target3 or args.slot15 or args[15] },
            { x = 98, y = 18, value = args.output4 or args.target4 or args.slot16 or args[16] },
            { x = 80, y = 36, value = args.output5 or args.target5 or args.slot17 or args[17] },
            { x = 98, y = 36, value = args.output6 or args.target6 or args.slot18 or args[18] },
            { x = 80, y = 54, value = args.output7 or args.target7 or args.slot19 or args[19] },
            { x = 98, y = 54, value = args.output8 or args.target8 or args.slot20 or args[20] },
        },
        images = {
            { x = 64, y = 0, width = 6, height = 72, file = "GUI BC Energy Gauge Empty.png" },
            { x = 65, y = 1, width = 4, height = 70, file = "GUI BC Energy Gauge Full.png", progress = "up" },
        },
        text = text,
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Distiller(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local energy = tonumber(args.energy1) or tonumber(args.text1) or tonumber(args.energy) or tonumber(args.text) or
        args[4]
    local unit = args.unit or "RF"

    local text = {}
    if energy ~= nil then
        table.insert(text, {
            x = 56,
            y = 28,
            size = 16,
            value = tostring(energy),
            animate = true,
            suffix = " " .. tostring(unit),
            css = { color = "#00ffff" }
        })
    end

    local gui = GuiUtils.new({
        name = "bc-distiller",
        width = 89,
        height = 63,
        scale = 2,
        images = {
            { x = 18, y = 3, width = 36, height = 57, file = "GUI BC Distiller Progress.png" },
            { x = 18, y = 3, width = 36, height = 57, file = "GUI BC Distiller Progress Full.png", progress = "right" },
        },
        tanks = {
            { x = 0,  y = 25, background = true, max = 16, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 56, y = 0,  background = true, max = 16, value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2] },
            { x = 56, y = 45, background = true, max = 16, value = args.output2 or args.target2 or args.slot3 or args[3] },
        },
        text = text,
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

return p
