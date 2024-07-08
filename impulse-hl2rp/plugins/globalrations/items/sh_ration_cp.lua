local ITEM = {}



ITEM.UniqueID = "ration_cp"

ITEM.Category = "Rations"

ITEM.Name = "Civil Protection Ration"

ITEM.Desc = "A better ration designed to suit the needs of those that protect the Universal Union."

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

    ply:GiveInventoryItem("food_coffee",1,false)

    ply:GiveInventoryItem("food_cp",1,true)

    ply:GiveInventoryItem("food_chocolate")

    ply:GiveInventoryItem("rationcard_250",1,false)

    return true

end



impulse.RegisterItem(ITEM)