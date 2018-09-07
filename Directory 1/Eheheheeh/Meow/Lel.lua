function test.test(callback, signalType, times, interval)
	checkArg(1, callback, "function")
	checkArg(2, signalType, "string", "nil")
	checkArg(3, times, "number", "nil")
	checkArg(4, interval, "number", "nil")

	local ID = math.random(1, 0x7FFFFFFF)
	while handlers[ID] do
		ID = math.random(1, 0x7FFFFFFF)
	end

	handlers[ID] = {
		signalType = signalType,
		callback = callback,
		times = times or math.huge,
		interval = interval,
		nextTriggerTime = interval and (computer.uptime() + interval) or nil
	}

	return ID
end