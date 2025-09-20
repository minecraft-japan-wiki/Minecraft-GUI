local p = {}
local t = {}
local GUI_METATABLE = {}
local IS_STACK_SIZE_TEXT = false

local slotUtils = require("Module:Slot/utils")
local animate = require('Module:AnimateFrame')


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

local function nonNilValues(default, ...)
    for _, v in ipairs({ ... }) do
        if v ~= nil then
            return v
        end
    end
    return default
end



------ generate sprite -------
function t.generateSlot(slot, config)
    config = config or {}
    local sub = mw.html.create("span")
    -- amount
    local amount = config.amount

    -- scale
    local scale = tonumber(config.scale) or 2

    -- placeholder (slot icon)
    if config.placeholder then
        local placeholder
        if config.showPlaceholder then
            placeholder = slotUtils.getSprite("SlotSprite:" .. config.placeholder)[1]
        elseif (not config.showPlaceholder) and (not slot) then
            placeholder = slotUtils.getSprite("SlotSprite:" .. config.placeholder)[1]
        end

        if placeholder then
            sub:tag("span")
                :addClass("mjwgui-placeholder")
                :wikitext(placeholder)
        end
    end

    -- show sprite
    if slot then
        sub:wikitext(slot)

        if amount ~= 1 or config.showStacksize then
            local sub_overlay = sub:tag("span")
            sub_overlay:addClass('mjwgui-slot-nfr')

            local num_len = string.len(tostring(amount))

            for j = 1, num_len, 1 do
                local chr = string.sub(tostring(amount), j, j)
                local num = tonumber(chr) or 10
                local overlay_num = sub_overlay:tag("span")
                overlay_num:addClass('mjwgui-slot-stacksize')
                if IS_STACK_SIZE_TEXT then
                    overlay_num:wikitext(num)
                    if amount < 1 then
                        overlay_num:addClass('mjwgui-slot-stacksize--negative')
                    end
                else
                    overlay_num
                        :addClass("mjwgui-slot-stacksize-num")
                        :css("background-position", "-" .. tostring(num * 12) .. "px -0px")
                end
            end
        end
    end


    -- large
    if config.large then
        local largeSub = mw.html.create("span")
            :addClass("mjwgui-slot")
            :addClass("mjwgui-slot--large")
            :node(sub:addClass("mjwgui-slot--inner"))

        -- nobg
        if not nonNilValues(true, config.background) then
            largeSub:addClass("mjwgui-slot--nobg")
        end

        -- position
        if type(config.x) == "number" and config.x ~= 0 then
            largeSub:css("left", tostring(config.x * scale) .. "px")
        end
        if type(config.y) == "number" and config.y ~= 0 then
            largeSub:css("top", tostring(config.y * scale) .. "px")
        end

        -- css
        if config.css then
            largeSub:css(config.css)
        end

        return largeSub
    else
        sub:addClass("mjwgui-slot")

        --nobg
        if not nonNilValues(true, config.background) then
            sub:addClass("mjwgui-slot--nobg")
        end

        -- position
        if type(config.x) == "number" and config.x ~= 0 then
            sub:css("left", tostring(config.x * scale) .. "px")
        end
        if type(config.y) == "number" and config.y ~= 0 then
            sub:css("top", tostring(config.y * scale) .. "px")
        end

        -- css
        if config.css then
            sub:css(config.css)
        end

        return sub
    end
end

