local sub = require("heating_sub")

local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
require ("__base__.prototypes.entity.pipecovers")

-- 축전지 관리


-- 축전지 끝

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
--          열투입기 시작-----------------------------------------------
{
  type = "item",
  name = "fast-heat-inserter",
  icon = "__base__/graphics/icons/fast-inserter.png",
  icon_size = 64, icon_mipmaps = 4,
  subgroup = "inserter",
  order = "d[fast-inserter]",
  place_result = "fast-heat-inserter",
  stack_size = 50
},
{
  type = "inserter",
  name = "fast-heat-inserter",
  icon = "__base__/graphics/icons/fast-inserter.png",
  icon_size = 64, icon_mipmaps = 4,
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  minable = { mining_time = 0.1, result = "fast-heat-inserter" },
  max_health = 150,
  corpse = "fast-inserter-remnants",
  dying_explosion = "fast-inserter-explosion",
  resistances =
  {
    {
      type = "fire",
      percent = 90
    }
  },
  collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
  selection_box = {{-0.4, -0.35}, {0.4, 0.45}},
  damaged_trigger_effect = hit_effects.entity(),
  pickup_position = {0, -1},
  insert_position = {0, 1.2},
  energy_per_movement = "10KJ",
  energy_per_rotation = "10KJ",
  energy_source =
  {
    type = "heat",
    max_temperature = 1000,
    specific_heat = "1MJ",
    max_transfer = "2GW",
    min_working_temperature = 20,
    minimum_glow_temperature = 35,
    connections =
    {
      {
        position = { 0, 0 },
        direction = defines.direction.north,
      },
      {
        position = { 0, 0 },
        direction = defines.direction.east,
      },
      {
        position = { 0, 0 },
        direction = defines.direction.south,
      },
      {
        position = { 0, 0 },
        direction = defines.direction.west,
      },
    },
    pipe_covers =
      make_4way_animation_from_spritesheet(
      {
        filename = "__base__/graphics/entity/heat-exchanger/heatex-endings.png",
        width = 32,
        height = 32,
        direction_count = 4,
        hr_version =
        {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings.png",
          width = 64,
          height = 64,
          direction_count = 4,
          scale = 0.5
        }
      }),
    heat_pipe_covers =
      make_4way_animation_from_spritesheet(
      apply_heat_pipe_glow{
        filename = "__base__/graphics/entity/heat-exchanger/heatex-endings-heated.png",
        width = 32,
        height = 32,
        direction_count = 4,
        hr_version =
        {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings-heated.png",
          width = 64,
          height = 64,
          direction_count = 4,
          scale = 0.5
        }
      }),
    heat_picture =
    {
      north = apply_heat_pipe_glow
      {
        filename = "__base__/graphics/entity/heat-exchanger/heatex-N-heated.png",
        priority = "extra-high",
        width = 24,
        height = 48,
        shift = util.by_pixel(-1, 8),
        hr_version =
        {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-N-heated.png",
          priority = "extra-high",
          width = 44,
          height = 96,
          shift = util.by_pixel(-0.5, 8.5),
          scale = 0.5
        }
      },
      east = apply_heat_pipe_glow
      {
        filename = "__base__/graphics/entity/heat-exchanger/heatex-E-heated.png",
        priority = "extra-high",
        width = 40,
        height = 40,
        shift = util.by_pixel(-21, -13),
        hr_version =
        {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-E-heated.png",
          priority = "extra-high",
          width = 80,
          height = 80,
          shift = util.by_pixel(-21, -13),
          scale = 0.5
        }
      },
      south = apply_heat_pipe_glow
      {
        filename = "__base__/graphics/entity/heat-exchanger/heatex-S-heated.png",
        priority = "extra-high",
        width = 16,
        height = 20,
        shift = util.by_pixel(-1, -30),
        hr_version =
        {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-S-heated.png",
          priority = "extra-high",
          width = 28,
          height = 40,
          shift = util.by_pixel(-1, -30),
          scale = 0.5
        }
      },
      west = apply_heat_pipe_glow
      {
        filename = "__base__/graphics/entity/heat-exchanger/heatex-W-heated.png",
        priority = "extra-high",
        width = 32,
        height = 40,
        shift = util.by_pixel(23, -13),
        hr_version =
        {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-W-heated.png",
          priority = "extra-high",
          width = 64,
          height = 76,
          shift = util.by_pixel(23, -13),
          scale = 0.5
        }
      }
    }
  },
  extension_speed = 0.07,
  rotation_speed = 0.04,
  fast_replaceable_group = "inserter",
  -- next_upgrade = "stack-inserter",
  vehicle_impact_sound = sounds.generic_impact,
  open_sound = sounds.machine_open,
  close_sound = sounds.machine_close,
  working_sound = sounds.inserter_fast,
  hand_base_picture =
  {
    filename = "__base__/graphics/entity/fast-inserter/fast-inserter-hand-base.png",
    priority = "extra-high",
    width = 8,
    height = 34,
    hr_version =
    {
      filename = "__base__/graphics/entity/fast-inserter/hr-fast-inserter-hand-base.png",
      priority = "extra-high",
      width = 32,
      height = 136,
      scale = 0.25
    }
  },
  hand_closed_picture =
  {
    filename = "__base__/graphics/entity/fast-inserter/fast-inserter-hand-closed.png",
    priority = "extra-high",
    width = 18,
    height = 41,
    hr_version =
    {
      filename = "__base__/graphics/entity/fast-inserter/hr-fast-inserter-hand-closed.png",
      priority = "extra-high",
      width = 72,
      height = 164,
      scale = 0.25
    }
  },
  hand_open_picture =
  {
    filename = "__base__/graphics/entity/fast-inserter/fast-inserter-hand-open.png",
    priority = "extra-high",
    width = 18,
    height = 41,
    hr_version =
    {
      filename = "__base__/graphics/entity/fast-inserter/hr-fast-inserter-hand-open.png",
      priority = "extra-high",
      width = 72,
      height = 164,
      scale = 0.25
    }
  },
  hand_base_shadow =
  {
    filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-base-shadow.png",
    priority = "extra-high",
    width = 8,
    height = 33,
    hr_version =
    {
      filename = "__base__/graphics/entity/burner-inserter/hr-burner-inserter-hand-base-shadow.png",
      priority = "extra-high",
      width = 32,
      height = 132,
      scale = 0.25
    }
  },
  hand_closed_shadow =
  {
    filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-closed-shadow.png",
    priority = "extra-high",
    width = 18,
    height = 41,
    hr_version =
    {
      filename = "__base__/graphics/entity/burner-inserter/hr-burner-inserter-hand-closed-shadow.png",
      priority = "extra-high",
      width = 72,
      height = 164,
      scale = 0.25
    }
  },
  hand_open_shadow =
  {
    filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-open-shadow.png",
    priority = "extra-high",
    width = 18,
    height = 41,
    hr_version =
    {
      filename = "__base__/graphics/entity/burner-inserter/hr-burner-inserter-hand-open-shadow.png",
      priority = "extra-high",
      width = 72,
      height = 164,
      scale = 0.25
    }
  },
  platform_picture =
  {
    sheet =
    {
      filename = "__base__/graphics/entity/fast-inserter/fast-inserter-platform.png",
      priority = "extra-high",
      width = 46,
      height = 46,
      shift = {0.09375, 0},
      hr_version =
      {
        filename = "__base__/graphics/entity/fast-inserter/hr-fast-inserter-platform.png",
        priority = "extra-high",
        width = 105,
        height = 79,
        shift = util.by_pixel(1.5, 7.5-1),
        scale = 0.5
      }
    }
  },
  circuit_wire_connection_points = circuit_connector_definitions["inserter"].points,
  circuit_connector_sprites = circuit_connector_definitions["inserter"].sprites,
  circuit_wire_max_distance = inserter_circuit_wire_max_distance,
  default_stack_control_input_signal = inserter_default_stack_control_input_signal
},

