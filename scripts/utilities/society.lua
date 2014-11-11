-- MTW : something to enable SCTx like syntax for SHELP/SWHO/SOCIETY whatever

function mtw.society_do(num, what)
 send("society switch "..num)
 send(what)
 if not what:lower():match("^shelp *edit ") then
  if mtw.current_society then
   send("society switch "..mtw.current_society)
  else
   send("society switch "..mtw.default_society)
  end
 end
end

function mtw.society_switch(num)
 mtw.current_society = num
 send("society switch "..num, false)
end