------ generate tank -------
function t.generateTank(slot, config)
    config = config or {}
    local sub = mw.html.create("span")

    -- amount
    local amount = tonumber(config.amount) or 1
    local max = tonumber(config.max) or amount
    local currentProgress = 0
    if max ~= 0 then
        currentProgress = math.floor((amount / max) * 100)
        if currentProgress > 100 then
            currentProgress = 1
        elseif currentProgress < 0 then
            currentProgress = 0
        end
    end

    -- scale
    local scale = tonumber(config.scale) or 2

    -- nobg
    sub:addClass("mjwgui-tank")
    if not nonNilValues(true, config.background) then
        sub:addClass("mjwgui-tank--nobg")
    end

    -- tank inner
    local direction = config.direction
    local fluid = sub:tag("span"):addClass("mjwgui-tank-inner")


    if direction == "right" then
        fluid
            :addClass("mjwgui-tank--right")
            :css("width", tostring(currentProgress) .. "%")
    elseif direction == "down" then
        fluid
            :addClass("mjwgui-tank--down")
            :css("height", tostring(currentProgress) .. "%")
    elseif direction == "left" then
        fluid
            :addClass("mjwgui-tank--left")
            :css("width", tostring(currentProgress) .. "%")
    else -- up
        fluid
            :addClass("mjwgui-tank--up")
            :css("height", tostring(currentProgress) .. "%")
    end

    -- tank sprite
    local sprite = sub:tag("span"):addClass("mjwgui-tank-item")
    if slot then
        sprite:wikitext(slot)
    end

    -- size
    if type(config.width) == "number" and config.width >= 0 then
        sub:css("width", tostring(config.width * scale) .. "px")
    end
    if type(config.height) == "number" and config.height >= 0 then
        sub:css("height", tostring(config.height * scale) .. "px")
    end

    -- position
    if type(config.x) == "number" and config.x ~= 0 then
        sub:css("left", tostring(config.x * scale) .. "px")
    end
    if type(config.y) == "number" and config.y ~= 0 then
        sub:css("top", tostring(config.y * scale) .. "px")
    end

    -- css
    if config.css then
        sub:css(config.css)
    end

    return sub
end

------ generate text -------
function t.generateText(text, config)
    config = config or {}
    local sub = mw.html.create("span")
        :addClass("mjwgui-text")

    -- scale
    local scale = tonumber(config.scale) or 2

    -- decoration
    local isMinetext = false
    local function setMineText()
        if not isMinetext then
            sub:addClass("minecraft-text")
            isMinetext = true
        end
    end

    if config.color then
        setMineText()
        sub:addClass("minecraft-text-" .. config.color)
    end
    if config.bold then
        setMineText()
        sub:addClass("minecraft-text-bold")
    end
    if config.strike then
        setMineText()
        sub:addClass("minecraft-text-strike")
    end
    if config.underline then
        setMineText()
        sub:addClass("minecraft-text-underline")
    end
    if config.obfuscated then
        setMineText()
        sub:addClass("minecraft-text-obfuscated")
    end

    -- position
    if type(config.x) == "number" and config.x ~= 0 then
        sub:css("left", tostring(config.x * scale) .. "px")
    end
    if type(config.y) == "number" and config.y ~= 0 then
        sub:css("top", tostring(config.y * scale) .. "px")
    end

    -- line height
    if type(config.height) == "number" then
        if config.height > 0 then
            sub:css("line-height", tostring(config.height * scale) .. "px")
        end
    elseif type(config.size) == "number" then
        if config.size > 0 then
            sub:css("line-height", tostring(config.size) .. "px")
        end
    end

    -- size
    local fontsize = config.size
    if type(fontsize) == "number" then
        fontsize = tostring(fontsize) .. "px"
    end
    if type(fontsize) == "string" then
        sub:css("font-size", fontsize)
    end

    -- css
    if config.css then
        sub:css(config.css)
    end

    --text
    local str = text
    if type(config.prefix) == "string" and string.len(text) > 0 then
        str = config.prefix .. str
    end
    if type(config.suffix) == "string" and string.len(text) > 0 then
        str = str .. config.suffix
    end
    sub:wikitext(str)

    return sub
end

