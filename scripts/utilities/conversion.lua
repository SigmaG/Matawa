-- MTW: functions about converting denizens to gods

t_conversion = {"pontification","preaching","evangelizing","proselytizing"}
conversion_size = 0
conversion_first = false
conversion_mob = ""

function mtw.reset_convert()
 conversion_mob = ""
 conversion_size = 0
 conversion_first = false
 disableTrigger("random conversion answers")
 disableTrigger("attempt of conversion ended")
end

function mtw.attempt_conversion(denizen,str)
 conversion_mob = denizen
 for i = 1,string.len(str) do
  send("convert "..conversion_mob.." with "..t_conversion[tonumber(string.sub(str,i,i))])
 end
end


function mtw.try_convert()
 for i=1,conversion_size do
  send("convert "..conversion_mob.." with "..t_conversion[conversion_table[i]])
 end
end

function mtw.conversion_answer()
 if conversion_first then
  mtw.first_try_convert()
 else
 end
end

function mtw.convert(denizen)
 conversion_mob = denizen
 conversion_size = 0
 enableTrigger("random conversion answers")
 enableTrigger("attempt of conversion ended")
 conversion_available = {}
 mtw.first_try_convert()
 conversion_first = true
 conversion_get_numbers = false
end

function mtw.first_try_convert()
 send("convert "..conversion_mob.." with "..t_conversion[1])
 conversion_size = conversion_size + 1
end

function mtw.find_numbers()
 for i = 1,conversion_size do
  send("convert "..conversion_mob.." with "..t_conversion[conversion_current_test])
 end
end

function mtw.start_actual_conversion()
 conversion_get_numbers = false
 mtw.conversion_all_generate()
 for k,v in pairs(conversion_all) do
  conversion_table = v
  conversion_all[k] = nil
  break
 end
 tempTimer(0.2,[[mtw.try_convert()]])
end

function mtw.conversion_attempt_result(matches)
 local good = tonumber(matches[2])
 local bad = tonumber(matches[3])
 if conversion_get_numbers then
  for i=1,good do
   table.insert(conversion_available,conversion_current_test)
  end
  if conversion_current_test < 4 then
   if #conversion_available == conversion_size then
    mtw.start_actual_conversion()
   else
    conversion_current_test = conversion_current_test + 1
    if conversion_current_test == 4 then
     for i=1,conversion_size-#conversion_available do
      table.insert(conversion_available,4)
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
 if conversion_first then
  for i=1,good do
   table.insert(conversion_available,1)
  end
  conversion_first = false
  disableTrigger("random conversion answers")
  conversion_get_numbers = true
  conversion_current_test = 2
  tempTimer(0.2,[[mtw.find_numbers()]])
  return
 end
 for k,v in pairs(conversion_all) do
  conversion_table = v
  conversion_all[k] = nil
  break
 end
 tempTimer(0.2,[[mtw.try_convert()]])
end

function mtw.conversion_all_generate()
 conversion_all = {}
 mtw.permutation(conversion_available,conversion_size)
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
		conversion_all[idx] = new
	else
		for i = 1, n do
			a[i], a[n] = a[n], a[i]
			mtw.permutation(a, n - 1)
			a[i], a[n] = a[n], a[i]
		end
	end
end
