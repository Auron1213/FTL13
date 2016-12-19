/*
//////////////////////////////////////
Irritants
	Extremely noticable to antibodies.
	Causes immune systems to waste significant effort and compromise systems.
	and compromise systems.
	Externalizing the virus lets it spread.
	Active irritants mean the virus is capable and dangerous.
Bonus
	Forces a spread type of AIRBORNE
	with extra range!
//////////////////////////////////////
*/

/datum/symptom/irritants

	name = "Irritant Properties"
	stealth = -5
	resistance = 2
	stage_speed = 1
	transmittable = 5
	level = 1
	severity = 2

/datum/symptom/sneeze/Activate(datum/disease/advance/A)
	..()
	if(prob(SYMPTOM_ACTIVATION_PROB))
		var/mob/living/M = A.affected_mob
		switch(A.stage)
			if(1, 2, 3)
				M.emote("cough")
				var/obj/item/I = M.get_active_hand()
				if(I && I.w_class <= 2)
					M.drop_item()
			else
				M.emote("sneeze")
				A.spread(A.holder, 5)
        
	return
