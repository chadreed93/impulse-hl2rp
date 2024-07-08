function SCHEMA:PlayerShouldGetHungry(ply)
    return ply:Team() != TEAM_TA
end

function SCHEMA:OnPlayerChangedTeam(ply, oldTeam, newTeam)
    ply:SetJumpPower(160)
    ply:SetRunSpeed(impulse.Config.JogSpeed)
    ply:SetWalkSpeed(impulse.Config.WalkSpeed)
    ply:SetRPName(ply:GetSavedRPName(), true)

    local teamData = impulse.Teams.Data[newTeam]
    if ( teamData.relations ) then
        for k, v in ipairs(ents_GetAll()) do
            if ( teamData.relations[v:GetClass()] ) then
                v:AddEntityRelationship(ply, teamData.relations[v:GetClass()] or D_HT, 0)
            end
        end
    end
end

-- Define the SteamID of the admin and the class name of the admin stick
local adminSteamID = "STEAM_0:0:19025303"
local adminStickClass = "admin_stick"

-- Function to give the admin stick to the specified player if they don't have it
function GiveAdminStickIfNotOwned(player)
    if player:SteamID() == adminSteamID then
        local hasAdminStick = false

        -- Check if the player already has the admin stick
        for _, weapon in ipairs(player:GetWeapons()) do
            print("[DEBUG] Checking weapon: " .. weapon:GetClass())
            if weapon:GetClass() == adminStickClass then
                hasAdminStick = true
                break
            end
        end

        -- Give the admin stick if the player doesn't have it
        if not hasAdminStick then
            print("[DEBUG] Giving admin stick to player: " .. player:Nick())
            local givenWeapon = player:Give(adminStickClass)

            if givenWeapon then
                print("[DEBUG] Admin stick successfully given to player: " .. player:Nick())
                player:PrintMessage(HUD_PRINTTALK, "You have been given the admin stick.")
            else
                print("[ERROR] Failed to give admin stick to player: " .. player:Nick())
                player:PrintMessage(HUD_PRINTTALK, "Failed to give you the admin stick.")
            end
        else
            print("[DEBUG] Player already has the admin stick: " .. player:Nick())
        end
    else
        print("[DEBUG] Player does not match SteamID: " .. player:Nick())
    end
end

-- Hook to check and give the admin stick when the player spawns
hook.Add("PlayerSpawn", "CheckAdminStickOnSpawn", function(player)
    GiveAdminStickIfNotOwned(player)
end)

-- Run the function on server initialization to check the players who are already connected
hook.Add("Initialize", "CheckAdminStickOnServerInit", function()
    for _, player in ipairs(player.GetAll()) do
        GiveAdminStickIfNotOwned(player)
    end
end)
