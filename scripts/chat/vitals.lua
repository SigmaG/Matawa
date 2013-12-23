-- MTW : demonnicVitals

--Set some vital statistics. Will work with both ATCP and GMCP. 

function demonnicVitals( msg, arg )
  demonnic.nextLevel = tonumber(gmcp.Char.Vitals.nl)
  demonnic.curHealth = tonumber(gmcp.Char.Vitals.hp)    
  demonnic.maxHealth = tonumber(gmcp.Char.Vitals.maxhp)
  demonnic.curMana = tonumber(gmcp.Char.Vitals.mp)
  demonnic.maxMana = tonumber(gmcp.Char.Vitals.maxmp)
  demonnic.curEgo = tonumber(gmcp.Char.Vitals.ego)
  demonnic.maxEgo = tonumber(gmcp.Char.Vitals.maxego)
  demonnic.curPower = tonumber(gmcp.Char.Vitals.pow)
  demonnic.maxPower = tonumber(gmcp.Char.Vitals.maxpow)
  demonnic.curWillpower = tonumber(gmcp.Char.Vitals.wp)
  demonnic.maxWillpower = tonumber(gmcp.Char.Vitals.maxwp)
  demonnic.curEndurance = tonumber(gmcp.Char.Vitals.ep)
  demonnic.maxEndurance = tonumber(gmcp.Char.Vitals.maxep)
end