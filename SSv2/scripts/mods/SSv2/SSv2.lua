local mod = get_mod("SSv2")

-- Load Wwise bank
Wwise.load_bank("wwise/SeriousSounds_soundbank")

-- Sound replacements: [game event] = { event = our Wwise event, volume = setting id and RTPC name }
-- Keys starting with "PLACEHOLDER_" still need the real in-game event name.
local sounds = {
	-- Kruber
	["PLACEHOLDER_mercenary_ability"] = { event = "fusrodah_event", volume = "fusrodah_volume" },
	["PLACEHOLDER_huntsman_ability"] = { event = "sneaky_event", volume = "sneaky_volume" },
	["PLACEHOLDER_foot_knight_ability"] = { event = "strike_event", volume = "strike_volume" },
	["Play_career_bretonnian_knight_ability_swing_hit"] = { event = "metalpipe_event", volume = "metalpipe_volume" },
	-- Bardin
	["PLACEHOLDER_ironbreaker_ability"] = { event = "zhonya_event", volume = "zhonya_volume" },
	["PLACEHOLDER_slayer_ability"] = { event = "leeroyjenkins_event", volume = "leeroyjenkins_volume" },
	["PLACEHOLDER_engineer_ability"] = { event = "cost400000_event", volume = "cost400000_volume" },
	-- Sienna
	["Play_sienna_adept_blink_ability"] = { event = "gokutp_event", volume = "gokutp_volume" },
	["PLACEHOLDER_unchained_ability"] = { event = "tnt_event", volume = "tnt_volume" },
	["PLACEHOLDER_necromancer_ability"] = { event = "skeletonarmy_event", volume = "skeletonarmy_volume" },
	-- Not ultimates
	["player_combat_weapon_grenade_explosion"] = { event = "reverbfart_event", volume = "reverbfart_volume" },
	["chr_vce_death"] = { event = "fortnitedown_event", volume = "fortnitedown_volume" },
}

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

	local master_vol = mod:get("master_volume") or 100
	debug("RTPC master_volume = " .. tostring(master_vol))

	-- Set individual volumes
	for _, sound in pairs(sounds) do
		local vol = mod:get(sound.volume) or 100
		debug("RTPC " .. sound.volume .. " = " .. tostring(vol))
		WwiseWorld.set_global_parameter(wwise_world, sound.volume, vol*master_vol/100)
	end
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

	local sound = sounds[event_name]
	if not sound then
		return func(self, event_name, ...)
	end

	debug("-> Replaced with: " .. sound.event)
	local result = func(self, sound.event, ...)

	-- Debug: check if the event was actually triggered
	if result then
		debug("Event triggered successfully")
	else
		debug("Event trigger returned nil/false")
	end

	return result
end)