------ generate gauge -------
function t.generateGauge(value, maxValue, config)
    local frame = mw.getCurrentFrame()
    config = config or {}
    local sub = mw.html.create("span")
        :addClass("mjwgui-gauge")

    -- scale
    local scale = tonumber(config.scale) or 2

    -- size
    local width = (tonumber(config.width) or 0) * scale
    local height = (tonumber(config.height) or 0) * scale
    if width > 0 then
        sub:css("width", tostring(width) .. "px")
    end
    if height > 0 then
        sub:css("height", tostring(height) .. "px")
    end

    -- position
    if type(config.x) == "number" and config.x ~= 0 then
        sub:css("left", tostring(config.x * scale) .. "px")
    end
    if type(config.y) == "number" and config.y ~= 0 then
        sub:css("top", tostring(config.y * scale) .. "px")
    end

    -- inner
    local fluid = sub:tag("span"):addClass("mjwgui-gauge-item")

    -- image
    local imageSize = ""
    if width > 0 then
        imageSize = imageSize .. tostring(width)
    end
    if height > 0 then
        imageSize = imageSize .. "x" .. tostring(height)
    end
    if string.len(imageSize) > 0 then
        imageSize = imageSize .. "px"
    end
    fluid:wikitext(frame:preprocess("[[File:" .. config.file .. "|link=|alt=|" .. imageSize .. "]]"))

    -- repeat
    if config["repeat"] then
        fluid:addClass("mjwgui-gauge--repeat")
    end

    -- progress
    local volume = tonumber(value) or 0
    local maxVolume = tonumber(maxValue) or tonumber(config.max) or 0
    local currentProgress = 1
    if maxVolume == 0 then
        currentProgress = 1
    else
        currentProgress = volume / maxVolume
    end

    if currentProgress > 1 then currentProgress = 1 end
    if currentProgress < 0 then currentProgress = 0 end
    currentProgress = math.floor(currentProgress * 100)

    -- direction
    local direction = config.direction
    if direction == "right" then
        fluid
            :css("top", 0)
            :css("left", 0)
            :css("width", tostring(currentProgress) .. "%")
    elseif direction == "down" then
        fluid
            :css("top", 0)
            :css("left", 0)
            :css("height", tostring(currentProgress) .. "%")
    elseif direction == "left" then
        fluid
            :css("bottom", 0)
            :css("right", 0)
            :css("width", tostring(currentProgress) .. "%")
    else -- up
        fluid
            :css("bottom", 0)
            :css("right", 0)
            :css("height", tostring(currentProgress) .. "%")
    end

    -- css
    if config.css then
        sub:css(config.css)
    end

    return sub
end

