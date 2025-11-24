-- Crystal Factory Extended
-- Clean production with zero byproducts

-- Load crystal system
require("crystal")

-- Load crystal resonator and modules
require("crystal-resonator")

-- Load crystal centrifuge (50% base productivity!)
require("crystal-centrifuge")

-- Load crystal fluid system
require("crystal-fluid")

-- Load crystal chemical plant
require("crystal-chemical-plant")

-- Load crystal heat pipe
require("crystal-heat-pipe")

-- Load crystal ocean tile (Arcana exclusive - Aquilo style)
require("crystal-ocean-tile")

-- Load crystal resource generator (Arcana exclusive)
require("crystal-resource-generator")

-- Load crystal farming system (Gleba style)
require("crystal-farming")

-- Load short train system
require("crystal-train")

-- Load long range elevated rail system (wider pylon spacing)
if mods["elevated-rails"] then
    require("crystal-elevated-rail")
end

-- Load Arcana planet (if Space Age is present)
if mods["space-age"] then
    require("planet-arcana")
end
