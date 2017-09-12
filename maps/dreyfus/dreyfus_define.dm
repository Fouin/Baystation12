/datum/map/dreyfus
	name = "Dreyfus"
	full_name = "SSNI Dreyfus"
	path = "dreyfus"
	flags = MAP_HAS_BRANCH

	lobby_icon = 'maps/dreyfus/icons/lobby.dmi'

	station_levels = list(1,2,3,4,5,6)
	admin_levels = list(8)
	contact_levels = list(1,2,3,4,5,6,8)
	player_levels = list(1,2,3,4,5,6,7)
	accessible_z_levels = list("1"=1,"2"=1,"3"=1,"4"=1,"5"=1,"6"=1,"7"=90)

	allowed_spawns = list("Arrivals Shuttle", "Cryogenic Storage")
	default_spawn = "Arrivals Shuttle"

	station_name  = "SSNI Dreyfus"
	station_short = "Dreyfus"
	dock_name     = "Relais NTTM1-54" // sur Charnay-4
	boss_name     = "Direction Centrale"
	boss_short    = "DIRCEN"
	company_name  = "NanoTrasen Industries"
	company_short = "NTi"
	system_name = "Iota-Pavonis"

	id_hud_icons = 'maps/dreyfus/icons/assignment_hud.dmi'


	map_admin_faxes = list("Nanotrasen Industries Direction Centrale")

	shuttle_docked_message = "La navette de roulement arriv�e du %Dock_name% s'est amar�e � la station. D�part dans %ETD%"
	shuttle_leaving_dock = "La navette de roulement d'�quipage s'est d�samar�e. Arriv� estim�e dans %ETA%."
	shuttle_called_message = "Un roulement d'�quipage vers %Dock_name% viens d'�tre planifi�. Une navette de transfert a �t� appel�e. Elle arrivera dans approximativement %ETA%"
	shuttle_recall_message = "Le roulement de l'�quipage a �t� annul�."
	emergency_shuttle_docked_message = "La navette d'�vacuation s'est amarr�e � la station. Vous �tes pri� d'�vacuer d'ici %ETD%."
	emergency_shuttle_leaving_dock = "La navette d'�vacuation s'est d�samar�e. Arriv� estim�e dans %ETA%."
	emergency_shuttle_called_message = "La navette d'�vacuation a �t� appel�e. Elle arrivera dans approximativement %ETA%"
	emergency_shuttle_recall_message = "La navette d'�vacuation a �t� rappel�e. Le co�t de cette manoevre sera d�duit directement de vos salaires."

	evac_controller_type = /datum/evacuation_controller/shuttle

/datum/map/dreyfus/perform_map_generation()
	new /datum/random_map/automata/cave_system(null,1,1,3,255, 255) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null,1,1,3,64, 64)
	new /datum/random_map/automata/cave_system(null,1,1,4,255, 255) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null,1,1,4,64, 64)
	new /datum/random_map/automata/cave_system(null,1,1,2,255, 255) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null,1,1,2,64, 64)
	return 1

/datum/map/torch/send_welcome()
	var/welcome_text = "<center><font size = 3><b>SSNI Dreyfus</b></font><hr />"
	welcome_text += "Message de bienvenue g�n�r� le [stationdate2text()] � [stationtime2text()].</center><br /><br />"
	welcome_text += "Bienvenue � bord du SSNI Dreyfus, station de <b>NanoTrasen Industries</b> en orbite de Charnay-4, dans le syst�me de Iota-Pavonis.<br />"
	welcome_text += "Les ordres de productions sont disponibles aupr�s du Directeur G�n�ral.<br />"
	welcome_text += "La temp�rature actuelle est de [rand(19,32)] degr�s.<br />"
	welcome_text += "Le dernier ravitaillement � eu lieu il y a [rand(7,30)] jours.<br />"
	welcome_text += "<b>NanoTrasen Industries</b> vous souhaite une journ�e de travail heureuse et productive.<br />"



	post_comm_message("SSNI Dreyfus Message de Bienvenue", welcome_text)
	minor_announcement.Announce(message = "New [GLOB.using_map.company_name] Update available at all communication consoles.")
