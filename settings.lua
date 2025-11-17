-- Crystal Factory Extended Settings

data:extend({
    {
        type = "int-setting",
        name = "crystal-processing-time",
        setting_type = "startup",
        default_value = 10,
        minimum_value = 1,
        maximum_value = 60,
        order = "a"
    },
    {
        type = "bool-setting",
        name = "crystal-easy-mode",
        setting_type = "startup",
        default_value = false,
        order = "b"
    },
    {
        type = "double-setting",
        name = "crystal-power-multiplier",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.1,
        maximum_value = 10.0,
        order = "c"
    }
})

