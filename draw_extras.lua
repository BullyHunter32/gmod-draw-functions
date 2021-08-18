local math 		= math
local surface 	= surface

-- Draws a filled circle
function draw.GenerateCircle(iPosX, iPosY, iRadius, iStartAngle, iEndAngle, iVertices)
	local tCircle = {}
	if iStartAngle ~= 0 or iEndAngle ~= 360 then
		tCircle[1] = {x = iPosX, y = iPosY}
	end

	iStartAngle = iStartAngle - 90
	iEndAngle = iEndAngle - 90

	for i = iStartAngle, iEndAngle, 360 / iVertices do
		tCircle[#tCircle + 1] =
		{
			x = iPosX + math.cos(math.rad(i)) * iRadius,
			y = iPosY + math.sin(math.rad(i)) * iRadius
		}
	end

	return tCircle
end

	-- Draws a filled circle
function draw.DrawCircle(iPosX, iPosY, iRadius, iVertices)
    iPosX = iPosX or 0
    iPosY = iPosY or 0
    iRadius = iRadius or 100
    iVertices = iVertices or 200 -- the more vertices, the better the quality
    
    local tCircle = draw.GenerateCircle(iPosX, iPosY, iRadius, 0, 360, iVertices)
    surface.DrawPoly(tCircle)
end

-- Draws a filled circle but with an angle, like a cut pie
function draw.DrawArc(iPosX, iPosY, iRadius, iStartAngle, iEndAngle, iVertices)
    iPosX = iPosX or 0
    iPosY = iPosY or 0
    iRadius = iRadius or 100
    iStartAngle = iStartAngle or 0
    iEndAngle = iEndAngle or 360
	iVertices = iVertices or 200
	
	local tCircle = draw.GenerateCircle(iPosX, iPosY, iRadius, iStartAngle, iEndAngle, iVertices)
    surface.DrawPoly(tCircle)
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
