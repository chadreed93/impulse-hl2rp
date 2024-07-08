surface.CreateFont("impulseHL2RPScannerFontLARGE", {
    font = "Lucida Sans Typewriter",
    antialias = true,
    outline = false,
    weight = 800,
    size = 64
})



function PLUGIN:PostDrawTranslucentRenderables(bDrawingDepth,bDrawingSkybox)
	if bDrawingDepth then return end
    if bDrawingSkybox then return end
    local lp = LocalPlayer()
    if not IsValid(lp) then return end

    local ang = lp:EyeAngles() + Angle()
    ang:RotateAroundAxis(ang:Up(), 180)

    if not lp:IsCP() then return end
    if not lp:IsScanner() then return end
    local scanner = lp:GetScannerFromPlayer()
    local trg = scanner:GetCurrentTarget()
    do
        if IsValid(trg) then
            if trg:GetMoveType() == MOVETYPE_NOCLIP then
                return
            end
            local known = scanner:IsPlayerKnown(trg)
            local scanning = scanner:IsPlayerScanning(trg)

            if trg:IsRebel() then
                local name = known and trg:Name() or (scanning and "<DISPATCHING...>" or "<HOSTILE>")
                local clr = Color(255, 0, 0)
            
                outline.Add(trg,clr,OUTLINE_MODE_BOTH)
            else
                local name = known and trg:Name() or (scanning and "<SCANNING...>" or "<UNKNOWN>")
                local clr = known and team.GetColor(trg:Team()) or color_white
            
                outline.Add(trg,clr,OUTLINE_MODE_BOTH)
            end
        end
    end

    

    local Ents = ents.FindInSphere(scanner:GetPos(), 300)
    for v,k in ipairs(Ents) do
        if k:IsPlayer() and not (k == lp) then
            -- prevent moderators from being seen in noclip
            if k:GetMoveType() == MOVETYPE_NOCLIP then
                continue
            end
            local known = scanner:IsPlayerKnown(k)
            local scanning = scanner:IsPlayerScanning(k)
            local name
            local clr

             if k:IsRebel() then
                name = known and k:Name() or (scanning and "<DISPATCHING...>" or "<HOSTILE>")
                clr = Color(255, 0, 0)
            else
                name = known and k:Name() or (scanning and "<SCANNING...>" or "<UNKNOWN>")
                clr = known and team.GetColor(k:Team()) or color_white
            end
            cam.Start3D2D(k:GetPos()+Vector(0,0,82),((k:GetPos()-scanner:GetPos()):GetNormalized()*Vector(-1,-1,0)):Angle() + Angle(0,90,90),0.1)
                draw.SimpleTextOutlined(name,"impulseHL2RPScannerFontLARGE",0,0,clr,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,2,color_black)
            cam.End3D2D()
        end
    end
end

local math = math
local clamp = math.Clamp

-- TImesince

local function TimeSince()
    local t = CurTime()
    return function()
        return CurTime() - t
    end
end

local lastZoomTick = TimeSince()

function PLUGIN:Think()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    if not ply:IsScanner() then return end
    local scanner = ply:GetScannerFromPlayer()
    scanner.Zoom = scanner.Zoom or 90
    if input.IsMouseDown(MOUSE_LEFT) then
        if lastZoomTick() > 0.06 then
            surface.PlaySound("common/talk.wav")
            lastZoomTick = TimeSince()
        end
        scanner.Zoom = clamp(scanner.Zoom-(FrameTime()*25),30,105)
    end
    if input.IsMouseDown(MOUSE_RIGHT) then
        if lastZoomTick() > 0.06 then
            surface.PlaySound("common/talk.wav")
            lastZoomTick = TimeSince()
        end
        scanner.Zoom = clamp(scanner.Zoom+(FrameTime()*25),30,105)
    end
end

function PLUGIN:CalcView(ply,origin,angles,fov)
    if not ply:IsScanner() then return end
    local scanner = ply:GetScannerFromPlayer()
    local view = {}
    view.origin = scanner:GetPos()
    view.angles = angles
    view.fov = scanner.Zoom or 90
    return view
end

function PLUGIN:PlayerButtonDown(ply,btn)
    if not ply:IsCP() then
        return
    end
    
    if not ply:IsScanner() then
        return
    end

    if not (btn == KEY_F2) then
        return
    end

    if (ply.lastSCNExitOpen or 0) > CurTime() then return end
    ply.lastSCNExitOpen = CurTime() + 2

    Derma_Query("Do you want to exit the scanner?","Scanner Exit","Yes",function()
        net.Start("impulseHL2RPExitScanner")
        net.SendToServer()
    end,"No")
