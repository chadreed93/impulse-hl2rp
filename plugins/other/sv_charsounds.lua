local painSounds = {
	Sound("vo/npc/male01/pain01.wav"),
	Sound("vo/npc/male01/pain02.wav"),
	Sound("vo/npc/male01/pain03.wav"),
	Sound("vo/npc/male01/pain04.wav"),
	Sound("vo/npc/male01/pain05.wav"),
	Sound("vo/npc/male01/pain06.wav")
}

local drownSounds = {
	Sound("player/pl_drown1.wav"),
	Sound("player/pl_drown2.wav"),
	Sound("player/pl_drown3.wav"),
}

local deathSounds = {
	Sound("vo/npc/male01/pain07.wav"),
	Sound("vo/npc/male01/pain08.wav"),
	Sound("vo/npc/male01/pain09.wav")
}

function PLUGIN:GetPlayerPainSound(client)
	if (client:WaterLevel() >= 3) then
		return drownSounds[math.random(1, #drownSounds)]
	end
end

function PLUGIN:PlayerHurt(client, attacker, health, damage)
	if ((client.NextPain or 0) < CurTime() and health > 0) then
		local painSound = hook.Run("GetPlayerPainSound", client) or painSounds[math.random(1, #painSounds)]

		if (client:IsFemale() and !painSound:find("female")) then
			painSound = painSound:gsub("male", "female")
		end

        if client:Team() == TEAM_CP or client:Team() == TEAM_OTA or client:Team() == TEAM_VORT then
            painSound = impulse.Config.PainSounds[client:Team()][math.random(1,#impulse.Config.PainSounds[client:Team()])]
        end

		client:EmitSound(painSound)
		client.NextPain = CurTime() + 0.33
	end
end

function PLUGIN:PlayerDeath(client, inflictor, attacker)
	local deathSound = deathSounds[math.random(1, #deathSounds)]

	if (client:IsFemale() and !deathSound:find("female")) then
		deathSound = deathSound:gsub("male", "female")
	end

	if client:Team() == TEAM_CP or client:Team() == TEAM_OTA or client:Team() == TEAM_VORT then
		painSound = impulse.Config.DeathSounds[client:Team()][math.random(1,#impulse.Config.DeathSounds[client:Team()])]
	end

	client:EmitSound(deathSound)
end