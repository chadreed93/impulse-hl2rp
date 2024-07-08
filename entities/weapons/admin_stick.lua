if CLIENT then
    SWEP.PrintName = "Stick Of God"
    SWEP.Slot = 0
    SWEP.SlotPos = 5
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = true

    surface.CreateFont("PlayerNameFont", {
        font = "Arial",
        size = 24,
        weight = 1000,
        antialias = true,
        shadow = false
    })
end

SWEP.Author = "RedMist, fixed by Nate"
SWEP.Instructions = "Left click to fire, right click to change"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "stunstick"

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.NextStrike = 0

SWEP.ViewModel = Model("models/weapons/v_stunbaton.mdl")
SWEP.WorldModel = Model("models/weapons/w_stunbaton.mdl")

SWEP.Sound1 = Sound("npc/metropolice/vo/moveit.wav")
SWEP.Sound2 = Sound("npc/metropolice/vo/movealong.wav")

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

-- Stunstick Effects
sound.Add({
    name = "lsStunstickBuzz",
    channel = CHAN_AUTO,
    volume = 0.34,
    level = 45,
    sound = "ambient/machines/combine_shield_touch_loop1.wav"
})

function SWEP:Initialize()
    if SERVER then
        self.Gear = 1
    end

    self:SetWeaponHoldType("normal")
end

local SLAP_SOUNDS = {
    "physics/body/body_medium_impact_hard1.wav",
    "physics/body/body_medium_impact_hard2.wav",
    "physics/body/body_medium_impact_hard3.wav",
    "physics/body/body_medium_impact_hard5.wav",
    "physics/body/body_medium_impact_hard6.wav",
    "physics/body/body_medium_impact_soft5.wav",
    "physics/body/body_medium_impact_soft6.wav",
    "physics/body/body_medium_impact_soft7.wav"
}

function SWEP:Precache()
end

function SWEP:DoFlash(ply)
    umsg.Start("StunStickFlash", ply)
    umsg.End()
end

local Gears = {}

local function AddGear(Title, Desc, SA, Func)
    table.insert(Gears, {Title, Desc, SA, Func})
end

function SWEP:PrimaryAttack()
    if CurTime() < self.NextStrike then return end
    if not self.Owner:IsAdmin() then
        self.Owner:Kick("God Stick, but...you're not an admin?")
        return false
    end

    self.Owner:SetAnimation(PLAYER_ATTACK1)
    local r, g, b, a = self.Owner:GetColor()

    self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)

    self.NextStrike = CurTime() + 0.3

    if CLIENT then return end

    local trace = self.Owner:GetEyeTrace()
    local Gear = self.Owner:GetTable().CurGear or 1

    if Gears[Gear][3] and not self.Owner:IsSuperAdmin() then
        self.Owner:Notify("This gear requires Super Admin status.")
        return false
    end

    -- Play zap sound and apply animation
    self.Owner:EmitSound("weapons/stunstick/stunstick_swing1.wav")
    self.Owner:StopSound("lsStunstickBuzz")
    self.Owner:EmitSound("lsStunstickBuzz")

    Gears[Gear][4](self.Owner, trace)
end

AddGear("Press Button", "Press a button on the map.", false,
function(Player, Trace)
    if IsValid(Trace.Entity) and Trace.Entity:GetClass() == "func_button" then
        Trace.Entity:Fire("Press")
        Player:PrintMessage(HUD_PRINTTALK, "Button pressed.")
    else
        Player:PrintMessage(HUD_PRINTTALK, "Not looking at a button.")
    end
end)

AddGear("[DEV]ENT Info", "Left Click to get Info of an Entity.", false,
function(Player)
    local Eyes = Player:GetEyeTrace().Entity:GetPos()
    local Eyes2 = Player:GetEyeTrace().Entity:GetAngles()
    local Eyes3 = Player:GetEyeTrace().Entity:GetModel()

    if CLIENT then
        SetClipboardText('Vector(' .. math.Round(Eyes.x) .. ', ' .. math.Round(Eyes.y) .. ', ' .. math.Round(Eyes.z) .. ')')
    end
    Player:PrintMessage(HUD_PRINTTALK, Eyes3)
    Player:PrintMessage(HUD_PRINTTALK, 'Vector(' .. math.Round(Eyes.x) .. ', ' .. math.Round(Eyes.y) .. ', ' .. math.Round(Eyes.z) .. ')\nAngle(' .. tostring(Eyes2) .. ')')
end)

