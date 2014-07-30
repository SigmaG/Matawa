-- MTW: functions about converting denizens to gods

mtw.conversion = {}
mtw.conversion.t = {"pontification","preaching","evangelizing","proselytizing"}
mtw.conversion.size = 0
mtw.conversion.first = false
mtw.conversion.mob = ""

function mtw.reset_convert()
 mtw.conversion.mob = ""
 mtw.conversion.size = 0
 mtw.conversion.first = false
 disableTrigger("random conversion answers")
 disableTrigger("attempt of conversion ended")
 disableTrigger("conversion attempt")
 disableTrigger("conversion success")
end

function mtw.attempt_conversion(denizen,str)
 mtw.conversion.mob = denizen
 local show = false
 if mtw.toggles.conversion_display then
  show = true
 else
  cecho("\n<yellow>attempt "..mtw.conversion.mob .. " ")
 end
 for i = 1,string.len(str) do
  local n = tonumber(string.sub(str,i,i))
  if not show then cecho("\n<yellow>"..n) end
  send("convert "..mtw.conversion.mob.." with "..mtw.conversion.t[n], show)
 end
end


function mtw.try_convert()
 local show = false
 if mtw.toggles.conversion_display then
  show = true
 end
 for i=1,mtw.conversion.size do
  send("convert "..mtw.conversion.mob.." with "..mtw.conversion.t[mtw.conversion.table[i]], show)
 end
end

function mtw.conversion_answer()
 if not mtw.toggles.conversion_display then
  deleteLine()
 end
 if mtw.conversion.first then
  mtw.first_try_convert()
 else
 end
end

function mtw.convert(denizen)
 mtw.conversion.mob = denizen
 mtw.conversion.size = 0
 enableTrigger("random conversion answers")
 enableTrigger("attempt of conversion ended")
 enableTrigger("conversion attempt")
 enableTrigger("conversion success")
 mtw.conversion.available = {}
 mtw.first_try_convert()
 mtw.conversion.first = true
 mtw.conversion.get_numbers = false
end

function mtw.conversion_attempt()
 if not mtw.toggles.conversion_display then
  deleteLine()
 end
end

function mtw.first_try_convert()
 local show = false
 if mtw.toggles.conversion_display then
  show = true
 end
 send("convert "..mtw.conversion.mob.." with "..mtw.conversion.t[1], show)
 mtw.conversion.size = mtw.conversion.size + 1
end

function mtw.find_numbers()
 local show = false
 if mtw.toggles.conversion_display then
  show = true
 end
 for i = 1,mtw.conversion.size do
  send("convert "..mtw.conversion.mob.." with "..mtw.conversion.t[mtw.conversion.current_test], show)
 end
end

function mtw.start_actual_conversion()
 mtw.conversion.get_numbers = false
 mtw.conversion.all_generate()
 for k,v in pairs(mtw.conversion.all) do
  mtw.conversion.table = v
  mtw.conversion.all[k] = nil
  break
 end
 tempTimer(0.2,[[mtw.try_convert()]])
end

function mtw.conversion_attempt_result(matches)
 local good = tonumber(matches[2])
 local bad = tonumber(matches[3])
 if mtw.conversion.get_numbers then
  for i=1,good do
   table.insert(mtw.conversion.available,mtw.conversion.current_test)
  end
  if mtw.conversion.current_test < 4 then
   if #mtw.conversion.available == mtw.conversion.size then
    mtw.start_actual_conversion()
   else
    mtw.conversion.current_test = mtw.conversion.current_test + 1
    if mtw.conversion.current_test == 4 then
     for i=1,mtw.conversion.size-#mtw.conversion.available do
      table.insert(mtw.conversion.available,4)
     end
     mtw.start_actual_conversion()
    else
     tempTimer(0.2,[[mtw.find_numbers()]])
    end
   end
  else
   mtw.start_actual_conversion()
  end
 return
 end
 if mtw.conversion.first then
  for i=1,good do
   table.insert(mtw.conversion.available,1)
  end
  mtw.conversion.first = false
  mtw.conversion.get_numbers = true
  mtw.conversion.current_test = 2
  tempTimer(0.2,[[mtw.find_numbers()]])
  return
 end
 for k,v in pairs(mtw.conversion.all) do
  mtw.conversion.table = v
  mtw.conversion.all[k] = nil
  break
 end
 tempTimer(0.2,[[mtw.try_convert()]])
end

function mtw.conversion.all_generate()
 mtw.conversion.all = {}
 mtw.permutation(mtw.conversion.available,mtw.conversion.size)
end

function mtw.permutation(a, n)
	new={}
	for i=1,#a do
		new[i] = a[i]
	end
	if n == 0 then
		idx = 0
		pow = 1
		k = #new
		for i = k,1,-1 do
			idx = idx + pow*new[i]
			pow = pow * 10
		end
		mtw.conversion.all[idx] = new
	else
		for i = 1, n do
			a[i], a[n] = a[n], a[i]
			mtw.permutation(a, n - 1)
			a[i], a[n] = a[n], a[i]
		end
	end
end


function mtw.conversion_aliases()
 cecho("\n<green>Conversion commands:")
 mtw.disp_toggle("conversion_display", "tconv: Toggle displaying the spammy conversion lines")
 echo("\n conv X: convert NPC of name or id X")
 echo("\n attempt X aaaaa: try the arguments aaaaa (numbers between 1 and 4) on NPC X")
 echo("\n convrst: reset a conversion attempt")
 send(" ")
end
