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

-- Load Arcana planet (if Space Age is present)
if mods["space-age"] then
    require("planet-arcana")
end
