target_cached = target_cached or nil 
target_scan_cam_pos = nil 
target_scan_cam_ang = nil
target_scan_ply_ang = nil
target_scan_ply_pos = nil 

net.Receive("impulseHL2RPStartScanning",function()
    local scanner = net.ReadEntity()
    local trg     = net.ReadEntity()

    target_cached = trg
    target_scan_cam_pos = LocalPlayer():EyePos() + Vector()
    target_scan_cam_ang = LocalPlayer():EyeAngles() + Angle()
    target_scan_ply_pos = target_cached:GetPos() + Vector()
    target_scan_ply_ang = target_cached:GetAngles() + Angle()

    scanner.ScanningPlayers[trg] = trg
end)

net.Receive("impulseHL2RPFinishScanning",function()
    local scanner = net.ReadEntity()
    local trg     = net.ReadEntity()
    scanner.ScanningPlayers[trg] = nil
    scanner.ScannedPlayers[trg] = trg
end)

IllegalItems = IllegalItems or {}

net.Receive("impulseHL2RPScannerAlert", function()
    local spotter = net.ReadEntity()
    local pos = net.ReadVector()

    impulse.AddCombineWaypoint("CONTRABAND SPOTTED BY AIRWATCH", pos, 90, 7, 4, 4, spotter)
end)