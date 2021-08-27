-- used this code to test what i was making

-- caching the background
local background = draw.DrawCircle(120, ScrH() - 120, 75, nil, true)
local innerBackground = draw.DrawCircle(120, ScrH() - 120, 75, nil, true)

local scrw, scrh = ScrW(), ScrH()
hook.Add("HUDPaint", "x", function()

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
end)
