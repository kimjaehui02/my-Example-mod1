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
