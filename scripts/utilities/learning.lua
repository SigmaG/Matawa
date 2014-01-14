function mtw.learn_start(lessons, skill, teacher)
	mtw.learning = {}
	mtw.learning.lessons = tonumber(lessons)
	mtw.learning.skill = skill
	mtw.learning.teacher = teacher

	mtw.learn_next()
end

function mtw.learn_next(token)
	if not mtw.learning then return end
	if token then
		mtw.set_balance("learn " .. math.min(mtw.learning.lessons, 15) .. " " .. mtw.learning.skill .. " from " .. mtw.learning.teacher)
	else
		send("learn " .. math.min(mtw.learning.lessons, 15) .. " " .. mtw.learning.skill .. " from " .. mtw.learning.teacher,false)
	end
	
	mtw.learning.lessons = math.max( mtw.learning.lessons - 15, 0)
	if mtw.learning.lessons == 0 then mtw.learning = nil end
end