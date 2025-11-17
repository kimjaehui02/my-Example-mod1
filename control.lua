-- Crystal Factory Extended - Control Script

script.on_init(function()
    log("Crystal Factory Extended initialized")
end)

script.on_configuration_changed(function(data)
    if data.mod_changes and data.mod_changes["my Example-mod1"] then
        log("Crystal Factory Extended configuration changed")
    end
end)