end

local scannerColorModify = {
    ["$pp_colour_addr"] = 0,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 1,
    ["$pp_colour_colour"] = 1,
    ["$pp_colour_mulr"] = 0,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0
}

-- Draw the HUD for the scanner.
function PLUGIN:HUDPaint()
    if not LocalPlayer():IsScanner() then return end
    local scanner = LocalPlayer():GetScannerFromPlayer()
    local target = scanner:GetCurrentTarget()

    DrawColorModify(scannerColorModify)

    -- nutscript style scanner hud
    local boxWide, boxHeight = 580, 420
    local boxWide2, boxHeight2 = boxWide * 0.5, boxHeight * 0.5
    local scrW, scrH = ScrW() * 0.5, ScrH() * 0.5
    local x, y = scrW - boxWide2, scrH - boxHeight2
    local pos = scanner:GetPos()
    local ang = LocalPlayer():GetAimVector():Angle()
    
    --[[
    -- This is not yet in use, just a patch to fix current scanners.
    surface.SetDrawColor(235, 235, 235, 230)
    local target = scanner:GetCurrentTarget()
    if target then
        if scanner:IsPlayerKnown(target) then
            impulse.Surface.DrawText("Target: " .. target:GetRPName(), "impulseHL2RPScannerFontLARGE", scrW, ScrH() * 0.8, color_white, ALIGN_CENTER)
        elseif scanner:IsPlayerScanning(target) then
            impulse.Surface.DrawText("Target: Scanning...", "impulseHL2RPScannerFontLARGE", scrW, ScrH() * 0.8, color_white, ALIGN_CENTER)
        else
            impulse.Surface.DrawText("Target: ???", "impulseHL2RPScannerFontLARGE", scrW, ScrH() * 0.8, color_white, ALIGN_CENTER)
        end
    end
    ]]

    draw.SimpleText("POS ("..math.floor(pos[1])..", "..math.floor(pos[2])..", "..math.floor(pos[3])..")", "impulseHL2RPScannerFont", x + 8, y + 8, color_white)
    draw.SimpleText("ANG ("..math.floor(ang[1])..", "..math.floor(ang[2])..", "..math.floor(ang[3])..")", "impulseHL2RPScannerFont", x + 8, y + 24, color_white)
    draw.SimpleText("IAS ("..math.Round(scanner:GetVelocity():Length2D())..")", "impulseHL2RPScannerFont", x + 8, y + 40, color_white)
    draw.SimpleText("ID  ("..LocalPlayer():Name()..")", "impulseHL2RPScannerFont", x + 8, y + 56, color_white)
    draw.SimpleText("ZM  ("..math.Round(scanner.Zoom or 90)..")", "impulseHL2RPScannerFont", x + 8, y + 72, color_white)
    draw.SimpleText("F2  (DISMOUNT)", "impulseHL2RPScannerFont", x + 8, y + 88, color_white)
    draw.SimpleText("MDE (INCURSION)", "impulseHL2RPScannerFont", x + 8, y + 104, color_white)
    
    surface.SetDrawColor(color_white)
    surface.DrawLine(x, y, x + 128, y)
    surface.DrawLine(x, y, x, y + 128)

    x = scrW + boxWide2

    surface.DrawLine(x, y, x - 128, y)
    surface.DrawLine(x, y, x, y + 128)

    x = scrW - boxWide2
    y = scrH + boxHeight2

    surface.DrawLine(x, y, x + 128, y)
    surface.DrawLine(x, y, x, y - 128)

    x = scrW + boxWide2

    surface.DrawLine(x, y, x - 128, y)
    surface.DrawLine(x, y, x, y - 128)
end

function DrawScanned(panel,w,h)
    if not target_scan_cam_pos then return end
    local x,y = panel:GetPos()
    x,y = panel:LocalToScreen(x,y)
    local pos, ang = WorldToLocal(target_scan_cam_pos,target_scan_cam_ang,target_scan_ply_pos-target_scan_cam_pos,target_scan_ply_ang-target_scan_cam_ang)
    cam.Start3D(pos,ang,80,x,y,w,h)
        target_cached:DrawModel()
    cam.End3D()
end