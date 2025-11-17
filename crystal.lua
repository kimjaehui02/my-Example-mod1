-- Crystal Production System - Zero Byproducts
-- 부산물 없는 순수한 크리스탈 생산 시스템

local processing_time = settings.startup["crystal-processing-time"].value or 10
local power_multiplier = settings.startup["crystal-power-multiplier"].value or 1.0

-- Item Group
data:extend({
    {
        type = "item-subgroup",
        name = "crystal-items",
        group = "intermediate-products",
        order = "z-crystal"
    },
    {
        type = "item-subgroup",
        name = "crystal-buildings",
        group = "production",
        order = "z-crystal"
    }
})

-- Items
data:extend({
    -- Raw Crystal (now minable ore)
    {
        type = "item",
        name = "raw-crystal",
        icon = "__base__/graphics/icons/uranium-ore.png",
        icon_size = 64,
        subgroup = "raw-resource",  -- 자원 그룹으로 변경
        order = "h[raw-crystal]",
        stack_size = 50,
        weight = 2 * 1000
    },
    -- Refined Crystal
    {
        type = "item",
        name = "refined-crystal",
        icon = "__base__/graphics/icons/uranium-235.png",
        icon_size = 64,
        subgroup = "crystal-items",
        order = "b[refined-crystal]",
        stack_size = 50,
        weight = 1 * 1000
    },
    -- Pure Crystal
    {
        type = "item",
        name = "pure-crystal",
        icon = "__base__/graphics/icons/rocket-fuel.png",
        icon_size = 64,
        subgroup = "crystal-items",
        order = "c[pure-crystal]",
        stack_size = 50,
        weight = 500
    },
    -- Crystal Refinery
    {
        type = "item",
        name = "crystal-refinery",
        icon = "__base__/graphics/icons/electric-furnace.png",
        icon_size = 64,
        subgroup = "crystal-buildings",
        order = "a[crystal-refinery]",
        place_result = "crystal-refinery",
        stack_size = 10
    }
})

-- Recipe Category
data:extend({
    {
        type = "recipe-category",
        name = "crystal-refining"
    }
})

-- Crystal Ore Resource (맵에서 채굴 가능)
-- Factorio 2.0에서는 resource_autoplace 시스템 필요
-- 간단하게: autoplace 제거, 치트로 생성하거나 Arcana 행성에서만 생성
local resource_autoplace = require("resource-autoplace")

-- 크리스탈 광석 패치 초기화
resource_autoplace.initialize_patch_set("raw-crystal-ore", false)

data:extend({
    {
        type = "resource",
        name = "raw-crystal-ore",
        icon = "__base__/graphics/icons/uranium-ore.png",
        flags = {"placeable-neutral"},
        order = "a-b-f",
        subgroup = "raw-resource",
        tree_removal_probability = 0.7,
        tree_removal_max_distance = 32 * 32,
        minable = {
            mining_time = 2,
            result = "raw-crystal",
            mining_particle = "stone-particle"
        },
        collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        -- Factorio 2.0 autoplace 시스템
        autoplace = resource_autoplace.resource_autoplace_settings({
            name = "raw-crystal-ore",
            order = "d",  -- 우라늄 이후
            base_density = 0.8,
            base_spots_per_km2 = 1.0,
            has_starting_area_placement = false,  -- 시작 지역에는 없음
            random_spot_size_minimum = 2,
            random_spot_size_maximum = 4,
            regular_rq_factor_multiplier = 1.0
        }),
        stage_counts = {10000, 6330, 3670, 1930, 870, 270, 100, 50},
        stages = {
            sheet = {
                filename = "__base__/graphics/entity/uranium-ore/uranium-ore.png",
                priority = "extra-high",
                width = 128,
                height = 128,
                frame_count = 8,
                variation_count = 8,
                scale = 0.5
            }
        },
        map_color = {0.5, 0.9, 1.0},  -- 청록색
        mining_visualisation_tint = {r = 0.5, g = 0.9, b = 1.0, a = 1.0}
    }
})

-- Autoplace Control (맵 생성 옵션에 표시)
data:extend({
    {
        type = "autoplace-control",
        name = "raw-crystal-ore",
        localised_name = {"", "[entity=raw-crystal-ore] ", {"entity-name.raw-crystal-ore"}},
        richness = true,
        order = "b-f",
        category = "resource"
    }
})

