/datum/preferences
	var/med_record = ""
	var/sec_record = ""
	var/gen_record = ""
	var/nanotrasen_relation = "Neutre"
	var/memory = ""

	//Some faction information.
	var/home_system = "Non défini"           //System of birth.
	var/citizenship = "Aucune"            //Current home system.
	var/faction = "Aucune"                //Antag faction/general associated faction.
	var/religion = "Aucune"               //Religious association.

/datum/category_item/player_setup_item/general/background
	name = "Histoire"
	sort_order = 5

/datum/category_item/player_setup_item/general/background/load_character(var/savefile/S)
	from_file(S["med_record"],pref.med_record)
	from_file(S["sec_record"],pref.sec_record)
	from_file(S["gen_record"],pref.gen_record)
	from_file(S["home_system"],pref.home_system)
	from_file(S["citizenship"],pref.citizenship)
	from_file(S["faction"],pref.faction)
	from_file(S["religion"],pref.religion)
	from_file(S["nanotrasen_relation"],pref.nanotrasen_relation)
	from_file(S["memory"],pref.memory)

/datum/category_item/player_setup_item/general/background/save_character(var/savefile/S)
	to_file(S["med_record"],pref.med_record)
	to_file(S["sec_record"],pref.sec_record)
	to_file(S["gen_record"],pref.gen_record)
	to_file(S["home_system"],pref.home_system)
	to_file(S["citizenship"],pref.citizenship)
	to_file(S["faction"],pref.faction)
	to_file(S["religion"],pref.religion)
	to_file(S["nanotrasen_relation"],pref.nanotrasen_relation)
	to_file(S["memory"],pref.memory)

/datum/category_item/player_setup_item/general/background/sanitize_character()
	if(!pref.home_system) pref.home_system = "Non défini"
	if(!pref.citizenship) pref.citizenship = "Aucune"
	if(!pref.faction)     pref.faction =     "Aucune"
	if(!pref.religion)    pref.religion =    "Aucune"

	pref.nanotrasen_relation = sanitize_inlist(pref.nanotrasen_relation, COMPANY_ALIGNMENTS, initial(pref.nanotrasen_relation))

/datum/category_item/player_setup_item/general/background/content(var/mob/user)
	. += "<b>Histoire du Personnage</b><br>"
	. += "Relation avec [GLOB.using_map.company_name] : <a href='?src=\ref[src];nt_relation=1'>[pref.nanotrasen_relation]</a><br/>"
	. += "Système de Naissance : <a href='?src=\ref[src];home_system=1'>[pref.home_system]</a><br/>"
	. += "Citoyenneté : <a href='?src=\ref[src];citizenship=1'>[pref.citizenship]</a><br/>"
	. += "Faction : <a href='?src=\ref[src];faction=1'>[pref.faction]</a><br/>"
	. += "Religion : <a href='?src=\ref[src];religion=1'>[pref.religion]</a><br/>"

	. += "<br/><b>Dossiers</b>:<br/>"
	if(jobban_isbanned(user, "Records"))
		. += "<span class='danger'>You are banned from using character records.</span><br>"
	else
		. += "Dossiers Médicaux :<br>"
		. += "<a href='?src=\ref[src];set_medical_records=1'>[TextPreview(pref.med_record,40)]</a><br><br>"
		. += "Curriculum Vitae :<br>"
		. += "<a href='?src=\ref[src];set_general_records=1'>[TextPreview(pref.gen_record,40)]</a><br><br>"
		. += "Casier Judicaire :<br>"
		. += "<a href='?src=\ref[src];set_security_records=1'>[TextPreview(pref.sec_record,40)]</a><br>"
		. += "Mémoire :<br>"
		. += "<a href='?src=\ref[src];set_memory=1'>[TextPreview(pref.memory,40)]</a><br>"

