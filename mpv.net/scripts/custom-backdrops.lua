local assdraw = require "mp.assdraw"
local options = require "mp.options"
local msg = require "mp.msg"

local settings = {
	backdrop_opacity = 0.0,
	z_index = -1.0
}

local backdrop_overlay = mp.create_osd_overlay("ass-events")
local console_open = false
local stats_open = false


local function update_options(list)
	msg.info("Updating Options")
	if list == nil or #list < 1 then
		return
	end
	
	for key, value in ipairs(list) do
		settings[key] = value
	end
end

local function draw_backdrop()
	local ass = assdraw.ass_new()
	local w, h, _ = mp.get_osd_size()
	local alpha = 255 - math.ceil(255 * settings.backdrop_opacity)

	ass.text = string.format("{\\pos(0,0)\\rDefault\\an7\\1c&H000000&\\alpha&H%X&}", alpha)
	ass:draw_start()
	ass:rect_cw(0, 0, w, h)
	ass:draw_stop()
	ass:new_event()
	backdrop_overlay.data = ass.text
	backdrop_overlay.z = settings.z_index
	backdrop_overlay:update()
end

local function clear_backdrop()
	backdrop_overlay.data = ""
	backdrop_overlay:remove()
end

local function handle_backdrop()
	if console_open or stats_open then
		draw_backdrop()
	else
		clear_backdrop()
	end
end

local function on_console_change(_, value)
	console_open = value
	if console_open and stats_open then
		mp.command("script-binding stats/display-stats-toggle")
	end
	handle_backdrop()
end

local function on_stats_change(_, value)
	stats_open = value
	handle_backdrop()
end

options.read_options(settings, "custom-backdrops", update_options)
mp.observe_property("user-data/mpv/console/open", "bool", on_console_change)
mp.observe_property("user-data/mpv/stats/open", "bool", on_stats_change)
mp.observe_property("osd-dimensions", "native", handle_backdrop)