CreateThread(function()
    while true do
        Wait(0)
        local sleep = true
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for k, v in pairs(Config.Zones) do
            for i=1, #v.Pos do
                if k == 'Arms' then
                    local dist = #(playerCoords - v.Pos[i])

                    if dist < Config.DrawDistance then
                        sleep = false
                        DrawMarker(v.Marker.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0, 0, 0, 0, 0, 0, v.Marker.Scale.x, v.Marker.Scale.y, v.Marker.Scale.z, v.Marker.Color.r, v.Marker.Color.g, v.Marker.Color.b, v.Marker.Color.a, false, false, 2, true, nil, nil, false)
                        if dist < 1 then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 0.1, '[E] Posilovat')
                            if IsControlJustPressed(0, 38) then
                                arms(v.Time)
                            end
                        end
                    end
                elseif k == 'Chins' then
                    local dist = #(playerCoords - v.Pos[i])

                    if dist < Config.DrawDistance then
                        sleep = false
                        DrawMarker(v.Marker.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0, 0, 0, 0, 0, 0, v.Marker.Scale.x, v.Marker.Scale.y, v.Marker.Scale.z, v.Marker.Color.r, v.Marker.Color.g, v.Marker.Color.b, v.Marker.Color.a, false, false, 2, true, nil, nil, false)
                        if dist < 1 then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 0.1, '[E] Posilovat')
                            if IsControlJustPressed(0, 38) then
                                chins(v.Time)
                            end
                        end
                    end
                elseif k == 'Pushups' then
                    local dist = #(playerCoords - v.Pos[i])

                    if dist < Config.DrawDistance then
                        sleep = false
                        DrawMarker(v.Marker.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0, 0, 0, 0, 0, 0, v.Marker.Scale.x, v.Marker.Scale.y, v.Marker.Scale.z, v.Marker.Color.r, v.Marker.Color.g, v.Marker.Color.b, v.Marker.Color.a, false, false, 2, true, nil, nil, false)
                        if dist < 1 then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 0.1, '[E] Klikovat')
                            if IsControlJustPressed(0, 38) then
                                pushups(v.Time)
                            end
                        end
                    end
                elseif k == 'Situps' then
                    local dist = #(playerCoords - v.Pos[i])

                    if dist < Config.DrawDistance then
                        sleep = false
                        DrawMarker(v.Marker.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0, 0, 0, 0, 0, 0, v.Marker.Scale.x, v.Marker.Scale.y, v.Marker.Scale.z, v.Marker.Color.r, v.Marker.Color.g, v.Marker.Color.b, v.Marker.Color.a, false, false, 2, true, nil, nil, false)
                        if dist < 1 then
                            DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 0.1, '[E] Sklapovat')
                            if IsControlJustPressed(0, 38) then
                                situps(v.Time)
                            end
                        end
                    end
                end
            end
        end

        if sleep then
            Wait(500)
        end
    end
end)

CreateThread(function()
	for k, v in pairs(Config.Zones) do
        if v.EnableBlips then
            for i=1, #v.Pos do
                if k == 'Blips' then
                    blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
                    SetBlipSprite(blip, v.Blip.Sprite)
                    SetBlipScale(blip, v.Blip.Scale)
                    SetBlipColour(blip, v.Blip.Colour)
                    SetBlipDisplay(blip, 4)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Blip.Name)
                    EndTextCommandSetBlipName(blip)
                end
            end
        end
	end
end)

function DrawText3D(x,y,z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z + 0.25)
	local p = GetGameplayCamCoords()
	local distance = #(vector3(p.x, p.y, p.z) - vector3(x, y, z))
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry('STRING')
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0135, 0.025+ factor, 0.03, 0, 0, 0, 150)
	end
end

function arms(time)
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, 'world_human_muscle_free_weights', 0, true)
    Wait(2500)
    exports['pogressBar']:drawBar(time, 'Posiluješ...')
    Wait(time)
    ClearPedTasks(playerPed)
end
exports('arms', arms)

function chins(time)
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, 'prop_human_muscle_chin_ups', 0, true)
    Wait(2500)
    exports['pogressBar']:drawBar(time, 'Posiluješ...')
    Wait(time)
    ClearPedTasks(playerPed)
end
exports('chins', chins)

function situps(time)
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, 'world_human_sit_ups', 0, true)
    Wait(2500)
    exports['pogressBar']:drawBar(time, 'Posiluješ...')
    Wait(time)
    ClearPedTasks(playerPed)
end
exports('situps', situps)

function pushups(time)
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, 'world_human_push_ups', 0, true)
    Wait(2500)
    exports['pogressBar']:drawBar(time, 'Posiluješ...')
    Wait(time)
    ClearPedTasks(playerPed)
end
exports('pushups', pushups)
