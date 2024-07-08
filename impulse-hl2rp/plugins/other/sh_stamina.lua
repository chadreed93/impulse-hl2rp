/*function AdjustStaminaOffset(ply, baseOffset)
    -- Ensure baseOffset is initialized
    if baseOffset == nil then
        baseOffset = 0
    end
    -- Additional logic if needed
end

function PLUGIN:AdjustStaminaOffset(client, baseOffset)
    -- Ensure baseOffset is initialized
    if baseOffset == nil then
        baseOffset = 0
    end
    return baseOffset * 2
end

function PlayerStaminaLost(ply)
end

function PlayerStaminaGained(ply)
end

SYNC_BRTH = impulse.Sync.RegisterVar(SYNC_BOOL)

local meta = FindMetaTable("Player")

local function CalcStaminaChange(ply)
    if not IsValid(ply) then return end
    if ply:Team() == TEAM_UNASSIGNED then return end

    local teamData = impulse.Teams.Data[ply:Team()] or {}
    local runSpeed = teamData.runSpeed or impulse.Config.JogSpeed or 0
    local walkSpeed = impulse.Config.WalkSpeed or 0
    local staminaDrain = impulse.Config.StaminaDrain or 0
    local staminaCrouchRegeneration = impulse.Config.StaminaCrouchRegeneration or 0
    local staminaRegeneration = impulse.Config.StaminaRegeneration or 0
    local offset

    if ply:GetMoveType() == MOVETYPE_NOCLIP then
        return 0
    end

    if ply:KeyDown(IN_SPEED) and ply:GetVelocity():LengthSqr() >= (walkSpeed * walkSpeed) then
        offset = -staminaDrain
    else
        offset = ply:Crouching() and staminaCrouchRegeneration or staminaRegeneration
    end

    offset = hook.Run("AdjustStaminaOffset", ply, offset) or offset

    if CLIENT then
        return offset
    else
        local current = ply:GetNW2Int("stm", 0)
        -- Ensure offset is a number
        offset = tonumber(offset) or 0
        local value = math.Clamp(current + offset, 0, impulse.Config.MaxStamina or 100)

        if current ~= value then
            ply:SetNW2Int("stm", value)

            if value == 0 and not ply:GetSyncVar(SYNC_BRTH, false) then
                ply:SetSyncVar(SYNC_BRTH, true)
                ply:SetRunSpeed(walkSpeed)

                hook.Run("PlayerStaminaLost", ply)

            elseif value >= 50 and ply:GetSyncVar(SYNC_BRTH, false) then
                ply:SetSyncVar(SYNC_BRTH, nil)
                ply:SetRunSpeed(runSpeed)

                hook.Run("PlayerStaminaGained", ply)
            end
        end
    end
end

if SERVER then
    function PLUGIN:PostSetupPlayer(ply)
        if ply:Team() == TEAM_UNASSIGNED then return end
        local uniqueID = "impulseStamina" .. ply:SteamID()

        timer.Create(uniqueID, 0.25, 0, function()
            if not IsValid(ply) then
                timer.Remove(uniqueID)
                return
            end

            CalcStaminaChange(ply)
        end)

        timer.Simple(0.25, function()
            ply:SetNW2Int("stm", ply.impulseData.stamina or impulse.Config.MaxStamina or 100)
        end)
    end

    function PLUGIN:PlayerDisconnected(ply)
        if ply:Team() == TEAM_UNASSIGNED then return end
        if not ply.impulseData then return end
        ply.impulseData.stamina = ply:GetNW2Int("stm", 0)
    end

    function meta:RestoreStamina(amount)
        if self:Team() == TEAM_UNASSIGNED then return end
        local current = self:GetNW2Int("stm", 0)
        local value = math.Clamp(current + amount, 0, impulse.Config.MaxStamina or 100)

        self:SetNW2Int("stm", value)
    end
    
    function meta:ConsumeStamina(amount)
        if self:Team() == TEAM_UNASSIGNED then return end
        local current = self:GetNW2Int("stm", 0)
        local value = math.Clamp(current - amount, 0, impulse.Config.MaxStamina or 100)

        self:SetNW2Int("stm", value)
    end
else
    local predictedStamina = 100

    function PLUGIN:Think(ply)
        local offset = CalcStaminaChange(LocalPlayer())
        if LocalPlayer():Team() == TEAM_UNASSIGNED then return end
        offset = math.Remap(FrameTime(), 0, 0.25, 0, offset)

        if offset ~= 0 then
            predictedStamina = math.Clamp(predictedStamina + offset, 0, impulse.Config.MaxStamina or 100)
        end
    end

    function PLUGIN:EntityNetworkedVarChanged(ply, key, _, new)
        if key ~= "stm" then return end
        if math.abs(predictedStamina - new) > 5 then
            predictedStamina = new
        end
    end
end

function meta:GetStamina()
    return self:GetNW2Int("stm", 0)
end

function PLUGIN:PlayerTick(ply)
    if not ply.NextStaminaBreath or ply.NextStaminaBreath <= CurTime() then
        local stamina = ply:GetNW2Int("stm", 100)
        if stamina <= 5 then
            ply:EmitSound("player/heartbeat1.wav", 60)
            ply:EmitSound("player/breathe1.wav", 60)
            ply.StaminaBreathing = true
            timer.Simple(3.9, function()
                if ply:IsValid() then
                    ply:StopSound("player/heartbeat1.wav")
                    ply:StopSound("player/breathe1.wav")
                    ply.StaminaBreathing = false
                end
            end)
            ply.NextStaminaBreath = CurTime() + 4
        end
    end
end

if CLIENT then
    local staminabluralpha = 0
    local staminabluramount = 0
    local staminablurmaxamount = 5

    function PLUGIN:HUDPaint()
        local frametime = RealFrameTime()

        if LocalPlayer().StaminaBreathing then
            staminabluralpha = Lerp(frametime / 2, staminabluralpha, 255)
            staminabluramount = Lerp(frametime / 2, staminabluramount, staminablurmaxamount)
        else
            staminabluralpha = Lerp(frametime / 2, staminabluralpha, 0)
            staminabluramount = Lerp(frametime / 2, staminabluramount, 0)
        end

        if DrawBlurAt then
            DrawBlurAt(0, 0, ScrW(), ScrH(), staminabluramount, 0.2, staminabluralpha)
        else
            print("Error: DrawBlurAt is not defined")
        end
    end
end
*?