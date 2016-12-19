/*
//////////////////////////////////////
Invasive Retrovirus
    Antibodies do not detect this trait.
    Virus is less versatile and therefore less resistant.
    This is not a slow process.
    Virus is less versatile and therefore less transmittable.
    Incredibly dangerous.
//////////////////////////////////////
*/

/datum/symptom/genetic_mutation
	name = "Hostile Invasive Retrovirus"
	stealth = 0
	resistance = -2
	stage_speed = 0
	transmittable = -2
	level = 6
	severity = 5
	var/list/possible_mutations
	var/archived_dna = null
  
  /datum/symptom/genetic_mutation/Activate(datum/disease/advance/A)
	..()
	if(prob(SYMPTOM_ACTIVATION_PROB)) // 3% chance
		var/mob/living/carbon/M = A.affected_mob
		if(!M.has_dna())
			return
		switch(A.stage)
			if(4, 5)
				M << "<span class='warning'>[pick("Your skin feels itchy.", "You feel burdened.")]</span>"
				randmut(M, possible_mutations)
	return
  
  /datum/symptom/genetic_mutation/Start(datum/disease/advance/A)
	possible_mutations = (bad_mutations | not_good_mutations) - mutations_list[RACEMUT]
	var/mob/living/carbon/M = A.affected_mob
	if(M)
		if(!M.has_dna())
			return
		archived_dna = M.dna.struc_enzymes
    
  /datum/symptom/genetic_mutation/End(datum/disease/advance/A)
	var/mob/living/carbon/M = A.affected_mob
	if(M && archived_dna)
		if(!M.has_dna())
			return
		M.dna.struc_enzymes = archived_dna
		M.domutcheck()
    
/*
//////////////////////////////////////
Benign Invasive Retrovirus
    Antibodies do not detect this trait.
    Virus is less versatile and therefore less resistant.
    This is not a slow process.
    Virus is less versatile and therefore less transmittable.
    Nonthreatening.
//////////////////////////////////////
*/

/datum/symptom/positive_genetic_mutation
	name = "Benign Invasive Retrovirus"
	stealth = 0
	resistance = -2
	stage_speed = 0
	transmittable = -2
	level = 6
	severity = 5
	var/list/possible_mutations
	var/archived_dna = null
  
  /datum/symptom/positive_genetic_mutation/Activate(datum/disease/advance/A)
	..()
	if(prob(SYMPTOM_ACTIVATION_PROB)) // 3% chance
		var/mob/living/carbon/M = A.affected_mob
		if(!M.has_dna())
			return
		switch(A.stage)
			if(5)
				M << "<span class='warning'>[pick("Your skin feels itchy.", "Your body feels as though it has lost a great weight.")]</span>"
				M.dna.remove_mutation_group(possible_mutations)
				randmut(M, possible_mutations)
	return
  
  /datum/symptom/positive_genetic_mutation/Start(datum/disease/advance/A)
	possible_mutations = (good_mutations) - mutations_list[RACEMUT]
	var/mob/living/carbon/M = A.affected_mob
	if(M)
		if(!M.has_dna())
			return
		archived_dna = M.dna.struc_enzymes
    
  /datum/symptom/positive_genetic_mutation/End(datum/disease/advance/A)
	var/mob/living/carbon/M = A.affected_mob
	if(M && archived_dna)
		if(!M.has_dna())
			return
		M.dna.struc_enzymes = archived_dna
		M.domutcheck()
