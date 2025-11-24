-- Arcana Map Generation - Small Crystal Moon
-- 세리스 모드의 맵 생성 방식을 정확히 복사

local ARCANA_RADIUS = 150

-- Noise expressions for circular terrain
data:extend({
    {
        type = "noise-expression",
        name = "arcana_radius",
        expression = tostring(ARCANA_RADIUS),
    },
    {
        -- 맵 중심(0,0)에서의 거리 계산
        type = "noise-expression",
        name = "arcana_map_distance",
        expression = "sqrt(x * x + y * y)",
    },
    {
        -- 섬 표면 높이: 반경 안은 양수, 밖은 음수 (elevation 기반)
        -- 이게 property_expression_names의 elevation로 사용됨
        -- 중앙(0,0)에서 거리가 150보다 작으면 양수, 크면 음수
        type = "noise-expression",
        name = "arcana_surface",
        expression = "(arcana_radius - arcana_map_distance) / 30",
    },
    {
        -- 땅 확률: elevation (arcana_surface)이 0 이상일 때만 생성
        -- 타일 autoplace는 이 probability_expression을 평가함
        -- 중앙 근처(거리 < 150)에서만 땅 생성
        type = "noise-expression",
        name = "arcana_land",
        expression = "if(arcana_surface >= 0, 1.0, 0)",
    },
    {
        -- 물 확률: elevation (arcana_surface)이 0 미만일 때만 생성
        -- 땅이 아닌 곳(거리 >= 150)에만 물 생성
        type = "noise-expression",
        name = "arcana_void",
        expression = "if(arcana_surface < 0, 1.0, 0)",
    },
    {
        -- 시작 지역 자원 보장 (중앙 근처에 강제 생성)
        type = "noise-expression",
        name = "arcana_starting_area",
        expression = "max(0, 10 - (arcana_map_distance / 20))",
    },
})

log("Arcana map generation expressions loaded")
