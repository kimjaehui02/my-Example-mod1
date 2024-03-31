local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
require ("__base__.prototypes.entity.pipecovers")


apply_heat_pipe_glow = function(layer)
  layer.tint = heated_pipes_tint
  if layer.hr_version then
    layer.hr_version.tint = heated_pipes_tint
  end
  local light_layer = util.copy(layer)
  light_layer.draw_as_light = true
  light_layer.tint = heat_glow_tint
  if light_layer.hr_version then
    light_layer.hr_version.draw_as_light = true
    light_layer.hr_version.tint = heat_glow_tint
  end
  return
  {
    layers =
    {
      layer,
      light_layer
    }
  }
end

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



-- local hit_effects = require ("prototypes.entity.hit-effects")
-- local sounds = require("prototypes.entity.sounds")

electric_drill_animation_speed = 0.4
electric_drill_animation_sequence =
{
  1, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
  21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1
}

electric_drill_animation_shadow_sequence =
{
  1, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
  21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1
}

function electric_mining_drill_smoke()
  return
  {
    priority = "high",
    filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-smoke.png",
    line_length = 6,
    width = 24,
    height = 38,
    frame_count = 30,
    animation_speed = electric_drill_animation_speed,
    direction_count = 1,
    shift = util.by_pixel(0, 2),
    hr_version =
    {
      priority = "high",
      filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-smoke.png",
      line_length = 6,
      width = 48,
      height = 72,
      frame_count = 30,
      animation_speed = electric_drill_animation_speed,
      direction_count = 1,
      shift = util.by_pixel(0, 3),
      scale = 0.5
    }
  }
end

function electric_mining_drill_smoke_front()
  return
  {
    priority = "high",
    filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-smoke-front.png",
    line_length = 6,
    width = 76,
    height = 68,
    frame_count = 30,
    animation_speed = electric_drill_animation_speed,
    direction_count = 1,
    shift = util.by_pixel(-4, 8),
    hr_version =
    {
      priority = "high",
      filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-smoke-front.png",
      line_length = 6,
      width = 148,
      height = 132,
      frame_count = 30,
      animation_speed = electric_drill_animation_speed,
      direction_count = 1,
      shift = util.by_pixel(-3, 9),
      scale = 0.5
    }
  }
end

function electric_mining_drill_animation()
  return
  {
    priority = "high",
    filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill.png",
    line_length = 6,
    width = 84,
    height = 80,
    frame_count = 30,
    animation_speed = electric_drill_animation_speed,
    frame_sequence = electric_drill_animation_sequence,
    direction_count = 1,
    shift = util.by_pixel(0, -12),
    hr_version =
    {
      priority = "high",
      filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill.png",
      line_length = 6,
      width = 162,
      height = 156,
      frame_count = 30,
      animation_speed = electric_drill_animation_speed,
      frame_sequence = electric_drill_animation_sequence,
      direction_count = 1,
      shift = util.by_pixel(1, -11),
      scale = 0.5
    }
  }
end

function electric_mining_drill_shadow_animation()
  return
  {
    priority = "high",
    filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-shadow.png",
    line_length = 7,
    width = 112,
    height = 26,
    frame_count = 21,
    animation_speed = electric_drill_animation_speed,
    frame_sequence = electric_drill_animation_shadow_sequence,
    draw_as_shadow = true,
    shift = util.by_pixel(20, 6),
    hr_version =
    {
      priority = "high",
      filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-shadow.png",
      line_length = 7,
      width = 218,
      height = 56,
      frame_count = 21,
      animation_speed = electric_drill_animation_speed,
      frame_sequence = electric_drill_animation_shadow_sequence,
      draw_as_shadow = true,
      shift = util.by_pixel(21, 5),
      scale = 0.5
    }
  }
end

function electric_mining_drill_horizontal_animation()
  return
  {
    priority = "high",
    filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-horizontal.png",
    line_length = 6,
    width = 40,
    height = 80,
    frame_count = 30,
    animation_speed = electric_drill_animation_speed,
    frame_sequence = electric_drill_animation_sequence,
    direction_count = 1,
    shift = util.by_pixel(2, -12),
    hr_version =
    {
      priority = "high",
      filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-horizontal.png",
      line_length = 6,
      width = 80,
      height = 160,
      frame_count = 30,
      animation_speed = electric_drill_animation_speed,
      frame_sequence = electric_drill_animation_sequence,
      direction_count = 1,
      shift = util.by_pixel(2, -12),
      scale = 0.5
    }
  }
end

function electric_mining_drill_horizontal_front_animation()
  return
  {
    priority = "high",
    filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-horizontal-front.png",
    line_length = 6,
    width = 32,
    height = 76,
    frame_count = 30,
    animation_speed = electric_drill_animation_speed,
    frame_sequence = electric_drill_animation_sequence,
    direction_count = 1,
    shift = util.by_pixel(-2, 4),
    hr_version =
    {
      priority = "high",
      filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-horizontal-front.png",
      line_length = 6,
      width = 66,
      height = 154,
      frame_count = 30,
      animation_speed = electric_drill_animation_speed,
      frame_sequence = electric_drill_animation_sequence,
      direction_count = 1,
      shift = util.by_pixel(-3, 3),
      scale = 0.5
    }
  }
