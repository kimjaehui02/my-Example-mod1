-- Crystal Ocean Tile - 아르카나 전용 크리스탈 액체 지형
-- 아퀼로의 암모니아 바다를 정확히 그대로 복사

-- 필요한 모듈 로드
local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")

-- Space Age가 있을 때만 로드
local tile_trigger_effects = nil
local tile_pollution = nil
if mods["space-age"] then
    tile_trigger_effects = require("__space-age__.prototypes.tile.tile-trigger-effects")
    tile_pollution = require("__space-age__.prototypes.tile.tile-pollution-values")
end

-- 타일 서브그룹 정의
data:extend({
    {
        type = "item-subgroup",
        name = "arcana-tiles",
        group = "tiles",
        order = "z[arcana]"
    }
})

-- 크리스탈 오션 타일: water 타일을 복사하되 autoplace만 제거
-- autoplace는 planet-arcana.lua에서 독립적으로 관리하므로 참조 문제 없음
local crystal_ocean = table.deepcopy(data.raw.tile["water"])
crystal_ocean.name = "crystal-ocean"
crystal_ocean.order = "a[arcana-water]-a[crystal-ocean]"
crystal_ocean.subgroup = "arcana-tiles"
crystal_ocean.fluid = "crystal-essence"
crystal_ocean.collision_mask = tile_collision_masks.ammoniacal_ocean()
crystal_ocean.effect_color = {51, 204, 255}
crystal_ocean.effect_color_secondary = {102, 230, 255}
crystal_ocean.map_color = {51, 204, 255}
-- autoplace는 planet-arcana.lua의 autoplace_settings에서 관리
-- 타일 정의에도 autoplace가 필요하지만, 실제 값은 autoplace_settings에서 오버라이드됨
crystal_ocean.autoplace = {
    probability_expression = "arcana_void",
    richness_expression = 1
}

data:extend({crystal_ocean})

-- water_tile_type_names에 추가 (땅 타일이 해안선 전환을 인식하도록)
table.insert(water_tile_type_names, "crystal-ocean")

log("Crystal Ocean tile created")
