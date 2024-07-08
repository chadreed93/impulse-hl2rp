local setMaterialCommand = {
    description = "Sets the material of the player specified.",
    requiresArg = true,
    sdOnly = true,
    onRun = function(ply, arg, rawText)

        local name = arg[1]
        local materialID = arg[2]
        local materialPath = arg[3]
        local targ = impulse.FindPlayer(name)

        local niceMaterialPath = tostring(materialPath)
        local numberMaterialID = tonumber(materialID)

        if not ply:IsSuperAdmin() then
            return ply:Notify("You do not have permission to use this command.")
        end

        if targ and not IsValid(targ) then
            ply:Notify("Could not find player: "..tostring(name))
        end

        if targ and IsValid(targ) then
            targ:SetSubMaterial(numberMaterialID, niceMaterialPath)
        end
    end
}

impulse.RegisterChatCommand("/setmaterial", setMaterialCommand)