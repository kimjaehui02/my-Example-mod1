-- Crystal Elevated Rail - Long Range Support
-- 기둥이 더 드문드문 필요한 고가 레일

require("__elevated-rails__.prototypes.entity.elevated-rail-pictures")

local hit_effects = require("__base__.prototypes.entity.hit-effects")

-- 기존 elevated rail을 복사하여 support_range를 늘림
-- support_range가 클수록 기둥이 더 드문드문 필요함

-- Long Range Rail Ramp (기존 9 -> 18로 증가, 2배)
local long_range_rail_ramp = table.deepcopy(data.raw["rail-ramp"]["rail-ramp"])
long_range_rail_ramp.name = "long-range-rail-ramp"
long_range_rail_ramp.icon = "__elevated-rails__/graphics/icons/rail-ramp.png"
long_range_rail_ramp.minable = {mining_time = 0.2, result = "long-range-rail-ramp", count = 1}
long_range_rail_ramp.support_range = 18  -- 기존 9의 2배

-- Long Range Elevated Straight Rail
local long_range_straight_rail = table.deepcopy(data.raw["elevated-straight-rail"]["elevated-straight-rail"])
long_range_straight_rail.name = "long-range-elevated-straight-rail"
long_range_straight_rail.order = "b[elevated-rail]-e[long-range-elevated-straight-rail]"
long_range_straight_rail.icon = "__elevated-rails__/graphics/icons/elevated-rail.png"
long_range_straight_rail.minable = {mining_time = 0.2, result = "long-range-rail", count = 1}
long_range_straight_rail.placeable_by = {item = "long-range-rail", count = 1}

-- Long Range Elevated Half Diagonal Rail
local long_range_half_diagonal_rail = table.deepcopy(data.raw["elevated-half-diagonal-rail"]["elevated-half-diagonal-rail"])
long_range_half_diagonal_rail.name = "long-range-elevated-half-diagonal-rail"
long_range_half_diagonal_rail.order = "b[elevated-rail]-f[long-range-elevated-half-diagonal-rail]"
long_range_half_diagonal_rail.deconstruction_alternative = "long-range-elevated-straight-rail"
long_range_half_diagonal_rail.icon = "__elevated-rails__/graphics/icons/elevated-half-diagonal-rail.png"
long_range_half_diagonal_rail.minable = {mining_time = 0.2, result = "long-range-rail", count = 2}
long_range_half_diagonal_rail.placeable_by = {item = "long-range-rail", count = 2}

-- Long Range Elevated Curved Rail A
local long_range_curved_rail_a = table.deepcopy(data.raw["elevated-curved-rail-a"]["elevated-curved-rail-a"])
long_range_curved_rail_a.name = "long-range-elevated-curved-rail-a"
long_range_curved_rail_a.order = "b[elevated-rail]-g[long-range-elevated-curved-rail-a]"
long_range_curved_rail_a.deconstruction_alternative = "long-range-elevated-straight-rail"
long_range_curved_rail_a.icon = "__elevated-rails__/graphics/icons/elevated-curved-rail.png"
long_range_curved_rail_a.minable = {mining_time = 0.2, result = "long-range-rail", count = 3}
long_range_curved_rail_a.placeable_by = {item = "long-range-rail", count = 3}

-- Long Range Elevated Curved Rail B
local long_range_curved_rail_b = table.deepcopy(data.raw["elevated-curved-rail-b"]["elevated-curved-rail-b"])
long_range_curved_rail_b.name = "long-range-elevated-curved-rail-b"
long_range_curved_rail_b.order = "b[elevated-rail]-h[long-range-elevated-curved-rail-b]"
long_range_curved_rail_b.deconstruction_alternative = "long-range-elevated-straight-rail"
long_range_curved_rail_b.icon = "__elevated-rails__/graphics/icons/elevated-curved-rail-b.png"
long_range_curved_rail_b.minable = {mining_time = 0.2, result = "long-range-rail", count = 3}
long_range_curved_rail_b.placeable_by = {item = "long-range-rail", count = 3}

-- Long Range Rail Support (기존 11 -> 22로 증가, 2배)
local long_range_rail_support = table.deepcopy(data.raw["rail-support"]["rail-support"])
long_range_rail_support.name = "long-range-rail-support"
long_range_rail_support.icon = "__elevated-rails__/graphics/icons/rail-support.png"
long_range_rail_support.minable = {mining_time = 0.5, result = "long-range-rail-support"}
long_range_rail_support.support_range = 22  -- 기존 11의 2배
long_range_rail_support.snap_to_spots_distance = 6  -- 기존 3의 2배

data:extend({
    long_range_rail_ramp,
    long_range_straight_rail,
    long_range_half_diagonal_rail,
    long_range_curved_rail_a,
    long_range_curved_rail_b,
    long_range_rail_support
})

-- Items
data:extend({
    {
        type = "item",
        name = "long-range-rail",
        icon = "__elevated-rails__/graphics/icons/elevated-rail.png",
        icon_size = 64,
        subgroup = "transport",
        order = "a[rail-system]-b[long-range-elevated-rail]",
        stack_size = 100,
        place_result = "long-range-elevated-straight-rail"
    },
    {
        type = "item",
        name = "long-range-rail-ramp",
        icon = "__elevated-rails__/graphics/icons/rail-ramp.png",
        icon_size = 64,
        subgroup = "transport",
        order = "a[rail-system]-a[long-range-rail-ramp]",
        stack_size = 50,
        place_result = "long-range-rail-ramp"
    },
    {
        type = "item",
        name = "long-range-rail-support",
        icon = "__elevated-rails__/graphics/icons/rail-support.png",
        icon_size = 64,
        subgroup = "transport",
        order = "a[rail-system]-c[long-range-rail-support]",
        stack_size = 50,
        place_result = "long-range-rail-support"
    }
})

-- Recipes
data:extend({
    {
        type = "recipe",
        name = "long-range-rail",
        enabled = false,
        ingredients = {
            {type = "item", name = "rail", amount = 1},
            {type = "item", name = "steel-plate", amount = 1}
        },
        energy_required = 0.5,
        results = {{type = "item", name = "long-range-rail", amount = 1}}
    },
    {
        type = "recipe",
        name = "long-range-rail-ramp",
        enabled = false,
        ingredients = {
            {type = "item", name = "rail-ramp", amount = 1},
            {type = "item", name = "steel-plate", amount = 2}
        },
        energy_required = 1,
        results = {{type = "item", name = "long-range-rail-ramp", amount = 1}}
    },
    {
        type = "recipe",
        name = "long-range-rail-support",
        enabled = false,
        ingredients = {
            {type = "item", name = "rail-support", amount = 1},
            {type = "item", name = "steel-plate", amount = 2}
        },
        energy_required = 1,
        results = {{type = "item", name = "long-range-rail-support", amount = 1}}
    }
})

-- Technology
data:extend({
    {
        type = "technology",
        name = "long-range-elevated-rail",
        icon = "__elevated-rails__/graphics/icons/elevated-rail.png",
        icon_size = 64,
        prerequisites = {"elevated-rail"},  -- 기존 elevated-rail 기술 필요
        effects = {
            {
                type = "unlock-recipe",
                recipe = "long-range-rail"
            },
            {
                type = "unlock-recipe",
                recipe = "long-range-rail-ramp"
            },
            {
                type = "unlock-recipe",
                recipe = "long-range-rail-support"
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
        order = "c-g"
    }
})

log("Long Range Elevated Rail System loaded - Wider pylon spacing!")


