local ITEM = {}



ITEM.UniqueID = "rationcard_80"

ITEM.Name = "Vortigaunt Credit"

ITEM.Desc =  "Some lose credits scavenged from around the ration machine."

ITEM.Category = "RationCard"

ITEM.Model = Model("models/uu_branded/bioshockinfinite/hext_coin.mdl")

ITEM.FOV = 14

ITEM.Weight = 0.1

ITEM.NoCenter = true



ITEM.Droppable = true

ITEM.DropOnDeath = true



ITEM.Illegal = false

ITEM.CanStack = true



ITEM.UseName = "Use"

ITEM.UseWorkBarTime = 1

ITEM.UseWorkBarName = "Depositing..."

ITEM.UseWorkBarFreeze = true

ITEM.UseWorkBarSound = "npc/vort/claw_swing2.wav"



function ITEM:OnUse(ply, ent)
    local traceent = ply:GetEyeTrace().Entity

    if IsValid(traceent) and traceent:GetClass("impulse_atm") then
        ply:Notify("You have recieved 80 credits.")
        ply:GiveBankMoney(80)
        return true
    else
        ply:Notify("You can't use that here.")
        return false 
    end
end



impulse.RegisterItem(ITEM)