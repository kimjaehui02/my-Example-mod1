-- Crystal Chemical Plant
-- 크리스탈 화학 공장 - 크리스탈 에센스와 크리스탈을 사용하는 특수 화학 공장

-- Recipe Category
data:extend({
    {
        type = "recipe-category",
        name = "crystal-chemistry"
    }
})

-- Item
data:extend({
    {
        type = "item",
        name = "crystal-chemical-plant",
        icon = "__my Example-mod1__/graphics/entity/icon/chemical-plant.png",
        icon_size = 64,
        subgroup = "crystal-buildings",
        order = "c[crystal-chemical-plant]",
        place_result = "crystal-chemical-plant",
        stack_size = 10,
        weight = 50 * kg
    }
})

-- Entity (Assembling Machine with fluid boxes)
data:extend({
    {
        type = "assembling-machine",
        name = "crystal-chemical-plant",
        icon = "__my Example-mod1__/graphics/entity/icon/chemical-plant.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.3, result = "crystal-chemical-plant"},
        fast_replaceable_group = "chemical-plant",
        max_health = 350,
        corpse = "chemical-plant-remnants",
        dying_explosion = "medium-explosion",
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        drawing_box_vertical_extension = 0.4,
        
        -- 크리스탈 화학공장 그래픽 (파란색!)
        graphics_set = {
            animation = {
                layers = {
                    {
                        filename = "__my Example-mod1__/graphics/entity/hr-chemical-plant.png",
                        priority = "high",
                        width = 220,
                        height = 292,
                        frame_count = 24,
                        line_length = 12,
                        shift = {0.015625, -0.28125},
                        scale = 0.5,
                        animation_speed = 0.5
                    },
                    {
                        filename = "__base__/graphics/entity/chemical-plant/chemical-plant-shadow.png",
                        priority = "high",
                        width = 312,
                        height = 222,
                        repeat_count = 24,
                        frame_count = 1,
                        shift = {0.96875, 0.15625},
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },
        
        open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.5},
        close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.5},
        working_sound = {
            sound = {
                filename = "__base__/sound/chemical-plant.ogg",
                volume = 0.5
            },
            fade_in_ticks = 4,
            fade_out_ticks = 20
        },
        
        -- 제작 속성
        crafting_speed = 1.25,  -- 일반 화학공장(1.0)보다 빠름
        crafting_categories = {"chemistry", "crystal-chemistry"},  -- 일반 화학 + 크리스탈 화학!
        
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = {pollution = 3}  -- 크리스탈이라 좀 깨끗함
        },
        energy_usage = "200kW",  -- 일반(210kW)보다 살짝 낮음
        
        module_slots = 4,  -- 일반(3)보다 많음!
        allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
        
        -- 유체 박스 (입력 2개, 출력 2개 - 화학공장 방식)
        fluid_boxes = {
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections = {
                    {
                        flow_direction = "input",
                        direction = defines.direction.north,
                        position = {-1, -1}
                    }
                }
            },
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections = {
                    {
                        flow_direction = "input",
                        direction = defines.direction.north,
                        position = {1, -1}
                    }
                }
            },
            {
                production_type = "output",
                pipe_covers = pipecoverspictures(),
                volume = 100,
                pipe_connections = {
                    {
                        flow_direction = "output",
                        direction = defines.direction.south,
                        position = {-1, 1}
                    }
                }
            },
            {
                production_type = "output",
                pipe_covers = pipecoverspictures(),
                volume = 100,
                pipe_connections = {
                    {
                        flow_direction = "output",
                        direction = defines.direction.south,
                        position = {1, 1}
                    }
                }
            }
        },
        
        water_reflection = {
            pictures = {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-reflection.png",
                priority = "extra-high",
                width = 28,
                height = 36,
                shift = {0.15625, 1.25},
                variation_count = 4,
                scale = 5
            },
            rotate = false,
            orientation_to_variation = true
        }
    }
})

-- Recipe (크리스탈 화학공장 제작)
data:extend({
    {
        type = "recipe",
        name = "crystal-chemical-plant",
        enabled = false,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 20},
            {type = "item", name = "iron-gear-wheel", amount = 20},
            {type = "item", name = "electronic-circuit", amount = 10},
            {type = "item", name = "pipe", amount = 10},
            {type = "item", name = "refined-crystal", amount = 10}  -- 크리스탈 필요!
        },
        results = {{type = "item", name = "crystal-chemical-plant", amount = 1}},
        energy_required = 8
    }
})

-- 예제 레시피: 크리스탈 에센스 정제
data:extend({
    {
        type = "recipe",
        name = "refined-essence",
        category = "crystal-chemistry",
        enabled = false,
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-235.png",
        icon_size = 64,
        subgroup = "crystal-items",
        order = "d[refined-essence]",
        ingredients = {
            {type = "fluid", name = "crystal-essence", amount = 50},
            {type = "item", name = "raw-crystal", amount = 2}
        },
        results = {
            {type = "item", name = "refined-crystal", amount = 5}
        },
        energy_required = 5,
        allow_productivity = true
    },
    -- 크리스탈 슬러리 (유체 출력)
    {
        type = "recipe",
        name = "crystal-slurry",
        category = "crystal-chemistry",
        enabled = false,
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-processing.png",
        icon_size = 64,
        subgroup = "fluid",
        order = "d[crystal-slurry]",
        ingredients = {
            {type = "item", name = "pure-crystal", amount = 1},
            {type = "fluid", name = "water", amount = 100}
        },
        results = {
            {type = "fluid", name = "crystal-essence", amount = 200}
        },
        energy_required = 8,
        allow_productivity = true
    }
})

-- Technology에 추가
table.insert(data.raw["technology"]["crystal-processing"].effects, {
    type = "unlock-recipe",
    recipe = "crystal-chemical-plant"
})
table.insert(data.raw["technology"]["crystal-processing"].effects, {
    type = "unlock-recipe",
    recipe = "refined-essence"
})
table.insert(data.raw["technology"]["crystal-processing"].effects, {
    type = "unlock-recipe",
    recipe = "crystal-slurry"
})

log("Crystal Chemical Plant loaded - Fluid processing!")