end

function electric_mining_drill_horizontal_shadow_animation()
  return
  {
    priority = "high",
    filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-horizontal-shadow.png",
    line_length = 7,
    width = 92,
    height = 80,
    frame_count = 21,
    animation_speed = electric_drill_animation_speed,
    frame_sequence = electric_drill_animation_shadow_sequence,
    draw_as_shadow = true,
    shift = util.by_pixel(32, 2),
    hr_version =
    {
      priority = "high",
      filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-horizontal-shadow.png",
      line_length = 7,
      width = 180,
      height = 164,
      frame_count = 21,
      animation_speed = electric_drill_animation_speed,
      frame_sequence = electric_drill_animation_shadow_sequence,
      draw_as_shadow = true,
      shift = util.by_pixel(33, 1),
      scale = 0.5
    }
  }
end

function electric_mining_drill_status_colors()
  return
  {
    -- If no_power, idle, no_minable_resources, disabled, insufficient_input or full_output is used, always_draw of corresponding layer must be set to true to draw it in those states.

    no_power = { 0, 0, 0, 0 },                  -- If no_power is not specified or is nil, it defaults to clear color {0,0,0,0}

    idle = { 1, 0, 0, 1 },                      -- If idle is not specified or is nil, it defaults to white.
    no_minable_resources = { 1, 0, 0, 1 },      -- If no_minable_resources, disabled, insufficient_input or full_output are not specified or are nil, they default to idle color.
    insufficient_input = { 1, 1, 0, 1 },
    full_output = { 1, 1, 0, 1 },
    disabled = { 1, 1, 0, 1 },

    working = { 0, 1, 0, 1 },                   -- If working is not specified or is nil, it defaults to white.
    low_power = { 1, 1, 0, 1 },                 -- If low_power is not specified or is nil, it defaults to working color.
  }
end

function electric_mining_drill_status_leds_working_visualisation()
  local led_blend_mode = nil -- "additive"
  local led_tint = {1,1,1,1}
  return
  {
    apply_tint = "status",
    always_draw = true,
    --draw_as_sprite = true,
    draw_as_light = true,
    north_animation =
    {
      filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-N-light.png",
      width = 16,
      height = 16,
      blend_mode = led_blend_mode,
      tint = led_tint,
      shift = util.by_pixel(26, -48),
      hr_version =
      {
        filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-light.png",
        width = 32,
        height = 32,
        blend_mode = led_blend_mode,
        tint = led_tint,
        shift = util.by_pixel(26, -48),
        scale = 0.5
      }
    },
    east_animation =
    {
      filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-E-light.png",
      width = 16,
      height = 18,
      blend_mode = led_blend_mode,
      tint = led_tint,
      shift = util.by_pixel(38, -32),
      hr_version =
      {
        filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-light.png",
        width = 32,
        height = 34,
        blend_mode = led_blend_mode,
        tint = led_tint,
        shift = util.by_pixel(38, -32),
        scale = 0.5
      }
    },
    south_animation =
    {
      filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-S-light.png",
      width = 20,
      height = 24,
      blend_mode = led_blend_mode,
      tint = led_tint,
      shift = util.by_pixel(26, 26),
      hr_version =
      {
        filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-light.png",
        width = 38,
        height = 46,
        blend_mode = led_blend_mode,
        tint = led_tint,
        shift = util.by_pixel(26, 26),
        scale = 0.5
      }
    },
    west_animation =
    {
      filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-W-light.png",
      width = 18,
      height = 18,
      blend_mode = led_blend_mode,
      tint = led_tint,
      shift = util.by_pixel(-40, -32),
      hr_version =
      {
        filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-light.png",
        width = 32,
        height = 34,
        blend_mode = led_blend_mode,
        tint = led_tint,
        shift = util.by_pixel(-39, -32),
        scale = 0.5
      }
    }
  }
end

function electric_mining_drill_add_light_offsets(t)
  t.north_position = { 0.8, -1.5}
  t.east_position =  { 1.2, -1}
  t.south_position = { 0.8,  0.8}
  t.west_position =  {-1.2, -1}
  return t
end

local electric_mining_drill_primary_light =
  electric_mining_drill_add_light_offsets(
  {
    light = { intensity = 1, size = 3, color={r=1, g=1, b=1}, minimum_darkness = 0.1 }
  })

local electric_mining_drill_secondary_light =
  electric_mining_drill_add_light_offsets(
  {
    always_draw = true,
    apply_tint = "status",
    light = { intensity = 0.2, size = 2, color={r=1, g=1, b=1}, minimum_darkness = 0.1 }
  })


