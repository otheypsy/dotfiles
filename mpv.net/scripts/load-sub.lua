-- local options = require "mp.options"
local msg = require "mp.msg"
local utils = require "mp.utils"

function On_File_Loaded(event)

    local path = mp.get_property("path")
	directory, filename = utils.split_path(path)
	local dir_files = utils.readdir(directory, "files")
	
	for _, name in ipairs(dir_files) do
		if string.find(name, "%.srt$") then
			
			local search_string = name
				:gsub("%.srt$", "")
				:gsub("%.en$", "")
				:gsub("%-en$", "")
				:gsub("%-", "%%-")
			
			if string.find(filename, search_string) and string.find(name, "%.srt") then
				local sub_file = utils.join_path(directory, name)
				mp.commandv("sub-add", sub_file)
				msg.info("Found subtitle file " .. sub_file)
			end
			
		end
	end

end


mp.register_event('start-file', On_File_Loaded)
