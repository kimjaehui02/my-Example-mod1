-- Crystal Factory Extended
-- Clean production with zero byproducts

-- Load crystal system
require("crystal")

-- Load crystal resonator and modules
require("crystal-resonator")

-- Load Arcana planet (if Space Age is present)
if mods["space-age"] then
    require("planet-arcana")
end
