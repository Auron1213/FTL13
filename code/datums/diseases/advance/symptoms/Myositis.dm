/*
//////////////////////////////////////
Myositis
	Not very noticeable to the immune system.
	Dangerous, more resiliant, areas to infect.
	Increases areas that can act as modes of infection.
	Necessary equipment makes viruses less mobile and reproductive.
	Moderate Level.
Bonus
	Fatal.
//////////////////////////////////////
*/

/datum/symptom/myositis

	name = "Myositis"
	stealth = -1
	resistance = -1
	stage_speed = 1
	transmittable = -2
	level = 3
	severity = 3

/datum/symptom/choking/Activate(datum/disease/advance/A)
	..()
	if(prob(SYMPTOM_ACTIVATION_PROB))
		var/mob/living/M = A.affected_mob
		switch(A.stage)
			if(1, 2)
				M << "<span class='warning'>[pick("Your muscles strain.", "Your feet feel swollen.")]</span>"
			if(3, 4)
				M << "<span class='warning'><b>[pick("Your neck is beginning to feel sore.", "Breathing is becoming difficult.", "Your muscles are starting to itch.")]</span>"
				Swelling_stage_3_4(M, A)
				M.emote("gasp")
			else
				M << "<span class='userdanger'>[pick("You can hardly walk.", "You can't breathe!", "Your swollen muscles are incredibly itchy.")]</span>"
				Swelling(M, A)
				M.emote("gasp")
	return

/datum/symptom/choking/proc/Swelling_stage_3_4(mob/living/M, datum/disease/advance/A)
	var/get_damage = sqrt(21+A.totalStageSpeed()*0.5)+sqrt(16+A.totalStealth()*2)
	M.adjustOxyLoss(get_damage)
	return 1

/datum/symptom/choking/proc/Swelling(mob/living/M, datum/disease/advance/A)
	var/get_damage = sqrt(21+A.totalStageSpeed())+sqrt(16+A.totalStealth()*4)
	M.adjustOxyLoss(get_damage)
  M.adjustBruteLoss(get_damage/2)
  ChangeSpeed(M)
	return 1
  
/datum/symptom/damage_converter/proc/ChangeSpeed(mob/living/M, var/targetSpeed)
  var/oldSpeed = M.speedmod
  M.speedmod = targetSpeed
  var/changedSpeed = 1
/datum/symptom/genetic_mutation/End(datum/disease/advance/A)
  var/mob/living/carbon/M = A.affected.mob
  if(var/changedSpeed = 1)
    M.speedmod = oldSpeed
