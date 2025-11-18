-- Crystal Fluid System
-- 크리스탈 에센스 유체 - 땅에서 추출하는 크리스탈 액체

-- Fluid Definition
data:extend({
    {
        type = "fluid",
        name = "crystal-essence",
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-235.png",
        icon_size = 64,
        subgroup = "fluid",
        order = "a[fluid]-g[crystal-essence]",
        default_temperature = 15,  -- 차가운 유체
        max_temperature = 100,
        heat_capacity = "0.1kJ",  -- 열용량 낮음
        base_color = {r = 0.4, g = 0.8, b = 1.0},  -- 밝은 청록색
        flow_color = {r = 0.6, g = 0.9, b = 1.0},  -- 더 밝은 청록색
        gas_temperature = 100,
        auto_barrel = true  -- 배럴 자동 생성
    }
})

-- Fluid Resource (매장지) - 석유처럼 땅에서 추출
local resource_autoplace = require("resource-autoplace")

-- 크리스탈 에센스 매장지 초기화
resource_autoplace.initialize_patch_set("crystal-essence", true)  -- true = infinite resource

data:extend({
    {
        type = "resource",
        name = "crystal-essence",
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-235.png",
        icon_size = 64,
        flags = {"placeable-neutral"},
        category = "basic-fluid",  -- 펌프잭으로 추출 가능!
        subgroup = "mineable-fluids",
        order = "a-b-crystal",
        infinite = true,  -- 무한 자원
        highlight = true,
        minimum = 30000,  -- 최소량 (고갈 시)
        normal = 150000,  -- 기본량
        infinite_depletion_amount = 5,  -- 고갈 속도
        resource_patch_search_radius = 8,
        tree_removal_probability = 0.8,
        tree_removal_max_distance = 32 * 32,
        minable = {
            mining_time = 1,
            results = {
                {
                    type = "fluid",
                    name = "crystal-essence",
                    amount_min = 5,
                    amount_max = 5,
                    probability = 1
                }
            }
        },
        collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        -- Factorio 2.0 autoplace 시스템
        autoplace = resource_autoplace.resource_autoplace_settings({
            name = "crystal-essence",
            order = "c",  -- 석유 이후
            base_density = 0.5,
            base_spots_per_km2 = 0.8,
            has_starting_area_placement = false,
            random_spot_size_minimum = 1,
            random_spot_size_maximum = 2,
            regular_rq_factor_multiplier = 1.0
        }),
        stage_counts = {0},
        stages = {
            sheet = {
                filename = "__base__/graphics/entity/crude-oil/crude-oil.png",
                priority = "extra-high",
                width = 75,
                height = 61,
                frame_count = 4,
                variation_count = 1,
                shift = {0.0, -0.1},
                tint = {r = 0.5, g = 0.9, b = 1.0, a = 0.9}  -- 청록색 틴트!
            }
        },
        map_color = {0.5, 0.9, 1.0},  -- 청록색
        map_grid = false
    }
})

-- Autoplace Control (맵 생성 옵션에 표시)
data:extend({
    {
        type = "autoplace-control",
        name = "crystal-essence",
        localised_name = {"", "[fluid=crystal-essence] ", {"autoplace-control-names.crystal-essence"}},
        category = "resource",
        richness = true,
        order = "b-z-crystal"
    }
})

log("Crystal Fluid System loaded - Crystal Essence!")

