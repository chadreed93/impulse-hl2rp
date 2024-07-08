local sudoCommand = {
    description = "Force a player to say something :troll:",
    requiresArg = true,
	superAdminOnly = true,
    onRun = function(ply, arg, rawText)
        local name = arg[1]
        local message = string.sub(rawText, (string.len(name) + 2))
		message = string.Trim(message)

		if not ply:IsSuperAdmin() then
            return
			ply:Notify("You cannot use this command.")
        end

        local targ = impulse.FindPlayer(name)
        if targ and IsValid(targ) then
            targ:Say(message)
            ply:Notify("You have forced "..targ:SteamName().." to say: "..message..".")
        else
            return ply:Notify("Could not find player: "..tostring(targ))
        end
end
}

impulse.RegisterChatCommand("/sudo", sudoCommand)