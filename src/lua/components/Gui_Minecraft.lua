local p = {}
local GuiUtils = require("Module:Gui")

function p.base(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local aliases = {
        craft = "crafting-table",
        crafting = "crafting-table",
        ["ì‹Æ‘ä"] = "crafting-table",
        ["ƒNƒ‰ƒtƒg"] = "crafting-table",
        craftingtable = "crafting-table",
        ["craft-3x3"] = "crafting-table",
        ["crafting-3x3"] = "crafting-table",
        ["3x3"] = "crafting-table",
        ["crafting-table"] = "crafting-table",

        inventory = "inventory-craft",
        inventorycraft = "inventory-craft",
        ["inv-craft"] = "inventory-craft",
        invcraft = "inventory-craft",
        inventorytable = "inventory-craft",
        ["inv-table"] = "inventory-craft",
        invtable = "inventory-craft",
        ["craft-2x2"] = "inventory-craft",
        ["crafting-2x2"] = "inventory-craft",
        ["2x2"] = "inventory-craft",
        ["ƒCƒ“ƒxƒ“ƒgƒŠ"] = "inventory-craft",
        ["inventory-craft"] = "inventory-craft",

        ["‚©‚Ü‚Ç"] = "furnace",
        ["¸˜B"] = "furnace",
        smelting = "furnace",
        furnace = "furnace",

        brewing = "brewing-stand",
        brewingstand = "brewing-stand",
        ["ø‘¢"] = "brewing-stand",
        ["ø‘¢‘ä"] = "brewing-stand",
        ["brewing-stand"] = "brewing-stand",

        ["‹@D‚è‹@"] = "loom",
        loom = "loom",

        ["ÎØ‘ä"] = "stonecutter",
        stonecutter = "stonecutter",

        ["‹à°"] = "anvil",
        ["C‘U"] = "anvil",
        repair = "anvil",
        ["repair-and-name"] = "anvil",
        anvil = "anvil",

        ["“uÎ"] = "grindstone",
        grindstone = "grindstone",

        villager = "trading",
        ["‘ºl"] = "trading",
        ["Žæˆø"] = "trading",
        trade = "trading",
        trading = "trading",

        ["trade-small"] = "trading-small",
        ["trading-small"] = "trading-small",

        smithing = "smithing-table",
        smithingtable = "smithing-table",
        ["new-smithing-table"] = "smithing-table",
        newsmithingtable = "smithing-table",
        upgrade = "smithing-table",
        ["upgrade-gear"] = "smithing-table",
        ["’b–è‘ä"] = "smithing-table",
        ["’b–è"] = "smithing-table",
        ["smithing-table"] = "smithing-table",

        oldsmithingtable = "legacy-smithing-table",
        ["old-smithing-table"] = "legacy-smithing-table",
        legacysmithingtable = "legacy-smithing-table",
        ["legacy-smithing-table"] = "legacy-smithing-table",
    }

    local key = string.gsub(string.lower(args[1]), " ", "-")

    local table_name = aliases[key]

    if not table_name then
        error("Module:Gui: '" .. args[1] .. "' has not found !!")
    end

    local args_p = {}
    for i, v in pairs(args) do
        if type(i) == "number" then
            if i ~= 1 then
                args_p[i - 1] = v
            end
        else
            args_p[i] = v
        end
    end

    if table_name == "crafting-table" then
        return p.CraftingTable(args_p)
    elseif table_name == "inventory-craft" then
        return p.InventoryTable(args_p)
    elseif table_name == "furnace" then
        return p.Furnace(args_p)
    elseif table_name == "brewing-stand" then
        return p.BrewingStand(args_p)
    elseif table_name == "loom" then
        return p.Loom(args_p)
    elseif table_name == "stonecutter" then
        return p.Stonecutter(args_p)
    elseif table_name == "anvil" then
        return p.Anvil(args_p)
    elseif table_name == "grindstone" then
        return p.Grindstone(args_p)
    elseif table_name == "trading" then
        return p.Trading(args_p)
    elseif table_name == "trading-small" then
        return p.TradingSmall(args_p)
    elseif table_name == "smithing-table" then
        return p.SmithingTable(args_p)
    elseif table_name == "legacy-smithing-table" then
        return p.LegacySmithingTable(args_p)
    end
end

function p.CraftingTable(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "crafting-table",
        width = 100,
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
            {
                x = 74,
                y = 14,
                large = true,
                amount = args.amount,
                value = args.output1 or args.target1 or args.output or args.target or args.slot10 or args[10]
            },
        },
        images = {
            { file = "GUI Crafting Table Arrow.png", x = 56, y = 20, width = 16, height = 13 }
        },
        shapeless = { isShapeless = args.shapeless, x = 91, y = 0 },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.InventoryTable(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "inventory-craft",
        width = 74,
        height = 36,
        scale = 2,
        slots = {
            { x = 0,  y = 0,  value = args.input1 or args.slot1 or args.A1 or args[1] },
            { x = 18, y = 0,  value = args.input2 or args.slot2 or args.B1 or args[2] },
            { x = 0,  y = 18, value = args.input3 or args.slot3 or args.A2 or args[3] },
            { x = 18, y = 18, value = args.input4 or args.slot4 or args.B2 or args[4] },
            {
                x = 56,
                y = 10,
                value = args.output1 or args.target1 or args.output or args.target or args.slot5 or args[5],
                amount = args.amount
            },
        },
        images = {
            { file = "GUI Crafting Table Arrow.png", x = 38, y = 12, width = 16, height = 13 }
        },
        shapeless = { isShapeless = args.shapeless, x = 65, y = 0 },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Furnace(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "furnace",
        width = 82,
        height = 54,
        scale = 2,
        slots = {
            { x = 0, y = 0,  value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 0, y = 36, value = args.input2 or args.fuel or args.slot2 or args[2] },
            {
                x = 56,
                y = 14,
                value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3],
                amount = args.amount,
                large = true,
            },
        },
        images = {
            { file = "GUI Furnace Fire.png",           x = 1,  y = 20, width = 15, height = 15 },
            { file = "GUI Furnace Arrow.png",          x = 25, y = 19, width = 22, height = 16 },
            { file = "GUI Furnace Progress Fire.png",  x = 1,  y = 20, width = 15, height = 15, reverse = true },
            { file = "GUI Furnace Progress Arrow.png", x = 25, y = 19, width = 22, height = 16, progress = "right" },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.BrewingStand(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local output1 = args.output1 or args.target1 or args.output or args.target or args.slot5 or args[5]
    local output2 = args.output2 or args.target2 or args.slot6 or args[6]
    local output3 = args.output3 or args.target3 or args.slot7 or args[7]
    local fuel = args.input5 or args.fuel or args.slot8 or args[8]

    local px = 0
    if fuel then
        px = px + 39
    end

    local gui = GuiUtils.new({
        name = "brewing-stand",
        width = 64 + px,
        height = 61,
        scale = 2,
        slots = {
            { x = 23 + px, y = 2,  value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 0 + px,  y = 36, value = args.input2 or args.bottle1 or args.slot2 or args[2], placeholder = "bottle" },
            { x = 23 + px, y = 43, value = args.input3 or args.bottle2 or args.slot3 or args[3], placeholder = "bottle" },
            { x = 46 + px, y = 36, value = args.input4 or args.bottle3 or args.slot4 or args[4], placeholder = "bottle" },
        },
        images = {
            { file = "GUI Brewing Stand Arrow.png",           x = 43 + px, y = 3,  width = 7,  height = 26 },
            { file = "GUI Brewing Stand Progress Arrow.png",  x = 43 + px, y = 3,  width = 7,  height = 26, progress = "down" },
            { file = "GUI Brewing Stand Bubble.png",          x = 8 + px,  y = 0,  width = 12, height = 29 },
            { file = "GUI Brewing Stand Progress Bubble.png", x = 8 + px,  y = 0,  width = 12, height = 29, duration = 0.5,   progress = "up" },
            { file = "GUI Brewing Stand Gauge Container.png", x = 4 + px,  y = 29, width = 20, height = 6 },
            {
                file = "GUI Brewing Stand Paths.png",
                x = 17 + px,
                y = 19,
                width = 30,
                height = 23,
                css = { ["z-index"] = "2" }
            },
        },
        gauges = {
            { file = "GUI Brewing Stand Gauge Full.png", x = 5 + px, y = 30, width = 18, height = 4, value = 10, max = 10, direction = "right" },
        },
        border = args.border,
        padding = args.padding,
    })

    if output1 or output2 or output3 then
        gui:setHeight(82)
            :insertImage({
                file = "GUI Brewing Stand Bottom Path.png",
                x = 7 + px,
                y = 53,
                width = 50,
                height = 12,
                css = { ["z-index"] = "2" },
            })
            :insertSlot({ x = 0 + px, y = 57, value = output1 })
            :insertSlot({ x = 23 + px, y = 64, value = output2 })
            :insertSlot({ x = 46 + px, y = 57, value = output3 })
    end

    if fuel then
        gui:insertImage({
            file = "GUI Brewing Stand Fuel Path.png",
            x = 17,
            y = 14,
            width = 27,
            height = 20,
            css = { ["z-index"] = "2" },
        })
            :insertSlot({
                x = 0,
                y = 0,
                value = fuel,
                placeholder = "blaze powder"
            })
    end

    return tostring(gui)
end

function p.Loom(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "loom",
        width = 103,
        height = 55,
        scale = 2,
        slots = {
            { x = 6,  y = 11, background = false, value = args.input1 or args.banner or args.slot1 or args[1],  placeholder = "Banner" },
            { x = 26, y = 11, background = false, value = args.input2 or args.dye or args.slot2 or args[2],     placeholder = "Dye" },
            { x = 16, y = 30, background = false, value = args.input3 or args.pattern or args.slot3 or args[3], placeholder = "Banner Pattern" },
            { x = 49, y = 6,  background = false, value = args.preview or args.slot4 or args[4] },
            {
                x = 77,
                y = 13,
                large = true,
                value = args.output1 or args.target1 or args.output or args.target or args.slot5 or args[5],
                amount = args.amount
            },
        },
        images = {
            { file = "GUI_Loom_Layout.png",       x = 0,  y = 0,  width = 50, height = 55 },
            { file = "GUI Loom Pattern Slot.png", x = 50, y = 7,  width = 16, height = 16 },
            { file = "GUI Loom Arrow.png",        x = 50, y = 18, width = 26, height = 15 }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Stonecutter(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local output = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3]
    local gui = GuiUtils.new({
        name = "stonecutter",
        width = 88,
        height = 56,
        scale = 2,
        slots = {
            { x = 0,  y = 18, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 21, y = 12, value = args.input2 or args.preview or args.slot2 or args[2] or output, amount = 1 },
            {
                x = 62,
                y = 13,
                value = output,
                amount = args.amount,
                large = true
            },
        },
        images = {
            { file = "GUI_Stonecutter_Layout.png", x = 21, y = 11, width = 40, height = 30 },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Anvil(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "anvil",
        width = 136,
        height = 52,
        scale = 2,
        slots = {
            { x = 0,  y = 34, value = args.input1 or args.slot1 or args[1] },
            { x = 46, y = 34, value = args.input2 or args.slot2 or args[2] },
            { x = 96, y = 34, value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3] },
        },
        text = {
            {
                x = 34,
                y = 12,
                height = 12,
                size = 20,
                color = "white",
                value = args.text1 or args.text or args[4],
                animate = true
            },
        },
        images = {
            { file = "GUI Anvil Hammer.png",         x = 0,  y = 0,  width = 30,  height = 30 },
            { file = "GUI Anvil Textbox.png",        x = 31, y = 10, width = 105, height = 16 },
            { file = "GUI Plus Icon.png",            x = 26, y = 36, width = 13,  height = 13 },
            { file = "GUI Crafting Table Arrow.png", x = 71, y = 36, width = 16,  height = 13 },
            { file = "GUI Anvil Title.png",          x = 31, y = 1,  width = 63,  height = 8 },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Grindstone(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "grindstone",
        width = 99,
        height = 54,
        scale = 2,
        slots = {
            { x = 18, y = 3,  value = args.input1 or args.slot1 or args[1] },
            { x = 18, y = 24, value = args.input2 or args.slot2 or args[2] },
            {
                x = 81,
                y = 18,
                value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3]
            },
        },
        images = {
            { file = "GUI Grindstone Layout.png", x = 0,  y = 0,  width = 54, height = 56 },
            { file = "GUI Furnace Arrow.png",     x = 56, y = 19, width = 22, height = 16 },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Trading(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "trading",
        width = 106,
        height = 26,
        scale = 2,
        slots = {
            { x = 0,  y = 3, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 26, y = 3, value = args.input2 or args.slot2 or args[2] },
            {
                x = 80,
                y = 0,
                amount = args.amount,
                value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3],
                large = true,
            },
        },
        images = {
            { file = "GUI Furnace Arrow.png", x = 51, y = 5, width = 22, height = 16 },
        },
        border = false,
        padding = false,
    })

    return tostring(gui)
end

function p.TradingSmall(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "trading-small",
        width = 88,
        height = 20,
        scale = 2,
        slots = {
            { x = 4,  y = 1, background = false, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 34, y = 1, background = false, value = args.input2 or args.slot2 or args[2] },
            { x = 67, y = 1, background = false, value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3], amount = args.amount },
        },
        images = {
            { file = "GUI Trading Small Base.png", x = 0, y = 0, width = 88, height = 20 }
        },
        border = false,
        padding = false,
    })

    return tostring(gui)
end

function p.SmithingTable(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "smithing-table",
        width = 96,
        height = 52,
        scale = 2,
        slots = {
            {
                x = 0,
                y = 34,
                value = args.input1 or args.slot1 or args[1],
                placeholder = "smithing template armor trim"
            },
            { x = 18, y = 34, value = args.input2 or args.slot2 or args[2] },
            { x = 36, y = 34, value = args.input3 or args.slot3 or args[3] },
            { x = 78, y = 34, value = args.output1 or args.target1 or args.output or args.target or args.slot4 or args[4] },
        },
        images = {
            { file = "GUI Smithing Table Hammer.png", x = 0,  y = 0,  width = 30, height = 30 },
            { file = "GUI Smithing Table Title.png",  x = 31, y = 11, width = 65, height = 8 },
            { file = "GUI Crafting Table Arrow.png",  x = 58, y = 36, width = 16, height = 13 },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.LegacySmithingTable(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "legacy-smithing-table",
        width = 96,
        height = 52,
        scale = 2,
        slots = {
            { x = 0,  y = 34, value = args.input1 or args.slot1 or args[1] },
            {
                x = 36,
                y = 34,
                value = args.input2 or args.slot2 or args[2],
                placeholder = "Netherite Ingot"
            },
            { x = 78, y = 34, value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3] },
        },
        images = {
            { file = "GUI Smithing Table Hammer.png", x = 0,  y = 0,  width = 30, height = 30 },
            { file = "GUI Smithing Table Title.png",  x = 31, y = 11, width = 65, height = 8 },
            { file = "GUI Plus Icon.png",             x = 20, y = 36, width = 13, height = 13 },
            { file = "GUI Crafting Table Arrow.png",  x = 58, y = 36, width = 16, height = 13 },
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.Chest(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "chest",
        width = 162,
        height = 65,
        scale = 2,
        images = {
            { file = "GUI Chest Title.png", x = 1, y = 0, width = 27, height = 7 },
        },
        border = args.border,
        padding = args.padding,
    })

    -- slots
    local chars = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I' }
    for y = 1, 3 do
        for x, v in ipairs(chars) do
            local idx = ((y - 1) * 9) + x
            gui:insertSlot({
                x = (x - 1) * 18,
                y = 11 + (y - 1) * 18,
                value = args[v .. tostring(y)] or args["slot" .. tostring(idx)] or args[idx]
            })
        end
    end

    return tostring(gui)
end

function p.EnderChest(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "ender-chest",
        width = 162,
        height = 65,
        scale = 2,
        images = {
            { file = "GUI Ender Chest Title.png", x = 1, y = 0, width = 61, height = 7 },
        },
        border = args.border,
        padding = args.padding,
    })

    -- slots
    local chars = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I' }
    for y = 1, 3 do
        for x, v in ipairs(chars) do
            local idx = ((y - 1) * 9) + x
            gui:insertSlot({
                x = (x - 1) * 18,
                y = 11 + (y - 1) * 18,
                value = args[v .. tostring(y)] or args["slot" .. tostring(idx)] or args[idx]
            })
        end
    end

    return tostring(gui)
end

function p.LargeChest(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "large-chest",
        width = 162,
        height = 119,
        scale = 2,
        images = {
            { file = "GUI Large Chest Title.png", x = 1, y = 0, width = 61, height = 8 },
        },
        border = args.border,
        padding = args.padding,
    })

    -- slots
    local chars = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I' }
    for y = 1, 6 do
        for x, v in ipairs(chars) do
            local idx = ((y - 1) * 9) + x
            gui:insertSlot({
                x = (x - 1) * 18,
                y = 11 + (y - 1) * 18,
                value = args[v .. tostring(y)] or args["slot" .. tostring(idx)] or args[idx]
            })
        end
    end

    return tostring(gui)
end

function p.Hotbar(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "hotbar",
        height = 24,
        width = 184,
        background = false,
        border = false,
        padding = false,
    })

    local offhand = args.offhand or args.slot10 or args[10]
    local side = string.lower(args.side or "")

    local px = 0
    if side == "r" or side == "right" then
        gui:setWidth(212)
            :insertImage({ x = 190, y = 1, width = 22, height = 22, file = "GUI Hotbar offhand right.png" })
            :insertSlot({ x = 192, y = 3, value = offhand, background = false })
    elseif offhand or side == "l" or side == "left" then
        px = 28
        gui:setWidth(212)
            :insertImage({ x = 0, y = 1, width = 22, height = 22, file = "GUI Hotbar offhand left.png" })
            :insertSlot({ x = 2, y = 3, value = offhand, background = false })
    end

    -- hotbar
    gui:insertImage({ x = 1 + px, y = 1, width = 182, height = 22, file = "GUI Hotbar base.png" })
    for i = 1, 9 do
        gui:insertSlot({
            x = 3 + (i - 1) * 20 + px,
            y = 3,
            value = args["slot" .. tostring(i)] or args[i],
            background = false
        })
    end

    -- selected
    local selected = tonumber(args.selected) or tonumber(args.select)
    if selected and selected >= 1 and selected <= 9 then
        selected = math.floor(selected)
        gui:insertImage({ x = (selected - 1) * 20 + px, y = 0, width = 24, height = 24, file = "GUI Hotbar selected.png", css = { ["z-index"] = 2 } })
    end

    return tostring(gui)
end

function p.CompoundCreator(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "compound-creator",
        width = 124,
        height = 68,
        scale = 2,
        slots = {
            { x = 22, y = 9,  value = args.input1 or args.input or args.slot1 or args.A1 or args[1] },
            { x = 40, y = 9,  value = args.input2 or args.slot2 or args.B1 or args[2] },
            { x = 58, y = 9,  value = args.input3 or args.slot3 or args.C1 or args[3] },
            { x = 22, y = 27, value = args.input4 or args.slot4 or args.A2 or args[4] },
            { x = 40, y = 27, value = args.input5 or args.slot5 or args.B2 or args[5] },
            { x = 58, y = 27, value = args.input6 or args.slot6 or args.C2 or args[6] },
            { x = 22, y = 45, value = args.input7 or args.slot7 or args.A3 or args[7] },
            { x = 40, y = 45, value = args.input8 or args.slot8 or args.B3 or args[8] },
            { x = 58, y = 45, value = args.input9 or args.slot9 or args.C3 or args[9] },
            {
                x = 106,
                y = 27,
                amount = args.amount,
                value = args.output1 or args.target1 or args.output or args.target or args.slot10 or args[10]
            },
        },
        images = {
            { file = "GUI Compound Creator Base.png", x = 0,  y = 0,  width = 84, height = 68 },
            { file = "GUI Compound Creator Path.png", x = 81, y = 32, width = 26, height = 6, css = { ["z-index"] = "2" } },
        },
        border = args.border,
        padding = args.padding,
    })
    return tostring(gui)
end

function p.LabTable(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "lab-table",
        height = 18,
        scale = 2,
        border = args.border,
        padding = args.padding,
    })

    -- slots
    local slotItems = {}
    for i = 1, 9 do
        local value
        if i == 1 then
            value = args.input1 or args.input or args.slot1 or args[1]
        else
            value = args["input" .. tostring(i)] or args["slot" .. tostring(i)] or args[i]
        end

        if value then
            table.insert(slotItems, value)
        end
    end

    -- input slots
    local valueLength = #slotItems
    local slotLength  = math.max(6, valueLength)
    local width       = slotLength * 18
    gui:setWidth(width)

    for i = 1, slotLength do
        gui:insertSlot({ x = (i - 1) * 18, y = 0, amount = 1 })
    end

    if valueLength > 0 then
        local slotStartPos = 1
        if valueLength == 1 or valueLength == 2 then
            slotStartPos = 3
        elseif valueLength == 3 or valueLength == 4 then
            slotStartPos = 2
        end

        for i = 1, valueLength do
            gui:changeSlot({ value = slotItems[i] }, i + slotStartPos - 1)
        end
    end

    -- output slots
    local output = args.output1 or args.target1 or args.output or args.target or args.slot10 or args[10]
    if output then
        gui:setHeight(41)
            :insertSlot({ x = width / 2 - 9, y = 23, value = output, amount = args.amount })
    end

    return tostring(gui)
end

return p
