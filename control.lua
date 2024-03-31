--컨트롤 루아
--control.lua

script.on_init(function()
    if not remote.interfaces["freeplay"] then return end
    local created_items = remote.call("freeplay", "get_created_items")
    created_items["heat-reactor"] = 1
    remote.call("freeplay", "set_created_items", created_items)
    end)