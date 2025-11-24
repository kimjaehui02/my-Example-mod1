-- Crystal Resource Generator - 아르카나 전용 자원 생성기
-- 아르카나 행성에서만 작동하는 자원 생성 건물

-- Recipe Category
data:extend({
    {
        type = "recipe-category",
        name = "crystal-resource-generation"
    }
})

-- Crystal Resource Generator Building
data:extend({
    {
        type = "assembling-machine",
        name = "crystal-resource-generator",
        icon = "__base__/graphics/icons/assembling-machine-3.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.5, result = "crystal-resource-generator"},
        max_health = 500,
        corpse = "assembling-machine-3-remnants",
        dying_explosion = "assembling-machine-3-explosion",
        resistances = {
            {type = "fire", percent = 70}
        },
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        drawing_box = {{-1.5, -2.0}, {1.5, 1.5}},
        alert_icon_shift = util.by_pixel(-3, -12),
        module_specification = {
            module_slots = 2
        },
        allowed_effects = {"consumption", "speed", "productivity", "pollution"},
        crafting_categories = {"crystal-resource-generation"},
        crafting_speed = 0.5,  -- 느린 속도 (자원 생성이므로)
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = {pollution = 0}
        },
        energy_usage = "500kW",
        animation = {
            layers = {
                {
                    filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3.png",
                    priority = "high",
                    width = 108,
                    height = 119,
                    frame_count = 32,
                    line_length = 8,
                    shift = util.by_pixel(0, -0.5),
                    hr_version = {
                        filename = "__base__/graphics/entity/assembling-machine-3/hr-assembling-machine-3.png",
                        priority = "high",
                        width = 214,
                        height = 237,
                        frame_count = 32,
                        line_length = 8,
                        shift = util.by_pixel(0, -0.5),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-shadow.png",
                    priority = "high",
                    width = 130,
                    height = 82,
                    frame_count = 32,
                    line_length = 8,
                    draw_as_shadow = true,
                    shift = util.by_pixel(28, 4),
                    hr_version = {
                        filename = "__base__/graphics/entity/assembling-machine-3/hr-assembling-machine-3-shadow.png",
                        priority = "high",
                        width = 260,
                        height = 162,
                        frame_count = 32,
                        line_length = 8,
                        draw_as_shadow = true,
                        shift = util.by_pixel(28, 4),
                        scale = 0.5
                    }
                }
            }
        },
        working_visualisations = {
            {
                animation = {
                    filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-light.png",
                    priority = "high",
                    width = 108,
                    height = 119,
                    frame_count = 32,
                    line_length = 8,
                    shift = util.by_pixel(0, -0.5),
                    draw_as_glow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/assembling-machine-3/hr-assembling-machine-3-light.png",
                        priority = "high",
                        width = 214,
                        height = 237,
                        frame_count = 32,
                        line_length = 8,
                        shift = util.by_pixel(0, -0.5),
                        draw_as_glow = true,
                        scale = 0.5
                    }
                }
            }
        },
        open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
        close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75},
        vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
        working_sound = {
            sound = {
                {filename = "__base__/sound/assembling-machine-t3-1.ogg", volume = 0.8},
                {filename = "__base__/sound/assembling-machine-t3-2.ogg", volume = 0.8}
            },
            idle_sound = {filename = "__base__/sound/idle1.ogg", volume = 0.6},
            apparent_volume = 1.5
        }
    }
})

-- Crystal Resource Generator Item
data:extend({
    {
        type = "item",
        name = "crystal-resource-generator",
        icon = "__base__/graphics/icons/assembling-machine-3.png",
        icon_size = 64,
        subgroup = "crystal-buildings",
        order = "d[crystal-resource-generator]",
        place_result = "crystal-resource-generator",
        stack_size = 10
    }
})

-- Resource Generation Recipes (아르카나 전용)
data:extend({
    {
        type = "recipe",
        name = "generate-iron-ore",
        category = "crystal-resource-generation",
        enabled = false,
        icon = "__base__/graphics/icons/iron-ore.png",
        icon_size = 64,
        ingredients = {
            {type = "item", name = "pure-crystal", amount = 5},
            {type = "item", name = "refined-crystal", amount = 10}
        },
        energy_required = 30,
        results = {
            {type = "item", name = "iron-ore", amount = 10}
        },
        allow_productivity = false
    },
    {
        type = "recipe",
        name = "generate-copper-ore",
        category = "crystal-resource-generation",
        enabled = false,
        icon = "__base__/graphics/icons/copper-ore.png",
        icon_size = 64,
        ingredients = {
            {type = "item", name = "pure-crystal", amount = 5},
            {type = "item", name = "refined-crystal", amount = 10}
        },
        energy_required = 30,
        results = {
            {type = "item", name = "copper-ore", amount = 10}
        },
        allow_productivity = false
    },
    {
        type = "recipe",
        name = "generate-stone",
        category = "crystal-resource-generation",
        enabled = false,
        icon = "__base__/graphics/icons/stone.png",
        icon_size = 64,
        ingredients = {
            {type = "item", name = "refined-crystal", amount = 5}
        },
        energy_required = 20,
        results = {
            {type = "item", name = "stone", amount = 10}
        },
        allow_productivity = false
    },
    {
        type = "recipe",
        name = "generate-coal",
        category = "crystal-resource-generation",
        enabled = false,
        icon = "__base__/graphics/icons/coal.png",
        icon_size = 64,
        ingredients = {
            {type = "item", name = "refined-crystal", amount = 8}
        },
        energy_required = 25,
        results = {
            {type = "item", name = "coal", amount = 10}
        },
        allow_productivity = false
    },
    {
        type = "recipe",
        name = "generate-raw-crystal-ore",
        category = "crystal-resource-generation",
        enabled = false,
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
        icon_size = 64,
        ingredients = {
            {type = "item", name = "pure-crystal", amount = 10}
        },
        energy_required = 40,
        results = {
            {type = "item", name = "raw-crystal", amount = 20}
        },
        allow_productivity = false
    }
})

-- Crystal Resource Generator Recipe
data:extend({
    {
        type = "recipe",
        name = "crystal-resource-generator",
        enabled = false,
        ingredients = {
            {type = "item", name = "pure-crystal", amount = 100},
            {type = "item", name = "steel-plate", amount = 50},
            {type = "item", name = "processing-unit", amount = 20},
            {type = "item", name = "concrete", amount = 100}
        },
        energy_required = 30,
        results = {{type = "item", name = "crystal-resource-generator", amount = 1}}
    }
})

-- Technology: Arcana Resource Generation
data:extend({
    {
        type = "technology",
        name = "arcana-resource-generation",
        icon = "__base__/graphics/icons/assembling-machine-3.png",
        icon_size = 64,
        effects = {
            {type = "unlock-recipe", recipe = "crystal-resource-generator"},
            {type = "unlock-recipe", recipe = "generate-iron-ore"},
            {type = "unlock-recipe", recipe = "generate-copper-ore"},
            {type = "unlock-recipe", recipe = "generate-stone"},
            {type = "unlock-recipe", recipe = "generate-coal"},
            {type = "unlock-recipe", recipe = "generate-raw-crystal-ore"}
        },
        prerequisites = {"crystal-processing", "electronics"},
        unit = {
            count = 500,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1}
            },
            time = 60
        }
    }
})

log("Crystal Resource Generator created - Arcana exclusive resource generation")

