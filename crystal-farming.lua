-- Crystal Farming System - Gleba Style
-- 크리스탈 씨앗을 심어서 크리스탈 결정을 키우는 시스템
-- Gleba의 yumako-seed/yumako-tree 구조를 완전히 복사

-- Crystal Seed Item (yumako-seed 구조 복사)
data:extend({
    {
        type = "item",
        name = "crystal-seed",
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
        icon_size = 64,
        pictures = {
            { size = 64, filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png", scale = 0.5, mipmap_count = 4 },
            { size = 64, filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png", scale = 0.5, mipmap_count = 4 },
            { size = 64, filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png", scale = 0.5, mipmap_count = 4 },
            { size = 64, filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png", scale = 0.5, mipmap_count = 4 },
        },
        subgroup = "crystal-items",
        order = "d[crystal-seed]",
        plant_result = "crystal-crop",
        place_result = "crystal-crop",
        stack_size = 10,
        weight = 10 * 1000  -- 10kg
        -- 연료로 사용 불가 (fuel_category, fuel_value 제거)
    }
})

-- Crystal Crop Entity (yumako-tree 구조 복사 - plant 타입!)
local plant_emissions = { pollution = -0.001 }
local plant_harvest_emissions = { spores = 15 }
local plant_flags = {"placeable-neutral", "placeable-off-grid", "breaths-air"}

data:extend({
    {
        type = "plant",
        name = "crystal-crop",
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
        icon_size = 64,
        flags = plant_flags,
        minable = {
            mining_time = 0.5,
            results = {
                {type = "item", name = "raw-crystal", amount = 3},
                {type = "item", name = "crystal-seed", amount = 1, probability = 0.3}  -- 30% 확률로 씨앗 드롭
            }
        },
        growth_ticks = 30 * 60,  -- 30초 (디버깅용)
        harvest_emissions = plant_harvest_emissions,
        emissions_per_second = plant_emissions,
        max_health = 50,
        collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
        selection_box = {{-1, -3}, {1, 0.8}},
        drawing_box_vertical_extension = 0.8,
        subgroup = "trees",
        order = "a[tree]-z[crystal-crop]",
        impact_category = "tree",
        -- 생장 가능 지형 정보 (tile_buildability_rules 사용)
        tile_buildability_rules = {
            {
                area = {{-0.5, -0.5}, {0.5, 0.5}},
                required_tiles = {layers = {ground_tile = true}},  -- 땅 타일 위에만
                remove_on_collision = true
            }
        },
        -- 간단한 그래픽 (yumako-tree variations 구조 복사)
        -- normal 제거하여 같은 파일 충돌 방지
        variations = {
            {
                trunk = {
                    filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/hr-uranium-ore-glow2.png",  -- 다른 파일 사용
                    priority = "extra-high",
                    width = 128,
                    height = 128,
                    frame_count = 1,
                    scale = 0.3,
                    tint = {r = 0.5, g = 0.9, b = 1.0, a = 1.0}
                },
                leaves = {
                    filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/hr-uranium-ore.png",  -- trunk와 다른 파일
                    priority = "extra-high",
                    width = 128,
                    height = 128,
                    frame_count = 1,
                    scale = 0.3,
                    tint = {r = 0.5, g = 0.9, b = 1.0, a = 1.0}
                },
                shadow = {
                    frame_count = 2,
                    lines_per_file = 1,
                    line_length = 1,
                    width = 128,
                    height = 128,
                    shift = {0, 0},
                    scale = 0.3,
                    filenames = {
                        "__core__/graphics/empty.png",
                        "__core__/graphics/empty.png"
                    }
                },
                leaves_when_damaged = 0,
                leaves_when_destroyed = 0,
                leaves_when_mined_manually = 0,
                leaves_when_mined_automatically = 0,
                branches_when_damaged = 0,
                branches_when_destroyed = 0,
                branches_when_mined_manually = 0,
                branches_when_mined_automatically = 0
            }
        },
        colors = {
            {r = 255, g = 255, b = 255},
            {r = 220, g = 255, b = 255},
            {r = 255, g = 220, b = 255},
            {r = 255, g = 255, b = 220}
        },
        agricultural_tower_tint = {
            primary = {r = 0.5, g = 0.9, b = 1.0, a = 1.0},
            secondary = {r = 0.4, g = 0.8, b = 1.0, a = 1.0}
        },
        map_color = {0.5, 0.9, 1.0}
    }
})

-- Recipes
data:extend({
    {
        type = "recipe",
        name = "crystal-seed",
        category = "crafting",  -- crafting machine에서 제작 가능
        enabled = false,  -- 기술로 언락 필요
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
        icon_size = 64,
        ingredients = {
            {type = "item", name = "refined-crystal", amount = 1}
        },
        energy_required = 5,
        results = {
            {type = "item", name = "crystal-seed", amount = 2}
        }
    }
})

-- Technology
data:extend({
    {
        type = "technology",
        name = "crystal-farming",
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
        icon_size = 64,
        prerequisites = {"crystal-processing"},  -- 크리스탈 처리 기술 필요
        effects = {
            {
                type = "unlock-recipe",
                recipe = "crystal-seed"
            }
        },
        unit = {
            count = 100,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1}
            },
            time = 30
        },
        order = "c-c"
    }
})

log("Crystal Farming System loaded - Plant crystal seeds and grow crystals!")
