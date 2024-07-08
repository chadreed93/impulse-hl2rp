--[[-
    Weapon Select plugin by Chessnut;
    lovingly ported to impulse by dylan.
-]]--

local PLUGIN = PLUGIN or {}


if (CLIENT) then

    local Enabled

	PLUGIN.index = PLUGIN.index or 1
	PLUGIN.deltaIndex = PLUGIN.deltaIndex or PLUGIN.index
	PLUGIN.infoAlpha = PLUGIN.infoAlpha or 0
	PLUGIN.alpha = PLUGIN.alpha or 0
	PLUGIN.alphaDelta = PLUGIN.alphaDelta or PLUGIN.alpha
	PLUGIN.fadeTime = PLUGIN.fadeTime or 0

	local matrixScale = Vector(1, 1, 0)
--[[-
    surface.CreateFont("ixWeaponSelectFont", {
        font = font,
        size = ScreenScale(16),
        extended = true,
        weight = 1000
    })
]]--

	function PLUGIN:HUDShouldDraw(name)
        if not Enabled then return end

		if (name == "CHudWeaponSelection") then
			return false
		end
	end
	function PLUGIN:HUDPaint()
        if not Enabled then return end

		local frameTime = FrameTime()

		PLUGIN.alphaDelta = Lerp(frameTime * 10, PLUGIN.alphaDelta, PLUGIN.alpha)

		local fraction = PLUGIN.alphaDelta

		if (fraction > 0.01) then
			local x, y = ScrW() * 0.5, ScrH() * 0.5
			local spacing = math.pi * 0.85
			local radius = 240 * PLUGIN.alphaDelta
			local shiftX = ScrW() * .02

			PLUGIN.deltaIndex = Lerp(frameTime * 12, PLUGIN.deltaIndex, PLUGIN.index)

			local weapons = LocalPlayer():GetWeapons()
			local index = PLUGIN.deltaIndex

			if (!weapons[PLUGIN.index]) then
				PLUGIN.index = #weapons
			end

			for i = 1, #weapons do
				local theta = (i - index) * 0.1
				local color = ColorAlpha(
					color_white,
					(255 - math.abs(theta * 3) * 255) * fraction
				)

				local lastY = 0

				if (PLUGIN.markup and (i < PLUGIN.index or i == 1)) then
					if (PLUGIN.index != 1) then
						local _, h = PLUGIN.markup:Size()
						lastY = h * fraction
					end

					if (i == 1 or i == PLUGIN.index - 1) then
						PLUGIN.infoAlpha = Lerp(frameTime * 3, PLUGIN.infoAlpha, 255)
						PLUGIN.markup:Draw(x + 6 + shiftX, y + 30, 0, 0, PLUGIN.infoAlpha * fraction)
					end
				end

				surface.SetFont("HUD")
				local weaponName = string.upper(weapons[i]:GetPrintName())
				local _, ty = surface.GetTextSize(weaponName)
				local scale = 1 - math.abs(theta * 2)

				local matrix = Matrix()
				matrix:Translate(Vector(
					shiftX + x + math.cos(theta * spacing + math.pi) * radius + radius,
					y + lastY + math.sin(theta * spacing + math.pi) * radius - ty / 2 ,
					1))
				matrix:Scale(matrixScale * scale)

				cam.PushModelMatrix(matrix)
					draw.DrawText(weaponName, (LocalPlayer():IsCP() and "HUD") or "HUD", 2, ty / 2, color, TEXT_ALIGN_LEFT )
				cam.PopModelMatrix()
			end

			if (PLUGIN.fadeTime < CurTime() and PLUGIN.alpha > 0) then
				PLUGIN.alpha = 0
			end
		end
	end

	function PLUGIN:OnIndexChanged(weapon)
        if not Enabled then return end

        local self = PLUGIN
		PLUGIN.alpha = 1
		PLUGIN.fadeTime = CurTime() + 1.5
		PLUGIN.markup = nil

		if (IsValid(weapon)) then
			local instructions = weapon.Instructions
			local text = ""

			if (instructions != nil and instructions:find("%S")) then
				local color = color_white
				text = text .. string.format(
					"<font=Impulse-Elements22-Shadow><color=%d,%d,%d>%s</font></color>\n%s\n",
					color.r, color.g, color.b, "Instructions", instructions
				)
			end

			if (text != "") then
				PLUGIN.markup = markup.Parse("<font=Impulse-LightUI18>"..text, ScrW() * 0.3)
				PLUGIN.infoAlpha = 0
			end

			local source, pitch = hook.Run("WeaponCycleSound")
			LocalPlayer():EmitSound(source or "impulse_redux/ui/linewriter"..math.random(1,8)..".mp3", 50, pitch or 180)
		end
	end

	function PLUGIN:PlayerBindPress(client, bind, pressed)
        if not Enabled then return end

        local self = PLUGIN
		bind = bind:lower()

		if (!pressed or !bind:find("invprev") and !bind:find("invnext")
		and !bind:find("slot") and !bind:find("attack")) then
			return
		end

		local currentWeapon = client:GetActiveWeapon()
		local bValid = IsValid(currentWeapon)
		local bTool

		if (client:InVehicle() or (bValid and currentWeapon:GetClass() == "weapon_physgun" and client:KeyDown(IN_ATTACK))) then
			return
		end

		if (bValid and currentWeapon:GetClass() == "gmod_tool") then
			local tool = client:GetTool()
			bTool = tool and (tool.Scroll != nil)
		end

		local weapons = client:GetWeapons()

		if (bind:find("invprev") and !bTool) then
			local oldIndex = PLUGIN.index
			PLUGIN.index = math.min(PLUGIN.index + 1, #weapons)

			if (PLUGIN.alpha == 0 or oldIndex != PLUGIN.index) then
				self:OnIndexChanged(weapons[PLUGIN.index])
			end

			return true
		elseif (bind:find("invnext") and !bTool) then
			local oldIndex = PLUGIN.index
			PLUGIN.index = math.max(PLUGIN.index - 1, 1)

			if (PLUGIN.alpha == 0 or oldIndex != PLUGIN.index) then
				self:OnIndexChanged(weapons[PLUGIN.index])
			end

			return true
		elseif (bind:find("slot")) then
			PLUGIN.index = math.Clamp(tonumber(bind:match("slot(%d)")) or 1, 1, #weapons)
			self:OnIndexChanged(weapons[PLUGIN.index])

			return true
		elseif (bind:find("attack") and PLUGIN.alpha > 0) then
			local weapon = weapons[PLUGIN.index]

			if (IsValid(weapon)) then
				LocalPlayer():EmitSound(hook.Run("WeaponSelectSound", weapon) or "impulse_redux/combine_terminals/combine_machines_select.wav")

				input.SelectWeapon(weapon)
				PLUGIN.alpha = 0
			end

			return true
		end
	end
	
	function PLUGIN:Think()

        Enabled = (impulse.GetSetting("hud_wepselecttype") == "Helix")

        if not Enabled then return end

        local self = PLUGIN
		local client = LocalPlayer()
		if (!IsValid(client) or !client:Alive()) then
			PLUGIN.alpha = 0
		end
	end

	function PLUGIN:ScoreboardShow()
        if not Enabled then return end

        local self = PLUGIN
		PLUGIN.alpha = 0
	end

	function PLUGIN:ShouldPopulateEntityInfo(entity)
        if not Enabled then return end

        local self = PLUGIN
		if (PLUGIN.alpha > 0) then
			return false
		end
	end
end

