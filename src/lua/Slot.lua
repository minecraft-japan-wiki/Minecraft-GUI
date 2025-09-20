local p = {}
local h = {}

local jsprite = require('Module:JSprite')
local aliases = require('Module:Slot/aliases')
local l10n = require('Module:SpriteLink')

local ENABLE_LOCALIZATION = true

local function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

local function trim(s)
    return (s:gsub('^[\t\r\n\f ]+', ''):gsub('[\t\r\n\f ]+$', ''))
end

local function getSprite(slot, args)
    local frame = mw.getCurrentFrame()
    slot = mw.text.trim(slot or '')

    if slot ~= 'blank' and slot ~= '' then
        if mw.ustring.match(slot, "[%w%s'(),:]+") == slot then
            local sprite = { args = args or {} }
            local sprite_other = string.find(slot, ":")
            local isPotion = false -- string.find(string.lower(slot), "potion of")

            if sprite_other or isPotion then
                if sprite_other then
                    sprite.title = string.sub(slot, 1, sprite_other - 1)
                    sprite.args[1] = string.sub(slot, sprite_other + 1)
                else
                    sprite.title = "EnchantSprite"
                    sprite.args[1] = slot
                end

                if not mw.title.new("Template:" .. sprite.title).exists and mw.title.new("Template:" .. sprite.title .. "Sprite").exists then
                    sprite.title = sprite.title .. "Sprite"
                end

                local id, l10n, link = l10n.getLinkAndTitle(sprite.title or "InvSprite", sprite.args[1])
                if id and l10n then
                    sprite.args["title"] = sprite.args["title"] or l10n
                    sprite.args["link"] = sprite.args["link"] or link
                end
                slot = tostring(frame:expandTemplate(sprite))
            else
                sprite.args[1] = slot
                sprite.args.sheet = "InvSprite"

                if ENABLE_LOCALIZATION then
                    local id, l10n, link = l10n.getLinkAndTitle(sprite.title or "InvSprite", slot)
                    if id and l10n then
                        sprite.args["title"] = sprite.args["title"] or l10n
                        sprite.args["link"] = sprite.args["link"] or link
                    end
                end

                slot = tostring(jsprite.base(sprite.args))
            end
        end
    else
        slot = ''
    end

    return slot
end

local function getSpriteWithAmount(slot, n, args)
    local amount = tonumber(n) or 1
    if type(slot) == "string" then
        if string.match(slot, '^.+%*%-?%d+$') then
            local tmp = split(slot, "*")
            if #tmp == 2 then
                slot = tmp[1]
                amount = tonumber(tmp[2]) or 1
            end
        end

        return { getSprite(slot, args), amount }
    elseif type(slot) == "table" then
        local name = slot["name"]
        slot["name"] = nil
        if slot["amount"] ~= nil then
            amount = tonumber(slot["amount"]) or amount
            slot["amount"] = nil
        end

        if type(name) == "string" then
            return getSpriteWithAmount(name, amount, slot)
        end
    end

    return { "", amount }
end

function p.getSprite(slot, n, args)
    return getSpriteWithAmount(slot, n, args)
end

function p.getAlias(id)
    local sprite_other = string.find(id, ":")
    local spriteTitle
    if sprite_other then
        spriteTitle = string.sub(id, 1, sprite_other - 1)
        id = string.sub(id, sprite_other + 1)
    end

    local alias
    if spriteTitle then
        alias = aliases[spriteTitle .. ":" .. id]
    else
        alias = aliases[id]
    end

    if alias then
        return alias
    else
        id = mw.ustring.lower(id)
        if spriteTitle then
            alias = aliases[spriteTitle .. ":" .. id]
        else
            alias = aliases[id]
        end

        if alias then
            return alias
        else
            id = mw.ustring.gsub(id, " ", "-")
            if spriteTitle then
                alias = aliases[spriteTitle .. ":" .. id]
            else
                alias = aliases[id]
            end

            if alias then
                return alias
            end
        end
    end
end

function p.getSprites(slots, n)
    local splitText = p.splitSlotText(slots)
    local ret = {}

    for _, v in ipairs(splitText) do
        if v == "" then
            table.insert(ret, { v, 1 })
        else
            table.insert(ret, getSpriteWithAmount(v, n))
        end
    end

    return ret
end

function p.splitSlotText(slots)
    local ret = {}

    local function setAlias(tbl, key)
        local alias = p.getAlias(key)
        if type(alias) == "table" then
            for _, w in ipairs(alias) do
                table.insert(tbl, w)
            end
        else
            table.insert(tbl, key)
        end
    end

    if type(slots) == "string" then
        if not slots:match("<.*>") and string.find(slots, ";") then
            local items = mw.text.split(slots, ";")
            for i, v in pairs(items) do
                v = trim(v)
                setAlias(ret, v)
            end
        else
            setAlias(ret, slots)
        end
    elseif type(slots) == "table" then
        for _, v in ipairs(slots) do
            if type(v) == "string" then
                setAlias(ret, v)
            else
                table.insert(ret, "")
            end
        end
    end

    return ret
end

return p
