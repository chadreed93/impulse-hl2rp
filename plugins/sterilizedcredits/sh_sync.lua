function PLUGIN:CreateSyncVars()
	SYNC_STCREDITS = impulse.Sync.RegisterVar(SYNC_BIGINT)
end

function meta:GetSterilizedCredits()
	return (self.GetSyncVar(self, SYNC_STCREDITS, nil) or 0)
end

if SERVER then
	function meta:SetSterilizedCredits(val)
		self:SetLocalSyncVar(SYNC_STCREDITS, val, true)
		self:GetData().sc = val
		self:SaveData()
	end
end