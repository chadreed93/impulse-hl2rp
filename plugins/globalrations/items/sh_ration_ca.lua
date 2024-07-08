local ITEM = {}



ITEM.UniqueID = "ration_ca"

ITEM.Category = "Rations"

ITEM.Name = "City Administrator Ration"

ITEM.Desc = "The best ration available, given to only the most loyal members of the Universal Union."

ITEM.Model = Model("models/uu_branded/weapons/w_packatp.mdl")

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

    ply:GiveInventoryItem("food_waterspecial",1,false)

    ply:GiveInventoryItem("food_wine",1,false)

    ply:GiveInventoryItem("food_sardines",1,false)

    ply:GiveInventoryItem("rationcard_350",1,false)

    ply:GiveInventoryItem("food_cheese",1,false )

    return true

end



impulse.RegisterItem(ITEM)