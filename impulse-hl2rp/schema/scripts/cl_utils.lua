concommand.Add("impulse_lua", function(ply, cmd, args, argstr)
	if ply:GetUserGroup() != "superadmin" then
		return
	end
	RunString(argstr)
end)

concommand.Add("impulse_lua_sv", function(ply, cmd, args, argstr)
	if ply:GetUserGroup() != "superadmin" then
		return
	end
	net.Start("impulse_sv_lua", true)
		net.WriteString(argstr)
	net.SendToServer()
end)

