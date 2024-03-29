local function quadBezier(t, p0, p1, p2)
	local l1 = Lerp(t, p0, p1)
	local l2 = Lerp(t, p1, p2)
	local quad = Lerp(t, l1, l2)
	return quad
end

local function cubicBezier(t, p0, p1, p2, p3)
	local l1 = Lerp(t, p0, p1)
	local l2 = Lerp(t, p1, p2)
	local l3 = Lerp(t, p2, p3)
	local a = Lerp(t, l1, l2)
	local b = Lerp(t, l2, l3)
	local cubic = Lerp(t, a, b)
	return cubic
end

-- Bezier curves
function draw.QuadBezier(p0, p1, p2, step)
    local old = p0
    step = step or 0.02
    for i = 0, 1, step do
        local pos = quadBezier(i, p0, p1, p2)
        surface.DrawLine(old.x, old.y, pos.x, pos.y)
        old = pos
    end
end

function draw.CubicBezier(p0, p1, p2, p3, step)
    local old = p0
    step = step or 0.02
    for i = 0, 1, step do
        local pos = cubicBezier(i, p0, p1, p2, p3)
        surface.DrawLine(old.x, old.y, pos.x, pos.y)
        old = pos
    end
end

-- Draws a filled circle
function draw.DrawCircle(iPosX, iPosY, iRadius, iVertices, bCache)
    iPosX = iPosX or 0
    iPosY = iPosY or 0
    iRadius = iRadius or 100
    iVertices = iVertices or 200 -- the more vertices, the better the quality
    
    local circle = {}
    local i = 0
    for ang = 1, 360, (360/iVertices) do
        i = i + 1
        circle[i] = {
            x = iPosX + (math.cos(math.rad(ang))) * iRadius, 
            y = iPosY + (math.sin(math.rad(ang))) * iRadius, 
        }
    end

    if bCache then
        return circle
    end
    
    surface.DrawPoly(circle)
end

-- Draws a filled circle but with an angle, like a cut pie
function draw.DrawArc(iPosX, iPosY, iRadius, iStartAngle, iEndAngle, bCache)
    iPosX = iPosX or 0
    iPosY = iPosY or 0
    iRadius = iRadius or 100
    iStartAngle = iStartAngle or 0
    iEndAngle = iEndAngle or 360

    iEndAngle = iEndAngle - 90
    iStartAngle = iStartAngle - 90

    local circle = {
        {x = iPosX, y = iPosY}
    }
    local i = 1
    for ang = iStartAngle, iEndAngle do
        i = i + 1
        circle[i] = {
            x = iPosX + (math.cos(math.rad(ang))) * iRadius,
            y = iPosY + (math.sin(math.rad(ang))) * iRadius,
        }
    end

    if bCache then
        return circle
    end

    surface.DrawPoly(circle)
end

function draw.DrawRing(iPosX, iPosY, iRadius, iThickness, iStartAngle, iEndAngle, tCachedCircle, tCachedRing)
    local tCircle
    local tRing

    if istable(iPosX) and istable(iPosY) then
        if not tCircle then
            tCircle = iPosX
        end 
        if not tRing then
            tRing = iPosY
        end
    end

    if not tCircle then
        if tCachedCircle then
            tCircle = tCachedCircle
        else
            tCircle = draw.DrawCircle(iPosX, iPosY, iRadius - iThickness, nil, true)
        end 
    end


    render.SetStencilWriteMask( 0xFF )
	render.SetStencilTestMask( 0xFF )
	render.SetStencilReferenceValue( 0 )
	render.SetStencilCompareFunction( STENCIL_ALWAYS )
	render.SetStencilPassOperation( STENCIL_KEEP )
	render.SetStencilFailOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )
	render.ClearStencil()
    
    render.SetStencilEnable(true)
        render.SetStencilReferenceValue(1)
        render.SetStencilFailOperation(STENCIL_REPLACE)
        render.SetStencilCompareFunction(STENCIL_NEVER)
        surface.DrawPoly(tCircle)
        render.SetStencilCompareFunction(STENCIL_NOTEQUAL)
        if tRing then
            surface.DrawPoly(tRing)
        elseif iStartAngle and iStartAngle ~= 0 or iEndAngle and iEndAngle ~= 0 then
            draw.DrawArc(iPosX, iPosY, iRadius, iStartAngle, iEndAngle)
        else
            draw.DrawCircle(iPosX, iPosY, iRadius)
        end
    render.SetStencilEnable(false)
