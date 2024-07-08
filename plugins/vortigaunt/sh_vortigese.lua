
local vortCall = {
	"ep_02.vort_01_Vort_Call02c",
	"ep_02.vort_01_Vort_Call01",
}

local vortTalk = { -- all of these sentences are from wheat#7163 :)
	"Tak, Surr lillimah",
	"Churr galing chur alla gung.",
	"Chur lung gong chella gurr.",
	"Hy Alister Bahh'shaa, Hach?",
	"Alla'Lillimah, Ahhhr.",
	"Hy'Hach Karr.",
	"Kallah Keh, Bahh'lih!",
	"Uya'Ahhhr, Lillimah.",
	"Ha'leh, Bahh'lih!",
	"Bahh-nach ha-mah.",
	"Brun'Churr, Ga'net?",
	"Voo-surr Ulathoi Hi-shuu, Galalung.",
	"Tak'Surr, Joh!",
	"Det'Brun, Dan.",
	"Dan'Chaa, Lillimah!",
	"Dan'Chaa, Bahh'lih Neatly!"
}

local targs = {}
local Vortigese = {
	description = "The language spoken by the Vortigaunts. Non-vorts cannot understand/translate this.",
	requiresArg = true,
	requiresAlive = true,
	onRun = function(ply, arg, rawText)
		if ply:Team() ~= TEAM_VORT then
			return ply:Notify("You must be a Vortigaunt to use this command")
		end

		--if ply:GetSyncVar(SYNC_VORTESSENCE) == false then
		--	return ply:Notify("You must be free from your chains.")
		--end

		for k,v in pairs(player.GetAll()) do
			if (ply:GetPos() - v:GetPos()):LengthSqr() <= (impulse.Config.TalkDistance ^ 2) then
				v:SendChatClassMessage(66, rawText, ply)
			end
		end

		--if (ply.NextVortSound or 0) < CurTime() then
		--	ply:EmitSound(vortCall[math.random(1, #vortCall)])
		--	ply.NextVortSound = CurTime() + 30
		--end
	end
}
impulse.RegisterChatCommand("/vortigese", Vortigese)
impulse.RegisterChatCommand("/vorttalk", Vortigese)

if CLIENT then
	impulse.RegisterChatClass(66, function(message, speaker)

		if LocalPlayer():Team() ~= TEAM_VORT then
			message = vortTalk[math.random(1, #vortTalk)]
		end

		chat.AddText(Color(143, 41, 134), "[Vortigese] " .. speaker:Nick() ..": ", message)
	end)
end
