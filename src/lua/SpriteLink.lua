local p = {}

local tableUtil = require("Module:TableUtil")

local function arrayHas(array, val)
    if type(array) ~= "table" then return nil end
    for _, v in ipairs(array) do
        if v == val then
            return true
        end
    end
    return false
end

local function searchList(k, list)
    local properties = {}

    if list then
        local t = list[k] or list[mw.ustring.lower(k)] or list[mw.ustring.lower(k):gsub('[%s%+]', '-')]
        if t then
            if type(t) == "table" then
                if type(t.rarity) == "string" then properties.rarity = t.rarity end
                if type(t.title) == "string" then properties.title = t.title end
                if type(t.description) == "string" then properties.description = t.description end

                if t.text then
                    return k, t.text, t.link or t.text, properties
                end
            elseif type(t) == "string" then
                return k, t, t, properties
            end
        end

        for i, v in pairs(list) do
            if type(v) == "table" then
                if type(v.rarity) == "string" then properties.rarity = v.rarity end
                if type(v.title) == "string" then properties.title = v.title end
                if type(v.description) == "string" then properties.description = v.description end

                if type(v.key) == "string" and v.key == k and v.text then
                    return i, v.text, v.link or v.text, properties
                elseif type(v.key) == "table" and arrayHas(v.key, k) and v.text then
                    return i, v.text, v.link or v.text, properties
                end
            elseif type(v) == "string" then
                if v == k then
                    return i, v, v, properties
                end
            end
        end
    end
end

local function searchMultipleList(key, ...)
    local tables = { ... }
    local id, l10n, link, properties
    for _, t in ipairs(tables) do
        id, l10n, link, properties = searchList(key, t)
        if id then break end
    end
    return id, l10n, link, properties
end

function p.getLinkAndTitle(sheet, key, option)
    local id, l10n, link, properties
    if not option then option = {} end
    if sheet == "ItemSprite" or sheet == "Item" then
        local lang = mw.loadData("Module:SpriteLink/Item")
        id, l10n, link, properties = searchMultipleList(key, lang.General, lang.Item)
    elseif sheet == "BlockSprite" or sheet == "Block" then
        local lang = mw.loadData("Module:SpriteLink/Block")
        id, l10n, link, properties = searchMultipleList(key, lang.General, lang.Block)
    elseif sheet == "InvSprite" or sheet == "Inv" then
        local langBlock = mw.loadData("Module:SpriteLink/Block")
        local langItem = mw.loadData("Module:SpriteLink/Item")
        id, l10n, link, properties = searchMultipleList(key, langBlock.General, langBlock.Inv, langItem.General,
            langItem.Inv)
    elseif sheet == "EntitySprite" or sheet == "Entity" then
        local lang = mw.loadData("Module:SpriteLink/Entity")
        id, l10n, link, properties = searchList(key, lang)
    elseif sheet == "BiomeSprite" or sheet == "Biome" then
        local lang = mw.loadData("Module:SpriteLink/Biome")
        id, l10n, link, properties = searchList(key, lang)
    elseif sheet == "EffectSprite" or sheet == "Effect" then
        local lang = mw.loadData("Module:SpriteLink/Effect")
        id, l10n, link, properties = searchList(key, lang)
    elseif sheet == "EnvSprite" or sheet == "Env" then
        local lang = mw.loadData("Module:SpriteLink/Env")
        id, l10n, link, properties = searchList(key, lang)
    elseif type(sheet) == "string" then
        local match = mw.ustring.match(sheet, "(.*)Sprite")
        if not match then
            match = sheet
        end
        local res, lang = pcall(mw.loadData, "Module:SpriteLink/" .. match)
        if res and type(lang) == "table" then
            id, l10n, link, properties = searchList(key, lang.localization)
            if option and lang["link-prefix"] then
                option["link-prefix"] = option["link-prefix"] or lang["link-prefix"]
            end
            if option and lang["link-suffix"] then
                option["link-suffix"] = option["link-suffix"] or lang["link-suffix"]
            end
        else
            local title = mw.title.makeTitle("Template", match .. "Sprite")
            if title.exists and title.redirectTarget then
                return p.getLinkAndTitle(title.redirectTarget.text, key)
            end
        end
    end

    if link and option["link-prefix"] then
        link = option["link-prefix"] .. link
    end
    if link and option["link-suffix"] then
        link = link .. option["link-suffix"]
    end
    if link then
        if properties then
            properties.link = link
        else
            properties = { link = link }
        end
    end

    return id, l10n, properties
end

function p.base(f)
    local args = f
    if f == mw.getCurrentFrame() then
        args = require('Module:ProcessArgs').merge(true)
    else
        f = mw.getCurrentFrame()
    end

    local sheet = args.sheet or "BlockSprite"
    local key = args[1]

    if key then
        local k, v, p = p.getLinkAndTitle(sheet, key, {
            ["link-prefix"] = args["link-prefix"],
            ["link-suffix"] = args["link-suffix"]
        })
        if not p then p = {} end

        if k and v then
            args[1] = args.id or k
            args.text = args.text or args[2] or v
            args.link = args.link or args[3] or p.link or v
            if args.notip == nil then
                args.notip = "1"
            end
            args.rarity = args.rarity or p.rarity
        else
            args.notip = "1"
            args[1] = args.id or args[1] or "blank"
            args.text = args.text or args[2] or key
            args.link = args.link or args[3] or key
            args.rarity = args.rarity or p.rarity
        end
    else
        args[1] = args.id or args[1] or "blank"
        args.text = args.text or args[2] or args[1]
        args.link = args.link or args[3] or args[1]
        args.rarity = args.rarity or p.rarity
    end

    return tostring(f:expandTemplate { title = sheet, args = args })
end

return p
