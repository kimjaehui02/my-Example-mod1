-- Crystal Train - Short Train System
-- 짧은 기차 시스템 (기존 기차보다 작은 크기)

-- Short Locomotive (짧은 기관차)
-- 크기: 기존의 1/2 (정수배)
-- 컨셉: 최대 속도는 낮지만 가속이 빠름
local short_locomotive = table.deepcopy(data.raw["locomotive"]["locomotive"])
short_locomotive.name = "short-locomotive"
short_locomotive.icon = "__base__/graphics/icons/locomotive.png"
short_locomotive.icon_size = 64
short_locomotive.minable = {mining_time = 0.5, result = "short-locomotive"}
-- 기존: {{-0.6, -2.6}, {0.6, 2.6}} (길이 5.2) -> 1/2배: {{-0.6, -1.3}, {0.6, 1.3}} (길이 2.6)
short_locomotive.collision_box = {{-0.6, -1.3}, {0.6, 1.3}}
short_locomotive.selection_box = {{-1, -1.5}, {1, 1.5}}
short_locomotive.connection_distance = 2  -- 타일 단위로 맞춤 (기존 3의 2/3)
short_locomotive.joint_distance = 2  -- 타일 단위로 맞춤 (기존 4의 1/2)
short_locomotive.weight = 1000  -- 무게 절반
short_locomotive.max_power = "1000kW"  -- 출력 매우 높게 (가속 빠르게)
short_locomotive.max_speed = 0.8  -- 최대 속도는 낮게 유지 (기존 1.2의 2/3)
short_locomotive.air_resistance = 0.001  -- 공기 저항 매우 낮춤 (가속 빠르게)
short_locomotive.friction_force = 0.10  -- 마찰력 매우 낮춤 (가속 빠르게)

data:extend({short_locomotive})

-- Short Cargo Wagon (짧은 화물차)
-- 크기: 기존의 1/2 (정수배)
local short_cargo_wagon = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
short_cargo_wagon.name = "short-cargo-wagon"
short_cargo_wagon.icon = "__base__/graphics/icons/cargo-wagon.png"
short_cargo_wagon.icon_size = 64
short_cargo_wagon.minable = {mining_time = 0.5, result = "short-cargo-wagon"}
-- 기존: {{-0.6, -2.4}, {0.6, 2.4}} (길이 4.8) -> 1/2배: {{-0.6, -1.2}, {0.6, 1.2}} (길이 2.4)
short_cargo_wagon.collision_box = {{-0.6, -1.2}, {0.6, 1.2}}
short_cargo_wagon.selection_box = {{-1, -1.5}, {1, 1.5}}
short_cargo_wagon.inventory_size = 20  -- 인벤토리 크기 절반
short_cargo_wagon.connection_distance = 2  -- 타일 단위로 맞춤 (기존 3의 2/3)
short_cargo_wagon.joint_distance = 2  -- 타일 단위로 맞춤 (기존 4의 1/2)
short_cargo_wagon.weight = 500  -- 무게 절반
short_cargo_wagon.max_speed = 0.8  -- 최대 속도는 낮게 유지 (기존 1.5의 약 절반)
short_cargo_wagon.air_resistance = 0.001  -- 공기 저항 매우 낮춤 (가속 빠르게)
short_cargo_wagon.friction_force = 0.10  -- 마찰력 매우 낮춤 (가속 빠르게)

data:extend({short_cargo_wagon})

-- Items
data:extend({
    {
        type = "item",
        name = "short-locomotive",
        icon = "__base__/graphics/icons/locomotive.png",
        icon_size = 64,
        subgroup = "transport",
        order = "a[train-system]-b[short-locomotive]",
        place_result = "short-locomotive",
        stack_size = 5
    },
    {
        type = "item",
        name = "short-cargo-wagon",
        icon = "__base__/graphics/icons/cargo-wagon.png",
        icon_size = 64,
        subgroup = "transport",
        order = "a[train-system]-c[short-cargo-wagon]",
        place_result = "short-cargo-wagon",
        stack_size = 5
    }
})

-- Recipes
data:extend({
    {
        type = "recipe",
        name = "short-locomotive",
        enabled = false,
        ingredients = {
            {type = "item", name = "engine-unit", amount = 10},
            {type = "item", name = "electronic-circuit", amount = 10},
            {type = "item", name = "steel-plate", amount = 30}
        },
        energy_required = 4,
        results = {{type = "item", name = "short-locomotive", amount = 1}}
    },
    {
        type = "recipe",
        name = "short-cargo-wagon",
        enabled = false,
        ingredients = {
            {type = "item", name = "iron-gear-wheel", amount = 10},
            {type = "item", name = "iron-plate", amount = 20},
            {type = "item", name = "steel-plate", amount = 20}
        },
        energy_required = 1,
        results = {{type = "item", name = "short-cargo-wagon", amount = 1}}
    }
})

-- Technology
data:extend({
    {
        type = "technology",
        name = "short-train",
        icon = "__base__/graphics/icons/locomotive.png",
        icon_size = 64,
        prerequisites = {"railway"},  -- 철도 기술 필요
        effects = {
            {
                type = "unlock-recipe",
                recipe = "short-locomotive"
            },
            {
                type = "unlock-recipe",
                recipe = "short-cargo-wagon"
            }
        },
        unit = {
            count = 50,
            ingredients = {
                {"automation-science-pack", 1}
            },
            time = 30
        },
        order = "c-g"
    }
})

log("Short Train System loaded - Compact trains!")

