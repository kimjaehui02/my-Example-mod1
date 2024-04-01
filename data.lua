require("heating")
require("heat_silo")


local sounds = require("__base__.prototypes.entity.sounds")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")



for _, resource in pairs(data.raw.resource) do
  if resource.name ~= "stone" and resource.name ~= "crude-oil" and resource.name ~= "iron-ore" then
      resource.autoplace = nil
      data.raw["autoplace-control"][resource.name] = nil
  end
end

-- "map-gen-presets"의 "default" 프리셋에서 "coal" 자원과 "crude-oil" 자원을 제외하고 "autoplace_controls" 데이터 제거
for _, preset in pairs(data.raw["map-gen-presets"]["default"]) do
  if type(preset) == "table" and preset.basic_settings and preset.basic_settings.autoplace_controls then
      for ore_name, ore in pairs(preset.basic_settings.autoplace_controls) do
          if ore_name ~= "stone" and ore_name ~= "crude-oil" and ore_name ~= "iron-ore" then
              preset.basic_settings.autoplace_controls[ore_name] = nil
          end
      end
  end
end
require("Hailite")
local scrapauto = table.deepcopy(data.raw["autoplace-control"]["iron-ore"])
local fossilauto = table.deepcopy(data.raw["autoplace-control"]["stone"])

fossilauto.name = "fossil-landfill"
scrapauto.name = "Scrap-landfill"

local fossil2 = table.deepcopy(data.raw["resource"]["stone"])
local scrap = table.deepcopy(data.raw["resource"]["iron-ore"])

scrap.stages.sheet.filename = "__my Example-mod1__/graphics/entity/iron-ore2.png"
scrap.stages.sheet.hr_version.filename = "__my Example-mod1__/graphics/entity/iron-ore2hr.png"
scrap.name = "Scrap2-landfill"


fossil2.stages.sheet.filename = "__my Example-mod1__/graphics/entity/fossil.png"
fossil2.stages.sheet.hr_version.filename = "__my Example-mod1__/graphics/entity/fossilhr.png"
fossil2.name = "fossil-landfill"


