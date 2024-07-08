local setTeamClassCommand = {
    description = "Sets the class of the player specified.",
    requiresArg = true,
    etOnly = true,
    onRun = function(ply, arg, rawText)
        local name = arg[1]
        local class = arg[2]
        local targ = impulse.FindPlayer(name)

        class = tonumber(class)

        if not ply:IsEventTeamDirector() then
            return ply:Notify("You do not have permission to use this command.")
        end

        if not class or not tonumber(class) then
			ply:Notify("The class must be a number.")
            return
        end

        if targ and not IsValid(targ) then
            ply:Notify("Could not find player: "..tostring(name))
        end

        if targ then
            if targ:Team() == TEAM_CWU then
                if class < 3 then
                    targ:SetTeamClass(class)
                    ply:Notify("You have set "..targ:Name().."'s class to "..class..".")
                else
                    ply:Notify("Invalid class.")
                end
            elseif targ:Team() == TEAM_CP then
                if class < 5 then
                    targ:SetTeamClass(class)
                    ply:Notify("You have set "..targ:Name().."'s class to "..class..".")
                else
                    ply:Notify("Invalid class.")
                end
            elseif targ:Team() == TEAM_OTA then
                if class < 5 then
                    targ:SetTeamClass(class)
                    ply:Notify("You have set "..targ:Name().."'s class to "..class..".")
                else
                    ply:Notify("Invalid class.")
                end
            elseif targ:Team() == TEAM_ZOMBIE then
                if class < 5 then
                    targ:SetTeamClass(class)
                    ply:Notify("You have set "..targ:Name().."'s class to "..class..".")
                else
                    ply:Notify("Invalid class.")
                end
            else
                ply:Notify(targ:Name().."'s team does not have classes.")
            end
        end
    end
}

impulse.RegisterChatCommand("/setclass", setTeamClassCommand)