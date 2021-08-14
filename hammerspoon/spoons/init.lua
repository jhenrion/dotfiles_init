------- SPOONS -------


-- HAMMERSPOON FILE UPDATE->AUTO RELOAD
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/hammerspoon/", hs.reload):start()
--path = hs.fs.pathToAbsolute(os.getenv("HOME") .. "/.hammerspoon/init.lua")

hs.alert.show("Hammerspoon config reloaded...")

-- HYPERKEY

-- Specify your combination (your hyperkey)
local hyper = { "cmd", "alt", "ctrl" }
-- We use 0 to reload the configuration
hs.hotkey.bind(hyper, "o", function()
   hs.reload()
 end)
-- Notify about the config reload
--hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

-- WINDOWS
function move_window(direction)
  return function()
        local win      = hs.window.focusedWindow()
        local app      = win:application()
        local app_name = app:name()
        local f        = win:frame()
        local screen   = win:screen()
        local max      = screen:frame()

        hs.window.animationDuration = 0.1

        --hs.alert.show(direction)

        if direction == "fullscreen" then
            win:maximize()
            --[[ print(win:isFullScreen())
            print(f.x) --f.x = -3840
            print(f.y) --f.y = -59
            print(f.w) --f.w = 1920
            print(f.h) --f.h = 1055 ]]
        else
          if direction == "left" then
              -- +-----------------+
              -- |        |        |
              -- |  HERE  |        |
              -- |        |        |
              -- +-----------------+
              f.x = max.x
              f.y = max.y
              f.w = max.w / 2
              f.h = max.h
          elseif direction == "right" then
              -- +-----------------+
              -- |        |        |
              -- |        |  HERE  |
              -- |        |        |
              -- +-----------------+
              f.x = max.x + (max.w / 2)
              f.y = max.y
              f.w = max.w / 2
              f.h = max.h
          elseif direction == "up" then
              -- +-----------------+
              -- |      HERE       |
              -- +-----------------+
              -- |                 |
              -- +-----------------+
              f.x = max.x
              f.w = max.w
              f.y = max.y
              f.h = max.h / 2
          elseif direction == "down" then
              -- +-----------------+
              -- |                 |
              -- +-----------------+
              -- |      HERE       |
              -- +-----------------+
              f.x = max.x
              f.w = max.w
              f.y = max.y + (max.h / 2)
              f.h = max.h / 2
          elseif direction == "upLeft" then
              -- +-----------------+
              -- |  HERE  |        |
              -- +--------+        |
              -- |                 |
              -- +-----------------+
              f.x = max.x
              f.y = max.y
              f.w = max.w/2
              f.h = max.h/2
          elseif direction == "upRight" then
              -- +-----------------+
              -- |        |  HERE  |
              -- |        +--------|
              -- |                 |
              -- +-----------------+
              f.x = max.x + (max.w / 2)
              f.y = max.y
              f.w = max.w/2
              f.h = max.h/2
          elseif direction == "downLeft" then
              -- +-----------------+
              -- |                 |
              -- +--------+        |
              -- |  HERE  |        |
              -- +-----------------+
              f.x = max.x
              f.y = max.y + (max.h / 2)
              f.w = max.w/2
              f.h = max.h/2
          elseif direction == "downRight" then
              -- +-----------------+
              -- |                 |
              -- |        +--------|
              -- |        |  HERE  |
              -- +-----------------+
              f.x = max.x + (max.w / 2)
              f.y = max.y + (max.h / 2)
              f.w = max.w/2
              f.h = max.h/2
          end
          win:setFrame(f)
        end
end

end

hs.hotkey.bind(hyper, "p", move_window("left"))
hs.hotkey.bind(hyper, "left", move_window("left"))
hs.hotkey.bind(hyper, "$", move_window("right"))
hs.hotkey.bind(hyper, "right", move_window("right"))
hs.hotkey.bind(hyper, ")", move_window("up"))
hs.hotkey.bind(hyper, "up", move_window("up"))
hs.hotkey.bind(hyper, "ù", move_window("down"))
hs.hotkey.bind(hyper, "down", move_window("down"))
hs.hotkey.bind(hyper, "à", move_window("upLeft"))
hs.hotkey.bind(hyper, "pageup", move_window("upLeft"))
hs.hotkey.bind(hyper, "-", move_window("upRight"))
hs.hotkey.bind(hyper, "end", move_window("upRight"))
hs.hotkey.bind(hyper, "m", move_window("downLeft"))
hs.hotkey.bind(hyper, "home", move_window("downLeft"))
hs.hotkey.bind(hyper, "`", move_window("downRight"))
hs.hotkey.bind(hyper, "pagedown", move_window("downRight"))
hs.hotkey.bind(hyper, "^", move_window("fullscreen"))
hs.hotkey.bind(hyper, "return", move_window("fullscreen"))

--[[ hs.hotkey.bind(hyper, "return", function()
 -- +--------------+
 -- |              |
 -- |     HERE     |
 -- |              |
 -- +---------------+
   local win = hs.window.focusedWindow();
   if not win then return end
   win:moveToUnit(hs.layout.maximized)
   end)
-- this one for fullscreen mode
 hs.hotkey.bind(hyper, "f", function()
     local win = hs.window.frontmostWindow()
     win:setFullscreen(not win:isFullscreen())
 end) ]]

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
