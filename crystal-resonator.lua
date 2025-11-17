-- Crystal Resonator - Advanced Beacon with Crystal Modules
-- 크리스탈 공명기 - 크리스탈 모듈 전용 고급 신호기

-- Crystal Resonator Building (4x4 size)
data:extend({
    {
        type = "beacon",
        name = "crystal-resonator",
        icon = "__base__/graphics/icons/beacon.png",  -- 임시
        flags = {"placeable-player", "player-creation"},
        minable = {mining_time = 0.5, result = "crystal-resonator"},
        fast_replaceable_group = "beacon",
        max_health = 300,
        corpse = "beacon-remnants",
        dying_explosion = "beacon-explosion",
        
        -- 4x4 크기 (짝수)
        collision_box = {{-1.7, -1.7}, {1.7, 1.7}},
        selection_box = {{-2.0, -2.0}, {2.0, 2.0}},
        
        drawing_box_vertical_extension = 0.7,
        
        -- 크리스탈 모듈만 허용
        allowed_effects = {"consumption", "speed", "productivity", "pollution"},
        allowed_module_categories = {"crystal-module"},
        
        -- 바닐라 비콘 그래픽 재사용 (크기만 조정)
        graphics_set = require("__base__.prototypes.entity.beacon-animations"),
        
        radius_visualisation_picture = {
            filename = "__base__/graphics/entity/beacon/beacon-radius-visualization.png",
            priority = "extra-high-no-scale",
            width = 10,
            height = 10
        },
        
        -- 매우 넓은 범위 (일반 신호기는 3)
        supply_area_distance = 30,
        
        -- 엄청나게 많은 모듈 슬롯
        module_slots = 20,
        
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input"
        },
        energy_usage = "5MW",  -- 매우 높은 전력 소비
        
        -- 효과 분배 (매우 약함)
        distribution_effectivity = 0.1,  -- 일반은 1.5, 우리는 극약체
        distribution_effectivity_bonus_per_quality_level = 0.05,
        
        -- 중복 방지: 2개 이상부터 효과 0
        profile = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        beacon_counter = "same_type",
        
        impact_category = "metal",
        open_sound = {filename = "__base__/sound/open-close/beacon-open.ogg", volume = 0.25},
        close_sound = {filename = "__base__/sound/open-close/beacon-close.ogg", volume = 0.25},
        
        water_reflection = {
            pictures = {
                filename = "__base__/graphics/entity/beacon/beacon-reflection.png",
                priority = "extra-high",
                width = 18,
                height = 29,
                shift = util.by_pixel(0, 55),
                variation_count = 1,
                scale = 5
            },
            rotate = false,
            orientation_to_variation = false
        }
    }
})

-- Crystal Resonator Item
data:extend({
    {
        type = "item",
        name = "crystal-resonator",
        icon = "__base__/graphics/icons/beacon.png",
        icon_size = 64,
        subgroup = "crystal-buildings",
        order = "b[crystal-resonator]",
        place_result = "crystal-resonator",
        stack_size = 10
    }
})

-- Crystal Resonator Recipe
data:extend({
    {
        type = "recipe",
        name = "crystal-resonator",
        enabled = false,
        ingredients = {
            {type = "item", name = "pure-crystal", amount = 50},
            {type = "item", name = "steel-plate", amount = 30},
            {type = "item", name = "advanced-circuit", amount = 30},
            {type = "item", name = "copper-cable", amount = 50}
        },
        energy_required = 15,
        results = {{type = "item", name = "crystal-resonator", amount = 1}}
    }
})

-- Module Category for Crystal Modules
data:extend({
    {
        type = "module-category",
        name = "crystal-module"
    }
})

-- Crystal Speed Module (매우 약한 효과)
data:extend({
    {
        type = "module",
        name = "crystal-speed-module",
        localised_description = {"item-description.crystal-speed-module"},
        icon = "__base__/graphics/icons/speed-module.png",  -- 임시
        subgroup = "crystal-items",
        category = "crystal-module",
        tier = 1,
        order = "d[crystal-module]-a[speed]",
        stack_size = 50,
        weight = 20 * 1000,
        effect = {
            speed = 0.08,  -- 일반 모듈은 0.2 (40% 효과)
            consumption = 0.25  -- 일반 모듈은 0.5
        },
        beacon_tint = {
            primary = {0.5, 0.9, 1.0, 1.0},  -- 청록색
            secondary = {0.7, 1.0, 1.0, 1.0}
        },
        art_style = "vanilla",
        requires_beacon_alt_mode = false
    }
})

-- Crystal Productivity Module
data:extend({
    {
        type = "module",
        name = "crystal-productivity-module",
        localised_description = {"item-description.crystal-productivity-module"},
        icon = "__base__/graphics/icons/productivity-module.png",  -- 임시
        subgroup = "crystal-items",
        category = "crystal-module",
        tier = 1,
        order = "d[crystal-module]-b[productivity]",
        stack_size = 50,
        weight = 20 * 1000,
        effect = {
            productivity = 0.015,  -- 일반 모듈은 0.04 (37.5% 효과)
            consumption = 0.2,
            pollution = 0.03,
            speed = -0.05
        },
        beacon_tint = {
            primary = {0.5, 0.9, 1.0, 1.0},
            secondary = {0.7, 1.0, 1.0, 1.0}
        },
        art_style = "vanilla",
        requires_beacon_alt_mode = false
    }
})

-- Crystal Efficiency Module
data:extend({
    {
        type = "module",
        name = "crystal-efficiency-module",
        localised_description = {"item-description.crystal-efficiency-module"},
        icon = "__base__/graphics/icons/efficiency-module.png",  -- 임시
        subgroup = "crystal-items",
        category = "crystal-module",
        tier = 1,
        order = "d[crystal-module]-c[efficiency]",
        stack_size = 50,
        weight = 20 * 1000,
        effect = {
            consumption = -0.12  -- 일반 모듈은 -0.3 (40% 효과)
        },
        beacon_tint = {
            primary = {0.5, 0.9, 1.0, 1.0},
            secondary = {0.7, 1.0, 1.0, 1.0}
        },
        art_style = "vanilla",
        requires_beacon_alt_mode = false
    }
})

-- Module Recipes
data:extend({
    {
        type = "recipe",
        name = "crystal-speed-module",
        enabled = false,
        ingredients = {
            {type = "item", name = "refined-crystal", amount = 5},
            {type = "item", name = "advanced-circuit", amount = 5},
            {type = "item", name = "electronic-circuit", amount = 5}
        },
        energy_required = 10,
        results = {{type = "item", name = "crystal-speed-module", amount = 1}}
    },
    {
        type = "recipe",
        name = "crystal-productivity-module",
        enabled = false,
        ingredients = {
            {type = "item", name = "refined-crystal", amount = 5},
            {type = "item", name = "advanced-circuit", amount = 5},
            {type = "item", name = "electronic-circuit", amount = 5}
        },
        energy_required = 10,
        results = {{type = "item", name = "crystal-productivity-module", amount = 1}}
    },
    {
        type = "recipe",
        name = "crystal-efficiency-module",
        enabled = false,
        ingredients = {
            {type = "item", name = "refined-crystal", amount = 5},
            {type = "item", name = "advanced-circuit", amount = 5},
            {type = "item", name = "electronic-circuit", amount = 5}
        },
        energy_required = 10,
        results = {{type = "item", name = "crystal-efficiency-module", amount = 1}}
    }
})

log("Crystal Resonator and Crystal Modules loaded")

