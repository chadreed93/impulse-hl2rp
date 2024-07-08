local setModelCommand = {
    description = "Sets the model of the player specified. Does not save to database.",
    requiresArg = true,
    etOnly = true,
    onRun = function(ply, arg, rawText)

        local name = arg[1]
        local model = arg[2]
        local plyTarget = impulse.FindPlayer(name)

        if not ply:IsEventTeamDirector() then
            return ply:Notify("You do not have permission to use this command.")
        end

        if plyTarget and not IsValid(plyTarget) then
            ply:Notify("Could not find player: "..tostring(name))
        end

        if plyTarget and IsValid(plyTarget) then
            plyTarget:SetModel(model)
        end
    end
}

impulse.RegisterChatCommand("/setmodel", setModelCommand)