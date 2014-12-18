-- MTW: offering functions

function mtw.offer_corpses()
 if mtw.have_offerings then
  for i in pairs(mtw.corpses) do
   send("offer "..mtw.corpses[i], false)
  end
  mtw.have_offerings = false
  mtw.corpses = {}
 else
  send("ii corpse", false)
  mtw.have_offerings = true
 end
end

function mtw.offer_sanctify()
 if mtw.have_offerings then
  for i in pairs(mtw.corpses) do
   send("offer "..mtw.corpses[i].." to sanctify", false)
  end
  mtw.have_offerings = false
  mtw.corpses = {}
 else
  send("ii corpse", false)
  mtw.have_offerings = true
 end
end

function mtw.offer_defile()
 if mtw.have_offerings then
  for i in pairs(mtw.corpses) do
   send("offer "..mtw.corpses[i].." to defile", false)
  end
  mtw.have_offerings = false
  mtw.corpses = {}
 else
  send("ii corpse", false)
  mtw.have_offerings = true
 end
end

function mtw.offer_give(person)
 if mtw.have_offerings then
  for i in pairs(mtw.corpses) do
   send("give "..mtw.corpses[i].." to "..person, false)
  end
  mtw.have_offerings = false
  mtw.corpses = {}
 else
  send("ii corpse", false)
  mtw.have_offerings = true
 end
end
