-- Crystal Farming System - Gleba Style
-- 크리스탈 결정 재배 시스템 (글레바의 농업 시스템처럼)

-- Crop Category
data:extend({
    {
        type = "recipe-category",
        name = "crystal-farming"
    }
})

-- Crystal Seed Item
data:extend({
    {
        type = "item",
        name = "crystal-seed",
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
        icon_size = 64,
        subgroup = "crystal-items",
        order = "d[crystal-seed]",
        stack_size = 100
    }
})

-- Crystal Crop Entity (작물)
data:extend({
    {
        type = "simple-entity",
        name = "crystal-crop",
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation", "not-on-map"},
        minable = {
            mining_time = 0.5,
            result = "raw-crystal",
            count = 2
        },
        max_health = 50,
        collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        picture = {
            filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/hr-uranium-ore.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.25
        }
    }
})

-- Crystal Farm Building (재배 시설)
data:extend({
    {
        type = "assembling-machine",
        name = "crystal-farm",
        icon = "__base__/graphics/icons/assembling-machine-1.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.5, result = "crystal-farm"},
        max_health = 300,
        corpse = "assembling-machine-1-remnants",
        dying_explosion = "assembling-machine-1-explosion",
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
        crafting_categories = {"crystal-farming"},
        crafting_speed = 0.5,  -- 느린 재배 속도
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = {pollution = 0}
        },
        energy_usage = "100kW",
        animation = {
            layers = {
                {
                    filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1.png",
                    priority = "high",
                    width = 108,
                    height = 114,
                    frame_count = 32,
                    line_length = 8,
                    shift = util.by_pixel(0, 2),
                    hr_version = {
                        filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1.png",
                        priority = "high",
                        width = 214,
                        height = 226,
                        frame_count = 32,
                        line_length = 8,
                        shift = util.by_pixel(0, 2),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1-shadow.png",
                    priority = "high",
                    width = 130,
                    height = 82,
                    frame_count = 32,
                    line_length = 8,
                    draw_as_shadow = true,
                    shift = util.by_pixel(28, 4),
                    hr_version = {
                        filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1-shadow.png",
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
                    filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1-light.png",
                    priority = "high",
                    width = 108,
                    height = 114,
                    frame_count = 32,
                    line_length = 8,
                    shift = util.by_pixel(0, 2),
                    draw_as_glow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1-light.png",
                        priority = "high",
                        width = 214,
                        height = 226,
                        frame_count = 32,
                        line_length = 8,
                        shift = util.by_pixel(0, 2),
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
                {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8},
                {filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8}
            },
            idle_sound = {filename = "__base__/sound/idle1.ogg", volume = 0.6},
            apparent_volume = 1.5
        }
    }
})

-- Crystal Farm Item
data:extend({
    {
        type = "item",
        name = "crystal-farm",
        icon = "__base__/graphics/icons/assembling-machine-1.png",
        icon_size = 64,
        subgroup = "crystal-buildings",
        order = "e[crystal-farm]",
        place_result = "crystal-farm",
        stack_size = 10
    }
})

-- Recipes
data:extend({
    {
        type = "recipe",
        name = "crystal-seed",
        enabled = false,
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
        icon_size = 64,
        ingredients = {
            {type = "item", name = "refined-crystal", amount = 1}
        },
        energy_required = 5,
        results = {
            {type = "item", name = "crystal-seed", amount = 2}
        }
    },
    {
        type = "recipe",
        name = "grow-crystal",
        category = "crystal-farming",
        enabled = false,
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
        icon_size = 64,
        ingredients = {
            {type = "item", name = "crystal-seed", amount = 1},
            {type = "fluid", name = "crystal-essence", amount = 10}
        },
        energy_required = 60,  -- 1분 재배
        results = {
            {type = "item", name = "raw-crystal", amount = 3}
        },
        allow_productivity = true
    },
    {
        type = "recipe",
        name = "crystal-farm",
        enabled = false,
        ingredients = {
            {type = "item", name = "iron-plate", amount = 20},
            {type = "item", name = "copper-plate", amount = 10},
            {type = "item", name = "refined-crystal", amount = 5}
        },
        energy_required = 10,
        results = {{type = "item", name = "crystal-farm", amount = 1}}
    }
})

log("Crystal Farming System loaded - Gleba style crystal crop growing!")