/datum/category_item/player_setup_item/general/background/OnTopic(var/href,var/list/href_list, var/mob/user)
	if(href_list["nt_relation"])
		var/new_relation = input(user, "Choisissez votre relation avec [GLOB.using_map.company_name]. Notez qu'il s'agit de ce que les autres personnages peuvent déduire sur vous en observant votre passé, pas de ce que votre personnage pense réelement.", "Character Preference", pref.nanotrasen_relation)  as null|anything in COMPANY_ALIGNMENTS
		if(new_relation && CanUseTopic(user))
			pref.nanotrasen_relation = new_relation
			return TOPIC_REFRESH

	else if(href_list["home_system"])
		var/choice = input(user, "Choisissez votre système de naissance.", "Character Preference", pref.home_system) as null|anything in home_system_choices + list("Unset","Other")
		if(!choice || !CanUseTopic(user))
			return TOPIC_NOACTION
		if(choice == "Other")
			var/raw_choice = sanitize(input(user, "Choisissez un système de naissance..", "Character Preference")  as text|null, MAX_NAME_LEN)
			if(raw_choice && CanUseTopic(user))
				pref.home_system = raw_choice
		else
			pref.home_system = choice
		return TOPIC_REFRESH

	else if(href_list["citizenship"])
		var/choice = input(user, "Choisissez votre citoyenneté.", "Character Preference", pref.citizenship) as null|anything in citizenship_choices + list("None","Other")
		if(!choice || !CanUseTopic(user))
			return TOPIC_NOACTION
		if(choice == "Other")
			var/raw_choice = sanitize(input(user, "Choisissez une citoyennetée.", "Character Preference") as text|null, MAX_NAME_LEN)
			if(raw_choice && CanUseTopic(user))
				pref.citizenship = raw_choice
		else
			pref.citizenship = choice
		return TOPIC_REFRESH

	else if(href_list["faction"])
		var/choice = input(user, "Choisissez la faction pour laquelle vous travaillez.", "Character Preference", pref.faction) as null|anything in faction_choices + list("None","Other")
		if(!choice || !CanUseTopic(user))
			return TOPIC_NOACTION
		if(choice == "Other")
			var/raw_choice = sanitize(input(user, "Choisisissez une faction.", "Character Preference")  as text|null, MAX_NAME_LEN)
			if(raw_choice)
				pref.faction = raw_choice
		else
			pref.faction = choice
		return TOPIC_REFRESH

	else if(href_list["religion"])
		var/choice = input(user, "Choisissez une religion.", "Character Preference", pref.religion) as null|anything in religion_choices + list("None","Other")
		if(!choice || !CanUseTopic(user))
			return TOPIC_NOACTION
		if(choice == "Other")
			var/raw_choice = sanitize(input(user, "Choisissez une religion.", "Character Preference")  as text|null, MAX_NAME_LEN)
			if(raw_choice)
				pref.religion = sanitize(raw_choice)
		else
			pref.religion = choice
		return TOPIC_REFRESH

	else if(href_list["set_medical_records"])
		var/new_medical = sanitize(input(user,"Enter medical information here.","Character Preference", html_decode(pref.med_record)) as message|null, MAX_PAPER_MESSAGE_LEN, extra = 0)
		if(!isnull(new_medical) && !jobban_isbanned(user, "Records") && CanUseTopic(user))
			pref.med_record = new_medical
		return TOPIC_REFRESH

	else if(href_list["set_general_records"])
		var/new_general = sanitize(input(user,"Enter employment information here.","Character Preference", html_decode(pref.gen_record)) as message|null, MAX_PAPER_MESSAGE_LEN, extra = 0)
		if(!isnull(new_general) && !jobban_isbanned(user, "Records") && CanUseTopic(user))
			pref.gen_record = new_general
		return TOPIC_REFRESH

	else if(href_list["set_security_records"])
		var/sec_medical = sanitize(input(user,"Enter security information here.","Character Preference", html_decode(pref.sec_record)) as message|null, MAX_PAPER_MESSAGE_LEN, extra = 0)
		if(!isnull(sec_medical) && !jobban_isbanned(user, "Records") && CanUseTopic(user))
			pref.sec_record = sec_medical
		return TOPIC_REFRESH

	else if(href_list["set_memory"])
		var/memes = sanitize(input(user,"Enter memorized information here.","Character Preference", html_decode(pref.memory)) as message|null, MAX_PAPER_MESSAGE_LEN, extra = 0)
		if(!isnull(memes) && CanUseTopic(user))
			pref.memory = memes
		return TOPIC_REFRESH

	return ..()
