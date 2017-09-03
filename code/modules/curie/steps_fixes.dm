/*
To Lefouin

This way I feel the thing gets managed a bit better
Also adds step cooldown
And fixes the thing of stepping on weird items on the floor - Sansaur

*/


// For step CD
// Defaults to 1 for each odd step
/atom/movable
	var/steps_no_sound = 0
	var/steps_needed = 1

/proc/getFootStepSound(T as turf, M as mob)
	if(!T) // Check if its a turf at all (sanity check)
		return

	if(!istype(T, /turf/simulated)) // Check if its a turf that isn't space and admin tile
		return

	if(istype(M, /mob/living/silicon))
		return HEAVY_FOOTSTEP_SOUNDS[rand(1, HEAVY_FOOTSTEP_SOUNDS.len)] // If silicon, use heavy

	/*
		This only works with ABSOLUTE PATHS
	*/
	for(var/obj/O in T)
		// We don't want invisible items to make special sounds. This will require more checks
		// !O.icon_state || !O.icon  don't work
		if(O.invisibility >= 100)
			continue
		if(is_type_in_list(O, itemStepsList)) //<-- This should be the way that this should work, but nope, it's gonna just use
//		if(O in itemStepsList)
			// Returns sound - Gets list of sounds by item type, then we get a random sound of said list checking by it's length
			var/TipoLocalizar = locate(O) in itemStepsList
			if(!TipoLocalizar)
				continue

			var/lenghtlist = length(itemStepsList[TipoLocalizar])				// Puto O.type!
			var/soundin = itemStepsList[TipoLocalizar][rand(1, lenghtlist)] 	// Puto O.type!
			return soundin

	// After checking for Objects, we'll check of the turf is actually an Open Space, if a sound was played it's because the mob stepped on an object
	// On the Open Space (Lattices)
	if(istype(T,/turf/simulated/open))
		return

	for(var/i in stepsList) // Choose a random sound associated with the turf type
		if(istype(T, i))
			var/t[] = stepsList[i]
			var/step = rand(1, t.len)
			return stepsList[i][step]


	return DEFAULT_FOOTSTEP_SOUNDS[rand(1, DEFAULT_FOOTSTEP_SOUNDS.len)] // If no type is specified, use default

/proc/playFootstep(atom/movable/A) // Main proc
	// Problems:
	// 1) Cooldown to the footsteps
	// 2) OpenSpae shouldn't play a footstep
	// 3)
	//	..(A) No
	if(!A || !istype(A))
		return
	var/playSteps = isGroundedMob(A)
	if(isWalking(A))  // Check if the player is in sneak mode (walk mode)
		return
	if(!checkStepCD(A))
		return
	if(playSteps) // Play the sound
		var/curTurf = get_turf(A)
		if(curTurf)
			var/stepSound = getFootStepSound(curTurf, A)
			if(stepSound)
				playsound(curTurf, "sound/footsteps/" + stepSound, footstepVol, footstepVarReq, footstepRange, 0, 0, footstepFreq)

proc/checkStepCD(atom/movable/A)
	if(A.steps_no_sound >= A.steps_needed)
		A.steps_no_sound = 0
		return 1
	else
		A.steps_no_sound++
		return 0
