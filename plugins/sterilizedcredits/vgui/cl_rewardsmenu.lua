local PANEL = {}

function PANEL:Init()
	self:SetSkin("combine")
	self:SetSize(600, 400)
	self:Center()
	self:MakePopup()
	self:SetTitle("Rewards Officer")
	self:LightArmor()
	self:CombatArmor()
	self:IncendiaryGrenade()
end

function PANEL:LightArmor()
	self.LightArmorContainer = vgui.Create("Panel", self)
	local pnl = self.LightArmorContainer
	function pnl:Paint(w, h)
		surface.SetDrawColor(45, 45, 45, 240)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 180)
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(100, 100, 100, 25)
		surface.DrawOutlinedRect(1, 1, w - 2, h - 2)

		draw.SimpleText("Light Armor", "impulseHL2RPScannerFont", 10, 10, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("50 SCs", "impulseHL2RPScannerFont", 10, 30, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		
	end
	--pnl:SetPaintBackground(true)
	pnl:SetSize(250,100)
	pnl:SetPos(25, 50)

	local mdl = vgui.Create("DModelPanel", pnl)
	mdl:SetSize(90, 90)
	mdl:SetPos(135, 5)
	
	mdl:SetModel(Model("models/nemez/combine_soldiers/combine_soldier_prop_vest.mdl"))
	mdl:SetFOV(24)
	mdl.Entity:SetPos(Vector(0,0,-10))

	local btn = vgui.Create("DButton", pnl)
	btn:Dock(BOTTOM)
	btn:SetText("Purchase")
	btn.DoClick = function()
		net.Start("impulseHL2RPClaimReward")
		net.WriteUInt(1, 3)
		net.SendToServer()
		self:Remove()
	end
end

function PANEL:CombatArmor()
	self.CombatArmorContainer = vgui.Create("Panel", self)
	local pnl = self.CombatArmorContainer
	function pnl:Paint(w, h)

		surface.SetDrawColor(45, 45, 45, 240)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 180)
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(100, 100, 100, 25)
		surface.DrawOutlinedRect(1, 1, w - 2, h - 2)

		draw.SimpleText("Combat Armor", "impulseHL2RPScannerFont", 10, 10, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("80 SCs", "impulseHL2RPScannerFont", 10, 30, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end
	--pnl:SetPaintBackground(true)
	pnl:SetSize(250,100)
	pnl:SetPos(25, 200)

	local mdl = vgui.Create("DModelPanel", pnl)
	mdl:SetSize(90, 90)
	mdl:SetPos(135, 5)
	
	mdl:SetModel(Model("models/nemez/combine_soldiers/combine_soldier_prop_vest_urban.mdl"))
	mdl:SetFOV(24)
	mdl.Entity:SetPos(Vector(0,0,-10))

	local btn = vgui.Create("DButton", pnl)
	btn:Dock(BOTTOM)
	btn:SetText("Purchase")
	btn.DoClick = function()
		net.Start("impulseHL2RPClaimReward")
		net.WriteUInt(2, 3)
		net.SendToServer()
		self:Remove()
	end
end

function PANEL:IncendiaryGrenade()
	self.IncendiaryGrenadeContainer = vgui.Create("Panel", self)
	local pnl = self.IncendiaryGrenadeContainer
	function pnl:Paint(w, h)

		surface.SetDrawColor(45, 45, 45, 240)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 180)
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(100, 100, 100, 25)
		surface.DrawOutlinedRect(1, 1, w - 2, h - 2)

		draw.SimpleText("Incendiary Grenade", "impulseHL2RPScannerFont", 10, 10, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("90 SCs", "impulseHL2RPScannerFont", 10, 30, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end
	--pnl:SetPaintBackground(true)
	pnl:SetSize(250,100)
	pnl:SetPos(325, 50)

	local mdl = vgui.Create("DModelPanel", pnl)
	mdl:SetSize(350, 350)
	mdl:SetPos(55, -175)
	
	mdl:SetModel(Model("models/weapons/w_eq_flashbang.mdl")) ---models/weapons/w_eq_flashbang.mdl
	mdl:SetFOV(50)
	mdl.Entity:SetPos(Vector(0,0,30))

	local btn = vgui.Create("DButton", pnl)
	btn:Dock(BOTTOM)
	btn:SetText("Purchase")
	btn.DoClick = function()
		net.Start("impulseHL2RPClaimReward")
		net.WriteUInt(3, 3)
		net.SendToServer()
		self:Remove()
	end
end



function PANEL:PaintOver(w, h)
	draw.SimpleText("You have " .. LocalPlayer():GetSterilizedCredits() .. " SCs", "impulseHL2RPScannerFont", w/2, h-10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
end

vgui.Register("impulseRewardsOfficerMenu", PANEL, "DFrame")
