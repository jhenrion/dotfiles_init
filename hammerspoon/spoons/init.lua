------- SPOONS -------


-- HAMMERSPOON FILE UPDATE->AUTO RELOAD
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/hammerspoon/", hs.reload):start()
--path = hs.fs.pathToAbsolute(os.getenv("HOME") .. "/.hammerspoon/init.lua")

hs.alert.show("Hammerspoon config reloaded...")

-- WIFI

wifiWatcher = nil
workSSID = "GROUPEADEO"
homeSSID = "Sabaidee"
lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

	-- Wifi network disconnected
	if newSSID == nil then
		hs.alert.show("WiFi disconnected...")
	else
		--hs.alert.show("lastSSID: " .. lastSSID)
		--hs.alert.show("newSSID: " .. newSSID)

		-- Joining work wifi network
		if newSSID == workSSID and lastSSID ~= workSSID then
			-- TODO: Pause/quit music (itunes, spotify)
			-- TODO: Pause/quit video (vlc)
		elseif newSSID == workSSID and lastSSID == workSSID then
			-- Test connection to work network, if ko launch pingone login page
			hs.network.ping.ping("intralm2.fr.corp.leroymerlin.com",5,1,2,"any",pingWorkCallback)
		end


    	if newSSID == homeSSID and lastSSID ~= homeSSID then
    	    -- We just joined our WiFi network
    	    hs.alert.show("We just joined our WiFi network" .. newSSID)

    	    -- hs.audiodevice.defaultOutputDevice():setVolume(25)

    	elseif newSSID ~= homeSSID and lastSSID == homeSSID then
    	    -- We just departed our home WiFi network
			hs.alert.show("We just departed our home WiFi network" .. newSSID)

    	    -- hs.audiodevice.defaultOutputDevice():setVolume(0)
    	end

    	lastSSID = newSSID
      hs.alert.show("newSSID: " .. newSSID)
	end

end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

------- UTILS FUNCTIONS -------

function pingWorkCallback(object, message)

	if message == "receivedPacket" then
		newStatus = "success"
	elseif message == "didFail" or message == "sendPacketFailed" then
		hs.urlevent.openURL("https://desktop.pingone.com/adeo")
	end

	if newStatus == "success" then
		hs.alert.show("Connected to Work network")
	end

	--if not (newStatus == previousStatus)
	--then
	--  hs.alert.show(string.format("Network status changed to %s", newStatus))
	--  previousStatus = newStatus
	--end

end


------- REMINDER / NOTES --------

--googlePinger = hs.timer.new(15, pingGoogle)
--googlePinger:start()
