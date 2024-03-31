local sub = require("heating_sub")

local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
require ("__base__.prototypes.entity.pipecovers")

function make_heat_pipe_pictures(path, name_prefix, data, draw_as_glow)
  local all_pictures = {}
  local func = draw_as_glow and apply_heat_pipe_glow or function(t) return t end
  for key, t in pairs(data) do
    if t.empty then
      all_pictures[key] = { priority = "extra-high", filename = "__core__/graphics/empty.png", width = 1, height = 1 }
    else
      local tile_pictures = {}
      for i = 1, (t.variations or 1) do
        local sprite = func
        {
          priority = "extra-high",
          filename = path .. name_prefix .. "-" .. (t.name or string.gsub(key, "_", "-")) .. (t.ommit_number and ".png" or ("-" .. tostring(i) .. ".png")),
          width = (t.width or 32),
          height = (t.height or 32),
          shift = t.shift,
          hr_version =
          {
            priority = "extra-high",
            filename = path .. "hr-" .. name_prefix .. "-" .. (t.name or string.gsub(key, "_", "-")) .. (t.ommit_number and ".png" or ("-" .. tostring(i) .. ".png")),
            width = (t.width or 32) * 2,
            height = (t.height or 32) * 2,
            scale = 0.5,
            shift = t.shift
          }
        }
        table.insert(tile_pictures, sprite)
      end
      all_pictures[key] = tile_pictures
    end
  end
  return all_pictures
end

-- 기존 엔티티의 정의를 가져옵니다.
local heat_pipe_entity = data.raw["heat-pipe"]["heat-pipe"]

-- fast_replaceable_group 필드를 추가합니다.
heat_pipe_entity.fast_replaceable_group = "heat-pipe"




