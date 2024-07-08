local ITEM = {}

ITEM.UniqueID = "cos_elitevest"
ITEM.Name = "Salvaged Elite Ballistic Vest"
ITEM.Desc =  "A heavy vest, in ceremonial white. Provides additional ballistic protection. Salvaged from the body of an OTA Elite soldier."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/combine_vests/elitevest.mdl")
ITEM.FOV = 50
ITEM.NoCenter = true
ITEM.Weight = 9

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "chest"
ITEM.CanStack = false

ITEM.CosmeticData = {
	model = Model("models/combine_vests/elitevest.mdl"),
	pos = Vector(-3, -11, 0),
	ang = Angle(0, 90, 270),
	scale = 1,
	femalePos = Vector(-2, -9, 0),
	femaleScale = 0.8
}

impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse
impulse.Cosmetics[9] = ITEM.CosmeticData

function ITEM:CanEquip(ply)
	return not ply:IsCP()
end

function ITEM:OnEquip(ply)
	ply:SetSyncVar(SYNC_COS_CHEST, 9, true)
	ply.HasOTAVest = true
end

function ITEM:UnEquip(ply)
	ply:SetSyncVar(SYNC_COS_CHEST, nil, true)
	ply.HasOTAVest = false
end

impulse.RegisterItem(ITEM)