--          열투입기 끝-----------------------------------------------

--          축열기들 시작-----------------------------------------------

{
  type = "item",
  name = "steam-turbine123",
  icon = "__base__/graphics/icons/steam-turbine.png",
  icon_size = 64, icon_mipmaps = 4,
  subgroup = "energy",
  order = "f[nuclear-energy]-d[steam-turbine]",
  place_result = "steam-turbine123",
  stack_size = 10
},
{
  type = "generator",
  name = "steam-turbine123",
  icon = "__base__/graphics/icons/steam-turbine.png",
  icon_size = 64, icon_mipmaps = 4,
  flags = {"placeable-neutral","player-creation"},
  minable = {mining_time = 0.3, result = "steam-turbine123"},
  max_health = 300,
  corpse = "steam-turbine-remnants",
  dying_explosion = "steam-turbine-explosion",
  alert_icon_shift = util.by_pixel(0, -12),
  effectivity = 1,
  fluid_usage_per_tick = 1.2,
  maximum_temperature = 1000,
  burns_fluid = false,
  resistances =
  {
    {
      type = "fire",
      percent = 70
    }
  },
  fast_replaceable_group = "steam-engine",
  collision_box = {{-1.25, -2.35}, {1.25, 2.35}},
  selection_box = {{-1.5, -2.5}, {1.5, 2.5}},
  damaged_trigger_effect = hit_effects.entity(),
  fluid_box =
  {
    base_area = 1,
    height = 2,
    base_level = -1,
    pipe_covers = pipecoverspictures(),
    pipe_connections =
    {
      { type = "input-output", position = {0, 3} },
      { type = "input-output", position = {0, -3} }
    },
    production_type = "input-output",
    filter = "steam",
    minimum_temperature = 200.0
  },
  energy_source =
  {
    type = "electric",
    usage_priority = "secondary-output"
  },
  horizontal_animation =
  {
    layers =
    {
      {
        filename = "__base__/graphics/entity/steam-turbine/steam-turbine-H.png",
        width = 160,
        height = 123,
        frame_count = 8,
        line_length = 4,
        shift = util.by_pixel(0, -2.5),
        run_mode = "backward",
        hr_version =
        {
          filename = "__base__/graphics/entity/steam-turbine/hr-steam-turbine-H.png",
          width = 320,
          height = 245,
          frame_count = 8,
          line_length = 4,
          shift = util.by_pixel(0, -2.75),
          run_mode = "backward",
          scale = 0.5
        }
      },
      {
        filename = "__base__/graphics/entity/steam-turbine/steam-turbine-H-shadow.png",
        width = 217,
        height = 74,
        repeat_count = 8,
        frame_count = 1,
        line_length = 1,
        draw_as_shadow = true,
        shift = util.by_pixel(28.75, 18),
        run_mode = "backward",
        hr_version =
        {
          filename = "__base__/graphics/entity/steam-turbine/hr-steam-turbine-H-shadow.png",
          width = 435,
          height = 150,
          repeat_count = 8,
          frame_count = 1,
          line_length = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(28.5, 18),
          run_mode = "backward",
          scale = 0.5
        }
      }
    }
  },
  vertical_animation =
  {
   layers =
   {
      {
        filename = "__base__/graphics/entity/steam-turbine/steam-turbine-V.png",
        width = 108,
        height = 173,
        frame_count = 8,
        line_length = 4,
        shift = util.by_pixel(5, 6.5),
        run_mode = "backward",
        hr_version =
        {
          filename = "__base__/graphics/entity/steam-turbine/hr-steam-turbine-V.png",
          width = 217,
          height = 347,
          frame_count = 8,
          line_length = 4,
          shift = util.by_pixel(4.75, 6.75),
          run_mode = "backward",
          scale = 0.5
        }
      },
      {
        filename = "__base__/graphics/entity/steam-turbine/steam-turbine-V-shadow.png",
        width = 151,
        height = 131,
        repeat_count = 8,
        frame_count = 1,
        line_length = 1,
        draw_as_shadow = true,
        shift = util.by_pixel(39.5, 24.5),
        run_mode = "backward",
        hr_version =
        {
          filename = "__base__/graphics/entity/steam-turbine/hr-steam-turbine-V-shadow.png",
          width = 302,
          height = 260,
          repeat_count = 8,
          frame_count = 1,
          line_length = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(39.5, 24.5),
          run_mode = "backward",
          scale = 0.5
        }
      }
    }
  },
  smoke =
  {
    {
      name = "turbine-smoke",
      north_position = {0.0, -1.0},
      east_position = {0.75, -0.75},
      frequency = 10 / 32,
      starting_vertical_speed = 0.08,
      slow_down_factor = 1,
      starting_frame_deviation = 60
    }
  },
  vehicle_impact_sound = sounds.generic_impact,
  open_sound = sounds.machine_open,
  close_sound = sounds.machine_close,
  working_sound =
  {
    sound =
    {
      filename = "__base__/sound/steam-turbine.ogg",
      volume = 0.67
    },
    match_speed_to_activity = true,
    audible_distance_modifier = 0.7,
    max_sounds_per_type = 3,
    fade_in_ticks = 4,
    fade_out_ticks = 20
  },
  min_perceived_performance = 0.25,
  performance_to_sound_speedup = 0.5,
  water_reflection =
  {
    pictures =
    {
      filename = "__base__/graphics/entity/steam-turbine/steam-turbine-reflection.png",
      priority = "extra-high",
      width = 40,
      height = 36,
      shift = util.by_pixel(0, 50),
      variation_count = 2,
      repeat_count = 2,
      scale = 5
    },
    rotate = false,
    orientation_to_variation = true
  }
},
--          스팀들들 끝-----------------------------------------------


