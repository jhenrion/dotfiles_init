-- sources
-- https://gist.github.com/matellis/69954d4212b1a36c13aad3de4e75187e#file-things3-to-of3-applescript-L350
set theDate to date string of (current date)


tell application "OmniFocus"
	activate
	tell default document
		
		set planningTag to first flattened tag where its name is "📆 Planning"
		set todayTag to first flattened tag where its name is "Today"
		set thisWeekTag to first flattened tag where its name is "This Week"
		set nextWeekTag to first flattened tag where its name is "Next Week"
		
		set lundi to first flattened tag where its name is "lundi"
		set mardi to first flattened tag where its name is "mardi"
		set mercredi to first flattened tag where its name is "mercredi"
		set jeudi to first flattened tag where its name is "jeudi"
		set vendredi to first flattened tag where its name is "vendredi"
		set samedi to first flattened tag where its name is "samedi"
		set dimanche to first flattened tag where its name is "dimanche"
		
		set theDate to weekday of (current date) as integer
		
		
		if theDate > 0 then
			move dimanche to end of tags of todayTag
		end if
		
		if theDate > 1 then
			move lundi to end of tags of todayTag
			move mardi to end of tags of planningTag
			move mercredi to end of tags of planningTag
			move jeudi to end of tags of planningTag
			move vendredi to end of tags of planningTag
			move samedi to end of tags of planningTag
			move dimanche to end of tags of planningTag
			
		end if
		
		if theDate > 2 then
			move mardi to end of tags of todayTag
		end if
		
		if theDate > 3 then
			move mercredi to end of tags of todayTag
		end if
		
		if theDate > 4 then
			move jeudi to end of tags of todayTag
		end if
		
		if theDate > 5 then
			move vendredi to end of tags of todayTag
		end if
		
		if theDate > 6 then
			move samedi to end of tags of todayTag
		end if
		
	end tell
end tell