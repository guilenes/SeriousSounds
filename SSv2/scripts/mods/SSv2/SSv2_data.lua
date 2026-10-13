local mod = get_mod("SSv2")

return {
	name = "SSv2",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
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
			{
				setting_id = "gokutp_volume",
				type = "numeric",
				default_value = 100,
				title = "gokutp_volume_title",
				tooltip = "gokutp_volume_tooltip",
				range = {0, 100},
			},
			{
				setting_id = "metalpipe_volume",
				type = "numeric",
				default_value = 100,
				title = "metalpipe_volume_title",
				tooltip = "metalpipe_volume_tooltip",
				range = {0, 100},
			},
			{
				setting_id = "reverbfart_volume",
				type = "numeric",
				default_value = 100,
				title = "reverbfart_volume_title",
				tooltip = "reverbfart_volume_tooltip",
				range = {0, 100},
			},
			{
				setting_id = "fortnitedown_volume",
				type = "numeric",
				default_value = 100,
				title = "fortnitedown_volume_title",
				tooltip = "fortnitedown_volume_tooltip",
				range = {0, 100},
			},
		},
	},
}
