local lib = require("primordial/Extended API.493")



--infobox
local welc = menu.add_text("Info", "Welcome in the DeathSense.lua Alpha")
local creat = menu.add_text("Info", "Created by hkg")
local ver = menu.add_text("Info", "Version 1.0 Alpha")
local lUpd = menu.add_text("Info", "2025.02.10")
local uid = menu.add_text("Info", "your UID: ")



--aa menu
local aaEnable = menu.add_checkbox('Anti Aim', 'Enable', false)
local aaMode = menu.add_selection("Anti Aim", "Anti-Aim Mode", {"hkg", "curse", "custome"})
local pitchMode = menu.add_selection("Anti Aim", "Pitch", {"Zero", "Down", "Up", "Half down", "Half Up"})
local yawSlider = menu.add_slider("Anti Aim", "Yaw", 0, 60)
local desyncSlider = menu.add_slider("Anti Aim", "Desync", 0, 80)
local legFuk = menu.add_selection("Anti Aim", "Legfucker", {"Off", "Slide", "Static", "Jitter"})




--ragebot menu
local rageEnable = menu.add_checkbox('Ragebot', 'Enable', false)
local resolverEn = menu.add_checkbox("Ragebot", "Resolver", false)
local ForcePred = menu.add_checkbox('Ragebot', 'Force Prediction   ', false)
local ForcePredKey = ForcePred:add_keybind("Force prediction key")



--misc
local cTag = menu.add_checkbox("Misc", "Clantag", false)
local enabled = menu.add_checkbox("Misc", "Console color")
local recolor_console = enabled:add_color_picker("console colour")




-- primo cuccok
local pitchAng = menu.find("antiaim", "main", "angles", "pitch")




callbacks.add(e_callbacks.PAINT, function()
    --anti aim
    aaMode:set_visible(aaEnable:get())
    pitchMode:set_visible(aaMode:get() == 3)
    yawSlider:set_visible(aaMode:get() == 3)
    desyncSlider:set_visible(aaMode:get() == 3)
    legFuk:set_visible(aaMode:get() == 3)

    --ragebot
    resolverEn:set_visible(rageEnable:get())
    ForcePred:set_visible(rageEnable:get())


    --misc


end)

----------------------------------------------------------------------------------- anti aim


callbacks.add(e_callbacks.ANTIAIM, function(ctx)
    local local_player = entity_list.get_local_player()
    local bRunOnceAir  = nil
    local bRunOnceGrnd = nil

    if aaEnable:get() then
        if aaMode:get() == 1 then
            ctx:set_pitch(89)
            ctx:set_desync(1.0)
        else if aaMode:get() == 2 then
            ctx:set_pitch(89)
        else if aaMode:get() == 3 then

            --pitch
            if pitchMode:get() == 1 then
                ctx:set_pitch(0)
            elseif pitchMode:get() == 2 then 
                ctx:set_pitch(89)
            elseif pitchMode:get() == 3 then
                ctx:set_pitch(-89)
            elseif pitchMode:get() == 4 then
                ctx:set_pitch(45)
            elseif pitchMode:get() == 5 then
                ctx:set_pitch(-45)
            end
        end
    end
end)


------------------------------------------------------------------------------------------------------------------  misc

--console szin
ffi.cdef[[
    typedef bool(__thiscall* console_is_visible)(void*);
]]
local engine_client = ffi.cast(ffi.typeof("void***"), memory.create_interface("engine.dll", "VEngineClient014"))
local console_is_visible = ffi.cast("console_is_visible", engine_client[0][11])


local console_materials = { "vgui_white", "vgui/hud/800corner1", "vgui/hud/800corner2", "vgui/hud/800corner3", "vgui/hud/800corner4" }
local found_materials = {}

materials.for_each(function(mat)
    for material = 1, #console_materials do
        if ( string.match( mat:get_name( ), console_materials[material] )) then
            found_materials[material] = mat
        end
    end
end)

local function on_paint()
    if not engine.is_app_active() then 
        return 
    end

    local console_color = recolor_console:get()
    for material = 1, #found_materials do
        mat = found_materials[material]

        if enabled:get() and console_is_visible(engine_client) then
            mat:color_modulate(console_color.r/255, console_color.g/255, console_color.b/255)
            mat:alpha_modulate(console_color.a/255)
        else
            mat:color_modulate(1, 1, 1)
            mat:alpha_modulate(1)
        end
    end
end

callbacks.add(e_callbacks.PAINT, on_paint)


















---------------------------------------------------------------------- ragebot

-- resolver
--local function resolver(ctx)
    --local local_player = entity_list.get_local_player()


--end


--callbacks.add(e_callbacks.AIMBOT_SHOOT, resolver)