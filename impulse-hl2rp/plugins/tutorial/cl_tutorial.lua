color_white = Color(255,255,255,255)

function impulse.WorldText(text,pos,ang,col)

    col = col or table.Copy(color_white)

    cam.Start3D2D(pos,ang,0.1)

        draw.SimpleTextOutlined(text,"Impulse-Elements78",0,0,col,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,col.a))

     cam.End3D2D()     

end



function PLUGIN:PostDrawTranslucentRenderables(bDrawingDepth,bDrawingSkybox)

    if bDrawingDepth or bDrawingSkybox then return end

    if not impulse.Config.SpawnPos1 then return end

    if not LocalPlayer():InSpawn() then return end

    cam.Start3D2D(Vector(-7004.5600585938, 7164.51953125, -407.98178100586),Angle(0,-90,90),0.05)

        impulse.render.glowgo(-168*5,-45*5,337*5,91*5)

        draw.SimpleText("Half-Life 2: Roleplay","Impulse-Elements78",0,45*5.75,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

    cam.End3D2D()

    if LocalPlayer() and not (LocalPlayer().isNew) then return end

    --impulse.WorldText("Welcome to Landis: Half-Life 2 Roleplay!",Vector(-3906.4279785156, 2979.5344238281, 528.03125),Angle(180,0,-90))

    --impulse.WorldText("This is a brief tutorial to introduce you to our server.",Vector(-3558.6560058594, 2874.15234375, 528.03125),Angle(0,-90,90))

    --impulse.WorldText("You can toggle these messages at any time by typing \"/tutorial\" in chat.",Vector(-3186.0361328125, 2877.314453125, 528.03125),Angle(0,-90,90))

end