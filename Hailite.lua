


local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local resource_autoplace = require("resource-autoplace")


data:extend
(
  {
    -- 빙정핵 -----------------------------------------------------------------------
    {
      type = "recipe",
      name = "Hailite-enrichment-process",
      energy_required = 60,
      enabled = true,
      category = "Hailite-crafting",
      ingredients = {{"Ice-Core", 40}, {"perennial-ice", 5}},
      icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/kovarex-enrichment-process.png",
      icon_size = 64, icon_mipmaps = 4,
      subgroup = "intermediate-product",
      order = "r[uranium-processing]-c[kovarex-enrichment-process]",
      main_product = "",
      results = {{"Ice-Core", 41}, {"perennial-ice", 2}},
      allow_decomposition = false
    },
    {
      type = "recipe",
      name = "Hailite-processing",
      energy_required = 12,
      enabled = true,
      category = "Hailite-crafting",
      ingredients = {{"Hailite-ore", 10}},
      icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-processing.png",
      icon_size = 64, icon_mipmaps = 4,
      subgroup = "raw-material",
      order = "k[uranium-processing]", -- k ordering so it shows up after explosives which is j ordering
      results =
      {
        {
          name = "Ice-Core",
          probability = 0.7,
          amount = 1
        },
        {
          name = "perennial-ice",
          probability = 0.993,
          amount = 1
        }
      }
    },


    {
      type = "resource-category",
      name = "Hailite"
    },
    {
      type = "autoplace-control",
      name = "Hailite-ore",
      localised_name = {"", "[entity=Hailite-ore] ", {"entity-name.Hailite-ore"}},
      richness = true,
      order = "b-e",
      category = "resource"
    },
    {
      type = "resource",
      name = "Hailite-ore",
      category = "Hailite",
      icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
      icon_size = 64,
      icon_mipmaps = 4,
      flags = {"placeable-neutral"},
      order="a-b-e",
      tree_removal_probability = 0.7,
      tree_removal_max_distance = 32 * 32,
      walking_sound = sounds.ore,
      minable =
      {
        mining_particle = "stone-particle",
        mining_time = 2,
        result = "Hailite-ore"
      },
      collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
      selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
      autoplace = resource_autoplace.resource_autoplace_settings
      {
        name = "Hailite-ore",
        order = "c",
        base_density = 0.9,
        base_spots_per_km2 = 1.25,
        has_starting_area_placement = true,
        random_spot_size_minimum = 2,
        random_spot_size_maximum = 4,
        regular_rq_factor_multiplier = 1
      },
      stage_counts = {10000, 6330, 3670, 1930, 870, 270, 100, 50},
      stages =
      {
        sheet =
        {
          filename = "__base__/graphics/entity/uranium-ore/uranium-ore.png",
          priority = "extra-high",
          width = 64,
          height = 64,
          frame_count = 8,
          variation_count = 8,
          hr_version =
          {
            filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/hr-uranium-ore.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            frame_count = 8,
            variation_count = 8,
            scale = 0.5
          }
        }
      },
      stages_effect =
      {
        sheet =
        {
          filename = "__base__/graphics/entity/uranium-ore/uranium-ore-glow.png",
          priority = "extra-high",
          width = 64,
          height = 64,
          frame_count = 8,
          variation_count = 8,
          blend_mode = "additive",
          flags = {"light"},
          hr_version =
          {
            filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/hr-uranium-ore-glow2.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            frame_count = 8,
            variation_count = 8,
            scale = 0.5,
            blend_mode = "additive",
            flags = {"light"}
          }
        }
      },
      effect_animation_period = 5,
      effect_animation_period_deviation = 1,
      effect_darkness_multiplier = 3.6,
      min_effect_alpha = 0.2,
      max_effect_alpha = 0.3,
      mining_visualisation_tint = {r = 0.814, g = 1.000, b = 0.499, a = 1.000}, -- #cfff7fff
      map_color = {0.35, 0.8, 0.8}
    },
    {
      type = "item",
      name = "Hailite-ore",
      icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
      icon_size = 64,
      icon_mipmaps = 4,
      pictures =
      {
        {
          layers =
          {
            {
              filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
              size = 64,
              scale = 0.25,
              mipmap_count = 4
            },
            {
              filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore.png",
              blend_mode = "additive",
              draw_as_light = true,
              tint = {r = 0.3, g = 0.3, b = 0.3, a = 0.3},
              size = 64,
              scale = 0.25,
              mipmap_count = 4
            },
          }
        },
        {
          layers =
          {
            {
              filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore-1.png",
              size = 64,
              scale = 0.25,
              mipmap_count = 4
            },
            {
              filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore-1.png",
              blend_mode = "additive",
              draw_as_light = true,
              tint = { r = 0.6, g = 0.6, b = 0.6, a = 0.6},
              size = 64,
              scale = 0.25,
              mipmap_count = 4
            },
          }
        },
        {
          layers =
          {
            {
              filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore-2.png",
              size = 64,
              scale = 0.25,
              mipmap_count = 4
            },
            {
              filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore-2.png",
              blend_mode = "additive",
              draw_as_light = true,
              tint = { r = 0.6, g = 0.6, b = 0.6, a = 0.6},
              size = 64,
              scale = 0.25,
              mipmap_count = 4
            },
          }
        },
        {
          layers =
          {
            {
              filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore-3.png",
              size = 64,
              scale = 0.25,
              mipmap_count = 4
            },
            {
              filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-ore-3.png",
              blend_mode = "additive",
              draw_as_light = true,
              tint = { r = 0.6, g = 0.6, b = 0.6, a = 0.6},
              size = 64,
              scale = 0.25,
              mipmap_count = 4
            },
          }
        }
      },
      subgroup = "raw-resource",
      order = "g[uranium-ore]",
      stack_size = 50
    },
    {
      type = "item",
      name = "Ice-Core",
      icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-235.png",
      pictures =
      {
        layers =
        {
          {
            size = 64,
            filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-235.png",
            scale = 0.25,
            mipmap_count = 4
          },
          {
            draw_as_light = true,
            blend_mode = "additive",
            size = 64,
            filename = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-235.png",
            scale = 0.25,
            tint = {r = 0.6, g = 0.6, b = 0.6, a = 0.6},
            mipmap_count = 4
          }
        }
      },
      icon_size = 64, icon_mipmaps = 4,
      subgroup = "intermediate-product",
      order = "r[uranium-235]",
      stack_size = 100
    },
    {
      type = "item",
      name = "perennial-ice",
      icon = "__my Example-mod1__/graphics/entity/Hailite-tech/Hailite-ore/uranium-238.png",
      icon_size = 64, icon_mipmaps = 4,
      subgroup = "intermediate-product",
      order = "r[uranium-238]",
      stack_size = 100
    },
    {
      type = "item",
      name = "centrifuge",
      icon = "__base__/graphics/icons/centrifuge.png",
      icon_size = 64, icon_mipmaps = 4,
      subgroup = "production-machine",
      order = "g[centrifuge]",
      place_result = "centrifuge",
      stack_size = 50
    },


    -- 빙정핵 -----------------------------------------------------------------------
    
    -- 얼심분리기 -----------------------------------------------------------------------
  {
    type = "recipe-category",
    name = "Hailite-crafting"
  },
    {
      type = "item",
      name = "Hailite-centrifuge",
      icon = "__base__/graphics/icons/centrifuge.png",
      icon_size = 64, icon_mipmaps = 4,
      subgroup = "production-machine",
      order = "g[centrifuge]",
      place_result = "Hailite-centrifuge",
      stack_size = 50
    },
    {
      type = "recipe",
      name = "Hailite-centrifuge",
      energy_required = 4,
      enabled = true,
      ingredients =
      {
        {"concrete", 100},
        {"steel-plate", 50},
        {"advanced-circuit", 100},
        {"iron-gear-wheel", 100}
      },
      result = "Hailite-centrifuge",
      requester_paste_multiplier= 10
    },
    {
      type = "assembling-machine",
      name = "Hailite-centrifuge",
      icon = "__base__/graphics/icons/centrifuge.png",
      icon_size = 64, icon_mipmaps = 4,
      flags = {"placeable-neutral", "placeable-player", "player-creation"},
      minable = {mining_time = 0.1, result = "Hailite-centrifuge"},
      max_health = 350,
      corpse = "centrifuge-remnants",
      dying_explosion = "centrifuge-explosion",
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
      drawing_box = {{-1.5, -2.2}, {1.5, 1.5}},
  
      always_draw_idle_animation = true,
      idle_animation =
      {
        layers =
        {
          -- Centrifuge A
          {
            filename = "__base__/graphics/entity/centrifuge/centrifuge-C.png",
            priority = "high",
            line_length = 8,
            width = 119,
            height = 107,
            frame_count = 64,
            shift = util.by_pixel(-0.5, -26.5),
            hr_version =
            {
              filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-C.png",
              priority = "high",
              scale = 0.5,
              line_length = 8,
              width = 237,
              height = 214,
              frame_count = 64,
              shift = util.by_pixel(-0.25, -26.5)
            }
          },
          {
            filename = "__base__/graphics/entity/centrifuge/centrifuge-C-shadow.png",
            draw_as_shadow = true,
            priority = "high",
            line_length = 8,
            width = 132,
            height = 74,
            frame_count = 64,
            shift = util.by_pixel(20, -10),
            hr_version =
            {
              filename = "__base__/graphics/entity/centrifuge/hr-centrifuge-C-shadow.png",
              draw_as_shadow = true,
              priority = "high",
              scale = 0.5,
              line_length = 8,
              width = 279,
              height = 152,
              frame_count = 64,
              shift = util.by_pixel(16.75, -10)
            }
          },
          -- Centrifuge B
          {
            filename = "__base__/graphics/entity/centrifuge/centrifuge-B.png",
            priority = "high",
            line_length = 8,
            width = 78,
            height = 117,
            frame_count = 64,
            shift = util.by_pixel(23, 6.5),
            hr_version =
            {
              filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-B.png",
              priority = "high",
              scale = 0.5,
              line_length = 8,
              width = 156,
              height = 234,
              frame_count = 64,
              shift = util.by_pixel(23, 6.5)
            }
          },
          {
            filename = "__base__/graphics/entity/centrifuge/centrifuge-B-shadow.png",
            draw_as_shadow = true,
            priority = "high",
            line_length = 8,
            width = 124,
            height = 74,
            frame_count = 64,
            shift = util.by_pixel(63, 16),
            hr_version =
            {
              filename = "__base__/graphics/entity/centrifuge/hr-centrifuge-B-shadow.png",
              draw_as_shadow = true,
              priority = "high",
              scale = 0.5,
              line_length = 8,
              width = 251,
              height = 149,
              frame_count = 64,
              shift = util.by_pixel(63.25, 15.25)
            }
          },
          -- Centrifuge A
          {
            filename = "__base__/graphics/entity/centrifuge/centrifuge-A.png",
            priority = "high",
            line_length = 8,
            width = 70,
            height = 123,
            frame_count = 64,
            shift = util.by_pixel(-26, 3.5),
            hr_version =
            {
              filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-A.png",
              priority = "high",
              scale = 0.5,
              line_length = 8,
              width = 139,
              height = 246,
              frame_count = 64,
              shift = util.by_pixel(-26.25, 3.5)
            }
          },
          {
            filename = "__base__/graphics/entity/centrifuge/centrifuge-A-shadow.png",
            priority = "high",
            draw_as_shadow = true,
            line_length = 8,
            width = 108,
            height = 54,
            frame_count = 64,
            shift = util.by_pixel(6, 27),
            hr_version =
            {
              filename = "__base__/graphics/entity/centrifuge/hr-centrifuge-A-shadow.png",
              priority = "high",
              draw_as_shadow = true,
              scale = 0.5,
              line_length = 8,
              width = 230,
              height = 124,
              frame_count = 64,
              shift = util.by_pixel(8.5, 23.5)
            }
          }
        }
      },
  
      working_visualisations =
      {
        {
          effect = "uranium-glow",
          fadeout = true,
          light = {intensity = 0.2, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.2, g = 0.2, b = 1.0}}
        },
        {
          effect = "uranium-glow",
          fadeout = true,
          draw_as_light = true,
          animation =
          {
            layers =
            {
              -- Centrifuge C
              {
                filename = "__base__/graphics/entity/centrifuge/centrifuge-C-light.png",
                priority = "high",
                blend_mode = "additive", -- centrifuge
                line_length = 8,
                width = 96,
                height = 104,
                frame_count = 64,
                shift = util.by_pixel(0, -27),
  
                hr_version =
                {
                  filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-C-light2.png",
                  priority = "high",
                  scale = 0.5,
                  blend_mode = "additive", -- centrifuge
                  line_length = 8,
                  width = 190,
                  height = 207,
                  frame_count = 64,
                  shift = util.by_pixel(0, -27.25)
                }
              },
              -- Centrifuge B
              {
                filename = "__base__/graphics/entity/centrifuge/centrifuge-B-light.png",
                priority = "high",
                blend_mode = "additive", -- centrifuge
                line_length = 8,
                width = 65,
                height = 103,
                frame_count = 64,
                shift = util.by_pixel(16.5, 0.5),
                hr_version =
                {
                  filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-B-light2.png",
                  priority = "high",
                  scale = 0.5,
                  blend_mode = "additive", -- centrifuge
                  line_length = 8,
                  width = 131,
                  height = 206,
                  frame_count = 64,
                  shift = util.by_pixel(16.75, 0.5)
                }
              },
              -- Centrifuge A
              {
                filename = "__base__/graphics/entity/centrifuge/centrifuge-A-light.png",
                priority = "high",
                blend_mode = "additive", -- centrifuge
                line_length = 8,
                width = 55,
                height = 98,
                frame_count = 64,
                shift = util.by_pixel(-23.5, -2),
                hr_version =
                {
                  filename = "__my Example-mod1__/graphics/entity/Hailite-tech/centrifuge/hr-centrifuge-A-light2.png",
                  priority = "high",
                  scale = 0.5,
                  blend_mode = "additive", -- centrifuge
                  line_length = 8,
                  width = 108,
                  height = 197,
                  frame_count = 64,
                  shift = util.by_pixel(-23.5, -1.75)
                }
              }
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
            filename = "__base__/sound/centrifuge-1.ogg",
            volume = 0.3
          },
          {
            filename = "__base__/sound/centrifuge-2.ogg",
            volume = 0.3
          },
          {
            filename = "__base__/sound/centrifuge-6.ogg",
            volume = 0.3
          }
        },
        fade_in_ticks = 4,
        fade_out_ticks = 20,
        --max_sounds_per_type = 3,
        --idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.3 }
      },
      crafting_speed = 1,
      crafting_categories = {"Hailite-crafting"},
      energy_source =
      {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = 4
      },
      energy_usage = "350kW",
      module_specification =
      {
        module_slots = 2
      },
      allowed_effects = {"consumption", "speed", "productivity", "pollution"},
      water_reflection =
      {
        pictures =
        {
          filename = "__base__/graphics/entity/centrifuge/centrifuge-reflection.png",
          priority = "extra-high",
          width = 28,
          height = 32,
          shift = util.by_pixel(0, 65),
          variation_count = 1,
          scale = 5
        },
        rotate = false,
        orientation_to_variation = false
      }
    },



-- 얼심분리기 -----------------------------------------------------------------------
  }
)