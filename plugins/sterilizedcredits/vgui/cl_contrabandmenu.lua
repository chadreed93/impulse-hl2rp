local PANEL = {}

function PANEL:Init()
	self:SetSize(600, 400)
	self:Center()
	self:SetSkin("combine")
	self:MakePopup()
	self:SetTitle("Contraband Officer")

	self.Contraband = vgui.Create("DScrollPanel", self, "ContrabandScroll")
	local pnl = self.Contraband
	pnl:SetSize(250, 300)
	pnl:SetPos(300,50)

	self.TurnIn = vgui.Create("DButton", self)
	
	self.TurnIn:SetText("Turn in all contraband")
	self.TurnIn:SizeToContents()
	self.TurnIn:SetPos(590-self.TurnIn:GetWide(),390-self.TurnIn:GetTall())
	self.TurnIn.DoClick = function()
		net.Start("impulseHL2RPTurnInContraband")
		net.SendToServer()
		self:Remove()
	end
end

function PANEL:DisplayContraband(inv)
	for i, item in ipairs(inv) do
		local itemData = impulse.Inventory.Items[impulse.Inventory.ClassToNetID(item.class)]
		if (itemData) then
			local panel = vgui.Create("DButton", self.Contraband)
			panel.itemid = item.id
			self.Contraband:AddItem(panel)
			panel:SetText(itemData.Name .. " - " .. (itemData.ConfiscateReward or 2) .. " SCs")
			panel:Dock(TOP)
		end
	end
end

local SC_Text = [[Sterilized credits are awarded to units
upon turning in confiscated items.

Sterilized Credits are used to make
purchases for higher-tier equipment
from the Nexus Armory.

EX: Armory, weaponry, health kits.]]

function PANEL:PaintOver(w, h)
	draw.SimpleText("Contraband You Have:", "impulseHL2RPScannerFont", 300, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
	draw.SimpleText("What are SCs?", "impulseHL2RPScannerFont", 10, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
	draw.SimpleText(LocalPlayer():GetSterilizedCredits() .. " SCs", "impulseHL2RPScannerFont", 10, h - 10, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
	draw.DrawText(SC_Text, "DebugFixed", 10, 50, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT)
end

vgui.Register("impulseContrabandMenu", PANEL, "DFrame")