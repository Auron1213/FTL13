/*
//////////////////////////////////////
Competitive Viral Strains
    Antibodies do not detect this trait.
    Virus is more resiliant due to increased competition.
    The virus is more cautious in growth patterns.
    Virus is slightly less versatile.
    Not dangerous.
//////////////////////////////////////
*/
/datum/symptom/heal/competition

	name = "Viral Competition"
	stealth = 0
	resistance = 2
	stage_speed = -1
	transmittable = -1
	level = 3
	var/list/cured_diseases = list()

/datum/symptom/heal/competition/Heal(mob/living/M, datum/disease/advance/A)
	var/cured = 0
	for(var/datum/disease/D in M.viruses)
		if(D != A)
			cured = 1
			cured_diseases += D.GetDiseaseID()
			D.cure()
	if(cured)
		M << "<span class='notice'>You feel much better.</span>"

/datum/symptom/heal/competition/End(datum/disease/advance/A)
	// Remove all the diseases we cured.
	var/mob/living/M = A.affected_mob
	if(istype(M))
		if(cured_diseases.len)
			for(var/res in M.resistances)
				if(res in cured_diseases)
					M.resistances -= res
		M << "<span class='warning'>You feel weaker.</span>"
