-- MTW: illusion checker

-- code to check if triggers are fired because of an illusion.

function mtw.check_illusion(fct,matches,multimatches)
if mtw.see_illusion then
 tempTimer(0,[[mtw.see_illusion = false]])
 cecho("\n<pink>Illusion checked!")
else
 fct(matches,multimatches)
end
end