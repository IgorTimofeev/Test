function _G.downloadFile(url, path)
	local requestHandle, reason = internet.request(url, nil, {["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.119 Safari/537.36"})

	if requestHandle then
		filesystem.makeDirectory(filesystem.path(path) or "")

		local fileHandle, reason, chunk = io.open(path, "w")
		if fileHandle then
			repeat
				chunk, reason = requestHandle.read(math.huge)
				if chunk then
					fileHandle:write(chunk)
				else
					if reason then
						requestHandle:close()
						error("Failed to read chunk from URL: " .. tostring(reason))
					end
				end
			until not chunk

			requestHandle:close()
			fileHandle:close()
		else
			requestHandle:close()
			error("Failed to open file for writing: " .. tostring(reason))
		end
	else
		error("Failed to perform request to URL: " .. tostring(reason))
	end
end

_G.downloadFile("https://raw.githubusercontent.com/IgorTimofeev/MineOS/master/Applications/clear.lua", "/bin/clear.lua")