-- MTW : chat window trigger functions

function mtw.chat_tells(matches)
 if not string.find(matches[1], "OOC") and not string.find(matches[1], "%/%/") and not string.find(matches[1], "%(%(") then
  demonnic.chat:append("Tells")
 end
end

function mtw.chat_says(matches)
 if string.find(multimatches[2][2], "\"") then
  if not string.find(multimatches[2][1], "\"U\"") and not string.find(multimatches[2][1], "OOC") and not string.find(multimatches[2][1], "%/%/") and not string.find(multimatches[2][1], "%(%(") and not string.find(multimatches[2][1], "graffiti") then
   demonnic.chat:append("Says")
  end
 end
end

function mtw.chat_misc(matches)
 if not string.find(matches[1], "OOC") and not string.find(matches[1], "%/%/") and not string.find(matches[1], "%(%(") then
  demonnic.chat:append("Misc")
 end
end

function mtw.chat_deathsense(matches)
 selectString(matches[1], 1)
 fg("purple")
 bg("black")
 resetFormat()
 demonnic.chat:append("Misc")
end

function mtw.chat_shouts(matches)
 selectString(matches[1], 1)
 fg("CadetBlue")
 bg("black")
 resetFormat()
 demonnic.chat:append("Misc")
end