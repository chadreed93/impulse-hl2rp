
local function OrganizeNotices(i)
    local scrW = ScrW()*0.5
    local lastHeight = ScrH() - (ScrH()*0.2)

    for k, v in ipairs(impulse.notices) do
        local height = lastHeight - v:GetTall() - 10
        v:MoveTo(scrW - (v:GetWide()*0.5), height, 0.2, (k / #impulse.notices) * 0.25, nil)
        lastHeight = height
    end
end

function meta:RootsNotif(message, type)
    -- 1 is Good
    -- 2 is Bad
    -- 3 is Neutral

    if CLIENT then
        if not impulse.hudEnabled then
            return MsgN(message)
        end

        local notice

        if type == 1 then
            notice = vgui.Create("RootsNotifGood")
        elseif type == 2 then
            notice = vgui.Create("RootsNotifBad")
        else--if type == 3 then
            notice = vgui.Create("RootsNotifNeutral")
        end

        local i = table.insert(impulse.notices, notice)

        notice:SetMessage(message)
        notice:SetPos(ScrW()*0.5, ScrH() - (i - 1) * (notice:GetTall() + 4) + 4) -- needs to be recoded to support variable heights
        notice:MoveToFront() 
        OrganizeNotices(i)

        timer.Simple(7.5, function()
            if IsValid(notice) then
                notice:AlphaTo(0, 1, 0, function() 
                    notice:Remove()

                    for v,k in pairs(impulse.notices) do
                        if k == notice then
                            table.remove(impulse.notices, v)
                        end
                    end

                    OrganizeNotices(i)
                end)
            end
        end)

        MsgN(message)
    else
        net.Start("RootsNotif")
        net.WriteString(message)
        net.WriteUInt(type or 3, 8)
        net.Send(self)
    end
end



if CLIENT then
    
    net.Receive("RootsNotif", function(len)
	    local message = net.ReadString()
        local type = net.ReadUInt(8)

	    if not LocalPlayer() or not LocalPlayer().Notify then
	    	return
	    end
	
	    LocalPlayer():RootsNotif(message, type)
    end)

end