local mod = get_mod("SSv2")

-- One volume slider per sound, in the order they appear in the options menu
local volume_settings = {
	"fusrodah_volume",
	"sneaky_volume",
	"strike_volume",
	"metalpipe_volume",
	"zhonya_volume",
	"leeroyjenkins_volume",
	"cost400000_volume",
	"gokutp_volume",
	"tnt_volume",
	"skeletonarmy_volume",
	"reverbfart_volume",
	"fortnitedown_volume",
}

local widgets = {
	{
		setting_id = "enable_sounds",
		type = "checkbox",
		default_value = true,
		title = "enable_sounds_title",
		tooltip = "enable_sounds_tooltip",
	},
	{
		setting_id = "debug_messages",
		type = "checkbox",
		default_value = true,
		title = "debug_messages_title",
		tooltip = "debug_messages_tooltip",
	},
	{
		setting_id = "master_volume",
		type = "numeric",
		default_value = 100,
		title = "master_volume_title",
		tooltip = "master_volume_tooltip",
		range = {0, 100},
	},
}

for _, setting_id in ipairs(volume_settings) do
	widgets[#widgets + 1] = {
		setting_id = setting_id,
		type = "numeric",
		default_value = 100,
		title = setting_id .. "_title",
		tooltip = setting_id .. "_tooltip",
		range = {0, 100},
	}
end

return {
	name = "SSv2",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = widgets,
	},
}
