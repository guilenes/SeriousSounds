local mod = get_mod("SSv2")

-- Load Wwise bank
Wwise.load_bank("wwise/SeriousSounds_soundbank")

-- RTPC tracking
mod.rtpc_dirty = true

-- Debug output, toggled by the "debug_messages" setting
local function debug(message)
	if mod:get("debug_messages") then
		mod:chat_broadcast(message)
	end
end

-- Function to set RTPC using the wwise_world from the hook
local function update_rtpcs(wwise_world)
	if not wwise_world then return end
	
	-- TEMPORARILY DISABLED: Test if sounds play without RTPC setting
	-- Set master volume

	local master_vol = mod:get("master_volume") or 100
	debug("RTPC volume = " .. tostring(master_vol))

	-- Set individual volumes
	local gokutp_vol = mod:get("gokutp_volume") or 100
	debug("RTPC volume = " .. tostring(gokutp_vol))
	WwiseWorld.set_global_parameter(wwise_world, "gokutp_volume", gokutp_vol*master_vol/100)
	
	local metalpipe_vol = mod:get("metalpipe_volume") or 100
	debug("RTPC volume = " .. tostring(metalpipe_vol))
	WwiseWorld.set_global_parameter(wwise_world, "metalpipe_volume", metalpipe_vol*master_vol/100)
	
	local reverbfart_vol = mod:get("reverbfart_volume") or 100
	debug("RTPC volume = " .. tostring(reverbfart_vol))
	WwiseWorld.set_global_parameter(wwise_world, "reverbfart_volume", reverbfart_vol*master_vol/100)
	
	local fortnitedown_vol = mod:get("fortnitedown_volume") or 100
	debug("RTPC volume = " .. tostring(fortnitedown_vol))
	WwiseWorld.set_global_parameter(wwise_world, "fortnitedown_volume", fortnitedown_vol*master_vol/100)
end

-- Update RTPCs when settings change
mod.on_setting_changed = function() 
	-- We'll update RTPCs on the next event trigger
	mod.rtpc_dirty = true
end

mod:hook(WwiseWorld, "trigger_event", function (func, self, event_name, ...)
	-- Update RTPCs before triggering event
	if mod.rtpc_dirty then
		update_rtpcs(self)
		debug("Setting changed")
		mod.rtpc_dirty = false
	end

	-- Check if sounds are enabled
	local enable_sounds = mod:get("enable_sounds")
	if not enable_sounds then
		return func(self, event_name, ...)
	end
	
	local event_changed = false
	
    if event_name == "Play_sienna_adept_blink_ability" then
        event_name = "gokutp_event"
        debug("-> Replaced with: " .. event_name)
        event_changed = true
    elseif event_name == "Play_career_bretonnian_knight_ability_swing_hit" then
        event_name = "metalpipe_event"
        debug("-> Replaced with: " .. event_name)
        event_changed = true
    elseif event_name == "player_combat_weapon_grenade_explosion" then
        event_name = "reverbfart_event"
        debug("-> Replaced with: " .. event_name)
        event_changed = true
    elseif event_name == "chr_vce_death" then
        event_name = "fortnitedown_event"
        debug("-> Replaced with: " .. event_name)
        event_changed = true
    end
    
    local result = func(self, event_name, ...)
	
	-- Debug: check if the event was actually triggered (only for replaced events)
	if event_changed then
		if result then
			debug("Event triggered successfully")
		else
			debug("Event trigger returned nil/false")
		end
	end
	
	return result
end)
