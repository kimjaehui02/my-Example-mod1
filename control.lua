-- Crystal Factory Extended - Control Script

script.on_init(function()
    log("Crystal Factory Extended initialized")
end)

script.on_configuration_changed(function(data)
    if data.mod_changes and data.mod_changes["my Example-mod1"] then
        log("Crystal Factory Extended configuration changed")
    end
end)

-- 아르카나 전용 자원 생성기: 아르카나 행성에서만 작동
script.on_event(defines.events.on_built_entity, function(event)
    local entity = event.created_entity
    if entity and entity.name == "crystal-resource-generator" then
        local surface = entity.surface
        if surface and surface.name ~= "arcana" then
            -- 아르카나가 아니면 경고 메시지
            if event.player_index then
                local player = game.get_player(event.player_index)
                if player then
                    player.print({"crystal-factory.arcana-only-warning"})
                end
            end
        end
    end
end)

-- 자원 생성기 작동 제한: 아르카나에서만 레시피 실행 가능
script.on_event(defines.events.on_entity_settings_pasted, function(event)
    local entity = event.destination
    if entity and entity.name == "crystal-resource-generator" then
        local surface = entity.surface
        if surface and surface.name ~= "arcana" then
            -- 아르카나가 아니면 레시피 비활성화
            entity.set_recipe(nil)
        end
    end
end)

-- ============================================
-- 디버깅: 아르카나 행성에서 시작하기
-- 나중에 제거하려면 이 블록 전체를 삭제하거나 주석 처리하세요
-- ============================================
script.on_event(defines.events.on_player_created, function(event)
    local player = game.get_player(event.player_index)
    if not player then return end

    -- Space Age 모드가 로드되어 있는지 확인
    if not game.planets or not game.planets.arcana then
        log("Arcana planet not found - Space Age may not be loaded")
        return
    end

    -- 아르카나 표면 확인 및 생성
    local arcana_surface = game.surfaces["arcana"]
    if not arcana_surface then
        log("Arcana surface not found, creating it...")
        -- 표면 생성
        game.planets.arcana.create_surface()
        -- 생성 후 다시 확인
        arcana_surface = game.surfaces["arcana"]
        if not arcana_surface then
            log("Failed to create Arcana surface!")
            player.print("Debug: Failed to create Arcana surface")
            return
        end
        log("Arcana surface created successfully")
    end

    -- 플레이어를 아르카나로 텔레포트
    local success, error_msg = pcall(function()
        player.teleport({0, 0}, arcana_surface)
    end)
    
    if success then
        player.print("Debug: Starting on Arcana planet")
        log("Player teleported to Arcana successfully")
    else
        player.print("Debug: Failed to teleport to Arcana: " .. tostring(error_msg))
        log("Failed to teleport player: " .. tostring(error_msg))
    end
end)
-- ============================================
-- 디버깅 블록 끝
-- ============================================
