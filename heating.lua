local sub = require("heating_sub")

local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
require ("__base__.prototypes.entity.pipecovers")

  data:extend(
{
  {
    type = "item",
    name = "heat-mining-drill",
    icon = "__base__/graphics/icons/electric-mining-drill.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "extraction-machine",
    order = "a[items]-b[electric-mining-drill]",
    place_result = "heat-mining-drill",
    stack_size = 50
  },
  {
    type = "mining-drill",
    name = "heat-mining-drill",
    icon = "__base__/graphics/icons/electric-mining-drill.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.3, result = "heat-mining-drill"},
    max_health = 300,
    resource_categories = {"basic-solid"},
    corpse = "electric-mining-drill-remnants",
    dying_explosion = "electric-mining-drill-explosion",
    collision_box = {{ -1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{ -1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    heat_buffer =
    {
      max_temperature = 1000,
      specific_heat = "10MJ",
      max_transfer = "10GW",
      minimum_glow_temperature = 350,
      connections =
      {
        {
          position = {-2, -2},
          direction = defines.direction.north
        },
        {
          position = {0, -2},
          direction = defines.direction.north
        },
        {
          position = {2, -2},
          direction = defines.direction.north
        },
        {
          position = {2, -2},
          direction = defines.direction.east
        },
        {
          position = {2, 0},
          direction = defines.direction.east
        },
        {
          position = {2, 2},
          direction = defines.direction.east
        },
        {
          position = {2, 2},
          direction = defines.direction.south
        },
        {
          position = {0, 2},
          direction = defines.direction.south
        },
        {
          position = {-2, 2},
          direction = defines.direction.south
        },
        {
          position = {-2, 2},
          direction = defines.direction.west
        },
        {
          position = {-2, 0},
          direction = defines.direction.west
        },
        {
          position = {-2, -2},
          direction = defines.direction.west
        }
      },

      heat_picture = apply_heat_pipe_glow
      {
        filename = "__base__/graphics/entity/nuclear-reactor/reactor-heated.png",
        width = 108,
        height = 128,
        shift = util.by_pixel(1, -7),
        hr_version =
        {
          filename = "__base__/graphics/entity/nuclear-reactor/hr-reactor-heated.png",
          width = 216,
          height = 256,
          scale = 0.5,
          shift = util.by_pixel(3, -6.5)
        }
      },
    },
    input_fluid_box =
    {
      production_type = "input-output",
      pipe_picture = assembler2pipepictures(),
      pipe_covers = pipecoverspictures(),
      base_area = 1,
      height = 2,
      base_level = -1,
      pipe_connections =
      {
        { position = {-2, 0} },
        { position = {2, 0} },
        { position = {0, 2} }
      }
    },
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
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/electric-mining-drill.ogg",
        volume = 0.5
      },
      audible_distance_modifier = 0.6,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,

    graphics_set =
    {
      drilling_vertical_movement_duration = 10 / electric_drill_animation_speed,
      animation_progress = 1,
      min_animation_progress = 0,
      max_animation_progress = 30,

      status_colors = electric_mining_drill_status_colors(),

      circuit_connector_layer = "object",
      circuit_connector_secondary_draw_order = { north = 14, east = 30, south = 30, west = 30 },

      animation =
      {
        north =
        {
          layers =
          {
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N.png",
              line_length = 1,
              width = 96,
              height = 104,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(0, -4),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N.png",
                line_length = 1,
                width = 190,
                height = 208,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -4),
                repeat_count = 5,
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-output.png",
              line_length = 5,
              width = 32,
              height = 34,
              frame_count = 5,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(-4, -44),
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-output.png",
                line_length = 5,
                width = 60,
                height = 66,
                frame_count = 5,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-3, -44),
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-shadow.png",
              line_length = 1,
              width = 106,
              height = 104,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              draw_as_shadow = true,
              shift = util.by_pixel(6, -4),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-shadow.png",
                line_length = 1,
                width = 212,
                height = 204,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                draw_as_shadow = true,
                shift = util.by_pixel(6, -3),
                repeat_count = 5,
                scale = 0.5
              }
            }
          }
        },
        east =
        {
          layers =
          {
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E.png",
              line_length = 1,
              width = 96,
              height = 94,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(0, -4),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E.png",
                line_length = 1,
                width = 192,
                height = 188,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -4),
                repeat_count = 5,
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-output.png",
              line_length = 5,
              width = 26,
              height = 38,
              frame_count = 5,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(30, -8),
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-output.png",
                line_length = 5,
                width = 50,
                height = 74,
                frame_count = 5,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(30, -8),
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-shadow.png",
              line_length = 1,
              width = 112,
              height = 92,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              draw_as_shadow = true,
              shift = util.by_pixel(10, 2),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-shadow.png",
                line_length = 1,
                width = 222,
                height = 182,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                draw_as_shadow = true,
                shift = util.by_pixel(10, 2),
                repeat_count = 5,
                scale = 0.5
              }
            }
          }
        },
        south =
        {
          layers =
          {
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S.png",
              line_length = 1,
              width = 92,
              height = 98,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(0, -2),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S.png",
                line_length = 1,
                width = 184,
                height = 192,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -1),
                repeat_count = 5,
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-shadow.png",
              line_length = 1,
              width = 106,
              height = 102,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              draw_as_shadow = true,
              shift = util.by_pixel(6, 2),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-shadow.png",
                line_length = 1,
                width = 212,
                height = 204,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                draw_as_shadow = true,
                shift = util.by_pixel(6, 2),
                repeat_count = 5,
                scale = 0.5
              }
            }
          }
        },
        west =
        {
          layers =
          {
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W.png",
              line_length = 1,
              width = 96,
              height = 94,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(0, -4),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W.png",
                line_length = 1,
                width = 192,
                height = 188,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -4),
                repeat_count = 5,
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-output.png",
              line_length = 5,
              width = 24,
              height = 28,
              frame_count = 5,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(-30, -12),
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-output.png",
                line_length = 5,
                width = 50,
                height = 60,
                frame_count = 5,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-31, -13),
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-shadow.png",
              line_length = 1,
              width = 102,
              height = 92,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              draw_as_shadow = true,
              shift = util.by_pixel(-6, 2),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-shadow.png",
                line_length = 1,
                width = 200,
                height = 182,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                draw_as_shadow = true,
                shift = util.by_pixel(-5, 2),
                repeat_count = 5,
                scale = 0.5
              }
            }
          }
        }
      },

      shift_animation_waypoints =
      {
        -- Movement should be between 0.25-0.4 distance
        -- Bounds -0.5 - 0.6
        north = { {0, 0}, {0, -0.3}, {0, 0.1}, {0, 0.5}, {0, 0.2}, {0, -0.1}, {0, -0.5}, {0, -0.15}, {0, 0.25}, {0, 0.6}, {0, 0.3} },
        -- Bounds -1 - 0
        east = { {0, 0}, {-0.4, 0}, {-0.1, 0}, {-0.5, 0}, {-0.75, 0}, {-1, 0}, {-0.65, 0}, {-0.3, 0}, {-0.9, 0}, {-0.6, 0}, {-0.3, 0} },
        -- Bounds -1 - 0
        south = { {0, 0}, {0, -0.4}, {0, -0.1}, {0, -0.5}, {0, -0.75}, {0, -1}, {0, -0.65}, {0, -0.3}, {0, -0.9}, {0, -0.6}, {0, -0.3} },
        -- Bounds 0 - 1
        west = { {0, 0}, {0.4, 0}, {0.1, 0}, {0.5, 0}, {0.75, 0}, {1, 0}, {0.65, 0}, {0.3, 0}, {0.9, 0}, {0.6, 0}, {0.3, 0} }
      },

      shift_animation_waypoint_stop_duration = 195 / electric_drill_animation_speed,
      shift_animation_transition_duration = 30 / electric_drill_animation_speed,

      working_visualisations =
      {
        -- dust animation 1
        {
          constant_speed = true,
          synced_fadeout = true,
          align_to_waypoint = true,
          apply_tint = "resource-color",
          animation = electric_mining_drill_smoke(),
          north_position = { 0, 0.25 },
          east_position = { 0, 0 },
          south_position = { 0, 0.25 },
          west_position = { 0, 0 }
        },

        -- dust animation directional 1
        {
          constant_speed = true,
          fadeout = true,
          apply_tint = "resource-color",
          north_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-smoke.png",
                line_length = 5,
                width = 24,
                height = 30,
                frame_count = 10,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-2, -44),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-smoke.png",
                  line_length = 5,
                  width = 42,
                  height = 58,
                  frame_count = 10,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-1, -44),
                  scale = 0.5
                }
              }
            }
          },
          east_animation = nil,
          south_animation = nil,
          west_animation = nil
        },

        -- drill back animation
        {
          animated_shift = true,
          always_draw = true,
          north_animation =
          {
            layers =
            {
              electric_mining_drill_animation(),
              electric_mining_drill_shadow_animation()
            }
          },
          east_animation =
          {
            layers =
            {
              electric_mining_drill_horizontal_animation(),
              electric_mining_drill_horizontal_shadow_animation()
            }
          },
          south_animation =
          {
            layers =
            {
              electric_mining_drill_animation(),
              electric_mining_drill_shadow_animation()
            }
          },
          west_animation =
          {
            layers =
            {
              electric_mining_drill_horizontal_animation(),
              electric_mining_drill_horizontal_shadow_animation()
            }
          }
        },

        -- dust animation 2
        {
          constant_speed = true,
          synced_fadeout = true,
          align_to_waypoint = true,
          apply_tint = "resource-color",
          animation = electric_mining_drill_smoke_front(),
          north_position = { 0, 0.25 },
          east_position = { 0, 0 },
          south_position = { 0, 0.25 },
          west_position = { 0, 0 }
        },

        -- dust animation directional 2
        {
          constant_speed = true,
          fadeout = true,
          apply_tint = "resource-color",
          north_animation = nil,
          east_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-smoke.png",
                line_length = 5,
                width = 24,
                height = 28,
                frame_count = 10,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(24, -12),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-smoke.png",
                  line_length = 5,
                  width = 46,
                  height = 56,
                  frame_count = 10,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(24, -12),
                  scale = 0.5
                }
              }
            }
          },
          south_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-smoke.png",
                line_length = 5,
                width = 24,
                height = 18,
                frame_count = 10,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-2, 20),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-smoke.png",
                  line_length = 5,
                  width = 48,
                  height = 36,
                  frame_count = 10,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-2, 20),
                  scale = 0.5
                }
              }
            }
          },
          west_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-smoke.png",
                line_length = 5,
                width = 26,
                height = 30,
                frame_count = 10,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-26, -12),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-smoke.png",
                  line_length = 5,
                  width = 46,
                  height = 54,
                  frame_count = 10,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-25, -11),
                  scale = 0.5
                }
              }
            }
          }
        },

        -- drill front animation
        {
          animated_shift = true,
          always_draw = true,
          --north_animation = util.empty_sprite(),
          east_animation = electric_mining_drill_horizontal_front_animation(),
          --south_animation = util.empty_sprite(),
          west_animation = electric_mining_drill_horizontal_front_animation()
        },

        -- front frame
        {
          always_draw = true,
          north_animation = nil,
          east_animation =
          {
            priority = "high",
            filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-front.png",
            line_length = 1,
            width = 66,
            height = 74,
            frame_count = 1,
            animation_speed = electric_drill_animation_speed,
            direction_count = 1,
            shift = util.by_pixel(22, 10),
            hr_version =
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-front.png",
              line_length = 1,
              width = 136,
              height = 148,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(21, 10),
              scale = 0.5
            }
          },
          south_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-output.png",
                line_length = 5,
                width = 44,
                height = 28,
                frame_count = 5,
                animation_speed = electric_drill_animation_speed,
                shift = util.by_pixel(-2, 34),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-output.png",
                  line_length = 5,
                  width = 84,
                  height = 56,
                  frame_count = 5,
                  animation_speed = electric_drill_animation_speed,
                  shift = util.by_pixel(-1, 34),
                  scale = 0.5
                }
              },
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-front.png",
                line_length = 1,
                width = 96,
                height = 54,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                repeat_count = 5,
                shift = util.by_pixel(0, 26),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-front.png",
                  line_length = 1,
                  width = 190,
                  height = 104,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  repeat_count = 5,
                  shift = util.by_pixel(0, 27),
                  scale = 0.5
                }
              }
            }
          },
          west_animation =
          {
            priority = "high",
            filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-front.png",
            line_length = 1,
            width = 68,
            height = 70,
            frame_count = 1,
            animation_speed = electric_drill_animation_speed,
            direction_count = 1,
            shift = util.by_pixel(-22, 12),
            hr_version =
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-front.png",
              line_length = 1,
              width = 134,
              height = 140,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(-22, 12),
              scale = 0.5
            }
          }
        },

        -- LEDs
        electric_mining_drill_status_leds_working_visualisation(),

        -- light
        --electric_mining_drill_primary_light,
        electric_mining_drill_secondary_light
      }
    },

    wet_mining_graphics_set =
    {
      drilling_vertical_movement_duration = 10 / electric_drill_animation_speed,
      animation_progress = 1,
      min_animation_progress = 0,
      max_animation_progress = 30,

      status_colors = electric_mining_drill_status_colors(),

      circuit_connector_layer = "object",
      circuit_connector_secondary_draw_order = { north = 14, east = 48, south = 48, west = 48 },

      animation =
      {
        north =
        {
          layers =
          {
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-wet.png",
              line_length = 1,
              width = 96,
              height = 100,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(0, -8),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-wet.png",
                line_length = 1,
                width = 190,
                height = 198,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -7),
                repeat_count = 5,
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-output.png",
              line_length = 5,
              width = 32,
              height = 34,
              frame_count = 5,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(-4, -44),
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-output.png",
                line_length = 5,
                width = 60,
                height = 66,
                frame_count = 5,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-3, -44),
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-wet-shadow.png",
              line_length = 1,
              width = 124,
              height = 110,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              draw_as_shadow = true,
              shift = util.by_pixel(12, 2),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-wet-shadow.png",
                line_length = 1,
                width = 248,
                height = 222,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                draw_as_shadow = true,
                shift = util.by_pixel(12, 1),
                repeat_count = 5,
                scale = 0.5
              }
            }
          }
        },
        west =
        {
          layers =
          {
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-wet.png",
              line_length = 1,
              width = 96,
              height = 106,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(2, -10),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-wet.png",
                line_length = 1,
                width = 194,
                height = 208,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(1, -9),
                repeat_count = 5,
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-output.png",
              line_length = 5,
              width = 24,
              height = 28,
              frame_count = 5,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(-30, -12),
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-output.png",
                line_length = 5,
                width = 50,
                height = 60,
                frame_count = 5,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-31, -13),
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-wet-shadow.png",
              line_length = 1,
              width = 132,
              height = 102,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              draw_as_shadow = true,
              shift = util.by_pixel(8, 6),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-wet-shadow.png",
                line_length = 1,
                width = 260,
                height = 202,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                draw_as_shadow = true,
                shift = util.by_pixel(9, 6),
                repeat_count = 5,
                scale = 0.5
              }
            }
          }
        },
        south =
        {
          layers =
          {
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-wet.png",
              line_length = 1,
              width = 98,
              height = 106,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(0, -6),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-wet.png",
                line_length = 1,
                width = 192,
                height = 208,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(1, -5),
                repeat_count = 5,
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-wet-shadow.png",
              line_length = 1,
              width = 124,
              height = 98,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              draw_as_shadow = true,
              shift = util.by_pixel(12, 4),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-wet-shadow.png",
                line_length = 1,
                width = 248,
                height = 192,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                draw_as_shadow = true,
                shift = util.by_pixel(12, 5),
                repeat_count = 5,
                scale = 0.5
              }
            }
          }
        },
        east =
        {
          layers =
          {
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-wet.png",
              line_length = 1,
              width = 98,
              height = 106,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(-2, -10),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-wet.png",
                line_length = 1,
                width = 194,
                height = 208,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-2, -9),
                repeat_count = 5,
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-output.png",
              line_length = 5,
              width = 26,
              height = 38,
              frame_count = 5,
              animation_speed = electric_drill_animation_speed,
              direction_count = 1,
              shift = util.by_pixel(30, -8),
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-output.png",
                line_length = 5,
                width = 50,
                height = 74,
                frame_count = 5,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(30, -8),
                scale = 0.5
              }
            },
            {
              priority = "high",
              filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-wet-shadow.png",
              line_length = 1,
              width = 112,
              height = 100,
              frame_count = 1,
              animation_speed = electric_drill_animation_speed,
              draw_as_shadow = true,
              shift = util.by_pixel(10, 6),
              repeat_count = 5,
              hr_version =
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-wet-shadow.png",
                line_length = 1,
                width = 226,
                height = 202,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                draw_as_shadow = true,
                shift = util.by_pixel(9, 5),
                repeat_count = 5,
                scale = 0.5
              }
            }
          }
        }
      },

      shift_animation_waypoints =
      {
        -- Movement should be between 0.25-0.4 distance
        -- Bounds -0.5 - 0.2
        north = { {0, 0}, {0, -0.4}, {0, -0.1}, {0, 0.2} },
        -- Bounds -0.3 - 0
        east = { {0, 0}, {-0.3, 0}, {0, 0}, {-0.25, 0} },
        -- Bounds -0.7 - 0
        south = { {0, 0}, {0, -0.4}, {0, -0.7}, {0, -0.3} },
        -- Bounds 0 - 0.3
        west = { {0, 0}, {0.3, 0}, {0, 0}, {0.25, 0} }
      },

      shift_animation_waypoint_stop_duration = 195 / electric_drill_animation_speed,
      shift_animation_transition_duration = 30 / electric_drill_animation_speed,

      working_visualisations =
      {
        -- dust animation 1
        {
          constant_speed = true,
          synced_fadeout = true,
          align_to_waypoint = true,
          apply_tint = "resource-color",
          animation = electric_mining_drill_smoke(),
          north_position = { 0, 0.25 },
          east_position = { 0, 0 },
          south_position = { 0, 0.25 },
          west_position = { 0, 0 }
        },

        -- dust animation directional 1
        {
          constant_speed = true,
          fadeout = true,
          apply_tint = "resource-color",
          north_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-smoke.png",
                line_length = 5,
                width = 24,
                height = 30,
                frame_count = 10,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-2, -44),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-smoke.png",
                  line_length = 5,
                  width = 42,
                  height = 58,
                  frame_count = 10,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-1, -44),
                  scale = 0.5
                }
              }
            }
          },
          east_animation = nil,
          south_animation = nil,
          west_animation = nil
        },

        -- drill back animation
        {
          animated_shift = true,
          always_draw = true,
          north_animation =
          {
            layers =
            {
              electric_mining_drill_animation(),
              electric_mining_drill_shadow_animation()
            }
          },
          east_animation =
          {
            layers =
            {
              electric_mining_drill_horizontal_animation(),
              electric_mining_drill_horizontal_shadow_animation()
            }
          },
          south_animation =
          {
            layers =
            {
              electric_mining_drill_animation(),
              electric_mining_drill_shadow_animation()
            }
          },
          west_animation =
          {
            layers =
            {
              electric_mining_drill_horizontal_animation(),
              electric_mining_drill_horizontal_shadow_animation()
            }
          }
        },

        -- dust animation 2
        {
          constant_speed = true,
          synced_fadeout = true,
          align_to_waypoint = true,
          apply_tint = "resource-color",
          animation = electric_mining_drill_smoke_front()
        },

        -- dust animation directional 2
        {
          constant_speed = true,
          fadeout = true,
          apply_tint = "resource-color",
          north_animation = nil,
          east_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-smoke.png",
                line_length = 5,
                width = 24,
                height = 28,
                frame_count = 10,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(24, -12),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-smoke.png",
                  line_length = 5,
                  width = 46,
                  height = 56,
                  frame_count = 10,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(24, -12),
                  scale = 0.5
                }
              }
            }
          },
          south_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-smoke.png",
                line_length = 5,
                width = 24,
                height = 18,
                frame_count = 10,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-2, 20),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-smoke.png",
                  line_length = 5,
                  width = 48,
                  height = 36,
                  frame_count = 10,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-2, 20),
                  scale = 0.5
                }
              }
            }
          },
          west_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-smoke.png",
                line_length = 5,
                width = 26,
                height = 30,
                frame_count = 10,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-26, -12),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-smoke.png",
                  line_length = 5,
                  width = 46,
                  height = 54,
                  frame_count = 10,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-25, -11),
                  scale = 0.5
                }
              }
            }
          }
        },

        -- fluid window background (bottom)
        {
          -- render_layer = "lower-object-above-shadow",
          secondary_draw_order = -49,
          always_draw = true,
          north_animation = nil,
          east_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-wet-window-background.png",
                line_length = 1,
                width = 12,
                height = 8,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -52),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-wet-window-background.png",
                  line_length = 1,
                  width = 22,
                  height = 14,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, -52),
                  scale = 0.5
                }
              }
            }
          },
          south_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-wet-window-background.png",
                line_length = 1,
                width = 16,
                height = 12,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-2, -44),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-wet-window-background.png",
                  line_length = 1,
                  width = 30,
                  height = 20,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-2, -43),
                  scale = 0.5
                }
              }
            }
          },
          west_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-wet-window-background.png",
                line_length = 1,
                width = 12,
                height = 8,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -52),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-wet-window-background.png",
                  line_length = 1,
                  width = 22,
                  height = 14,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, -52),
                  scale = 0.5
                }
              }
            }
          }
        },

        -- fluid base (bottom)
        {
          always_draw = true,
          -- render_layer = "lower-object-above-shadow",
          secondary_draw_order = -48,
          apply_tint = "input-fluid-base-color",
          north_animation = nil,
          east_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-wet-fluid-background.png",
                line_length = 1,
                width = 12,
                height = 8,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -52),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-wet-fluid-background.png",
                  line_length = 1,
                  width = 22,
                  height = 14,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, -52),
                  scale = 0.5
                }
              }
            }
          },
          south_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-wet-fluid-background.png",
                line_length = 1,
                width = 14,
                height = 8,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-2, -42),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-wet-fluid-background.png",
                  line_length = 1,
                  width = 28,
                  height = 18,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-2, -43),
                  scale = 0.5
                }
              }
            }
          },
          west_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-wet-fluid-background.png",
                line_length = 1,
                width = 12,
                height = 8,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -52),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-wet-fluid-background.png",
                  line_length = 1,
                  width = 22,
                  height = 14,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, -52),
                  scale = 0.5
                }
              }
            }
          }
        },

        -- fluid flow (bottom)
        {
          --render_layer = "lower-object-above-shadow",
          secondary_draw_order = -47,
          always_draw = true,
          apply_tint = "input-fluid-flow-color",
          north_animation = nil,
          east_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-wet-fluid-flow.png",
                line_length = 1,
                width = 12,
                height = 8,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -52),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-wet-fluid-flow.png",
                  line_length = 1,
                  width = 24,
                  height = 14,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, -52),
                  scale = 0.5
                }
              }
            }
          },
          south_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-wet-fluid-flow.png",
                line_length = 1,
                width = 14,
                height = 8,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-2, -42),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-wet-fluid-flow.png",
                  line_length = 1,
                  width = 26,
                  height = 16,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-2, -42),
                  scale = 0.5
                }
              }
            }
          },
          west_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-wet-fluid-flow.png",
                line_length = 1,
                width = 12,
                height = 8,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -52),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-wet-fluid-flow.png",
                  line_length = 1,
                  width = 24,
                  height = 14,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, -52),
                  scale = 0.5
                }
              }
            }
          }
        },

        -- drill front animation
        {
          animated_shift = true,
          always_draw = true,
          --north_animation = util.empty_sprite(),
          east_animation = electric_mining_drill_horizontal_front_animation(),
          --south_animation = util.empty_sprite(),
          west_animation = electric_mining_drill_horizontal_front_animation()
        },

        -- fluid window background (front)
        {
          always_draw = true,
          north_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-wet-window-background.png",
                line_length = 1,
                width = 86,
                height = 44,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, 10),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-wet-window-background.png",
                  line_length = 1,
                  width = 172,
                  height = 90,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, 9),
                  scale = 0.5
                }
              }
            }
          },
          west_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-wet-window-background-front.png",
                line_length = 1,
                width = 40,
                height = 54,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(14, 10),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-wet-window-background-front.png",
                  line_length = 1,
                  width = 80,
                  height = 106,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(14, 10),
                  scale = 0.5
                }
              }
            }
          },
          south_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-wet-window-background-front.png",
                line_length = 1,
                width = 86,
                height = 14,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -8),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-wet-window-background-front.png",
                  line_length = 1,
                  width = 172,
                  height = 22,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, -7),
                  scale = 0.5
                }
              }
            }
          },
          east_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-wet-window-background-front.png",
                line_length = 1,
                width = 40,
                height = 54,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-14, 10),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-wet-window-background-front.png",
                  line_length = 1,
                  width = 82,
                  height = 110,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-15, 9),
                  scale = 0.5
                }
              }
            }
          }
        },

        -- fluid base (front)
        {
          always_draw = true,
          apply_tint = "input-fluid-base-color",
          north_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-wet-fluid-background.png",
                line_length = 1,
                width = 90,
                height = 46,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, 10),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-wet-fluid-background.png",
                  line_length = 1,
                  width = 178,
                  height = 94,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, 9),
                  scale = 0.5
                }
              }
            }
          },
          west_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-wet-fluid-background-front.png",
                line_length = 1,
                width = 40,
                height = 54,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(14, 10),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-wet-fluid-background-front.png",
                  line_length = 1,
                  width = 80,
                  height = 102,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(14, 11),
                  scale = 0.5
                }
              }
            }
          },
          south_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-wet-fluid-background-front.png",
                line_length = 1,
                width = 90,
                height = 16,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -8),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-wet-fluid-background-front.png",
                  line_length = 1,
                  width = 178,
                  height = 28,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, -7),
                  scale = 0.5
                }
              }
            }
          },
          east_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-wet-fluid-background-front.png",
                line_length = 1,
                width = 40,
                height = 54,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-14, 10),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-wet-fluid-background-front.png",
                  line_length = 1,
                  width = 82,
                  height = 106,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-15, 10),
                  scale = 0.5
                }
              }
            }
          }
        },

        -- fluid flow (front)
        {
          always_draw = true,
          apply_tint = "input-fluid-flow-color",
          north_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-wet-fluid-flow.png",
                line_length = 1,
                width = 86,
                height = 44,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, 10),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-wet-fluid-flow.png",
                  line_length = 1,
                  width = 172,
                  height = 88,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, 10),
                  scale = 0.5
                }
              }
            }
          },
          west_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-wet-fluid-flow-front.png",
                line_length = 1,
                width = 40,
                height = 50,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(14, 12),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-wet-fluid-flow-front.png",
                  line_length = 1,
                  width = 78,
                  height = 102,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(14, 11),
                  scale = 0.5
                }
              }
            }
          },
          south_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-wet-fluid-flow-front.png",
                line_length = 1,
                width = 86,
                height = 12,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, -8),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-wet-fluid-flow-front.png",
                  line_length = 1,
                  width = 172,
                  height = 22,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, -8),
                  scale = 0.5
                }
              }
            }
          },
          east_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-wet-fluid-flow-front.png",
                line_length = 1,
                width = 40,
                height = 54,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-14, 10),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-wet-fluid-flow-front.png",
                  line_length = 1,
                  width = 78,
                  height = 106,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-14, 10),
                  scale = 0.5
                }
              }
            }
          }
        },

        -- front frame (wet)
        {
          always_draw = true,
          north_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-wet-front.png",
                line_length = 1,
                width = 100,
                height = 66,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(0, 16),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-wet-front.png",
                  line_length = 1,
                  width = 200,
                  height = 130,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(0, 16),
                  scale = 0.5
                }
              }
            }
          },
          west_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-wet-front.png",
                line_length = 1,
                width = 104,
                height = 72,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(-4, 12),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-wet-front.png",
                  line_length = 1,
                  width = 208,
                  height = 144,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(-4, 12),
                  scale = 0.5
                }
              }
            }
          },
          south_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-output.png",
                line_length = 5,
                width = 44,
                height = 28,
                frame_count = 5,
                animation_speed = electric_drill_animation_speed,
                shift = util.by_pixel(-2, 34),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-output.png",
                  line_length = 5,
                  width = 84,
                  height = 56,
                  frame_count = 5,
                  animation_speed = electric_drill_animation_speed,
                  shift = util.by_pixel(-1, 34),
                  scale = 0.5
                }
              },
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-wet-front.png",
                line_length = 1,
                width = 96,
                height = 70,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                repeat_count = 5,
                shift = util.by_pixel(0, 18),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-wet-front.png",
                  line_length = 1,
                  width = 192,
                  height = 140,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  repeat_count = 5,
                  shift = util.by_pixel(0, 18),
                  scale = 0.5
                }
              }
            }
          },
          east_animation =
          {
            layers =
            {
              {
                priority = "high",
                filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-wet-front.png",
                line_length = 1,
                width = 106,
                height = 76,
                frame_count = 1,
                animation_speed = electric_drill_animation_speed,
                direction_count = 1,
                shift = util.by_pixel(2, 10),
                hr_version =
                {
                  priority = "high",
                  filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-wet-front.png",
                  line_length = 1,
                  width = 208,
                  height = 148,
                  frame_count = 1,
                  animation_speed = electric_drill_animation_speed,
                  direction_count = 1,
                  shift = util.by_pixel(3, 11),
                  scale = 0.5
                }
              }
            }
          }
        },

        -- LEDs
        electric_mining_drill_status_leds_working_visualisation(),

        -- light
        --electric_mining_drill_primary_light,
        electric_mining_drill_secondary_light
      }
    },

    integration_patch =
    {
      north =
      {
        priority = "high",
        filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-integration.png",
        line_length = 1,
        width = 110,
        height = 108,
        frame_count = 1,
        animation_speed = electric_drill_animation_speed,
        direction_count = 1,
        shift = util.by_pixel(-2, 2),
        repeat_count = 5,
        hr_version =
        {
          priority = "high",
          filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-integration.png",
          line_length = 1,
          width = 216,
          height = 218,
          frame_count = 1,
          animation_speed = electric_drill_animation_speed,
          direction_count = 1,
          shift = util.by_pixel(-1, 1),
          repeat_count = 5,
          scale = 0.5
        }
      },
      east =
      {
        priority = "high",
        filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-integration.png",
        line_length = 1,
        width = 116,
        height = 108,
        frame_count = 1,
        animation_speed = electric_drill_animation_speed,
        direction_count = 1,
        shift = util.by_pixel(4, 2),
        repeat_count = 5,
        hr_version =
        {
          priority = "high",
          filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-integration.png",
          line_length = 1,
          width = 236,
          height = 214,
          frame_count = 1,
          animation_speed = electric_drill_animation_speed,
          direction_count = 1,
          shift = util.by_pixel(3, 2),
          repeat_count = 5,
          scale = 0.5
        }
      },
      south =
      {
        priority = "high",
        filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-integration.png",
        line_length = 1,
        width = 108,
        height = 114,
        frame_count = 1,
        animation_speed = electric_drill_animation_speed,
        direction_count = 1,
        shift = util.by_pixel(0, 4),
        repeat_count = 5,
        hr_version =
        {
          priority = "high",
          filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-integration.png",
          line_length = 1,
          width = 214,
          height = 230,
          frame_count = 1,
          animation_speed = electric_drill_animation_speed,
          direction_count = 1,
          shift = util.by_pixel(0, 3),
          repeat_count = 5,
          scale = 0.5
        }
      },
      west =
      {
        priority = "high",
        filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-integration.png",
        line_length = 1,
        width = 118,
        height = 106,
        frame_count = 1,
        animation_speed = electric_drill_animation_speed,
        direction_count = 1,
        shift = util.by_pixel(-4, 2),
        repeat_count = 5,
        hr_version =
        {
          priority = "high",
          filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-integration.png",
          line_length = 1,
          width = 234,
          height = 214,
          frame_count = 1,
          animation_speed = electric_drill_animation_speed,
          direction_count = 1,
          shift = util.by_pixel(-4, 1),
          repeat_count = 5,
          scale = 0.5
        }
      }
    },

    mining_speed = 0.5,
    resource_searching_radius = 2.49,
    vector_to_place_result = {0, -1.85},
    module_specification =
    {
      module_slots = 3
    },
    radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-radius-visualization.png",
      width = 10,
      height = 10
    },
    monitor_visualization_tint = {r=78, g=173, b=255},
    fast_replaceable_group = "mining-drill",

    circuit_wire_connection_points = circuit_connector_definitions["electric-mining-drill"].points,
    circuit_connector_sprites = circuit_connector_definitions["electric-mining-drill"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },
  {
    type = "mining-drill",
    name = "burner-mining-drill",
    icon = "__base__/graphics/icons/burner-mining-drill.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    resource_categories = {"basic-solid"},
    minable = {mining_time = 0.3, result = "burner-mining-drill"},
    max_health = 150,
    corpse = "burner-mining-drill-remnants",
    dying_explosion = "burner-mining-drill-explosion",
    collision_box = {{ -0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{ -1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    mining_speed = 0.25,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/burner-mining-drill.ogg",
          volume = 0.6
        },
        {
          filename = "__base__/sound/burner-mining-drill-1.ogg",
          volume = 0.6
        }
      },
      --max_sounds_per_type = 3,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = sounds.generic_impact,
    allowed_effects = {}, -- no beacon effects on the burner drill
    energy_source =
    {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 1,
      emissions_per_minute = 12,
      light_flicker = {color = {0,0,0}},
      smoke =
      {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 3
        }
      }
    },
    energy_usage = "150kW",
    animations =
    {
      north =
      {
        layers =
        {
          {
            priority = "high",
            width = 87,
            height = 95,
            line_length = 4,
            shift = util.by_pixel(2.5, 0.5),
            filename = "__base__/graphics/entity/burner-mining-drill/burner-mining-drill-N.png",
            frame_count = 32,
            animation_speed = 0.5,
            run_mode = "forward-then-backward",
            hr_version =
            {
              priority = "high",
              width = 173,
              height = 188,
              line_length = 4,
              shift = util.by_pixel(2.75, 0.5),
              filename = "__base__/graphics/entity/burner-mining-drill/hr-burner-mining-drill-N.png",
              frame_count = 32,
              animation_speed = 0.5,
              run_mode = "forward-then-backward",
              scale = 0.5
            }
          },
          {
            priority = "high",
            width = 109,
            height = 76,
            line_length = 4,
            shift = util.by_pixel(23.5, -1),
            filename = "__base__/graphics/entity/burner-mining-drill/burner-mining-drill-N-shadow.png",
            frame_count = 32,
            animation_speed = 0.5,
            run_mode = "forward-then-backward",
            draw_as_shadow = true,
            hr_version =
            {
              priority = "high",
              width = 217,
              height = 150,
              line_length = 4,
              shift = util.by_pixel(23.75, -1),
              filename = "__base__/graphics/entity/burner-mining-drill/hr-burner-mining-drill-N-shadow.png",
              frame_count = 32,
              animation_speed = 0.5,
              run_mode = "forward-then-backward",
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      },
      east =
      {
        layers =
        {
          {
            priority = "high",
            width = 93,
            height = 84,
            line_length = 4,
            shift = util.by_pixel(2.5, 1),
            filename = "__base__/graphics/entity/burner-mining-drill/burner-mining-drill-E.png",
            frame_count = 32,
            animation_speed = 0.5,
            run_mode = "forward-then-backward",
            hr_version =
            {
              priority = "high",
              width = 185,
              height = 168,
              line_length = 4,
              shift = util.by_pixel(2.75, 1),
              filename = "__base__/graphics/entity/burner-mining-drill/hr-burner-mining-drill-E.png",
              frame_count = 32,
              animation_speed = 0.5,
              run_mode = "forward-then-backward",
              scale = 0.5
            }
          },
          {
            priority = "high",
            width = 93,
            height = 65,
            line_length = 4,
            shift = util.by_pixel(13.5, 0.5),
            filename = "__base__/graphics/entity/burner-mining-drill/burner-mining-drill-E-shadow.png",
            frame_count = 32,
            animation_speed = 0.5,
            run_mode = "forward-then-backward",
            draw_as_shadow = true,
            hr_version =
            {
              priority = "high",
              width = 185,
              height = 128,
              line_length = 4,
              shift = util.by_pixel(13.75, 0.5),
              filename = "__base__/graphics/entity/burner-mining-drill/hr-burner-mining-drill-E-shadow.png",
              frame_count = 32,
              animation_speed = 0.5,
              run_mode = "forward-then-backward",
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      },
      south =
      {
        layers =
        {
          {
            priority = "high",
            width = 87,
            height = 87,
            line_length = 4,
            shift = util.by_pixel(0.5, -0.5),
            filename = "__base__/graphics/entity/burner-mining-drill/burner-mining-drill-S.png",
            frame_count = 32,
            animation_speed = 0.5,
            run_mode = "forward-then-backward",
            hr_version =
            {
              priority = "high",
              width = 174,
              height = 174,
              line_length = 4,
              shift = util.by_pixel(0.5, -0.5),
              filename = "__base__/graphics/entity/burner-mining-drill/hr-burner-mining-drill-S.png",
              frame_count = 32,
              animation_speed = 0.5,
              run_mode = "forward-then-backward",
              scale = 0.5
            }
          },
          {
            priority = "high",
            width = 88,
            height = 69,
            line_length = 4,
            shift = util.by_pixel(11, 2.5),
            filename = "__base__/graphics/entity/burner-mining-drill/burner-mining-drill-S-shadow.png",
            frame_count = 32,
            animation_speed = 0.5,
            run_mode = "forward-then-backward",
            draw_as_shadow = true,
            hr_version =
            {
              priority = "high",
              width = 174,
              height = 137,
              line_length = 4,
              shift = util.by_pixel(11, 2.75),
              filename = "__base__/graphics/entity/burner-mining-drill/hr-burner-mining-drill-S-shadow.png",
              frame_count = 32,
              animation_speed = 0.5,
              run_mode = "forward-then-backward",
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      },
      west =
      {
        layers =
        {
          {
            priority = "high",
            width = 91,
            height = 88,
            line_length = 4,
            shift = util.by_pixel(-1.5, 0),
            filename = "__base__/graphics/entity/burner-mining-drill/burner-mining-drill-W.png",
            frame_count = 32,
            animation_speed = 0.5,
            run_mode = "forward-then-backward",
            hr_version =
            {
              priority = "high",
              width = 180,
              height = 176,
              line_length = 4,
              shift = util.by_pixel(-1.5, 0),
              filename = "__base__/graphics/entity/burner-mining-drill/hr-burner-mining-drill-W.png",
              frame_count = 32,
              animation_speed = 0.5,
              run_mode = "forward-then-backward",
              scale = 0.5
            }
          },
          {
            priority = "high",
            width = 89,
            height = 66,
            line_length = 4,
            shift = util.by_pixel(7.5, 1),
            filename = "__base__/graphics/entity/burner-mining-drill/burner-mining-drill-W-shadow.png",
            frame_count = 32,
            animation_speed = 0.5,
            run_mode = "forward-then-backward",
            draw_as_shadow = true,
            hr_version =
            {
              priority = "high",
              width = 176,
              height = 130,
              line_length = 4,
              shift = util.by_pixel(7.5, 1),
              filename = "__base__/graphics/entity/burner-mining-drill/hr-burner-mining-drill-W-shadow.png",
              frame_count = 32,
              animation_speed = 0.5,
              run_mode = "forward-then-backward",
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      }
    },
    monitor_visualization_tint = {r=78, g=173, b=255},
    resource_searching_radius = 0.99,
    vector_to_place_result = {-0.5, -1.3},
    fast_replaceable_group = "mining-drill",

    circuit_wire_connection_points = circuit_connector_definitions["burner-mining-drill"].points,
    circuit_connector_sprites = circuit_connector_definitions["burner-mining-drill"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance
  }
}
  )