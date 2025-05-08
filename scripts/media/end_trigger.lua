msg = require("mp.msg")
utils = require("mp.utils")
opt = require("mp.options")

path = nil
name = nil

mp.observe_property("name", string, function(name)
	name = mp.get_property("name")
	-- msg.warn(name)
end)

mp.observe_property("path", string, function(name)
	path = mp.get_property("path")
	msg.warn(path)
end)

function recordEOF(event)
	if event.reason == "eof" then
		msg.warn("writing to registry")
		msg.warn("'" .. path .. "'")
		os.execute("python mark.py '" .. path .. "'")
	end
end

mp.register_event("end-file", recordEOF)
-- mp.register_event("shutdown", shutdown)
