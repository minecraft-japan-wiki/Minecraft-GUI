local p = {}
local GuiUtils = require("Module:Gui")

function p.PureDaisy(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "botania-pure-daisy",
        width = 74,
        height = 44,
        scale = 2,
        slots = {
            { x = 0,  y = 14, value = args.input1 or args.input or args.slot1 or args[1],                                  background = false },
            { x = 58, y = 14, value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2], background = false },
            { x = 29, y = 14, value = args.input2 or args.flower or args.slot3 or args[3] or "Botania:Pure Daisy",         background = false },
        },
        images = {
            { x = 6, y = 0, width = 65, height = 44, file = "GUI Botania Flower.png" }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.ManaInfusion(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local manaValue = tonumber(args.mana) or tonumber(args.energy) or tonumber(args[5]) or 0
    local maxManaValue = tonumber(args.maxmana) or tonumber(args.maxenergy)
    if maxManaValue == nil then
        maxManaValue = 10000
        if manaValue < 0 then
            manaValue = 0
        elseif manaValue >= 10000 then
            maxManaValue = 100000
        elseif manaValue > 100000 then
            maxManaValue = 100000
        end
    end

    local gui = GuiUtils.new({
        name = "botania-infusion",
        width = 102,
        height = 54,
        scale = 2,
        slots = {
            { x = 23, y = 14, value = args.input1 or args.input or args.slot1 or args[1],                                  background = false },
            { x = 81, y = 14, value = args.output1 or args.target1 or args.output or args.target or args.slot2 or args[2], background = false },
            { x = 3,  y = 14, value = args.input2 or args.catalyst or args.slot3 or args[3],                               background = false },
            { x = 52, y = 14, value = args.manapool or args.slot4 or args[4] or "Botania:Mana Pool (Full)",                background = false },
        },
        images = {
            { x = 29, y = 0,  width = 65,  height = 44, file = "GUI Botania Flower.png" },
            { x = 0,  y = 49, width = 102, height = 5,  file = "GUI Botania Mana Gauge Empty.png" }
        },
        gauges = {
            {
                x = 1,
                y = 50,
                width = 100,
                height = 3,
                file = "GUI Botania Mana Gauge.png",
                value = manaValue,
                max = maxManaValue,
                -- args.unit or "Mana"
                direction = "right"
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.PetalApothecary(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local inputValues = {}
    for i = 1, 16 do
        local inputValue
        if i == 1 then
            inputValue = args.input1 or args.input or args.slot1 or args[1]
        else
            inputValue = args["input" .. tostring(i)] or args["slot" .. tostring(i)] or args[i]
        end
        if inputValue then
            table.insert(inputValues, inputValue)
        end
    end

    local gui = GuiUtils.new({
        name = "botania-petal",
        width = 102,
        height = 98,
        scale = 2,
        images = {
            { x = 10, y = 7, width = 85, height = 82, file = "GUI Botania Petal Overlay.png" },
        },
        border = args.border,
        padding = args.padding,
    })

    -- input slot
    local inputValueLength = #inputValues
    if inputValueLength > 0 then
        local r = 360 / inputValueLength
        for i = 1, inputValueLength do
            local theta = math.rad(-r * (i - 1) - 90)
            gui:insertSlot({
                x = math.floor(42 + (32 * math.cos(theta)) - 9),
                y = math.floor(57 - (32 * math.sin(theta)) - 9),
                value = inputValues[i],
                background = false
            })
        end
    end

    -- output slot
    gui
        :insertSlot({
            x = 71,
            y = 13,
            value = args.output1 or args.target1 or args.output or args.target or args.slot17 or args[17],
            background = false
        })
        :insertSlot({
            x = 33,
            y = 48,
            value = args.apothecary or "Botania:Petal Apothecary",
            background = false
        })

    return tostring(gui)
end

function p.RunicAltar(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    -- mana gauge
    local manaValue = tonumber(args.mana) or tonumber(args.energy) or tonumber(args[18]) or 0
    local maxManaValue = tonumber(args.maxmana) or tonumber(args.maxenergy)
    if maxManaValue == nil then
        maxManaValue = 10000
        if manaValue < 0 then
            manaValue = 0
        elseif manaValue >= 10000 then
            maxManaValue = 100000
        elseif manaValue > 100000 then
            maxManaValue = 100000
        end
    end

    -- ipnut values
    local inputValues = {}
    for i = 1, 16 do
        local inputValue
        if i == 1 then
            inputValue = args.input1 or args.input or args.slot1 or args[1]
        else
            inputValue = args["input" .. tostring(i)] or args["slot" .. tostring(i)] or args[i]
        end
        if inputValue then
            table.insert(inputValues, inputValue)
        end
    end

    -- gui
    local gui = GuiUtils.new({
        name = "botania-runic-altar",
        width = 102,
        height = 108,
        scale = 2,
        images = {
            { x = 10, y = 7,   width = 85,  height = 82, file = "GUI Botania Petal Overlay.png" },
            { x = 0,  y = 103, width = 102, height = 5,  file = "GUI Botania Mana Gauge Empty.png" }
        },
        gauges = {
            {
                x = 1,
                y = 104,
                width = 100,
                height = 3,
                file = "GUI Botania Mana Gauge.png",
                value = manaValue,
                max = maxManaValue,
                -- args.unit or "Mana"
                direction = "right"
            }
        },
        border = args.border,
        padding = args.padding,
    })

    -- input slot
    local inputValueLength = #inputValues
    if inputValueLength > 0 then
        local r = 360 / inputValueLength
        for i = 1, inputValueLength do
            local theta = math.rad(-r * (i - 1) - 90)
            gui:insertSlot({
                x = math.floor(42 + (32 * math.cos(theta)) - 9),
                y = math.floor(57 - (32 * math.sin(theta)) - 9),
                value = inputValues[i],
                background = false
            })
        end
    end

    -- output slot
    gui
        :insertSlot({
            x = 71,
            y = 13,
            value = args.output1 or args.target1 or args.output or args.target or args.slot17 or args[17],
            background = false
        })
        :insertSlot({
            x = 33,
            y = 48,
            value = args.apothecary or "Botania:Runic Altar",
            background = false
        })

    return tostring(gui)
end

function p.ElvenTrade(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "botania-elven-trade",
        width = 89,
        height = 83,
        scale = 2,
        slots = {
            { x = 22, y = 0,  background = false, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 40, y = 0,  background = false, value = args.input2 or args.slot2 or args[2] },
            { x = 71, y = 41, background = false, value = args.output1 or args.target1 or args.output or args.target or args.slot3 or args[3] }
        },
        images = {
            { x = 0, y = 8,  width = 71, height = 75, file = "GUI Botania Elven Trade Overlay.png" },
            { x = 2, y = 25, width = 48, height = 48, file = "GUI Botania Elven Trade Swirl.png" }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.TerrestrialAgglomeration(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local gui = GuiUtils.new({
        name = "botania-terrasteel",
        width = 102,
        height = 126,
        scale = 2,
        slots = {
            { x = 42, y = 0,  background = false, value = args.input1 or args.input or args.slot1 or args[1] },
            { x = 70, y = 48, background = false, value = args.input2 or args.slot2 or args[2] },
            { x = 14, y = 48, background = false, value = args.input3 or args.slot3 or args[3] },
            { x = 42, y = 32, background = false, value = args.output1 or args.target1 or args.output or args.target or args.slot4 or args[4] }
        },
        images = {
            { x = 19, y = 9,   width = 64,  height = 64, file = "GUI Botania Terrasteel Overlay.png" },
            { x = 30, y = 89,  width = 41,  height = 29, file = "GUI Botania Terrasteel Structure.png" },
            { x = 0,  y = 121, width = 102, height = 5,  file = "GUI Botania Mana Gauge Empty.png" }
        },
        gauges = {
            {
                x = 1,
                y = 122,
                width = 100,
                height = 3,
                file = "GUI Botania Mana Gauge.png",
                value = tonumber(args.mana) or tonumber(args.energy) or tonumber(args[5]) or 500000,
                max = tonumber(args.maxmana) or tonumber(args.maxenergy) or 500000,
                -- args.unit or "Mana"
                direction = "right"
            }
        },
        border = args.border,
        padding = args.padding,
    })

    return tostring(gui)
end

function p.BotanicalBrewery(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    -- mana gauge
    local manaValue = tonumber(args.mana) or tonumber(args.energy) or tonumber(args[9]) or 0
    local maxManaValue = tonumber(args.maxmana) or tonumber(args.maxenergy)
    if maxManaValue == nil then
        maxManaValue = 10000
        if manaValue < 0 then
            manaValue = 0
        elseif manaValue >= 10000 then
            maxManaValue = 100000
        elseif manaValue > 100000 then
            maxManaValue = 100000
        end
    end

    -- input value
    local inputValues = {}
    for i = 1, 6 do
        local inputValue
        if i == 1 then
            inputValue = args.input1 or args.input or args.slot1 or args[1]
        else
            inputValue = args["input" .. tostring(i)] or args["slot" .. tostring(i)] or args[i]
        end
        if inputValue then
            table.insert(inputValues, inputValue)
        end
    end

    -- gui
    local gui = GuiUtils.new({
        name = "botania-brewery",
        width = 108,
        height = 62,
        scale = 2,
        images = {
            { x = 28, y = 35, width = 22,  height = 15, file = "GUI Botania Botanical Brewery Right Arrow.png" },
            { x = 55, y = 18, width = 15,  height = 14, file = "GUI Botania Botanical Brewery Down Arrow.png" },
            { x = 3,  y = 57, width = 102, height = 5,  file = "GUI Botania Mana Gauge Empty.png" }
        },
        gauges = {
            {
                x = 4,
                y = 58,
                width = 100,
                height = 3,
                file = "GUI Botania Mana Gauge.png",
                value = manaValue,
                max = maxManaValue,
                -- args.unit or "Mana"
                direction = "right"
            }
        },
        border = args.border,
        padding = args.padding,
    })

    -- slots
    local inputValueLength = #inputValues
    local startPos = 54 - ((inputValueLength - 1) * 9)

    for i = 1, inputValueLength do
        gui:insertSlot({
            x = startPos + ((i - 1) * 18),
            y = 0,
            value = inputValues[i],
            background = false,
        })
    end

    -- output slots
    gui
        :insertSlot({
            x = 6,
            y = 34,
            value = args.input7 or args.bottle1 or args.bottle or args.slot7 or args[7]
        })
        :insertSlot({
            x = 54,
            y = 34,
            value = args.output1 or args.target1 or args.output or args.target or args.slot8 or args[8]
        })

    return tostring(gui)
end

return p
