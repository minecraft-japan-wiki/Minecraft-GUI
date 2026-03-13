local p = {}
local GuiUtils = require("Module:Gui")

function p.AlloyFurnace(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "rp2-alloy-furnace",
        width = 146,
        height = 54,
        scale = 2,
        slots = {
            { x = 31,  y = 0,  value = args.input1 or args.input1 or args.input or args.slot1 or args[1] },
            { x = 49,  y = 0, value = args.input2 or args.slot2 or args[2] },
            { x = 67,  y = 0, value = args.input3 or args.slot3 or args[3] },
            { x = 31,  y = 18,  value = args.input4 or args.slot4 or args[4] },
            { x = 49,  y = 18, value = args.input5 or args.slot5 or args[5] },
            { x = 67,  y = 18, value = args.input6 or args.slot6 or args[6] },
            { x = 31,  y = 36,  value = args.input7 or args.slot7 or args[7] },
            { x = 49,  y = 36, value = args.input8 or args.slot8 or args[8] },
            { x = 67,  y = 36, value = args.input9 or args.slot9 or args[9] },
            { x = 120, y = 14, value = args.output1 or args.target1 or args.output or args.target or args.slot10 or args[10], large = true },
            { x = 0, y = 25, value = args.fuel1 or args.fuel or args.input10 or args.slot11 or args[11] },
        },
        images = {
            { file = "GUI Furnace Fire.png",           x = 3,  y = 10, width = 15, height = 15 },
            { file = "GUI Furnace Arrow.png",          x = 92, y = 19, width = 22, height = 16 },
            { file = "GUI Furnace Progress Fire.png",  x = 3,  y = 10, width = 15, height = 15, reverse = true },
            { file = "GUI Furnace Progress Arrow.png", x = 92, y = 19, width = 22, height = 16, progress = "right" },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

return p