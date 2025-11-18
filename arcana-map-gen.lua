-- Arcana Map Generation - Small Crystal Moon
-- 작은 크리스탈 달 지형 생성

local ARCANA_RADIUS = 150  -- 반경 150타일

-- Noise expressions for circular terrain
data:extend({
    {
        type = "noise-expression",
        name = "arcana_radius",
        expression = tostring(ARCANA_RADIUS),
    },
    {
        type = "noise-expression",
        name = "arcana_map_distance",
        expression = "(x^2 + y^2)^(1/2)",
    },
    {
        type = "noise-expression",
        name = "arcana_surface",
        expression = "(arcana_radius - arcana_map_distance) / 20",
    },
    {
        type = "noise-expression",
        name = "arcana_water",
        expression = "max(0, (arcana_map_distance - arcana_radius + 5) * 10)",
    },
})

log("Arcana map generation expressions loaded - Radius: " .. ARCANA_RADIUS)