-------------------------
-- create
function GUI_METATABLE.create(gui_object)
    gui_object = gui_object or {}
    local frame = mw.getCurrentFrame()

    -------------------------
    -- outer
    local outer = mw.html.create("span"):addClass("mjwgui")

    -- class
    if type(gui_object.name) == "string" then
        outer:addClass("mjwgui_" .. gui_object.name)
    end

    local tableSettingClasses = {}
    if type(gui_object.class) == "string" then
        tableSettingClasses = { gui_object.class }
    elseif type(gui_object.class) == "table" then
        tableSettingClasses = gui_object.class
    end
    for _, class in ipairs(tableSettingClasses) do
        if type(class) == "string" then
            outer:addClass(class)
        end
    end

    -- styles
    if gui_object.padding ~= nil and not gui_object.padding then
        outer:css("padding", '0')
    end
    if not gui_object.border then
        outer:css("border", 'none')
    end
    if gui_object.background ~= nil and not gui_object.background then
        outer:css("background", "transparent")
    elseif type(gui_object.background) == "string" then
        outer:css("background", gui_object.background)
    end

    --------------------------------------
    -- sheet
    local gui = outer:tag("span"):addClass('mjwgui-sheet')

    -- styles
    local boxWidth = tonumber(gui_object.width) or 2
    local boxHeight = tonumber(gui_object.height) or 2
    local scale = tonumber(gui_object.scale) or 2
    if boxWidth > 0 and boxHeight > 0 then
        gui
            :css("width", tostring(boxWidth * scale) .. "px")
            :css("height", tostring(boxHeight * scale) .. "px")
    end

    -- items
    local slots = gui_object.slots or {}
    local texts = gui_object.text or {}
    local gauges = gui_object.gauges or {}
    local tanks = gui_object.tanks or {}

    --------------------------------------
    -- images
    if type(gui_object.images) == "table" then
        for _, image in ipairs(gui_object.images) do
            if image then
                local imageSpan = gui:tag("span"):addClass("mjwgui-image")

                -- position
                if type(image.x) == "number" then
                    imageSpan:css("left", tostring(image.x * scale) .. "px")
                end
                if type(image.y) == "number" then
                    imageSpan:css("top", tostring(image.y * scale) .. "px")
                end

                -- size
                local height, width
                if type(image.height) == "number" then
                    height = image.height * scale
                    imageSpan:css("height", tostring(height) .. "px")
                end
                if type(image.width) == "number" then
                    width = image.width * scale
                    imageSpan:css("width", tostring(width) .. "px")
                end

                -- style
                if image.css then
                    imageSpan:css(image.css)
                end

                -- file
                if type(image.file) == "string" then
                    local fileText = '[[File:' .. image.file
                    if height ~= nil and width ~= nil then
                        fileText = fileText .. "|" .. tostring(width) .. "x" .. tostring(height) .. "px"
                    else
                        if height ~= nil then
                            fileText = fileText .. "|x" .. tostring(height) .. "px"
                        elseif width ~= nil then
                            fileText = fileText .. "|" .. tostring(width) .. "px"
                        end
                    end

                    fileText = fileText .. '|alt=|link=|]]'
                    imageSpan:wikitext(frame:preprocess(fileText))
                end

                -- progress
                if image.progress then
                    -- reverse
                    if image.reverse then
                        imageSpan:addClass("mjwgui-progress--reverse")
                    else
                        imageSpan:addClass("mjwgui-progress")
                    end

                    -- dir
                    if image.progress == "up" then
                        local size = image.size or image.height or 0
                        imageSpan:css("animation-name", "mjwgui-progress--up")
                        imageSpan:css("clip", "rect(" .. tostring(size * scale) .. "px auto auto auto)")
                    elseif image.progress == "right" then
                        imageSpan:css("animation-name", "mjwgui-progress--right")
                        local size = image.size or image.width or 0
                        imageSpan:css("clip", "rect(auto " .. tostring(size * scale) .. "px auto auto)")
                    elseif image.progress == "down" then
                        local size = image.size or image.height or 0
                        imageSpan:css("animation-name", "mjwgui-progress--down")
                        imageSpan:css("clip", "rect(auto auto " .. tostring(size * scale) .. "px auto)")
                    elseif image.progress == "left" then
                        local size = image.size or image.width or 0
                        imageSpan:css("animation-name", "mjwgui-progress--left")
                        imageSpan:css("clip", "rect(auto auto  auto " .. tostring(size * scale) .. "px)")
                    end

                    -- duration
                    if type(image.duration) == "number" then
                        imageSpan:css("animation-duration", tostring(image.duration) .. "s")
                    end
                end
            end
        end
    end

    --------------------------------------
    -- shapeless icon
    if gui_object.shapeless and gui_object.shapeless.isShapeless then
        local shapelessX = nonNilValues(0, gui_object.shapeless.x)
        local shapelessY = nonNilValues(0, gui_object.shapeless.y)
        local shapelessText = gui_object.shapeless.text or "配置不問"
        local shapelessFile = gui_object.shapeless.file or "Grid layout Shapeless icon.png"

        gui:tag("span")
            :addClass("mjwgui-shapeless")
            :attr("title", shapelessText)
            :css("padding", "0")
            :css("left", tostring(shapelessX * scale) .. "px")
            :css("top", tostring(shapelessY * scale) .. "px")
            :css("cursor", "help")
            :wikitext(frame:preprocess('[[File:' .. shapelessFile .. '|link=|' .. shapelessText .. ']]'))
    end

    --------------------------------------
    -- count animation frames
    local max_animation = 1

    local slotlist = {}
    local textlist = {}
    local gaugelist = {}
    local gaugelimitlist = {}
    local tanklist = {}
    local tanklimitlist = {}

    -- slot
    for i = 1, #slots, 1 do
        slotlist[i] = {}
        if slots[i] then
            local slot = slots[i].value
            if slot then
                slotlist[i] = slotUtils.getSprites(slot, nil)
                max_animation = math.max(max_animation, #slotlist[i])
            end
        end
    end

    -- tank
    for i = 1, #tanks, 1 do
        tanklist[i] = {}
        if tanks[i] then
            local tank = tanks[i].value
            local max = tonumber(tanks[i].max) or 1000
            local amount = tonumber(tanks[i].amount)
            local unit = tanks[i].unit or "mB"

            if tank then
                local splitText = slotUtils.splitSlotText(tank)
                for _, v in ipairs(splitText) do
                    if string.match(v, '^.+%*%-?%d+$') then
                        local tmp = split(v, "*")
                        if #tmp == 2 then
                            v = tmp[1]
                            amount = tonumber(tmp[2])
                        end
                    end

                    local sprite
                    if amount == nil then
                        sprite = slotUtils.getSprite(v, 1, {
                            description = tostring(max) .. " " .. unit,
                        })
                        sprite[2] = max
                    else
                        sprite = slotUtils.getSprite(v, 1, {
                            description = tostring(amount) .. " " .. unit,
                        })
                        sprite[2] = amount
                    end
                    table.insert(tanklist[i], sprite)
                end
                max_animation = math.max(max_animation, #tanklist[i])
            end
        end
    end

    -- gauge
    local function getGaugeValue(value, hasAnimate)
        local res = {}
        if type(value) == "number" then
            res[1] = value
        elseif type(value) == "string" and not hasAnimate then
            res[1] = tonumber(trim(value or ''))
        elseif type(value) == "string" and hasAnimate then
            local items = split(value, ";")
            for s, v in ipairs(items) do
                res[s] = tonumber(trim(v or '')) or 0
            end
        end
        return res
    end

    for i = 1, #gauges, 1 do
        local isAnimate = gauges[i].animate
        gaugelist[i], gaugelimitlist[i] = {}, {}

        if gauges[i] then
            -- gauge value
            local gaugeValue = getGaugeValue(gauges[i].value, isAnimate)
            if #gaugeValue > 0 then
                gaugelist[i] = gaugeValue
            else
                gaugelist[i] = { 0 }
            end

            if #gaugelist[i] > max_animation then
                max_animation = #gaugelist[i]
            end

            -- gauge limit
            local gaugeMaxValue = getGaugeValue(gauges[i].max, isAnimate)
            if #gaugeMaxValue > 0 then
                gaugelimitlist[i] = gaugeMaxValue
            else
                gaugelimitlist[i] = { 0 }
            end

            if #gaugelimitlist[i] > max_animation then
                max_animation = #gaugelimitlist[i]
            end
        end
    end

    -- text
    for i = 1, #texts, 1 do
        textlist[i] = {}

        if texts[i] then
            local text = texts[i].value
            if texts[i].animate and text then
                local items = split(text, ";")
                for s, v in ipairs(items) do
                    textlist[i][s] = trim(v or '')
                end
            else
                textlist[i][1] = trim(text or "")
            end

            if #textlist[i] > max_animation then
                max_animation = #textlist[i]
            end
        end
    end

    --------------------------------------
    local function getCurrentFrame(length, frame_no)
        -- スロットの数が異なる場合でも、最大値のアニメーション数の割合でフレーム番号を算出
        -- 対象フレーム番号 = 対象スロットの最大アニメーション * (現在のフレーム番号 ÷ 最大値のアニメーション数)
        local idx = math.floor(length * ((frame_no - 1) / max_animation)) + 1
        if max_animation % length == 0 then
            idx = ((frame_no - 1) % length) + 1
        end
        return idx
    end

    -- slots
    for i = 1, #slots, 1 do
        if #slotlist[i] <= 1 then
            local slotAmount = tonumber(slots[i].amount)

            if slotlist[i][1] and slotlist[i][1][1] ~= "" then
                if slotAmount ~= nil then
                    slotlist[i][1][2] = slotAmount
                end
                local amount = slotlist[i][1][2] or 1

                local sub = t.generateSlot(slotlist[i][1][1], {
                    background      = slots[i].background,
                    large           = slots[i].large,
                    placeholder     = slots[i].placeholder,
                    showPlaceholder = slots[i].showPlaceholder,
                    showStacksize   = slots[i].showStacksize,
                    x               = slots[i].x,
                    y               = slots[i].y,
                    css             = slots[i].css,
                    scale           = scale,
                    amount          = amount,

                })
                gui:node(sub)
            else
                if nonNilValues(true, slots[i].background) then
                    local sub = t.generateSlot(nil, {
                        background      = slots[i].background,
                        large           = slots[i].large,
                        placeholder     = slots[i].placeholder,
                        showPlaceholder = slots[i].showPlaceholder,
                        showStacksize   = slots[i].showStacksize,
                        x               = slots[i].x,
                        y               = slots[i].y,
                        css             = slots[i].css,
                        scale           = scale,
                        amount          = nil,
                    })
                    gui:node(sub)
                end
            end
        else
            local anim_frames = {}
            local length = #slotlist[i]

            for frame_no = 1, max_animation, 1 do
                anim_frames[frame_no] = ""
                local idx = getCurrentFrame(length, frame_no)

                local slot = slotlist[i][idx][1]
                if slot ~= "" then
                    local slotAmount = tonumber(slots[i].amount)
                    local amount = slotAmount or slotlist[i][idx][2] or 1
                    local sub = t.generateSlot(slot, {
                        background      = slots[i].background,
                        large           = slots[i].large,
                        placeholder     = slots[i].placeholder,
                        showPlaceholder = slots[i].showPlaceholder,
                        showStacksize   = slots[i].showStacksize,
                        x               = slots[i].x,
                        y               = slots[i].y,
                        css             = slots[i].css,
                        scale           = scale,
                        amount          = amount,
                    })

                    anim_frames[frame_no] = tostring(sub)
                else
                    if nonNilValues(true, slots[i].background) then
                        local sub = t.generateSlot(nil, {
                            background      = slots[i].background,
                            large           = slots[i].large,
                            placeholder     = slots[i].placeholder,
                            showPlaceholder = slots[i].showPlaceholder,
                            showStacksize   = slots[i].showStacksize,
                            x               = slots[i].x,
                            y               = slots[i].y,
                            css             = slots[i].css,
                            scale           = scale,
                            amount          = nil,
                        })
                        anim_frames[frame_no] = tostring(sub)
                    end
                end
            end
            gui:wikitext(animate.base(anim_frames))
        end
    end

    -- tank
    for i = 1, #tanks, 1 do
        if #tanklist[i] <= 1 then
            local tankAmount = tonumber(tanks[i].amount)

            if tanklist[i][1] and tanklist[i][1][1] ~= "" then
                if tankAmount ~= nil then
                    tanklist[i][1][2] = tankAmount
                end
                local amount = tanklist[i][1][2] or 0

                local sub = t.generateTank(tanklist[i][1][1], {
                    background = tanks[i].background,
                    x          = tanks[i].x,
                    y          = tanks[i].y,
                    width      = tanks[i].width,
                    height     = tanks[i].height,
                    direction  = tanks[i].direction,
                    max        = tanks[i].max,
                    css        = tanks[i].css,
                    scale      = scale,
                    amount     = amount,
                })
                gui:node(sub)
            else
                if nonNilValues(true, tanks[i].background) then
                    local sub = t.generateTank(nil, {
                        background = tanks[i].background,
                        x          = tanks[i].x,
                        y          = tanks[i].y,
                        width      = tanks[i].width,
                        height     = tanks[i].height,
                        direction  = tanks[i].direction,
                        max        = tanks[i].max,
                        css        = tanks[i].css,
                        scale      = scale,
                        amount     = nil,
                    })
                    gui:node(sub)
                end
            end
        else
            local anim_frames = {}
            local length = #tanklist[i]

            for frame_no = 1, max_animation, 1 do
                anim_frames[frame_no] = ""
                local idx = getCurrentFrame(length, frame_no)

                local tank = tanklist[i][idx][1]
                if tank ~= "" then
                    local tankAmount = tonumber(tanks[i].amount)
                    local amount = tankAmount or tanklist[i][idx][2] or 1
                    local sub = t.generateTank(tank, {
                        background = tanks[i].background,
                        x          = tanks[i].x,
                        y          = tanks[i].y,
                        width      = tanks[i].width,
                        height     = tanks[i].height,
                        direction  = tanks[i].direction,
                        css        = tanks[i].css,
                        scale      = scale,
                        amount     = amount,
                    })

                    anim_frames[frame_no] = tostring(sub)
                else
                    if nonNilValues(true, tanks[i].background) then
                        local sub = t.generateTank(nil, {
                            background = tanks[i].background,
                            x          = tanks[i].x,
                            y          = tanks[i].y,
                            width      = tanks[i].width,
                            height     = tanks[i].height,
                            direction  = tanks[i].direction,
                            css        = tanks[i].css,
                            scale      = scale,
                            amount     = nil,
                        })
                        anim_frames[frame_no] = tostring(sub)
                    end
                end
            end
            gui:wikitext(animate.base(anim_frames))
        end
    end

    -- gauge
    for i = 1, #gauges, 1 do
        if #gaugelist[i] <= 1 then
            local sub = t.generateGauge(gaugelist[i][1], gaugelimitlist[i][1], {
                direction = gauges[i].direction,
                height    = gauges[i].height,
                width     = gauges[i].width,
                x         = gauges[i].x,
                y         = gauges[i].y,
                scale     = scale,
                file      = gauges[i].file,
                css       = gauges[i].css,
            })
            gui:node(sub)
        else
            local anim_frames = {}
            local length = #gaugelist[i]
            local length_limit = #gaugelimitlist[i]

            for frame_no = 1, max_animation, 1 do
                local idx = getCurrentFrame(length, frame_no)
                local idx_limit = getCurrentFrame(length_limit, frame_no)

                local sub = t.generateGauge(gaugelist[i][idx], gaugelimitlist[i][idx_limit], {
                    direction = gauges[i].direction,
                    height    = gauges[i].height,
                    width     = gauges[i].width,
                    x         = gauges[i].x,
                    y         = gauges[i].y,
                    file      = gauges[i].file,
                    css       = gauges[i].css,
                    scale     = scale,
                })
                anim_frames[frame_no] = tostring(sub)
            end
            gui:wikitext(animate.base(anim_frames))
        end
    end

    -- text ---
    for i = 1, #textlist, 1 do
        if #textlist[i] == 1 then
            local sub = t.generateText(textlist[i][1], {
                bold       = texts[i].bold,
                color      = texts[i].color,
                height     = texts[i].height,
                obfuscated = texts[i].obfuscated,
                size       = texts[i].size,
                strike     = texts[i].strike,
                underline  = texts[i].underline,
                prefix     = texts[i].prefix,
                suffix     = texts[i].suffix,
                x          = texts[i].x,
                y          = texts[i].y,
                css        = texts[i].css,
                scale      = scale,
            })
            gui:node(sub)
        else
            local anim_frames = {}
            local length = #textlist[i]

            for frame_no = 1, max_animation, 1 do
                local idx = getCurrentFrame(length, frame_no)

                local sub = t.generateText(textlist[i][idx], {
                    bold       = texts[i].bold,
                    color      = texts[i].color,
                    height     = texts[i].height,
                    obfuscated = texts[i].obfuscated,
                    size       = texts[i].size,
                    strike     = texts[i].strike,
                    underline  = texts[i].underline,
                    prefix     = texts[i].prefix,
                    suffix     = texts[i].suffix,
                    x          = texts[i].x,
                    y          = texts[i].y,
                    css        = texts[i].css,
                    scale      = scale,
                })
                anim_frames[frame_no] = tostring(sub)
            end
            gui:wikitext(animate.base(anim_frames))
        end
    end

    return outer
end

-- insert
function GUI_METATABLE.insertSlot(gui_object, value, pos)
    if type(value) == "table" then
        if pos == nil then
            table.insert(gui_object.slots, value)
        else
            table.insert(gui_object.slots, pos, value)
        end
        return gui_object
    else
        return error("Invalid slot value.")
    end
end

function GUI_METATABLE.insertTank(gui_object, value, pos)
    if type(value) == "table" then
        if pos == nil then
            table.insert(gui_object.tanks, value)
        else
            table.insert(gui_object.tanks, pos, value)
        end
        return gui_object
    else
        return error("Invalid tank value.")
    end
end

function GUI_METATABLE.insertImage(gui_object, value, pos)
    if type(value) == "table" then
        if pos == nil then
            table.insert(gui_object.images, value)
        else
            table.insert(gui_object.images, pos, value)
        end
        return gui_object
    else
        return error("Invalid image value.")
    end
end

function GUI_METATABLE.insertGuage(gui_object, value, pos)
    if type(value) == "table" then
        if pos == nil then
            table.insert(gui_object.guages, value)
        else
            table.insert(gui_object.guages, pos, value)
        end
        return gui_object
    else
        return error("Invalid guage value.")
    end
end

function GUI_METATABLE.insertText(gui_object, value, pos)
    if type(value) == "table" then
        if pos == nil then
            table.insert(gui_object.text, value)
        else
            table.insert(gui_object.text, pos, value)
        end
        return gui_object
    else
        return error("Invalid text value.")
    end
end

-- change
function GUI_METATABLE.changeSlot(gui_object, value, pos)
    if type(value) ~= "table" then return error("The slot value must be a table.") end
    pos = tonumber(pos)
    if pos == nil then return error("The index value must be a number.") end

    if not gui_object.slots[pos] then
        gui_object.slots[pos] = value
    else
        for k, v in pairs(value) do
            gui_object.slots[pos][k] = v
        end
    end

    return gui_object
end

function GUI_METATABLE.changeImage(gui_object, value, pos)
    if type(value) ~= "table" then return error("The image value must be a table.") end
    pos = tonumber(pos)
    if pos == nil then return error("The index value must be a number.") end

    if not gui_object.images[pos] then
        gui_object.images[pos] = value
    else
        for k, v in pairs(value) do
            gui_object.images[pos][k] = v
        end
    end

    return gui_object
end

-- set value
function GUI_METATABLE.setHeight(gui_object, num)
    num = tonumber(num)
    if num == nil then
        return error("The height must be a number.")
    else
        gui_object.height = num
        return gui_object
    end
end

function GUI_METATABLE.setWidth(gui_object, num)
    num = tonumber(num)
    if num == nil then
        return error("The width must be a number.")
    else
        gui_object.width = num
        return gui_object
    end
end

function GUI_METATABLE.setScale(gui_object, num)
    num = tonumber(num)
    if num == nil then
        return error("The scale must be a number.")
    else
        gui_object.width = num
        return gui_object
    end
end

-------------------------
-- object
function p.new(settings)
    if type(settings) ~= "table" then
        settings = {
            slots = {},
            images = {},
            tanks = {},
            gauges = {},
            text = {},
        }
    end

    if not settings.slots then settings.slots = {} end
    if not settings.images then settings.images = {} end
    if not settings.tanks then settings.tanks = {} end
    if not settings.gauges then settings.gauges = {} end
    if not settings.text then settings.text = {} end

    return setmetatable(settings, {
        __index = GUI_METATABLE,
        __tostring = function(gui_object)
            return tostring(gui_object:create())
        end
    })
end

return p
