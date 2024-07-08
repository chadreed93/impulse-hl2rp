impulse.Config.OTAReqCreditsBuyables = {
	["item_ziptie"] = {
		Restricted = true,
		Category = "Utilities",
		Max = 2,
		CanBuy = function(ply)
			return true
		end
	},
	["item_binoculars"] = {
		Restricted = true,
		Category = "Utilities",
		Max = 1,
		CanBuy = function(ply)
			return true
		end
	},
	["item_healthvial"] = {
		Restricted = true,
		Category = "Utilities",
		Max = 1,
		Cooldown = 600,
		CanBuy = function(ply)
			return true
		end
	},
	["item_suitbattery"] = {
		Restricted = true,
		Category = "Utilities",
		Max = 1,
		Cooldown = 600,
		CanBuy = function(ply)
			return true
		end
	},
	["item_breachingcharge"] = {
		Restricted = true,
		Category = "Utilities",
		Max = 3,
		CanBuy = function(ply)
			return true
		end
	},
	["wep_smokenade"] = {
		Desc = "AOS+ only",
		Restricted = true,
		Category = "Utilities",
		Max = 1,
		Cooldown = 300,
		CanBuy = function(ply)
			return ply:GetTeamRank() >= RANK_AOS
		end
	},
	["wep_grenade"] = {
		Desc = "AOS+ only",
		Restricted = true,
		Category = "Utilities",
		Max = 1,
		Cooldown = 300,
		CanBuy = function(ply)
			return ply:GetTeamRank() >= RANK_AOS
		end
	},
    ["wep_psmg"] = {
		Desc = "Grunt only",
		Restricted = true,
		Category = "Firearms",
		Max = 1,
		CanBuy = function(ply)
			return ply:GetTeamClass() == CLASS_GRUNT
		end
	},
    ["wep_ocipr"] = {
		Desc = "Ordinal only",
		Restricted = true,
		Category = "Firearms",
		Max = 1,
        CanBuy = function(ply)
			return ply:GetTeamClass() == CLASS_ORDINAL
		end
	},
	["wep_pshotgun"] = {
		Desc = "Wallhammer only",
		Restricted = true,
		Category = "Firearms",
		Max = 1,
		CanBuy = function(ply)
			return ply:GetTeamClass() == CLASS_WALLHAMMER
		end
	},
    ["wep_pminigun"] = {
    	Desc = "Suppressor only",
		Restricted = true,
		Category = "Firearms",
		Max = 1,
		CanBuy = function(ply)
			return ply:GetTeamClass() == CLASS_SUPPRESSOR
		end
	},
	
}

impulse.Config.OTAReqPurchaseItem = function(class, ply)
end