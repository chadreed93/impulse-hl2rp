local ITEM = {}



ITEM.UniqueID = "rationcard_300"

ITEM.Name = "Overwatch Transhuman Arm Credit"

ITEM.Desc =  "Redeemable at any ATM for credits."

ITEM.Category = "RationCard"

ITEM.Model = Model("models/dorado/tarjeta1.mdl")

ITEM.FOV = 20

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
        ply:Notify("You have recieved 300 credits.")
        ply:GiveBankMoney(300)
        return true
    else
        ply:Notify("You can't use that here.")
        return false 
    end
end

impulse.RegisterItem(ITEM)