data:extend(
{
  {
    type = "item",
    name = "scrap-ore",
    icon = "__base__/graphics/icons/crash-site-spaceship.png",
    icon_size = 64,
    icon_mipmaps = 4,
    pictures =
    {
      { size = 64, filename = "__base__/graphics/icons/crash-site-spaceship.png",   scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__base__/graphics/icons/crash-site-spaceship-wreck-big-2.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__base__/graphics/icons/crash-site-spaceship-wreck-medium-2.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__base__/graphics/icons/crash-site-spaceship-wreck-medium-1.png", scale = 0.25, mipmap_count = 4 }
    },
    subgroup = "raw-resource",
    order = "d[stone]",
    stack_size = 50
  },
  {
    type = "item",
    name = "fossil-ore",
    icon = "__base__/graphics/icons/remnants.png",
    icon_size = 64,
    icon_mipmaps = 4,
    dark_background_icon = "__base__/graphics/icons/coal-dark-background.png",
    pictures =
    {
      { size = 64, filename = "__base__/graphics/icons/remnants.png",   scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__base__/graphics/icons/medium-biter-corpse.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__base__/graphics/icons/tree-07-stump.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__base__/graphics/icons/sand-rock-big.png", scale = 0.25, mipmap_count = 4 }
    },
    fuel_category = "chemical",
    fuel_value = "2.5MJ",
    subgroup = "raw-resource",
    order = "b[coal]",
    stack_size = 50
  },
  {
    type = "item",
    name = "scrap-furnace",
    icon = "__my Example-mod1__/graphics/entity/furnace-icon.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "a[stone-furnace]",
    place_result = "scrap-furnace",
    stack_size = 50
  },
  {
    type = "item",
    name = "scrap-plant",
    icon = "__my Example-mod1__/graphics/entity/icon/chemical-plant.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "a[stone-furnace]",
    place_result = "scrap-plant",
    stack_size = 50
  }
})

scrap.minable =     
{
  mining_particle = "stone-particle",
  mining_time = 0.1,
  result = "scrap-ore",

}



fossil2.minable =     
{
  mining_particle = "stone-particle",
  mining_time = 0.1,
  result = "fossil-ore",

}
data:extend({scrap, fossil2,})


local scrapInteger = 2
local fossilInteger = 4

data:extend
{  
  {
    type = "recipe",
    name = "scrap-processing",
    category = "scrapping",
    energy_required = scrapInteger*0.5,
    enabled = true,
    ingredients = {{"scrap-ore", scrapInteger}},
    icon = "__base__/graphics/icons/crash-site-spaceship.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "k[uranium-processing]", -- k ordering so it shows up after explosives which is j ordering
    results =
    {
      {
        name = "iron-ore",
        probability = 0.001*scrapInteger*2,
        amount = 1
      },
      {
        name = "processing-unit",
        probability = 0.003*scrapInteger*2,
        amount = 1
      },
      {
        name = "engine-unit",
        probability = 0.02*scrapInteger*2,
        amount = 1
      },
      {
        name = "iron-gear-wheel",
        probability = 0.03*scrapInteger*2,
        amount = 1
      },
      {
        name = "copper-cable",
        probability = 0.025*scrapInteger*2,
        amount = 1
      },
      {
        name = "concrete",
        probability = 0.015*scrapInteger*2,
        amount = 1
      },
      {
        name = "transport-belt",
        probability = 0.015*scrapInteger*2,
        amount = 1
      },
      {
        name = "accumulator",
        probability = 0.002*scrapInteger*2,
        amount = 1
      }
    }
  },
  {
    type = "recipe",
    name = "fossil-processing",
    category = "scrapping",
    energy_required = fossilInteger,
    enabled = true,
    ingredients = {{"fossil-ore", fossilInteger}},
    icon = "__base__/graphics/icons/remnants.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "k[uranium-processing]", -- k ordering so it shows up after explosives which is j ordering
    results =
    {
      {
        name = "wood",
        probability = 0.15 * fossilInteger,
        amount = 2
      },
      {
        name = "coal",
        probability = 0.2 * fossilInteger,
        amount = 4
      },
      {
        name = "solid-fuel",
        probability = 0.01 * fossilInteger,
        amount = 1
      },
      {
        name = "stone",
        probability = 0.02 * fossilInteger,
        amount = 1
      }
    }
  },
  {
    type = "recipe",
    name = "scrap-furnace",
    ingredients = {{"scrap-ore", 12}, {"stone", 2}},
    result = "scrap-furnace",
    energy_required = 3,
    enabled = true
  },
  {
    type = "recipe",
    name = "scrap-plant",
    ingredients = 
    {      
    {"steel-plate", 4},
    {"iron-gear-wheel", 4},
    {"electronic-circuit", 4},
    {"pipe", 5},
    {"scrap-ore", 12}
    },
    result = "scrap-plant",
    energy_required = 3,
    enabled = true
  },
  
  {
    type = "furnace",
    name = "scrap-plant",
    icon = "__my Example-mod1__/graphics/entity/icon/chemical-plant.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = "scrap-plant"},
    max_health = 300,
    corpse = "chemical-plant-remnants",
    dying_explosion = "chemical-plant-explosion",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box = {{-1.5, -1.9}, {1.5, 1.5}},
    module_specification =
    {
      module_slots = 3
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},

    animation = make_4way_animation_from_spritesheet({ layers =
    {
      {
        filename = "__my Example-mod1__/graphics/entity/chemical-plant.png",
        width = 108,
        height = 148,
        frame_count = 24,
        line_length = 12,
        shift = util.by_pixel(1, -9),
        hr_version =
        {
          filename = "__my Example-mod1__/graphics/entity/hr-chemical-plant.png",
          width = 220,
          height = 292,
          frame_count = 24,
          line_length = 12,
          shift = util.by_pixel(0.5, -9),
          scale = 0.5
          }
      },
      {
        filename = "__base__/graphics/entity/chemical-plant/chemical-plant-shadow.png",
        width = 154,
        height = 112,
        repeat_count = 24,
        frame_count = 1,
        shift = util.by_pixel(28, 6),
        draw_as_shadow = true,
        hr_version =
        {
          filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-shadow.png",
          width = 312,
          height = 222,
          repeat_count = 24,
          frame_count = 1,
          shift = util.by_pixel(27, 6),
          draw_as_shadow = true,
          scale = 0.5
          }
      }
    }}),
    working_visualisations =
    {
      {
        apply_recipe_tint = "primary",
        north_animation =
        {
          filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-north.png",
          frame_count = 24,
          line_length = 6,
          width = 32,
          height = 24,
          shift = util.by_pixel(24, 14),
          hr_version =
          {
            filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-liquid-north.png",
            frame_count = 24,
            line_length = 6,
            width = 66,
            height = 44,
            shift = util.by_pixel(23, 15),
            scale = 0.5
          }
        },
        east_animation =
        {
          filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-east.png",
          frame_count = 24,
          line_length = 6,
          width = 36,
          height = 18,
          shift = util.by_pixel(0, 22),
          hr_version =
          {
            filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-liquid-east.png",
            frame_count = 24,
            line_length = 6,
            width = 70,
            height = 36,
            shift = util.by_pixel(0, 22),
            scale = 0.5
          }
        },
        south_animation =
        {
          filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-south.png",
          frame_count = 24,
          line_length = 6,
          width = 34,
          height = 24,
          shift = util.by_pixel(0, 16),
          hr_version =
          {
            filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-liquid-south.png",
            frame_count = 24,
            line_length = 6,
            width = 66,
            height = 42,
            shift = util.by_pixel(0, 17),
            scale = 0.5
          }
        },
        west_animation =
        {
          filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-west.png",
          frame_count = 24,
          line_length = 6,
          width = 38,
          height = 20,
          shift = util.by_pixel(-10, 12),
          hr_version =
          {
            filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-liquid-west.png",
            frame_count = 24,
            line_length = 6,
            width = 74,
            height = 36,
            shift = util.by_pixel(-10, 13),
            scale = 0.5
          }
        }
      },
      {
        apply_recipe_tint = "secondary",
        north_animation =
        {
          filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-north.png",
          frame_count = 24,
          line_length = 6,
          width = 32,
          height = 22,
          shift = util.by_pixel(24, 14),
          hr_version =
          {
            filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-foam-north.png",
            frame_count = 24,
            line_length = 6,
            width = 62,
            height = 42,
            shift = util.by_pixel(24, 15),
            scale = 0.5
          }
        },
        east_animation =
        {
          filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-east.png",
          frame_count = 24,
          line_length = 6,
          width = 34,
          height = 18,
          shift = util.by_pixel(0, 22),
          hr_version =
          {
            filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-foam-east.png",
            frame_count = 24,
            line_length = 6,
            width = 68,
            height = 36,
            shift = util.by_pixel(0, 22),
            scale = 0.5
          }
        },
        south_animation =
        {
          filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-south.png",
          frame_count = 24,
          line_length = 6,
          width = 32,
          height = 18,
          shift = util.by_pixel(0, 18),
          hr_version =
          {
            filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-foam-south.png",
            frame_count = 24,
            line_length = 6,
            width = 60,
            height = 40,
            shift = util.by_pixel(1, 17),
            scale = 0.5
          }
        },
        west_animation =
        {
          filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-west.png",
          frame_count = 24,
          line_length = 6,
          width = 36,
          height = 16,
          shift = util.by_pixel(-10, 14),
          hr_version =
          {
            filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-foam-west.png",
            frame_count = 24,
            line_length = 6,
            width = 68,
            height = 28,
            shift = util.by_pixel(-9, 15),
            scale = 0.5
          }
        }
      },
      {
        apply_recipe_tint = "tertiary",
        fadeout = true,
        constant_speed = true,
        north_position = util.by_pixel_hr(-30, -161),
        east_position = util.by_pixel_hr(29, -150),
        south_position = util.by_pixel_hr(12, -134),
        west_position = util.by_pixel_hr(-32, -130),
        render_layer = "wires",
        animation =
        {
          filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-outer.png",
          frame_count = 47,
          line_length = 16,
          width = 46,
          height = 94,
          animation_speed = 0.5,
          shift = util.by_pixel(-2, -40),
          hr_version =
          {
            filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-smoke-outer.png",
            frame_count = 47,
            line_length = 16,
            width = 90,
            height = 188,
            animation_speed = 0.5,
            shift = util.by_pixel(-2, -40),
            scale = 0.5
          }
        }
      },
      {
        apply_recipe_tint = "quaternary",
        fadeout = true,
        constant_speed = true,
        north_position = util.by_pixel_hr(-30, -161),
        east_position = util.by_pixel_hr(29, -150),
        south_position = util.by_pixel_hr(12, -134),
        west_position = util.by_pixel_hr(-32, -130),
        render_layer = "wires",
        animation =
        {
          filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-inner.png",
          frame_count = 47,
          line_length = 16,
          width = 20,
          height = 42,
          animation_speed = 0.5,
          shift = util.by_pixel(0, -14),
          hr_version =
          {
            filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-smoke-inner.png",
            frame_count = 47,
            line_length = 16,
            width = 40,
            height = 84,
            animation_speed = 0.5,
            shift = util.by_pixel(0, -14),
            scale = 0.5
          }
        }
      }
    },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/chemical-plant-1.ogg",
          volume = 0.5
        },
        {
          filename = "__base__/sound/chemical-plant-2.ogg",
          volume = 0.5
        },
        {
          filename = "__base__/sound/chemical-plant-3.ogg",
          volume = 0.5
        }
      },
      --max_sounds_per_type = 3,
      --idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.3 },
      apparent_volume = 1.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    crafting_speed = 1,
    source_inventory_size = 1,
    result_inventory_size = 8,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4
    },
    energy_usage = "210kW",
    crafting_categories = {"scrapping", "scrapping-with-fluid"},
    fluid_boxes =
    {
      -- {
      --   production_type = "input",
      --   pipe_covers = pipecoverspictures(),
      --   base_area = 10,
      --   base_level = -1,
      --   pipe_connections =
      --   {
      --     {
      --       type="input",
      --       position = {-1, -2}
      --     }
      --   }
      -- },
      -- {
      --   production_type = "input",
      --   pipe_covers = pipecoverspictures(),
      --   base_area = 10,
      --   base_level = -1,
      --   pipe_connections =
      --   {
      --     {
      --       type="input",
      --       position = {1, -2}
      --     }
      --   }
      -- },
      -- {
      --   production_type = "output",
      --   pipe_covers = pipecoverspictures(),
      --   base_level = 1,
      --   pipe_connections =
      --   {
      --     {
      --       type = "output",
      --       position = {-1, 2}
      --     }
      --   }
      -- },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        base_level = 1,
        pipe_connections =
        {
          {
            type = "output",
            position = {1, 2}
          }
        }
      }
    },
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/chemical-plant/chemical-plant-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 36,
        shift = util.by_pixel(5, 60),
        variation_count = 4,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = true
    }
  }
}


