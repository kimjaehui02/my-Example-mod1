-- Crystal Centrifuge - Advanced Crystal Processing with 50% Base Productivity
-- 크리스탈 원심분리기 - 50% 기본 생산성 내장

-- Item
data:extend({
    {
        type = "item",
        name = "crystal-centrifuge",
        icon = "__base__/graphics/icons/centrifuge.png",  -- 일단 바닐라 아이콘
        icon_size = 64,
        subgroup = "crystal-buildings",
        order = "b[crystal-centrifuge]",
        place_result = "crystal-centrifuge",
        stack_size = 50,
        weight = 50 * kg
    }
})

-- Entity (Assembling Machine)
data:extend({
    {
        type = "assembling-machine",
        name = "crystal-centrifuge",
        icon = "__base__/graphics/icons/centrifuge.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.5, result = "crystal-centrifuge"},
        fast_replaceable_group = "centrifuge",
        max_health = 400,
        corpse = "centrifuge-remnants",
        dying_explosion = "medium-explosion",
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        drawing_box_vertical_extension = 0.7,
        
        -- 크리스탈 원심분리기 그래픽 (이름2 버전 사용!)
        graphics_set = {
            always_draw_idle_animation = true,
            idle_animation = {
                layers = {
                    -- Centrifuge C
                    {
                        filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-C.png",
                        priority = "high",
                        scale = 0.5,
                        line_length = 8,
                        width = 237,
                        height = 214,
                        frame_count = 64,
                        shift = {-0.0078125, -0.828125},
                        animation_speed = 0.5
                    },
                    {
                        filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-C-shadow.png",
                        draw_as_shadow = true,
                        priority = "high",
                        scale = 0.5,
                        line_length = 8,
                        width = 279,
                        height = 152,
                        frame_count = 64,
                        shift = {0.5234375, -0.3125},
                        animation_speed = 0.5
                    },
                    -- Centrifuge B
                    {
                        filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-B.png",
                        priority = "high",
                        scale = 0.5,
                        line_length = 8,
                        width = 156,
                        height = 234,
                        frame_count = 64,
                        shift = {0.71875, 0.203125},
                        animation_speed = 0.5
                    },
                    {
                        filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-B-shadow.png",
                        draw_as_shadow = true,
                        priority = "high",
                        scale = 0.5,
                        line_length = 8,
                        width = 251,
                        height = 149,
                        frame_count = 64,
                        shift = {1.9765625, 0.4765625},
                        animation_speed = 0.5
                    },
                    -- Centrifuge A
                    {
                        filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-A.png",
                        priority = "high",
                        scale = 0.5,
                        line_length = 8,
                        width = 139,
                        height = 246,
                        frame_count = 64,
                        shift = {-0.8203125, 0.109375},
                        animation_speed = 0.5
                    },
                    {
                        filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-A-shadow.png",
                        priority = "high",
                        draw_as_shadow = true,
                        scale = 0.5,
                        line_length = 8,
                        width = 230,
                        height = 124,
                        frame_count = 64,
                        shift = {0.265625, 0.734375},
                        animation_speed = 0.5
                    }
                }
            },
            
            -- 작동 시각 효과 (크리스탈 빛! - 이름2 버전 사용!)
            working_visualisations = {
                {
                    fadeout = true,
                    light = {intensity = 0.3, size = 12, shift = {0, 0}, color = {r = 0.5, g = 0.8, b = 1.0}}  -- 청록색 빛
                },
                {
                    fadeout = true,
                    animation = {
                        layers = {
                            -- Centrifuge C Light
                            {
                                filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-C-light2.png",
                                priority = "high",
                                scale = 0.5,
                                blend_mode = "additive",
                                line_length = 8,
                                width = 190,
                                height = 207,
                                frame_count = 64,
                                draw_as_glow = true,
                                shift = {0, -0.8515625},
                                animation_speed = 0.5
                            },
                            -- Centrifuge B Light
                            {
                                filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-B-light2.png",
                                priority = "high",
                                scale = 0.5,
                                blend_mode = "additive",
                                line_length = 8,
                                width = 131,
                                height = 206,
                                frame_count = 64,
                                draw_as_glow = true,
                                shift = {0.5234375, 0.015625},
                                animation_speed = 0.5
                            },
                            -- Centrifuge A Light
                            {
                                filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-A-light2.png",
                                priority = "high",
                                scale = 0.5,
                                blend_mode = "additive",
                                line_length = 8,
                                width = 108,
                                height = 197,
                                frame_count = 64,
                                draw_as_glow = true,
                                shift = {-0.7734375, 0.234375},
                                animation_speed = 0.5
                            }
                        }
                    }
                }
            }
        },
        
        open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.5},
        close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.5},
        working_sound = {
            sound = {
                filename = "__base__/sound/centrifuge-1.ogg",
                volume = 0.4
            },
            fade_in_ticks = 4,
            fade_out_ticks = 20
        },
        
        -- 제작 속성
        crafting_speed = 1.5,  -- 원심분리기보다 빠름
        crafting_categories = {"centrifuging", "crystal-refining"},  -- 원심분리기 + 크리스탈 정제!
        
        -- 🌟 50% 기본 생산성! (Space Age 기능)
        effect_receiver = {
            base_effect = {
                productivity = 0.5  -- 50% 생산성 내장!
            },
            uses_module_effects = true,
            uses_beacon_effects = true,
            uses_surface_effects = true
        },
        
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = {pollution = 2}  -- 크리스탈이라 깨끗함
        },
        energy_usage = "500kW",  -- 원심분리기(350kW)보다 조금 더 높음
        
        module_slots = 3,  -- 바닐라 원심분리기는 2개
        allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
        
        water_reflection = {
            pictures = {
                filename = "__base__/graphics/entity/centrifuge/centrifuge-reflection.png",
                priority = "extra-high",
                width = 28,
                height = 32,
                shift = {0, 2.03125},
                variation_count = 1,
                scale = 5
            },
            rotate = false,
            orientation_to_variation = false
        }
    }
})