-- Building: Crystal Refinery
data:extend({
    {
        type = "furnace",
        name = "crystal-refinery",
        icon = "__base__/graphics/icons/electric-furnace.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.5, result = "crystal-refinery"},
        max_health = 350,
        corpse = "electric-furnace-remnants",
        dying_explosion = "electric-furnace-explosion",
        resistances = {
            {type = "fire", percent = 80}
        },
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        crafting_categories = {"crystal-refining"},
        energy_usage = tostring(500 * power_multiplier) .. "kW",
        crafting_speed = 2,
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = {pollution = 1}
        },
        source_inventory_size = 1,
        result_inventory_size = 1,
        graphics_set = {
            animation = {
                layers = {
                    {
                        filename = "__base__/graphics/entity/electric-furnace/electric-furnace.png",
                        priority = "high",
                        width = 239,
                        height = 219,
                        frame_count = 1,
                        shift = util.by_pixel(0.75, 5.75),
                        scale = 0.5
                    },
                    {
                        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-shadow.png",
                        priority = "high",
                        width = 227,
                        height = 171,
                        frame_count = 1,
                        draw_as_shadow = true,
                        shift = util.by_pixel(11.25, 7.75),
                        scale = 0.5
                    }
                }
            },
            working_visualisations = {
                {
                    fadeout = true,
                    effect = "flicker",
                    animation = {
                        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-heater.png",
                        priority = "high",
                        width = 60,
                        height = 56,
                        frame_count = 12,
                        animation_speed = 0.5,
                        shift = util.by_pixel(1.75, 32.75),
                        scale = 0.5
                    }
                }
            }
        },
        water_reflection = {
            pictures = {
                filename = "__base__/graphics/entity/electric-furnace/electric-furnace-reflection.png",
                priority = "extra-high",
                width = 24,
                height = 24,
                shift = util.by_pixel(5, 40),
                variation_count = 1,
                scale = 5
            },
            rotate = false,
            orientation_to_variation = false
        }
    }
})

-- Recipes - 100% Efficiency, Zero Byproducts
data:extend({
    -- Crystal Refinery Recipe
    {
        type = "recipe",
        name = "crystal-refinery",
        enabled = false,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 15},
            {type = "item", name = "advanced-circuit", amount = 10},
            {type = "item", name = "stone-brick", amount = 20}
        },
        energy_required = 5,
        results = {{type = "item", name = "crystal-refinery", amount = 1}}
    },
    -- Refined Crystal (100% efficiency)
    {
        type = "recipe",
        name = "refined-crystal",
        category = "crystal-refining",
        enabled = false,
        ingredients = {
            {type = "item", name = "raw-crystal", amount = 2}
        },
        energy_required = processing_time * 1.5,
        results = {{type = "item", name = "refined-crystal", amount = 1}},
        allow_productivity = true
    },
    -- Pure Crystal (100% efficiency)
    {
        type = "recipe",
        name = "pure-crystal",
        category = "crystal-refining",
        enabled = false,
        ingredients = {
            {type = "item", name = "refined-crystal", amount = 3}
        },
        energy_required = processing_time * 2,
        results = {{type = "item", name = "pure-crystal", amount = 1}},
        allow_productivity = true
    }
})

-- Technology
data:extend({
    {
        type = "technology",
        name = "crystal-processing",
        icon = "__base__/graphics/technology/production-science-pack.png",
        icon_size = 256,
        effects = {
            {type = "unlock-recipe", recipe = "crystal-refinery"},
            {type = "unlock-recipe", recipe = "refined-crystal"},
            {type = "unlock-recipe", recipe = "pure-crystal"},
            {type = "unlock-recipe", recipe = "crystal-resonator"},
            {type = "unlock-recipe", recipe = "crystal-speed-module"},
            {type = "unlock-recipe", recipe = "crystal-productivity-module"},
            {type = "unlock-recipe", recipe = "crystal-efficiency-module"}
        },
        prerequisites = {"steel-processing", "electronics"},
        unit = {
            count = 100,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1}
            },
            time = 30
        }
    }
})