data:extend
(
  {
--          축열기들 시작-----------------------------------------------
--          축열기들 끝-----------------------------------------------


    heat_pipe_entity,
    {
      type = "item",
      name = "scrap-pipe",
      icon = "__base__/graphics/icons/heat-pipe.png",
      icon_size = 64, icon_mipmaps = 4,
      subgroup = "energy",
      order = "f[nuclear-energy]-b[heat-pipe]",
      place_result = "scrap-pipe",
      stack_size = 50
    },
    {
      type = "recipe",
      name = "scrap-pipe",
      icon = "__my Example-mod1__/graphics/entity/scrap-pipe/heat-pipe.png",
      icon_size = 64, icon_mipmaps = 4,
      energy_required = 1,
      enabled = true,
      ingredients = {{"scrap-ore", 20}, {"copper-cable", 10}},
      result = "scrap-pipe"
    },

    {
        type = "item",
        name = "heat-reactor",
        icon = "__my Example-mod1__/graphics/entity/heat-silo/rocket-silo.png",
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "extraction-machine",
        order = "a[items]-b[electric-mining-drill]",
        place_result = "heat-reactor",
        stack_size = 1
      },
--  고철파이프의 시작 -----------------------------------------------------------------------------------------------------------------------------

{
  type = "heat-pipe",
  name = "scrap-pipe",
  icon = "__my Example-mod1__/graphics/entity/scrap-pipe/heat-pipe.png",
  icon_size = 64, icon_mipmaps = 4,
  flags = {"placeable-neutral", "player-creation"},
  minable = {mining_time = 0.1, result = "scrap-pipe"},
  max_health = 200,
  corpse = "heat-pipe-remnants",
  fast_replaceable_group = "heat-pipe",
  next_upgrade = "heat-pipe",
  dying_explosion = "heat-pipe-explosion",
  random_corpse_variation = true,
  working_sound =
  {
    sound =
    {
      {
        filename = "__base__/sound/heat-pipe.ogg",
        volume = 0.4
      }
    },
    match_volume_to_activity = true,
    max_sounds_per_type = 3,
    fade_in_ticks = 4,
    fade_out_ticks = 20
  },
  vehicle_impact_sound = sounds.generic_impact,
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
  collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  damaged_trigger_effect = hit_effects.entity(),
  heat_buffer =
  {
    max_temperature = 300,
    specific_heat = "1MJ",
    max_transfer = "0.5GW",
    minimum_glow_temperature = 100,
    connections =
    {
      {
        position = {0, 0},
        direction = defines.direction.north
      },
      {
        position = {0, 0},
        direction = defines.direction.east
      },
      {
        position = {0, 0},
        direction = defines.direction.south
      },
      {
        position = {0, 0},
        direction = defines.direction.west
      }
    }
  },

  connection_sprites = make_heat_pipe_pictures("__my Example-mod1__/graphics/entity/scrap-pipe/entitiy/2/", "heat-pipe",
  {
    single = { name = "straight-vertical-single", ommit_number = true },
    straight_vertical = { variations = 6 },
    straight_horizontal = { variations = 6 },
    corner_right_up = { name = "corner-up-right", variations = 6 },
    corner_left_up = { name = "corner-up-left", variations = 6 },
    corner_right_down = { name = "corner-down-right", variations = 6 },
    corner_left_down = { name = "corner-down-left", variations = 6 },
    t_up = {},
    t_down = {},
    t_right = {},
    t_left = {},
    cross = { name = "t" },
    ending_up = {},
    ending_down = {},
    ending_right = {},
    ending_left = {}
  }),

  heat_glow_sprites = make_heat_pipe_pictures("__base__/graphics/entity/heat-pipe/", "heated",
  {
    single = { empty = true },
    straight_vertical = { variations = 6 },
    straight_horizontal = { variations = 6 },
    corner_right_up = { name = "corner-up-right", variations = 6 },
    corner_left_up = { name = "corner-up-left", variations = 6 },
    corner_right_down = { name = "corner-down-right", variations = 6 },
    corner_left_down = { name = "corner-down-left", variations = 6 },
    t_up = {},
    t_down = {},
    t_right = {},
    t_left = {},
    cross = { name = "t" },
    ending_up = {},
    ending_down = {},
    ending_right = {},
    ending_left = {}
  }, true)
},

-- 고철파이프의 끝 ------------------------------------------------------------------------------------------------------------



      --  리액터의 시작-------------------------------------------------------------------------------------------------------------------------------
{
    type = "reactor",
    name = "heat-reactor",
    icon  = "__my Example-mod1__/graphics/entity/heat-silo/rocket-silo.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = "nuclear-reactor"},
    max_health = 500,
    corpse = "nuclear-reactor-remnants",
    dying_explosion = "nuclear-reactor-explosion",
    consumption = "40MW",
    neighbour_bonus = 1,
    energy_source =
    {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 1,
      burnt_inventory_size = 1,
      light_flicker =
      {
        color = {0,0,0},
        minimum_intensity = 0.7,
        maximum_intensity = 0.95
      }
    },
    collision_box = {{-4.40, -4.40}, {4.40, 4.40}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    damaged_trigger_effect = hit_effects.entity(),
    lower_layer_picture =
    {
      filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
      width = 156,
      height = 156,
      shift = util.by_pixel(-2, -4),
      hr_version =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-pipes.png",
        width = 320,
        height = 316,
        scale = 0.5,
        shift = util.by_pixel(-1, -5)
      }
    },
    heat_lower_layer_picture = apply_heat_pipe_glow
    {
      filename = "__base__/graphics/entity/rocket-silo/01-rocket-silo-hole.png",
      width = 202,
      height = 136,
      shift = util.by_pixel(-6, 16),
      hr_version =
      {
        filename = "__base__/graphics/entity/rocket-silo/hr-01-rocket-silo-hole.png",
        width = 400,
        height = 270,
        shift = util.by_pixel(-5, 16),
        scale = 0.5
      }
    },

    picture =
    {
      layers =
      {
        {
          filename = "__my Example-mod1__/graphics/entity/heat-silo/06-rocket-silo.png",
          width = 154,
          height = 158,
          shift = util.by_pixel(-6, -6),
          hr_version =
          {
            filename = "__my Example-mod1__/graphics/entity/heat-silo/hr-06-rocket-silo.png",
            width = 608,
            height = 596,
            shift = util.by_pixel(3, -1),
            scale = 0.5
          }
        },
        {
          filename = "__my Example-mod1__/graphics/entity/heat-silo/00-rocket-silo-shadow.png",
          priority = "medium",
          width = 304,
          height = 290,
          draw_as_shadow = true,
          dice = 2,
          shift = util.by_pixel(8, 2),
          hr_version =
          {
            filename = "__my Example-mod1__/graphics/entity/heat-silo/hr-00-rocket-silo-shadow.png",
            priority = "medium",
            width = 612,
            height = 578,
            draw_as_shadow = true,
            dice = 2,
            shift = util.by_pixel(7, 2),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/rocket-silo/01-rocket-silo-hole.png",
          width = 202,
          height = 136,
          shift = util.by_pixel(-6, 16),
          hr_version =
          {
            filename = "__base__/graphics/entity/rocket-silo/hr-01-rocket-silo-hole.png",
            width = 400,
            height = 270,
            shift = util.by_pixel(-5, 16),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/rocket-silo/14-rocket-silo-front.png",
          width = 292,
          height = 132,
          shift = util.by_pixel(-2, 78),
          hr_version =
          {
            filename = "__my Example-mod1__/graphics/entity/heat-silo/hr-14-rocket-silo-front.png",
            width = 580,
            height = 262,
            shift = util.by_pixel(-1, 78),
            scale = 0.5
          }
        }
      }
    },
    working_light_picture =
    {
      layers =
      {
    {
      filename = "__my Example-mod1__/graphics/entity/heat-silo/hr-01-rocket-silo-hole-light.png",
      width = 202,
      height = 136,
      shift = util.by_pixel(-6, 16),
      tint = {1,1,1,0},
      hr_version =
      {
        filename = "__my Example-mod1__/graphics/entity/heat-silo/hr-01-rocket-silo-hole-light.png",
        width = 400,
        height = 270,
        shift = util.by_pixel(-5, 16),
        tint = {1,1,1,0},
        scale = 0.5
      }
    },
            {
      filename = "__base__/graphics/entity/rocket-silo/14-rocket-silo-front.png",
      width = 292,
      height = 132,
      shift = util.by_pixel(-2, 78),
      hr_version =
      {
        filename = "__my Example-mod1__/graphics/entity/heat-silo/hr-14-rocket-silo-front.png",
        width = 580,
        height = 262,
        shift = util.by_pixel(-1, 78),
        scale = 0.5
      }
    }
  }},

    --light = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.0, g = 1.0, b = 0.0}},
    -- use_fuel_glow_color = false, -- should use glow color from fuel item prototype as light color and tint for working_light_picture
    -- default_fuel_glow_color = { 0, 1, 0, 1 } -- color used as working_light_picture tint for fuels that don't have glow color defined

    heat_buffer =
    {
      max_temperature = 10000,
      specific_heat = "10MJ",
      max_transfer = "10GW",
      minimum_glow_temperature = 350,
      connections =
      {
        {
          position = {-4, -4},
          direction = defines.direction.north
        },
        {
          position = {0, -4},
          direction = defines.direction.north
        },
        {
          position = {4, -4},
          direction = defines.direction.north
        },
        {
          position = {4, -4},
          direction = defines.direction.east
        },
        {
          position = {4, 0},
          direction = defines.direction.east
        },
        {
          position = {4, 4},
          direction = defines.direction.east
        },
        {
          position = {4, 4},
          direction = defines.direction.south
        },
        {
          position = {0, 4},
          direction = defines.direction.south
        },
        {
          position = {-4, 4},
          direction = defines.direction.south
        },
        {
          position = {-4, 4},
          direction = defines.direction.west
        },
        {
          position = {-4, 0},
          direction = defines.direction.west
        },
        {
          position = {-4, -4},
          direction = defines.direction.west
        }
      },

      heat_picture = apply_heat_pipe_glow
      {
        layers =
        {
      {
        filename = "__my Example-mod1__/graphics/entity/heat-silo/hr-01-rocket-silo-hole-light.png",
        width = 202,
        height = 136,
        shift = util.by_pixel(-6, 16),
        tint = {1,1,1,0},
        hr_version =
        {
          filename = "__my Example-mod1__/graphics/entity/heat-silo/hr-01-rocket-silo-hole-light.png",
          width = 400,
          height = 270,
          shift = util.by_pixel(-5, 16),
          tint = {1,1,1,0},
          scale = 0.5
        }
      },
              {
        filename = "__base__/graphics/entity/rocket-silo/14-rocket-silo-front.png",
        width = 292,
        height = 132,
        shift = util.by_pixel(-2, 78),
        hr_version =
        {
          filename = "__my Example-mod1__/graphics/entity/heat-silo/hr-14-rocket-silo-front.png",
          width = 580,
          height = 262,
          shift = util.by_pixel(-1, 78),
          scale = 0.5
        }
      }
    }}
    },

    connection_patches_connected =
    {
      sheet =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-connect-patches.png",
        width = 32,
        height = 32,
        variation_count = 12,
        hr_version =
        {
          filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-connect-patches.png",
          width = 64,
          height = 64,
          variation_count = 12,
          scale = 0.5
        }
      }
    },

    connection_patches_disconnected =
    {
      sheet =
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-connect-patches.png",
        width = 32,
        height = 32,
        variation_count = 12,
        y = 32,
        hr_version =
        {
          filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-connect-patches.png",
          width = 64,
          height = 64,
          variation_count = 12,
          y = 64,
          scale = 0.5
        }
      }
    },

    heat_connection_patches_connected =
    {
      sheet = apply_heat_pipe_glow
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-connect-patches-heated.png",
        width = 32,
        height = 32,
        variation_count = 12,
        hr_version =
        {
          filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-connect-patches-heated.png",
          width = 64,
          height = 64,
          variation_count = 12,
          scale = 0.5
        }
      }
    },

    heat_connection_patches_disconnected =
    {
      sheet = apply_heat_pipe_glow
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-connect-patches-heated.png",
        width = 32,
        height = 32,
        variation_count = 12,
        y = 32,
        hr_version =
        {
          filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-connect-patches-heated.png",
          width = 64,
          height = 64,
          variation_count = 12,
          y = 64,
          scale = 0.5
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
          filename = "__base__/sound/nuclear-reactor-1.ogg",
          volume = 0.55
        },
        {
          filename = "__base__/sound/nuclear-reactor-2.ogg",
          volume = 0.55
        }
      },
      --idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.3 },
      max_sounds_per_type = 3,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },

    meltdown_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "atomic-rocket"
          }
        }
      }
    }
  }
  --  리액터의 끝-------------------------------------------------------------------------------------------------------------------------------
}
)