--          축열기들 시작-----------------------------------------------
{
  type = "item",
  name = "hear-assembling-machine",
  icon = "__base__/graphics/icons/assembling-machine-1.png",
  icon_size = 64, icon_mipmaps = 4,
  subgroup = "production-machine",
  order = "a[assembling-machine-1]",
  place_result = "hear-assembling-machine",
  stack_size = 50
},
{
  type = "recipe",
  name = "hear-assembling-machine",
  enabled = true,
  ingredients =
  {
    {"electronic-circuit", 3},
    {"iron-gear-wheel", 5},
    {"iron-plate", 9}
  },
  result = "hear-assembling-machine"
},
{
  type = "assembling-machine",
  name = "hear-assembling-machine",
  icon = "__base__/graphics/icons/assembling-machine-1.png",
  icon_size = 64, icon_mipmaps = 4,
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  minable = {mining_time = 0.2, result = "hear-assembling-machine"},
  max_health = 300,
  corpse = "assembling-machine-1-remnants",
  dying_explosion = "assembling-machine-1-explosion",
  resistances =
  {
    {
      type = "fire",
      percent = 70
    }
  },
  collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  damaged_trigger_effect = hit_effects.entity(),
  fast_replaceable_group = "assembling-machine",

  alert_icon_shift = util.by_pixel(-3, -12),
  animation =
  {
    layers =
    {
      {
        filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1.png",
        priority="high",
        width = 108,
        height = 114,
        frame_count = 32,
        line_length = 8,
        shift = util.by_pixel(0, 2),
        hr_version =
        {
          filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1.png",
          priority="high",
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
        priority="high",
        width = 95,
        height = 83,
        frame_count = 1,
        line_length = 1,
        repeat_count = 32,
        draw_as_shadow = true,
        shift = util.by_pixel(8.5, 5.5),
        hr_version =
        {
          filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1-shadow.png",
          priority="high",
          width = 190,
          height = 165,
          frame_count = 1,
          line_length = 1,
          repeat_count = 32,
          draw_as_shadow = true,
          shift = util.by_pixel(8.5, 5),
          scale = 0.5
        }
      }
    }
  },
  crafting_categories = {"crafting", "basic-crafting", "advanced-crafting"},
  crafting_speed = 0.5,
  -- heat_buffer =
  -- {
  --   max_temperature = 1000,
  --   specific_heat = "10MJ",
  --   max_transfer = "10GW",
  --   minimum_glow_temperature = 350,
  --   connections =
  --   {
  --     {
  --       position = {-2, -2},
  --       direction = defines.direction.north
  --     },
  --     {
  --       position = {0, -2},
  --       direction = defines.direction.north
  --     },
  --     {
  --       position = {2, -2},
  --       direction = defines.direction.north
  --     },
  --     {
  --       position = {2, -2},
  --       direction = defines.direction.east
  --     },
  --     {
  --       position = {2, 0},
  --       direction = defines.direction.east
  --     },
  --     {
  --       position = {2, 2},
  --       direction = defines.direction.east
  --     },
  --     {
  --       position = {2, 2},
  --       direction = defines.direction.south
  --     },
  --     {
  --       position = {0, 2},
  --       direction = defines.direction.south
  --     },
  --     {
  --       position = {-2, 2},
  --       direction = defines.direction.south
  --     },
  --     {
  --       position = {-2, 2},
  --       direction = defines.direction.west
  --     },
  --     {
  --       position = {-2, 0},
  --       direction = defines.direction.west
  --     },
  --     {
  --       position = {-2, -2},
  --       direction = defines.direction.west
  --     }
  --   },

  --   heat_picture = apply_heat_pipe_glow
  --   {
  --     filename = "__base__/graphics/entity/nuclear-reactor/reactor-heated.png",
  --     width = 108,
  --     height = 128,
  --     shift = util.by_pixel(1, -7),
  --     hr_version =
  --     {
  --       filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-heated.png",
  --       width = 216,
  --       height = 256,
  --       scale = 0.5,
  --       shift = util.by_pixel(3, -6.5)
  --     }
  --   },
  -- },

  energy_usage = "500kW",
  energy_consumption = "10MW",
  energy_source =
  {
    type = "heat",
    max_temperature = 1000,
    specific_heat = "1MJ",
    max_transfer = "2GW",
    min_working_temperature = 20,
    minimum_glow_temperature = 350,
    connections =
    {
      {
        position = { -1, -1 },
        direction = defines.direction.north,
      },
      {
        position = { 1, -1 },
        direction = defines.direction.north,
      },
      {
        position = { 1, -1 },
        direction = defines.direction.east,
      },
      {
        position = { 1, 1 },
        direction = defines.direction.east,
      },
      {
        position = { 1, 1 },
        direction = defines.direction.south,
      },
      {
        position = { -1, 1 },
        direction = defines.direction.south,
      },
      {
        position = { -1, 1 },
        direction = defines.direction.west,
      },
      {
        position = { -1, -1 },
        direction = defines.direction.west,
      },
    },
    pipe_covers =
      make_4way_animation_from_spritesheet(
      {
        filename = "__base__/graphics/entity/heat-exchanger/heatex-endings.png",
        width = 32,
        height = 32,
        direction_count = 4,
        hr_version =
        {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings.png",
          width = 64,
          height = 64,
          direction_count = 4,
          scale = 0.5
        }
      }),
    heat_pipe_covers =
      make_4way_animation_from_spritesheet(
      apply_heat_pipe_glow{
        filename = "__base__/graphics/entity/heat-exchanger/heatex-endings-heated.png",
        width = 32,
        height = 32,
        direction_count = 4,
        hr_version =
        {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-endings-heated.png",
          width = 64,
          height = 64,
          direction_count = 4,
          scale = 0.5
        }
      }),
    heat_picture =
    {
      north = apply_heat_pipe_glow
      {
        filename = "__base__/graphics/entity/heat-exchanger/heatex-N-heated.png",
        priority = "extra-high",
        width = 24,
        height = 48,
        shift = util.by_pixel(-1, 8),
        hr_version =
        {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-N-heated.png",
          priority = "extra-high",
          width = 44,
          height = 96,
          shift = util.by_pixel(-0.5, 8.5),
          scale = 0.5
        }
      },
      east = apply_heat_pipe_glow
      {
        filename = "__base__/graphics/entity/heat-exchanger/heatex-E-heated.png",
        priority = "extra-high",
        width = 40,
        height = 40,
        shift = util.by_pixel(-21, -13),
        hr_version =
        {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-E-heated.png",
          priority = "extra-high",
          width = 80,
          height = 80,
          shift = util.by_pixel(-21, -13),
          scale = 0.5
        }
      },
      south = apply_heat_pipe_glow
      {
        filename = "__base__/graphics/entity/heat-exchanger/heatex-S-heated.png",
        priority = "extra-high",
        width = 16,
        height = 20,
        shift = util.by_pixel(-1, -30),
        hr_version =
        {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-S-heated.png",
          priority = "extra-high",
          width = 28,
          height = 40,
          shift = util.by_pixel(-1, -30),
          scale = 0.5
        }
      },
      west = apply_heat_pipe_glow
      {
        filename = "__base__/graphics/entity/heat-exchanger/heatex-W-heated.png",
        priority = "extra-high",
        width = 32,
        height = 40,
        shift = util.by_pixel(23, -13),
        hr_version =
        {
          filename = "__base__/graphics/entity/heat-exchanger/hr-heatex-W-heated.png",
          priority = "extra-high",
          width = 64,
          height = 76,
          shift = util.by_pixel(23, -13),
          scale = 0.5
        }
      }
    }
  },
  open_sound = sounds.machine_open,
  close_sound = sounds.machine_close,
  vehicle_impact_sound = sounds.generic_impact,
  working_sound =
  {
    sound =
    {
      {
        filename = "__base__/sound/assembling-machine-t1-1.ogg",
        volume = 0.5
      }
    },
    audible_distance_modifier = 0.5,
    fade_in_ticks = 4,
    fade_out_ticks = 20
  }
},
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
        type = "recipe",
        name = "nuclear-reactor",
        energy_required = 8,
        enabled = false,
        ingredients =
        {
          {"concrete", 500},
          {"steel-plate", 500},
          {"advanced-circuit", 500},
          {"copper-plate", 500}
        },
        result = "nuclear-reactor",
        requester_paste_multiplier = 1
      },
{
    type = "reactor",
    name = "heat-reactor",
    scale_energy_usage = true,
    icon  = "__my Example-mod1__/graphics/entity/heat-silo/rocket-silo.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = "heat-reactor"},
    max_health = 500,
    corpse = "nuclear-reactor-remnants",
    dying_explosion = "nuclear-reactor-explosion",
    consumption = "100MW",
    neighbour_bonus = 0.2,
    energy_source =
    {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 2,
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
      max_temperature = 1000,
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