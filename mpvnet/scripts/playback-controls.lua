local options = require 'mp.options'
local msg = require 'mp.msg'
local utils = require("mp.utils")
local ass_start = mp.get_property_osd("osd-ass-cc/0")
local ass_stop = mp.get_property_osd("osd-ass-cc/1")

local function bind_jump_keys()
	for key = 0, 9 do
		local base = key * 10
		local click_data = {
			click = "seek  " .. base + 0 .. " absolute-percent+exact ; show-text '${osd-ass-cc/0}{\\an5}{\\fs20}" .. base + 0 .. "%'",
			double_click = "seek  " .. base + 2 .. " absolute-percent+exact ; show-text '${osd-ass-cc/0}{\\an5}{\\fs20}" .. base + 2 .. "%'",
			triple_click = "seek  " .. base + 4 .. " absolute-percent+exact ; show-text '${osd-ass-cc/0}{\\an5}{\\fs20}" .. base + 4 .. "%'",
			quatra_click = "seek  " .. base + 6 .. " absolute-percent+exact ; show-text '${osd-ass-cc/0}{\\an5}{\\fs20}" .. base + 6 .. "%'",
			penta_click = "seek  " .. base + 8 .. " absolute-percent+exact ; show-text '${osd-ass-cc/0}{\\an5}{\\fs20}" .. base + 8 .. "%'",
		}
		local json, err = utils.format_json(click_data)
		mp.commandv('script-message-to', 'inputevent', 'bind', key, json)
	end
end

local function on_seek(delta_string, delay_string)
	local delta = tonumber(delta_string)
	local delay = tonumber(delay_string) or 2
	
	if delta == nil or delta == 0 then return end
	
    local osd_text = ass_start
	
	if delta > 0 then
		osd_text = osd_text .. "{\\an6}{\\fs20}" .. math.abs(delta) .. "s{\\fs10}{\\fnmodernz-icons} material_fast_forward_filled {\\fnosd-font}"
    else
		osd_text = osd_text .. "{\\an4}{\\fs10}{\\fnmodernz-icons} material_fast_rewind_filled {\\fnosd-font}{\\fs20}" .. math.abs(delta) .. "s"
	end
	
	osd_text = osd_text .. ass_stop
	
	mp.commandv("seek", delta, "exact")
	mp.osd_message(osd_text, delay)
end

local function handle_message(command, value_1, value_2)
	if command == "seek" then
		on_seek(value_1, value_2)
	end
end

local function custom_seek(value)
	msg.info("Custom Seek", value)
end

mp.register_script_message("playback-controls", handle_message, command, value_1, value_2)
mp.add_key_binding(nil, "custom_seek", custom_seek)
bind_jump_keys()
