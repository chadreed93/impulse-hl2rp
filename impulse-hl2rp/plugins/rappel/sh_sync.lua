function PLUGIN:SetupSyncVars()
	SYNC_RAPPELLING = impulse.Sync.RegisterVar(SYNC_BOOL)
	SYNC_RAPPEL_ANCHOR = impulse.Sync.RegisterVar(SYNC_VECTOR)
end