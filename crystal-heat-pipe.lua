-- Crystal Heat Pipe
-- 크리스탈 열 파이프 - 빠른 열 전도, 낮은 최대온도, 낮은 비열

-- Helper function for heat pipe pictures (simplified version)
local function make_crystal_heat_pipe_pictures(path, name)
    local pictures = {
        straight_vertical = {
            {
                filename = path .. "hr-heat-pipe-straight-vertical-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        straight_horizontal = {
            {
                filename = path .. "hr-heat-pipe-straight-horizontal-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        corner_right_up = {
            {
                filename = path .. "hr-heat-pipe-corner-up-right-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        corner_left_up = {
            {
                filename = path .. "hr-heat-pipe-corner-up-left-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        corner_right_down = {
            {
                filename = path .. "hr-heat-pipe-corner-down-right-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        corner_left_down = {
            {
                filename = path .. "hr-heat-pipe-corner-down-left-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        t_up = {
            {
                filename = path .. "hr-heat-pipe-t-up-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        t_down = {
            {
                filename = path .. "hr-heat-pipe-t-down-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        t_right = {
            {
                filename = path .. "hr-heat-pipe-t-right-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        t_left = {
            {
                filename = path .. "hr-heat-pipe-t-left-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        cross = {
            {
                filename = path .. "hr-heat-pipe-t-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        ending_up = {
            {
                filename = path .. "hr-heat-pipe-ending-up-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        ending_down = {
            {
                filename = path .. "hr-heat-pipe-ending-down-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        ending_right = {
            {
                filename = path .. "hr-heat-pipe-ending-right-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        ending_left = {
            {
                filename = path .. "hr-heat-pipe-ending-left-1.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        },
        single = {
            {
                filename = path .. "hr-heat-pipe-straight-vertical-single.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                scale = 0.5
            }
        }
    }
    return pictures
end

-- Item
data:extend({
    {
        type = "item",
        name = "crystal-heat-pipe",
        icon = "__base__/graphics/icons/heat-pipe.png",
        icon_size = 64,
        subgroup = "crystal-buildings",
        order = "d[crystal-heat-pipe]",
        place_result = "crystal-heat-pipe",
        stack_size = 50,
        weight = 10 * kg
    }
})

-- Entity
data:extend({
    {
        type = "heat-pipe",
        name = "crystal-heat-pipe",
        icon = "__base__/graphics/icons/heat-pipe.png",
        icon_size = 64,
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 0.1, result = "crystal-heat-pipe"},
        fast_replaceable_group = "heat-pipe",
        max_health = 150,  -- 바닐라(200)보다 약함
        corpse = "heat-pipe-remnants",
        dying_explosion = "heat-pipe-explosion",
        collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        
        working_sound = {
            sound = {filename = "__base__/sound/heat-pipe.ogg", volume = 0.3},
            match_volume_to_activity = true,
            max_sounds_per_prototype = 3,
            fade_in_ticks = 4,
            fade_out_ticks = 20
        },
        
        -- 🌟 크리스탈 열 파이프 특성!
        heat_buffer = {
            max_temperature = 600,  -- 바닐라(1000)의 절반! 낮은 최대 온도
            specific_heat = "50kJ",  -- 바닐라(1MJ)보다 훨씬 낮음! 낮은 비열 (소문자 k!)
            max_transfer = "10GW",  -- 바닐라(1GW)의 10배! 초고속 열 전도!
            minimum_glow_temperature = 200,
            connections = {
                {position = {0, 0}, direction = defines.direction.north},
                {position = {0, 0}, direction = defines.direction.east},
                {position = {0, 0}, direction = defines.direction.south},
                {position = {0, 0}, direction = defines.direction.west}
            }
        },
        
        -- 커스텀 그래픽 (색이 다른 열 파이프!)
        connection_sprites = make_crystal_heat_pipe_pictures(
            "__my Example-mod1__/graphics/entity/scrap-pipe/entitiy/2/",
            "heat-pipe"
        ),
        
        heat_glow_sprites = make_crystal_heat_pipe_pictures(
            "__my Example-mod1__/graphics/entity/scrap-pipe/entitiy/2/",
            "heat-pipe"
        )
    }
})

-- Recipe
data:extend({
    {
        type = "recipe",
        name = "crystal-heat-pipe",
        enabled = false,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 5},
            {type = "item", name = "copper-plate", amount = 10},
            {type = "item", name = "refined-crystal", amount = 2}  -- 크리스탈 필요!
        },
        results = {{type = "item", name = "crystal-heat-pipe", amount = 1}},
        energy_required = 1
    }
})

-- Technology에 추가
table.insert(data.raw["technology"]["crystal-processing"].effects, {
    type = "unlock-recipe",
    recipe = "crystal-heat-pipe"
})

log("Crystal Heat Pipe loaded - Fast heat transfer, low temperature!")