data:extend
{
  {
    type = "recipe-category",
    name = "scrapping"
  },  
  {
    type = "recipe-category",
    name = "scrapping-with-fluid"
  },
  {
    type = "furnace",
    name = "scrap-furnace",
    icon = "__base__/graphics/icons/stone-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "scrap-furnace"},
    max_health = 200,
    corpse = "stone-furnace-remnants",
    dying_explosion = "stone-furnace-explosion",
    repair_sound = sounds.manual_repair,
    mined_sound = sounds.deconstruct_bricks(0.8),
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = sounds.car_stone_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/furnace.ogg",
          volume = 0.6
        }
      },
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      audible_distance_modifier = 0.4
    },
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "explosion",
        percent = 30
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-0.8, -1}, {0.8, 1}},
    damaged_trigger_effect = hit_effects.rock(),
    crafting_categories = {"scrapping"},
    result_inventory_size = 8,
    energy_usage = "90kW",
    crafting_speed = 1,
    source_inventory_size = 1,
    energy_source =
    {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 1,
      emissions_per_minute = 2,
      light_flicker =
      {
        color = {0,0,0},
        minimum_intensity = 0.6,
        maximum_intensity = 0.95
      },
      smoke =
      {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 5,
          position = {0.0, -0.8},
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60
        }
      }
    },
    animation =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace.png",
          priority = "extra-high",
          width = 81,
          height = 64,
          frame_count = 1,
          shift = util.by_pixel(14.5, 2),
          hr_version =
          {
            filename = "__my Example-mod1__/graphics/entity/furnace.png",
            priority = "extra-high",
            width = 151,
            height = 146,
            frame_count = 1,
            shift = util.by_pixel(-0.25, 6),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace-shadow.png",
          priority = "extra-high",
          width = 81,
          height = 64,
          frame_count = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(14.5, 2),
          hr_version =
          {
            filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-shadow.png",
            priority = "extra-high",
            width = 164,
            height = 74,
            frame_count = 1,
            draw_as_shadow = true,
            force_hr_shadow = true,
            shift = util.by_pixel(14.5, 13),
            scale = 0.5
          }
        }
      }
    },
    working_visualisations =
    {
      {
        draw_as_light = true,
        fadeout = true,
        effect = "flicker",
        animation =
        {
          layers =
          {
            {
              filename = "__base__/graphics/entity/stone-furnace/stone-furnace-fire.png",
              priority = "extra-high",
              line_length = 8,
              width = 20,
              height = 49,
              frame_count = 48,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(-0.5, 5.5),
              hr_version =
              {
                filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-fire.png",
                priority = "extra-high",
                line_length = 8,
                width = 41,
                height = 100,
                frame_count = 48,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(-0.75, 5.5),
                scale = 0.5
              }
            },
            {
              filename = "__base__/graphics/entity/stone-furnace/stone-furnace-light.png",
              blend_mode = "additive",
              width = 54,
              height = 74,
              repeat_count = 48,
              shift = util.by_pixel(0, 4),
              hr_version =
              {
                filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-light.png",
                blend_mode = "additive",
                width = 106,
                height = 144,
                repeat_count = 48,
                shift = util.by_pixel(0, 5),
                scale = 0.5,
              }
            },
          }
        }
      },
      {
        draw_as_light = true,
        draw_as_sprite = false,
        fadeout = true,
        effect = "flicker",
        animation =
        {
          filename = "__base__/graphics/entity/stone-furnace/stone-furnace-ground-light.png",
          blend_mode = "additive",
          draw_as_sprite = false,
          width = 56,
          height = 56,
          repeat_count = 48,
          shift = util.by_pixel(0, 44),
          hr_version =
          {
            filename = "__base__/graphics/entity/stone-furnace/hr-stone-furnace-ground-light.png",
            blend_mode = "additive",
            draw_as_sprite = false,
            width = 116,
            height = 110,
            repeat_count = 48,
            shift = util.by_pixel(-1, 44),
            scale = 0.5,
          }
        },
      },
    },
    fast_replaceable_group = "furnace",
    next_upgrade = nil,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/stone-furnace/stone-furnace-reflection.png",
        priority = "extra-high",
        width = 16,
        height = 16,
        shift = util.by_pixel(0, 35),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
  scrap,
  fossil2
}

require("scrapping")