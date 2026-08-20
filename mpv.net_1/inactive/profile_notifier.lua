local options = require 'mp.options'
local msg = require 'mp.msg'

local profile_status = {
	["video"] = false,
	["image"] = false,
	["hdr"] = false,
	["sdr-2-hdr"] = false,
	["sdr"] = false,
	["hdr-2-sdr"] = false,
	["uhd-60"] = false,
	["uhd-30"] = false,
	["qhd-60"] = false,
	["qhd-30"] = false,
	["fhd-60"] = false,
	["fhd-30"] = false,
	["fhd-interlaced"] = false,
	["hd"] = false,
	["sdtv"] = false,
	["anime-hq-a"] = false,
	["anime-hq-b"] = false,
	["anime-hq-c"] = false,
	["av1-sw-decode"] = false
}

local function display_profiles()
	msg.info(" ---- Display Profile Indicators ---- ")
	local profiles = mp.get_property_native("user-data/profile_notifier/profiles")
	
	if profiles == nil then
		return
	end
	
	local aggregate_profile = ""
	for key, value in pairs(profiles) do
		if value == true then
			if aggregate_profile ~= "" then
				aggregate_profile = aggregate_profile .. " [" .. key .. "]"
			else
				aggregate_profile = "[" .. key .. "]"
			end
		end
	end
	local osd_text = "{\\an3}{\\fs8}" .. aggregate_profile
	mp.set_osd_ass(0, 0, osd_text)
end


local function on_reset()
	msg.info(" ---- Reset Profile Indicators ---- ")
	local script_opts = mp.get_property_native("script-opts")
	for key, value in pairs(script_opts) do
		if key:find("user-data/profile_notifier/profiles", 0, true) ~= nil then
			mp.commandv("change-list", "script-opts", "remove", key)
		end
	end
end

local function handle_message(command)
	if command == "reset" then
		on_reset()
	end
end

mp.add_hook("on_load", 4, on_reset)
mp.observe_property("user-data/profile_notifier/profiles", "string", display_profiles)
mp.register_script_message("profile_notifier", handle_message, command)