-- Recipe
data:extend({
    {
        type = "recipe",
        name = "crystal-centrifuge",
        enabled = false,
        ingredients = {
            {type = "item", name = "iron-gear-wheel", amount = 100},
            {type = "item", name = "steel-plate", amount = 50},
            {type = "item", name = "advanced-circuit", amount = 100},
            {type = "item", name = "concrete", amount = 100}
        },
        results = {{type = "item", name = "crystal-centrifuge", amount = 1}},
        energy_required = 10
    }
})

-- 크리스탈 정제 레시피 (원심분리기용 - 더 효율적!)
data:extend({
    {
        type = "recipe",
        name = "refined-crystal-centrifuge",
        category = "crystal-refining",  -- 크리스탈 원심분리기에서 가능
        enabled = false,
        ingredients = {
            {type = "item", name = "raw-crystal", amount = 10}
        },
        results = {
            {type = "item", name = "refined-crystal", amount = 8}  -- 용광로(5개)보다 많음!
        },
        energy_required = 8,  -- 용광로보다 빠름
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-processing.png",
        icon_size = 64,
        subgroup = "crystal-items",
        order = "b[refined-crystal-centrifuge]",
        allow_productivity = true
    },
    {
        type = "recipe",
        name = "pure-crystal-centrifuge",
        category = "crystal-refining",
        enabled = false,
        ingredients = {
            {type = "item", name = "refined-crystal", amount = 5}
        },
        results = {
            {type = "item", name = "pure-crystal", amount = 4}  -- 용광로(2개)보다 많음!
        },
        energy_required = 12,
        icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/kovarex-enrichment-process.png",
        icon_size = 64,
        subgroup = "crystal-items",
        order = "c[pure-crystal-centrifuge]",
        allow_productivity = true
    }
})

-- Technology에 추가
table.insert(data.raw["technology"]["crystal-processing"].effects, {
    type = "unlock-recipe",
    recipe = "crystal-centrifuge"
})
table.insert(data.raw["technology"]["crystal-processing"].effects, {
    type = "unlock-recipe",
    recipe = "refined-crystal-centrifuge"
})
table.insert(data.raw["technology"]["crystal-processing"].effects, {
    type = "unlock-recipe",
    recipe = "pure-crystal-centrifuge"
})

log("Crystal Centrifuge loaded - 50% base productivity!")

