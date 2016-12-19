/*
//////////////////////////////////////
Vestibular Infection
    Highly visible to antibodies.
    More areas of infection with less antibodies.
    --
    --
    Dangerous.
//////////////////////////////////////
*/
/datum/symptom/confusion

	name = "Vestibular Infection"
	stealth = 1
	resistance = -1
	stage_speed = -3
	transmittable = 0
	level = 4
	severity = 2


/datum/symptom/confusion/Activate(datum/disease/advance/A)
	..()
	if(prob(SYMPTOM_ACTIVATION_PROB))
		var/mob/living/carbon/M = A.affected_mob
		switch(A.stage)
			if(1, 2, 3, 4)
        M << "<span class='userdanger'>A wave of dizziness washes over you!</span>"
		  	M.Dizzy(5)
      else
			  M << "<span class='userdanger'>You can't think straight!</span>"
			  M.confused = min(100, M.confused + 10)
        M.adjustBruteLoss(2*A.totalResistance()) //The more resistant the virus is, the deeper into the inner ear it can corrode.
	return
