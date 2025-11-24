-- Arcana: Crystal Planet
-- 크리스탈 차원 - 부산물 없는 순수한 세계

local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")

-- Load arcana map generation (circular island)
require("arcana-map-gen")

-- 행성 정의
data:extend({
    {
        type = "planet",
        name = "arcana",
        icon = "__base__/graphics/icons/uranium-235.png",
        starmap_icon = "__base__/graphics/icons/uranium-235.png",
        starmap_icon_size = 64,
        
        -- 궤도 위치
        gravity_pull = 10,
        distance = 12,  -- Nauvis와 Vulcanus 사이
        orientation = 0.15,
        magnitude = 1.3,
        
        order = "ba[arcana]",
        subgroup = "planets",
        
        -- 표면 속성
        surface_properties = {
            ["day-night-cycle"] = 5 * minute,
            ["magnetic-field"] = 99,  -- 높은 자기장
            ["solar-power"] = 300,
            pressure = 3000,
            gravity = 30
        },
        
        solar_power_in_space = 500,
        pollutant_type = nil,  -- 공해 없음
        
        -- 맵 생성 설정 (작은 원형 섬 - 세리스 스타일)
        map_gen_settings = {
            terrain_segmentation = 1,
            water = 0,  -- autoplace_settings에서 water 직접 관리
            width = 32 * 30,  -- 960 타일
            height = 32 * 30,  -- 960 타일
            starting_area_size = 0.5,  -- 아주 작은 시작 지역
            autoplace_controls = {
                ["iron-ore"] = {
                    frequency = 2,
                    size = 1.5,
                    richness = 3
                },
                ["copper-ore"] = {
                    frequency = 2,
                    size = 1.5,
                    richness = 3
                },
                ["stone"] = {
                    frequency = 1,
                    size = 1,
                    richness = 2
                },
                ["coal"] = {
                    frequency = 1.5,
                    size = 1,
                    richness = 2
                },
                ["raw-crystal-ore"] = {
                    frequency = 0.8,
                    size = 2,
                    richness = 4
                },
                ["crystal-essence"] = {
                    frequency = 0.6,
                    size = 1.5,
                    richness = 3
                }
            },
            autoplace_settings = {
                tile = {
                    treat_missing_as_default = false,
                    settings = {
                        ["grass-1"] = {
                            -- elevation (arcana_surface)이 0 이상일 때만 땅 생성
                            probability_expression = "if(arcana_surface >= 0, 1.0, 0)",
                            richness_expression = 1
                        },
                        ["water"] = {
                            -- elevation (arcana_surface)이 0 미만일 때만 물 생성
                            probability_expression = "if(arcana_surface < 0, 1.0, 0)",
                            richness_expression = 1
                        }
                    }
                },
                entity = {
                    treat_missing_as_default = false,
                    settings = {
                        ["iron-ore"] = {
                            -- water 제외, 땅 타일만 허용
                            tile_restriction = {"grass-1", "dirt-1", "dirt-2", "dirt-3", "dirt-4", "dirt-5", "dirt-6", "dirt-7", "sand-1", "sand-2", "sand-3"}
                        },
                        ["copper-ore"] = {
                            tile_restriction = {"grass-1", "dirt-1", "dirt-2", "dirt-3", "dirt-4", "dirt-5", "dirt-6", "dirt-7", "sand-1", "sand-2", "sand-3"}
                        },
                        ["stone"] = {
                            tile_restriction = {"grass-1", "dirt-1", "dirt-2", "dirt-3", "dirt-4", "dirt-5", "dirt-6", "dirt-7", "sand-1", "sand-2", "sand-3"}
                        },
                        ["coal"] = {
                            tile_restriction = {"grass-1", "dirt-1", "dirt-2", "dirt-3", "dirt-4", "dirt-5", "dirt-6", "dirt-7", "sand-1", "sand-2", "sand-3"}
                        },
                        ["raw-crystal-ore"] = {
                            tile_restriction = {"grass-1", "dirt-1", "dirt-2", "dirt-3", "dirt-4", "dirt-5", "dirt-6", "dirt-7", "sand-1", "sand-2", "sand-3"}
                        },
                        ["crystal-essence"] = {
                            -- water 타일 위에만 생성
                            tile_restriction = {"water"}
                        }
                    }
                }
            },
            default_enable_all_autoplace_controls = false,
            property_expression_names = {
                elevation = "arcana_surface",  -- 원형 지형! 반경 밖은 낮음 (물)
                temperature = "temperature_basic",
                moisture = "moisture_basic",
                aux = "aux_basic",
                cliffiness = "cliffiness_basic",
            },
            starting_area = "normal",  -- 시작 지역 있음 (자원 보장)
            water = 0,  -- 물 없음 (크리스탈 공허 사용)
            cliff_settings = {
                name = "cliff",
                cliff_elevation_0 = 10,
                cliff_elevation_interval = 40,
                richness = 0.5
            },
            peaceful_mode = true  -- 적 없음
        },
        
        -- 소행성 (행성에서는 생략 가능)
        asteroid_spawn_influence = 1,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        
        -- 환경음 (바닐라 재사용)
        persistent_ambient_sounds = {
            base_ambience = {
                filename = "__base__/sound/ambient/world-ambience-4.ogg",
                volume = 0.5
            }
        },
        
        -- 시각 효과
        surface_render_parameters = {
            fog = {
                shape_noise_texture = {
                    filename = "__core__/graphics/clouds-noise.png",
                    size = 2048
                },
                detail_noise_texture = {
                    filename = "__core__/graphics/clouds-detail-noise.png",
                    size = 2048
                },
                color = {0.2, 0.8, 0.9}
            },
            day_night_cycle_color_lookup = {
                {0.0, "__core__/graphics/color_luts/lut-day.png"},
                {0.45, "__core__/graphics/color_luts/nightvision.png"},
                {0.55, "__core__/graphics/color_luts/nightvision.png"},
                {0.80, "__core__/graphics/color_luts/lut-day.png"}
            }
        }
    }
})

-- 행성 연결 (Space Connection)
-- space-connection에서는 파라미터 1개만!
data:extend({
    {
        type = "space-connection",
        name = "nauvis-arcana",
        subgroup = "planet-connections",
        from = "nauvis",
        to = "arcana",
        order = "aa[arcana]",
        length = 12000,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus)
    }
})

-- 행성 발견 기술
data:extend({
    {
        type = "technology",
        name = "planet-discovery-arcana",
        icons = {
            {
                icon = "__base__/graphics/icons/uranium-235.png",
                icon_size = 64,
                scale = 4
            }
        },
        icon_size = 256,
        essential = true,
        effects = {
            {
                type = "unlock-space-location",
                space_location = "arcana",
                use_icon_overlay_constant = true
            }
        },
        prerequisites = {"space-platform-thruster"},
        unit = {
            count = 800,  -- Vulcanus(1000)보다 쉽게
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"space-science-pack", 1}
            },
            time = 60
        }
    }
})

log("Arcana crystal planet with connection and technology loaded")

