local ITEM = {}



ITEM.UniqueID = "ration_ota"

ITEM.Category = "Rations"

ITEM.Name = "Overwatch Transhuman Arm Ration"

ITEM.Desc = "Filled with everything an Overwatch soldier need."

ITEM.Model = Model("models/uu_branded/weapons/w_packatm.mdl")

ITEM.Weight = 2

ITEM.FOV = 5.7908309455587

ITEM.CamPos = Vector(-160, -91.690544128418, 170)



ITEM.Droppable = true

ITEM.DropOnDeath = false



ITEM.Illegal = false

ITEM.CanStack = true



ITEM.UseName = "Open"

ITEM.UseWorkBarTime = 5

ITEM.UseWorkBarName = "Opening..."

ITEM.UseWorkBarSound = "impulse/craft/fabric/1.wav"



function ITEM:OnUse(ply)

    ply:GiveInventoryItem("food_ota",1,true)

    ply:GiveInventoryItem("rationcard_300",1,false)

    return true

end



impulse.RegisterItem(ITEM)