-- used this code to test what i was making

-- caching the background
local background = draw.DrawCircle(120, ScrH() - 120, 75, nil, true)
local innerBackground = draw.DrawCircle(120, ScrH() - 120, 75, nil, true)

local scrw, scrh = ScrW(), ScrH()

-- Cache middle of Spining Rings
local midSpinRing = draw.DrawCircle(ScrW()/2, ScrH()/2, ScrH()*0.07, nil, true) -- why 0.7? because that's the radius of the circle minus the thickness of the ring

-- static ring polys around the spnning one cause cool
local topArc = draw.DrawArc(ScrW()*0.5, ScrH()*0.45, ScrH()*0.08, -45, 45, true)
local topCenter = draw.DrawCircle(ScrW()*0.5, ScrH()*0.45, ScrH()*0.075, nil, true)

local leftArc = draw.DrawArc(ScrW()*0.5 - (ScrH() * 0.05), ScrH()*0.5, ScrH()*0.08, -135, -45, true)
local leftCenter = draw.DrawCircle(ScrW()*0.5 - (ScrH() * 0.05), ScrH()*0.5, ScrH()*0.075, nil, true)

local bottomArc = draw.DrawArc(ScrW()*0.5, ScrH()*0.55, ScrH()*0.08, 135, 225, true)
local bottomCenter = draw.DrawCircle(ScrW()*0.5, ScrH()*0.55, ScrH()*0.075, nil, true)

local rightArc = draw.DrawArc(ScrW()*0.5 + (ScrH() * 0.05), ScrH()*0.5, ScrH()*0.08, 45, 135, true)
local rightCenter = draw.DrawCircle(ScrW()*0.5 + (ScrH() * 0.05), ScrH()*0.5, ScrH()*0.075, nil, true)

hook.Add("HUDPaint", "m", function()
    draw.NoTexture() -- materials conflict with my polys :(

    -- health
    local hpRatio = math.min(LocalPlayer():Health()/LocalPlayer():GetMaxHealth(), 1)
    local ang = hpRatio*360

    local hpColor = Color(
        255-(hpRatio*255),
        hpRatio*255,
        0
    )

    surface.SetDrawColor(40, 40, 40, 255)
    surface.DrawPoly(background)

    surface.SetDrawColor(0, 0, 0, 150)
    surface.DrawPoly(innerBackground)

    surface.SetDrawColor(hpColor)
    draw.DrawArc(120, ScrH() - 120, 70, 0, ang)

    local n = CurTime()*180
    draw.DrawArc(300, ScrH() - 120, 70, n, n)

    -- ammo bar
    local ratio = LocalPlayer():GetActiveWeapon()
    ratio = ratio:IsValid() and (ratio:Clip1() / ratio:GetMaxClip1()) or 1
    draw.DrawProgressBar(50, 50, 100, 30, nil, ratio, nil, true)

    -- bouncy text
    draw.BouncingText("She Sells Sea Shells By The Sea Shore", "ChatFont", 500, 100, color_white, 1, 1, 7, 2)
        
    surface.SetDrawColor(255, 0, 0)
    draw.QuadBezier(
        Vector(0, scrh/2),
        Vector(scrw/2, 0),
        Vector(scrw, scrh/2)
    )

    surface.SetDrawColor(0, 255, 0)
    draw.CubicBezier(
        Vector(0, 0),
        Vector(scrw, 0),
        Vector(0, scrh),
        Vector(scrw, scrh)
    )

    local startAng = (CurTime()*88)%360
    draw.DrawRing(scrw*0.5, scrh*0.5, scrh*0.08, scrh*0.01, startAng, startAng + 90, midSpinRing)
    draw.DrawRing(scrw*0.5, scrh*0.5, scrh*0.08, scrh*0.01, startAng + 180, startAng + 270, midSpinRing)

    draw.DrawRing(topCenter, topArc)
    draw.DrawRing(leftCenter, leftArc)
    draw.DrawRing(bottomCenter, bottomArc)
    draw.DrawRing(rightCenter, rightArc)
end)