end
    

local color_outline = Color(20, 20, 20, 100)
function draw.DrawProgressBar(iPosX, iPosY, iWidth, iHeight, tColor, flRatio, tOutlineCol, bOutline)
    iPosX = iPosX or 0
    iPosY = iPosY or 0
    iWidth = iWidth or 100
    iHeight = iHeight or 100
    tColor = tColor or color_white
    flRatio = flRatio or 1
    tOutlineCol = tOutlineCol or color_outline

    surface.SetDrawColor(tColor)
    surface.DrawRect(iPosX, iPosY, iWidth*flRatio, iHeight)

    if bOutline then
        surface.SetDrawColor(tOutlineCol)
        surface.DrawOutlinedRect(iPosX, iPosY, iWidth, iHeight)
    end
end

-- makes a mexican wave sorta thing
function draw.BouncingText(sText, sFont, iPosX, iPosY, tColor, iHorizAlign, iVertAlign, iAnimHeight, iAnimSpeed)
    sText = sText or ""
    sFont = sFont or "DermaLarge"
    iPosX = iPosX or 0
    iPosY = iPosY or 0
    tColor = tColor or color_white
    iHorizAlign = iHorizAlign or 0
    iVertAlign = iVertAlign or 0
    iAnimHeight = iAnimHeight or 20
    iAnimSpeed = iAnimSpeed or 1

    surface.SetFont(sFont)
    surface.SetTextColor(tColor)

    -- for the text alignment
    local textOffsetX = 0
    local textOffsetY = 0
    local textWidth, textHeight = surface.GetTextSize(sText)

    if iHorizAlign ~= 0 then
        if iHorizAlign == TEXT_ALIGN_CENTER then
            textOffsetX = -(textWidth/2)
        elseif iHorizAlign == TEXT_ALIGN_RIGHT then
            textOffsetX = -textWidth
        end
    end

    if iVertAlign ~= 0 then
        if iVertAlign == TEXT_ALIGN_CENTER then
            textOffsetY = textHeight/2
        elseif iVertAlign == TEXT_ALIGN_BOTTOM then
            textOffsetY = -textHeight
        end
    end

    local textWidth, textHeight = 0, 0
    for i = 1, #sText do
        local char = sText[i]
        local tW, tH = surface.GetTextSize(char)
        surface.SetTextPos(iPosX + textOffsetX + textWidth, iPosY + textOffsetY + (math.cos((CurTime() + (i/10))*(iAnimSpeed)) * iAnimHeight))
        textWidth = textWidth + tW
        textHeight = textHeight + tH
        surface.DrawText(char)
    end
end

function draw.CreateRoundedBoxPoly(radius, x, y, w, h)
    local poly = {}
    local index = 1

    poly[index] = {
        x = x,    
        y = y + radius,
    }

    for i = 0, 90 do
        index = index + 1

        local ang = i + 180
        poly[index] = {
            x = x + radius + (math.cos(math.rad(ang))*radius),    
            y = y + radius + (math.sin(math.rad(ang))*radius),
        }
    end

    index = index + 1
    poly[index] = {
        x = x + radius,    
        y = y,
    }

    index = index + 1
    poly[index] = {
        x = x + w - radius, 
        y = y
    }

    for i = 0, 90 do
        index = index + 1

        local ang = i - 90
        poly[index] = {
            x = x + w - radius + (math.cos(math.rad(ang))*radius),    
            y = y + radius + (math.sin(math.rad(ang))*radius),
        }
    end

    index = index + 1
    poly[index] = {
        x = x + w, 
        y = y + radius
    }

    for i = 0, 90 do
        index = index + 1

        local ang = i - 0
        poly[index] = {
            x = x + w - radius + (math.cos(math.rad(ang))*radius),    
            y = y + h - radius + (math.sin(math.rad(ang))*radius),
        }
    end

    index = index + 1
    poly[index] = {
        x = x + radius, 
        y = y + h
    }

    for i = 0, 90 do
        index = index + 1

        local ang = i + 90
        poly[index] = {
            x = x + radius + (math.cos(math.rad(ang))*radius),    
            y = y + h - radius + (math.sin(math.rad(ang))*radius),
        }
    end

    index = index + 1
    poly[index] = {
        x = x,
        y = y + h - radius
    }

    return poly
end
