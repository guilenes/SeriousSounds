return {

    run = function()
		fassert(rawget(_G, "new_mod"), "`SSv2` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("SSv2", {
			mod_script       = "scripts/mods/SSv2/SSv2",
			mod_data         = "scripts/mods/SSv2/SSv2_data",
			mod_localization = "scripts/mods/SSv2/SSv2_localization",
		})
	end,
	
    packages = {
        "resource_packages/SSv2/SSv2"
	},
	
}