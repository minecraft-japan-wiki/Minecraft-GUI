local p = {}
local GuiUtils = require("Module:Gui")

function p.AlloySmelter(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local imagePath = { x = 17, y = 17, width = 33, height = 31, file = "GUI EnderIO Alloy Smelter Alloy Path.png", css = { ["z-index"] = "2" } }
    local mode = mw.ustring.lower(args.mode or "")
    if mode == "auto" then
        imagePath = { x = 17, y = 17, width = 33, height = 31, file = "GUI EnderIO Alloy Smelter Auto Path.png", css = { ["z-index"] = "2" } }
    elseif mode == "furnace" then
        imagePath = { x = 17, y = 17, width = 33, height = 31, file = "GUI EnderIO Alloy Smelter Furnace Path.png", css = { ["z-index"] = "2" } }
    end

    local gui = GuiUtils.new({
        name = "enderio-alloy-smelter",
        width = 90,
        height = 73,
        scale = 2,
        slots = {
            { x = 0,  y = 10, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 25, y = 0,  value = args.input2 or args.slot2 or args[2] },
            { x = 49, y = 10, value = args.input3 or args.slot3 or args[3] },
            { x = 21, y = 47, value = args.output1 or args.target1 or args.output or args.target or args.slot4 or args[4], large = true },
        },
        images = {
            imagePath,
            { x = 3,  y = 30, width = 14, height = 14, file = "GUI EnderIO Alloy Smelter Fire Empty.png" },
            { x = 51, y = 30, width = 14, height = 14, file = "GUI EnderIO Alloy Smelter Fire Empty.png" },
            { x = 3,  y = 30, width = 14, height = 14, file = "GUI EnderIO Alloy Smelter Fire Full.png", progress = "up", reverse = true, duration = 10 },
            { x = 51, y = 30, width = 14, height = 14, file = "GUI EnderIO Alloy Smelter Fire Full.png", progress = "up", reverse = true, duration = 10 },
        },
        text = {
            {
                x = 49,
                y = 54,
                size = 16,
                value = args.energy1 or args.text1 or args.energy or args[5],
                suffix = " " .. (args.unit or "μI"),
                animate = true,
                css = { color = "#808080" }
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.SAGMill(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local ball = args.ball1 or args.input2 or args.ball or args.slot6 or args[6]

    local gui = GuiUtils.new({
        name = "enderio-sag-mill",
        width = 99,
        height = 72,
        scale = 2,
        slots = {
            { x = 31, y = 0,  value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 0,  y = 47, value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2] },
            { x = 21, y = 47, value = args.output2 or args.target2 or args.slot3 or args[3] },
            { x = 42, y = 47, value = args.output3 or args.target3 or args.slot4 or args[4] },
            { x = 63, y = 47, value = args.output4 or args.target4 or args.slot5 or args[5] },
            { x = 73, y = 11, value = ball },
        },
        images = {
            { x = 31, y = 20, width = 17, height = 24, file = "GUI EnderIO Crusher Arrow Empty.png" },
            { x = 31, y = 20, width = 17, height = 24, file = "GUI EnderIO Crusher Arrow Full.png", progress = "down" },
            { x = 93, y = 11, width = 6,  height = 18, file = "GUI EnderIO Crusher Ball Gauge.png" },
        },
        text = {
            { x = 0,  y = 66, size = 14, value = args.chance1 or args.text1 or args.chance or args.text or args[7], suffix = "%", animate = true, css = { color = "#808080" } },
            { x = 21, y = 66, size = 14, value = args.chance2 or args.text2 or args[8],                             suffix = "%", animate = true, css = { color = "#808080" } },
            { x = 42, y = 66, size = 14, value = args.chance3 or args.text3 or args[9],                             suffix = "%", animate = true, css = { color = "#808080" } },
            { x = 63, y = 66, size = 14, value = args.chance4 or args.text4 or args[10],                            suffix = "%", animate = true, css = { color = "#808080" } },
            {
                x = 52,
                y = 33,
                size = 16,
                value = args.energy1 or args.text5 or args.energy or args[7],
                suffix = " " .. (args.unit or "μI"),
                animate = true,
                css = { color = "#808080" }
            }
        },
        border = args.border,
        padding = args.padding,
    })

    if ball then
        gui:insertImage({
            x = 94,
            y = 12,
            width = 4,
            height = 16,
            file = "GUI EnderIO Crusher Ball Gauge Full.png",
            reverse = true,
            progress = "up",
            duration = 10
        })
    end

    return tostring(gui)
end

function p.SliceAndSplice(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "enderio-slice-and-splice",
        width = 108,
        height = 60,
        scale = 2,
        slots = {
            { x = 0,  y = 24, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 18, y = 24, value = args.input2 or args.slot2 or args[2] },
            { x = 36, y = 24, value = args.input3 or args.slot3 or args[3] },
            { x = 0,  y = 42, value = args.input4 or args.slot4 or args[4] },
            { x = 18, y = 42, value = args.input5 or args.slot5 or args[5] },
            { x = 36, y = 42, value = args.input6 or args.slot6 or args[6] },
            { x = 90, y = 33, value = args.output1 or args.target1 or args.output or args.target or args.slot7 or args[7] },
            {
                x = 10,
                y = 0,
                value = args.input7 or args.axe or args.slot8 or args[8] or
                    "wooden axe;iron axe;golden axe;diamond axe;EnderIO:dark axe"
            },
            {
                x = 28,
                y = 0,
                value = args.input8 or args.shears or args.slot9 or args[9] or "shears;EnderIO:dark shears"
            },
        },
        images = {
            { x = 60, y = 34, width = 24, height = 17, file = "GUI EnderIO Arrow Empty.png" },
            { x = 60, y = 34, width = 24, height = 17, file = "GUI EnderIO Arrow Full.png", progress = "right" }
        },
        text = {
            {
                x = 56,
                y = 8,
                size = 16,
                value = args.energy1 or args.text1 or args.energy or args.text or args[10],
                suffix = " " .. (args.unit or "μI"),
                animate = true,
                css = { color = "#808080" }
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.SoulBinder(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "enderio-soul-binder",
        width = 114,
        height = 30,
        scale = 2,
        slots = {
            { x = 0,  y = 0, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 21, y = 0, value = args.input2 or args.slot2 or args[2] },
            { x = 74, y = 0, value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3] },
            { x = 96, y = 0, value = args.output2 or args.target2 or args.slot4 or args[4] },
        },
        images = {
            { x = 43, y = 2, width = 24, height = 17, file = "GUI EnderIO Arrow Empty.png" },
            { x = 43, y = 2, width = 24, height = 17, file = "GUI EnderIO Arrow Full.png", progress = "right" }
        },
        text = {
            {
                x = 3,
                y = 20,
                size = 16,
                value = args.level or args.text1 or args.text or args[5],
                suffix = " Lv",
                color = "enchantment",
                animate = true,
                css = { color = "#80fe20", ["text-shadow"] = "0.12em 0.1em 0 #203f08" }
            },
            {
                x = 64,
                y = 20,
                size = 16,
                value = args.energy1 or args.energy or args.text2 or args[6],
                suffix = " " .. (args.unit or "μI"),
                animate = true,
                css = { color = "#808080" }
            },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.TheVat(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "enderio-the-vat",
        width = 119,
        height = 67,
        scale = 2,
        slots = {
            { x = 26, y = 0, value = args.input2 or args.slot2 or args[2] },
            { x = 75, y = 0, value = args.input3 or args.slot3 or args[3] }
        },
        tanks = {
            {
                x = 0,
                y = 0,
                width = 17,
                height = 49,
                max = 8000,
                value = args.input1 or args.input or args.slot1 or args[1],
            },
            {
                x = 102,
                y = 0,
                width = 17,
                height = 49,
                max = 8000,
                value = args.output1 or args.target1 or args.output or args.target or args.slot4 or args[4],
            },
        },
        images = {
            { x = 16,  y = 12, width = 87, height = 39, file = "GUI EnderIO Vat Path.png",         css = { ["z-index"] = "2" } },
            { x = 1,   y = 6,  width = 5,  height = 37, file = "GUI EnderIO Vat Gauge Memory.png", css = { ["z-index"] = "2" } },
            { x = 113, y = 6,  width = 5,  height = 37, file = "GUI EnderIO Vat Gauge Memory.png", css = { ["z-index"] = "2" } },
            { x = 53,  y = 53, width = 14, height = 14, file = "GUI EnderIO Vat Fire Empty.png" },
            { x = 53,  y = 53, width = 14, height = 14, file = "GUI EnderIO Vat Fire Full.png",    reverse = true },
        },
        text = {
            {
                x = 26,
                y = 20,
                size = 16,
                value = args.multiply1 or args.text1 or args.multiply or args.text or args[5],
                prefix = "x",
                animate = true,
                css = { color = "#808080" }
            },
            {
                x = 75,
                y = 20,
                size = 16,
                value = args.multiply2 or args.text2 or args[6],
                prefix = "x",
                animate = true,
                css = { color = "#808080" }
            },
            {
                x = 72,
                y = 57,
                size = 16,
                value = args.energy1 or args.text3 or args.energy or args[7],
                suffix = " " .. (args.unit or "μI"),
                animate = true,
                css = { color = "#808080" }
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.FluidTank(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "enderio-fluid-tank",
        width = 90,
        height = 49,
        scale = 2,
        slots = {
            { x = 0,  y = 0,  value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 0,  y = 31, value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2] },
            { x = 72, y = 0,  value = args.input2 or args.slot4 or args[4] },
            { x = 72, y = 31, value = args.output2 or args.target2 or args.slot5 or args[5] },
        },
        tanks = {
            {
                x = 36,
                y = 0,
                width = 18,
                height = 49,
                value = args.tank1 or args.tank or args.slot3 or args[3],
                max = 16000
            }
        },
        images = {
            { x = 5,  y = 21, width = 8,  height = 7,  file = "GUI EnderIO Fluid Tank Arrow Down.png" },
            { x = 77, y = 21, width = 8,  height = 7,  file = "GUI EnderIO Fluid Tank Arrow Down.png" },
            { x = 20, y = 5,  width = 13, height = 8,  file = "GUI EnderIO Fluid Tank Arrow Right.png" },
            { x = 56, y = 5,  width = 13, height = 8,  file = "GUI EnderIO Fluid Tank Arrow Right.png" },
            { x = 37, y = 6,  width = 5,  height = 37, file = "GUI EnderIO Fluid Tank Gauge.png",      css = { ["z-index"] = "2" } },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.FireCrafting(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "enderio-fire-crafting",
        width = 99,
        height = 48,
        scale = 2,
        slots = {
            { x = 0,  y = 0,  value = args.input1 or args.input or args.slot1 or args[1],                                 background = false },
            { x = 67, y = 9,  value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2] },
            { x = 0,  y = 18, value = args.input2 or args.base or args.slot3 or args[3] or "bedrock",                     background = false }
        },
        images = {
            { x = 27, y = 11, width = 31, height = 15, file = "GUI EnderIO Infinity Arrow Right.png" }
        },
        text = {
            {
                x = 29,
                y = 15,
                size = 14,
                value = args.chance1 or args.chance or args.text1 or args.text or args[4],
                suffix = "%",
                animate = true,
                css = { color = "#ffffff" }
            },
            {
                x = 27,
                y = 30,
                size = 16,
                value = args.dimension or args.text2 or args[5] or "オーバーワールド",
                animate = true,
                css = { color = "#808080" }
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

return p