AddGear("Disguise", "Left click to toggle disguise mode", false,
function(Player)
    Player:ConCommand("disguise")
end)

AddGear("Kill Player", "Aim at a player to slay him.", false,
function(Player, Trace)
    if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
        Trace.Entity:Kill()
        Player:PrintMessage(HUD_PRINTTALK, "Player killed.")
    end
end)

AddGear("Slap Player", "Aim at an entity to slap him.", false,
function(Player, Trace)
    if not Trace.Entity:IsPlayer() then
        local RandomVelocity = Vector(math.random(5000) - 2500, math.random(5000) - 2500, math.random(5000) - (5000 / 4))
        local RandomSound = SLAP_SOUNDS[math.random(#SLAP_SOUNDS)]

        Trace.Entity:EmitSound(RandomSound)
        Trace.Entity:GetPhysicsObject():SetVelocity(RandomVelocity)
        Player:PrintMessage(HUD_PRINTTALK, "Entity slapped.")
    else
        local RandomVelocity = Vector(math.random(500) - 250, math.random(500) - 250, math.random(500) - (500 / 4))
        local RandomSound = SLAP_SOUNDS[math.random(#SLAP_SOUNDS)]

        Trace.Entity:EmitSound(RandomSound)
        Trace.Entity:SetVelocity(RandomVelocity)
        Player:PrintMessage(HUD_PRINTTALK, "Player slapped.")
    end
end)

AddGear("Warn Player", "Aim at a player to warn him.", false,
function(Player, Trace)
    if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
        Trace.Entity:Notify("Don't be a mongoloid.")
        Player:PrintMessage(HUD_PRINTTALK, "Player warned.")
    end
end)

AddGear("Kick Player", "Aim at a player to kick him.", false,
function(Player, Trace)
    if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
        if Trace.Entity:SteamID() == "STEAM_0:0:19025303" then
            self.Owner:Kill()
            Player:PrintMessage(HUD_PRINTTALK, "Yeah no..")
        else
            Trace.Entity:Kick("Kicked.")
            Player:PrintMessage(HUD_PRINTTALK, "Player kicked.")
        end
    end
end)

AddGear("Respawn Player", "Aim at a player to respawn him.", false,
function(Player, Trace)
    if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
        Trace.Entity:Notify("An administrator has respawned you.")
        Trace.Entity:Spawn()
        Player:PrintMessage(HUD_PRINTTALK, "Player respawned.")
    end
end)

AddGear("Super Slap Player", "Aim at an entity to super slap him.", true,
function(Player, Trace)
    if IsValid(Trace.Entity) then
        if not Trace.Entity:IsPlayer() then
            local RandomVelocity = Vector(math.random(50000) - 25000, math.random(50000) - 25000, math.random(50000) - (50000 / 4))
            local RandomSound = SLAP_SOUNDS[math.random(#SLAP_SOUNDS)]

            Trace.Entity:EmitSound(RandomSound)
            Trace.Entity:GetPhysicsObject():SetVelocity(RandomVelocity)
            Player:PrintMessage(HUD_PRINTTALK, "Entity super slapped.")
        else
            local RandomVelocity = Vector(math.random(5000) - 2500, math.random(5000) - 2500, math.random(5000) - (5000 / 4))
            local RandomSound = SLAP_SOUNDS[math.random(#SLAP_SOUNDS)]

            Trace.Entity:EmitSound(RandomSound)
            Trace.Entity:SetVelocity(RandomVelocity)
            Player:PrintMessage(HUD_PRINTTALK, "Player super slapped.")
        end
    end
end)

AddGear("Unlock Door", "Aim at a door to unlock it.", true,
function(Player, Trace)
    if IsValid(Trace.Entity) then
        Trace.Entity:Fire('unlock', '', 0)
        Trace.Entity:Fire('open', '', 0.5)
        Player:PrintMessage(HUD_PRINTTALK, "Door unlocked.")
    end
end)

AddGear("Lock Door", "Aim at a door to lock it.", true,
function(Player, Trace)
    if IsValid(Trace.Entity) then
        Trace.Entity:Fire('lock', '', 0)
        Trace.Entity:Fire('close', '', 0.5)
        Player:PrintMessage(HUD_PRINTTALK, "Door locked.")
    end
end)

AddGear("Retrieve Item Owner", "Left click to retrieve owner of an item", true,
function(Player, Trace)
    if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
        Player:Notify("Don't be an idiot and ask for whos the owner of the player, tard.")
        return false
    end

    if IsValid(Trace.Entity) then
        if Trace.Entity:GetTable().ItemSpawner then
            Player:Notify("Owner: " .. Trace.Entity:GetTable().ItemSpawner:GetRPName() .. "[" .. Trace.Entity:GetTable().ItemSpawner:Nick() .. "]")
        elseif Trace.Entity.pickupPlayer then
            Player:Notify("Owner: " .. Trace.Entity.pickupPlayer:GetRPName() .. "[" .. Trace.Entity.pickupPlayer:Nick() .. "]")
        elseif Trace.Entity:GetTable().Owner then
            Player:Notify("Owner: " .. Trace.Entity:GetTable().Owner:GetRPName() .. "[" .. Trace.Entity:GetTable().Owner:Nick() .. "]")
        else
            Player:Notify("Unsupported entity")
        end
    end
end)

AddGear("Revive Player", "Aim at a corpse to revive the player.", true,
function(Player, Trace)
    umsg.Start('god_try_revive', Player)
    umsg.End()
end)

AddGear("Ignite", "Spawns a fire wherever you're aiming.", true,
function(Player, Trace)
    if IsValid(Trace.Entity) then
        Trace.Entity:Ignite(300)
    else
        local Fire = ents.Create('ent_fire')
        Fire:SetPos(Trace.HitPos)
        Fire:Spawn()

        Player:PrintMessage(HUD_PRINTTALK, "Fire started.")
    end
end)

AddGear("Teleport", "Teleports you to a targeted location.", true,
function(Player, Trace)
    local EndPos = Player:GetEyeTrace().HitPos
    local CloserToUs = (Player:GetPos() - EndPos):Angle():Forward()

    Player:SetPos(EndPos + (CloserToUs * 20))
    Player:PrintMessage(HUD_PRINTTALK, "Teleported.")
end)

AddGear("God Mode", "Left click to alternate between god and mortal.", true,
function(Player, Trace)
    if Player.IsGod then
        Player.IsGod = false
        Player:PrintMessage(HUD_PRINTTALK, "You are now vulnerable.")
        Player:GodDisable()
    else
        Player.IsGod = true
        Player:PrintMessage(HUD_PRINTTALK, "You are now invulnerable.")
        Player:GodEnable()
    end
end)

AddGear("Extinguish (Local)", "Extinguishes the fires near where you aim.", true,
function(Player, Trace)
    for k, v in pairs(ents.FindInSphere(Trace.HitPos, 250)) do
        if v:GetClass() == 'ent_fire' then
            v:Remove()
        end
    end

    Player:PrintMessage(HUD_PRINTTALK, "Fires extinguished nearby.")
end)

AddGear("Extinguish (All)", "Extinguishes all fires on the map.", true,
function(Player, Trace)
    for k, v in pairs(ents.FindByClass('ent_fire')) do
        v:Remove()
    end

    for k, v in pairs(player.GetAll()) do
        v:Notify("All fires on the map have been extinguished to preserve gameplay.")
    end

    Player:PrintMessage(HUD_PRINTTALK, "Fires extinguished.")
end)

AddGear("Disable Car", "Aim at a car to disable it.", true,
function(Player, Trace)
    if IsValid(Trace.Entity) and Trace.Entity:IsVehicle() then
        Trace.Entity:DisableVehicle(true)
        Player:PrintMessage(HUD_PRINTTALK, "Vehicle disabled.")
    end
end)

AddGear("Fix Car", "Aim at a disabled car to fix it.", true,
function(Player, Trace)
    if IsValid(Trace.Entity) and Trace.Entity:IsVehicle() then
        local Owner = Trace.Entity:GetNetworkedEntity("owner")
        Owner.HasDisabledCar = false
        Trace.Entity.Disabled = false
        Trace.Entity:SetColor(255, 255, 255, 255)
        Trace.Entity:Fire('turnon', '', 0.5)
        Player:PrintMessage(HUD_PRINTTALK, "Vehicle repaired.")
    end
end)

AddGear("Remover", "Aim at any object to remove it.", true,
function(Player, Trace)
    if IsValid(Trace.Entity) then
        if Trace.Entity:IsVehicle() and IsValid(Trace.Entity:GetDriver()) then
            Trace.Entity:GetDriver():ExitVehicle()
        end

        if string.find(tostring(Trace.Entity), "door") or string.find(tostring(Trace.Entity), "npc") or string.find(tostring(Trace.Entity), "ticket_check") or string.find(tostring(Trace.Entity), "car_display") or string.find(tostring(Trace.Entity), "prop_vehicle_prisoner_pod") or string.find(tostring(Trace.Entity), "gmod_playx_repeater") or string.find(tostring(Trace.Entity), "gmod_playx") or string.find(tostring(Trace.Entity), "theater_control") or string.find(tostring(Trace.Entity), "theater_control2") then
            return Player:PrintMessage(HUD_PRINTTALK, "Nope.")
        end

        if Trace.Entity:IsPlayer() then
            Trace.Entity:Kill()
        else
            Trace.Entity:Remove()
        end
    end
end)

AddGear("Explode", "Aim at any object to explode it.", true,
function(Player, Trace)
    if IsValid(Trace.Entity) then
        if Trace.Entity:IsVehicle() and IsValid(Trace.Entity:GetDriver()) then
            Trace.Entity:GetDriver():ExitVehicle()
        end

        if string.find(tostring(Trace.Entity), "door") or string.find(tostring(Trace.Entity), "npc") or string.find(tostring(Trace.Entity), "ticket_check") or string.find(tostring(Trace.Entity), "car_display") or string.find(tostring(Trace.Entity), "prop_vehicle_prisoner_pod") or string.find(tostring(Trace.Entity), "gmod_playx_repeater") or string.find(tostring(Trace.Entity), "gmod_playx") or string.find(tostring(Trace.Entity), "theater_control") or string.find(tostring(Trace.Entity), "theater_control2") then
            return Player:PrintMessage(HUD_PRINTTALK, "Nope.")
        end

        ExplodeInit(Trace.Entity:GetPos(), Player)

        timer.Simple(0.5, function()
            if IsValid(Trace.Entity) then
                if Trace.Entity:IsPlayer() then
                    Trace.Entity:Kill()
                elseif string.find(tostring(Trace.Entity), "jeep") then
                    Trace.Entity:DisableVehicle(true, false)
                else
                    Trace.Entity:Remove()
                end
            end
        end)
    end
end)

AddGear("Freeze", "Target a player to change his freeze state.", true,
function(Player, Trace)
    if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
        if Trace.Entity.IsFrozens then
            Trace.Entity:Freeze(false)
            Player:PrintMessage(HUD_PRINTTALK, "Player unfrozen.")
            Trace.Entity:PrintMessage(HUD_PRINTTALK, "You have been unfrozen.")
            Trace.Entity.IsFrozens = nil
        else
            Trace.Entity.IsFrozens = true
            Trace.Entity:Freeze(true)
            Player:PrintMessage(HUD_PRINTTALK, "Player frozen.")
            Trace.Entity:PrintMessage(HUD_PRINTTALK, "You have been frozen.")
        end
    end
end)

AddGear("Telekinesis (Stupid)", "Left click to make it float.", true,
function(Player, Trace)
    local self = Player:GetActiveWeapon()

    if self.Floater then
        self.Floater = nil
        self.FloatSmart = nil
    elseif IsValid(Trace.Entity) then
        self.Floater = Trace.Entity
        self.FloatSmart = nil
    end
end)

AddGear("Telekinesis (Smart)", "Left click to make it float and follow your crosshairs.", true,
function(Player, Trace)
    local self = Player:GetActiveWeapon()

    if self.Floater then
        self.Floater = nil
        self.FloatSmart = nil
    elseif IsValid(Trace.Entity) then
        self.Floater = Trace.Entity
        self.FloatSmart = true
    end
end)

AddGear("Demote", "Left click to demote a player.", false,
function(Player, Trace)
    Trace.Entity:Notify("An admin has demoted you.")

    if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
        if Trace.Entity:Team() == TEAM_POLICE then
            GAMEMODE.Police_Leave(Trace.Entity)
        elseif Trace.Entity:Team() == TEAM_MEDIC then
            GAMEMODE.Medic_Leave(Trace.Entity)
        elseif Trace.Entity:Team() == TEAM_FIREMAN then
            GAMEMODE.Fireman_Leave(Trace.Entity)
        elseif Trace.Entity:Team() == TEAM_SWAT then
            GAMEMODE.Swat_Leave(Trace.Entity)
        elseif Trace.Entity:Team() == TEAM_DISPATCHER then
            GAMEMODE.Dispatcher_Leave(Trace.Entity)
        elseif Trace.Entity:Team() == TEAM_SECRET_SERVICE then
            GAMEMODE.Secret_Service_Leave(Trace.Entity)
        elseif Trace.Entity:Team() == TEAM_MAYOR then
            GAMEMODE.Mayor_Leave(Trace.Entity)

            for k, v in pairs(player.GetAll()) do
                if v ~= Player and v ~= Trace.Entity then
                    v:Notify("The mayor has been impeached!")
                end
            end
        elseif Trace.Entity:Team() == TEAM_CITIZEN then
            Player:Notify("You cannot demote a citizen.")
            return false
        else
            return false
        end
    else
        return false
    end
end)

function SWEP:Think()
    if self.Floater then
        local trace = {}
        trace.start = self.Floater:GetPos()
        trace.endpos = trace.start - Vector(0, 0, 100000)
        trace.filter = {self.Floater}
        local tr = util.TraceLine(trace)

        local altitude = tr.HitPos:Distance(trace.start)
        local vec

        if self.FloatSmart then
            local trace = {}
            trace.start = self.Owner:GetShootPos()
            trace.endpos = trace.start + (self.Owner:GetAimVector() * 400)
            trace.filter = {self.Owner, self.Weapon}
            local tr = util.TraceLine(trace)

            vec = trace.endpos - self.Floater:GetPos()
        else
            vec = Vector(0, 0, 0)
        end

        if altitude < 150 then
            if vec == Vector(0, 0, 0) then
                vec = Vector(0, 0, 25)
            else
                vec = vec + Vector(0, 0, 100)
            end
        end

        vec:Normalize()

        if self.Floater:IsPlayer() then
            local speed = self.Floater:GetVelocity()
            self.Floater:SetVelocity((vec * 1) + speed)
        else
            local speed = self.Floater:GetPhysicsObject():GetVelocity()
            self.Floater:GetPhysicsObject():SetVelocity((vec * math.Clamp((self.Floater:GetPhysicsObject():GetMass() / 20), 10, 20)) + speed)
        end
    end
end

local chRotate = 0
function SWEP:DrawHUD()
    if not CLIENT then return end

    local godstickCrosshair = surface.GetTextureID("vgui/loading-rotate")
    local trace = self.Owner:GetEyeTrace()
    local x = ScrW() / 2
    local y = ScrH() / 2

    if IsValid(trace.Entity) then
        draw.WordBox(8, 8, 10, "Target: " .. tostring(trace.Entity), "PlayerNameFont", Color(50, 50, 75, 100), Color(255, 0, 0, 255))
        surface.SetDrawColor(255, 0, 0, 255)
        chRotate = chRotate + 8
    else
        draw.WordBox(8, 8, 10, "Target: " .. tostring(trace.Entity), "PlayerNameFont", Color(50, 50, 75, 100), Color(255, 255, 255, 255))
        surface.SetDrawColor(255, 255, 255, 255)
        chRotate = chRotate + 3
    end

    surface.SetTexture(godstickCrosshair)
    surface.DrawTexturedRectRotated(x, y, 64, 64, chRotate)
end

function MonitorWeaponVis()
    for k, v in pairs(player.GetAll()) do
        if v:IsAdmin() and IsValid(v:GetActiveWeapon()) then
            local pr, pg, pb, pa = v:GetColor()
            local wr, wg, wb, wa = v:GetActiveWeapon():GetColor()

            if pa == 0 and wa == 255 then
                v:GetActiveWeapon():SetColor(wr, wg, wb, 0)
            elseif pa == 255 and wa == 0 then
                v:GetActiveWeapon():SetColor(wr, wg, wb, 255)
            end
        end
    end
end
hook.Add('Think', 'MonitorWeaponVis', MonitorWeaponVis)

function MonitorKeysForFlymobile(Player, Key)
    if Player:InVehicle() and Player:GetVehicle().CanFly then
        local Force

        if Key == IN_ATTACK then
            Force = Player:GetVehicle():GetUp() * 450000
        elseif Key == IN_ATTACK2 then
            Force = Player:GetVehicle():GetForward() * 100000
        end

        if Force then
            Player:GetVehicle():GetPhysicsObject():ApplyForceCenter(Force)
        end
    end
end
hook.Add('KeyPress', 'MonitorKeysForFlymobile', MonitorKeysForFlymobile)

if SERVER then
    function GodSG(Player, Cmd, Args)
        Player:GetTable().CurGear = tonumber(Args[1])
    end
    concommand.Add('god_sg', GodSG)
end

timer.Simple(0.5, function() GAMEMODE.StickText = Gears[1][1] .. ' - ' .. Gears[1][2] end)

function SWEP:SecondaryAttack()
    if SERVER then return false end

    local MENU = DermaMenu()

    for k, v in pairs(Gears) do
        local Title = v[1]

        if v[3] then
            Title = "[SA] " .. Title
        end

        MENU:AddOption(Title, function()
            RunConsoleCommand('god_sg', k)
            LocalPlayer():PrintMessage(HUD_PRINTTALK, v[2])
            GAMEMODE.StickText = v[1] .. ' - ' .. v[2]
        end)
    end

    MENU:Open(100, 100)
    timer.Simple(0, function() gui.SetMousePos(110, 110) end)
end

function TryRevive()
    local EyeTrace = LocalPlayer():GetEyeTrace()

    for k, v in pairs(player.GetAll()) do
        if not v:Alive() then
            for _, ent in pairs(ents.FindInSphere(EyeTrace.HitPos, 5)) do
                if ent == v:GetRagdollEntity() then
                    RunConsoleCommand('perp_m_h', v:UniqueID())
                    LocalPlayer():PrintMessage(HUD_PRINTTALK, "Player revived.")
                    return
                end
            end
        end
    end
end
usermessage.Hook('god_try_revive', TryRevive)

-- Stunstick Glow and Effects
local STUNSTICK_GLOW_MATERIAL = Material("effects/stunstick")
local STUNSTICK_GLOW_MATERIAL2 = Material("effects/blueflare1")
local STUNSTICK_GLOW_MATERIAL_NOZ = Material("sprites/light_glow02_add_noz")

local color_glow = Color(128, 128, 128)

function SWEP:ExtraDrawWorldModel()
    self:DrawModel()

    local size = math.Rand(6.5, 7.5)
    local glow = math.Rand(0.6, 0.8) * 255
    local color = Color(glow, glow, glow)
    local attachment = self:GetAttachment(1)

    if (attachment) then
        local position = attachment.Pos

        render.SetMaterial(STUNSTICK_GLOW_MATERIAL2)
        render.DrawSprite(position, size * 2, size * 2, color)

        render.SetMaterial(STUNSTICK_GLOW_MATERIAL)
        render.DrawSprite(position, size, size + 3, color_glow)
    end
end

function SWEP:PostDrawViewModel()
    local vm = LocalPlayer():GetViewModel()

    if not IsValid(vm) then
        return
    end

    cam.Start3D(EyePos(), EyeAngles())
        local size = math.Rand(5.5, 6.5)
        local color = Color(255, 255, 255, 50 + math.sin(RealTime() * 2) * 20)

        STUNSTICK_GLOW_MATERIAL_NOZ:SetFloat("$alpha", color.a / 255)

        render.SetMaterial(STUNSTICK_GLOW_MATERIAL_NOZ)

        local attachment = vm:GetAttachment(vm:LookupAttachment("sparkrear"))

        if (attachment) then
            render.DrawSprite(attachment.Pos, size * 10, size * 15, color)
        end

        for i = 1, 9 do
            local attachment = vm:GetAttachment(vm:LookupAttachment("spark" .. i .. "a"))
            size = math.Rand(2.5, 5.0)

            if (attachment and attachment.Pos) then
                render.DrawSprite(attachment.Pos, size, size, color)
            end

            attachment = vm:GetAttachment(vm:LookupAttachment("spark" .. i .. "b"))
            size = math.Rand(2.5, 5.0)

            if (attachment and attachment.Pos) then
                render.DrawSprite(attachment.Pos, size, size, color)
            end
        end
    cam.End3D()
end
