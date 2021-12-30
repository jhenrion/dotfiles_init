set theCal to "OmniFocus" as string

--Delete current items in this calendar
tell application "Calendar"
	tell calendar theCal
		set theEvents to every event
		repeat with current_event in theEvents
			delete current_event
		end repeat
	end tell
end tell

--Add all uncompleted due items in this calendar
tell application "OmniFocus"
	set theTasks to (flattened tasks whose (due date is not missing value) and (completed is false) and (dropped is false) and (containing project is missing value or status of containing project is active status or status of containing project is on hold status)) of default document
	repeat with aTask in theTasks
		
		-- determine the start Date
		set theStart to ((due date of aTask) - 3 * days)
		set {theStart's hours, theStart's minutes, theStart's seconds} to {9, 0, 0}
		set theWeekDay to weekday of theStart as integer
		
		if theWeekDay = 1 or theWeekDay = 7 then
			set theStart to (theStart - 2 * days)
		end if
		
		set theAction to "Due: " & name of aTask
		set theEnd to (theStart + 1 * hours)
		set theURI to "omnifocus://task/" & id of aTask
		set theDescription to "Due: " & (due date of aTask) & return & return & theURI & return & return & (note of aTask) & return & return & "test"
		
		log "theAction: " & theAction
		log "theStart: " & theStart
		log "theEnd: " & theEnd
		log "theURI: " & theURI
		log "theDescription: " & theDescription
		
		tell application "Calendar"
			make new event at end of events of calendar theCal with properties {summary:theAction, start date:theStart, end date:theEnd, allday event:false, description:theDescription}
		end tell
		
	end repeat
end tell
