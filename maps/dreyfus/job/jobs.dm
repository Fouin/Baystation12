/datum/map/dreyfus
	allowed_jobs = list(
						/datum/job/assistant,
						/datum/job/captain,
						/datum/job/hop,
						/datum/job/qm,
						/datum/job/engineer,
						/datum/job/cargo_tech,
						/datum/job/mining,
						/datum/job/ouvrier,
						/datum/job/cgt,
						/datum/job/scientist,
						/datum/job/doctor,
						/datum/job/trader,
						/datum/job/hos,
						/datum/job/officer,
						/datum/job/chef,
						/datum/job/chaplain,
						/datum/job/janitor,
						/datum/job/employe,
						/datum/job/liaison,
						/datum/job/ai,
						/datum/job/cyborg,
						)

/datum/job/assistant
	title = "Passager"
	supervisors = "tout le monde"
	minimal_player_age = 14
	economic_modifier = 3
	ideal_character_age = 21
	alt_titles = list(
		"Actionnaire",
		"Journaliste",
		"Visiteur",
		"Stagiaire",
		"Etudiant",
		)
	allowed_branches = list(
		/datum/mil_branch/administration,
		/datum/mil_branch/contractuel,
		/datum/mil_branch/ouvrier,
	)

/datum/job/captain
	title = "Directeur General"
	supervisors = "NanoTrasen et les Actionnaires"
	minimal_player_age = 41
	economic_modifier = 15
	ideal_character_age = 65
	alt_titles = list(
		"Directeur Executif",
		)
	outfit_type = /decl/hierarchy/outfit/job/dreyfus/directeur
	allowed_branches = list(
		/datum/mil_branch/administration
	)

/datum/job/hop
	title = "Directeur Adjoint"
	supervisors = "le Directeur General"
	minimal_player_age = 31
	economic_modifier = 12
	ideal_character_age = 45
	total_positions = 1
	spawn_positions = 1
	alt_titles = list(
		"Directeur R.H.",
		"Directeur Finances",
		)
	outfit_type = /decl/hierarchy/outfit/job/dreyfus/adjoint
	allowed_branches = list(
		/datum/mil_branch/administration
	)

/datum/job/employe
	title = "Secretaire"
	supervisors = "les Directeurs"
	minimal_player_age = 21
	economic_modifier = 8
	ideal_character_age = 30
	total_positions = 2
	spawn_positions = 2
	selection_color = "#6161aa"
	department_flag = COM
	department = "Command"
	alt_titles = list(
		"Gestionnaire",
		)
	outfit_type = /decl/hierarchy/outfit/job/dreyfus/employe
	allowed_branches = list(
		/datum/mil_branch/administration
	)
	announced = 1
	access = list(access_lawyer)
	minimal_access = list(access_lawyer)

/datum/job/liaison
	title = "Controleur de Gestion"
	supervisors = "Nanotrasen Industries"
	minimal_player_age = 21
	economic_modifier = 8
	ideal_character_age = 30
	total_positions = 1
	spawn_positions = 1
	selection_color = "#5151db"
	department_flag = COM
	department = "Command"
	outfit_type = /decl/hierarchy/outfit/job/dreyfus/controleur
	allowed_branches = list(
		/datum/mil_branch/administration
	)
	announced = 1
	access = list(access_lawyer)
	minimal_access = list(access_lawyer)

/datum/job/scientist
	title = "Technicien"
	supervisors = "le Contremaitre"
	minimal_player_age = 19
	economic_modifier = 8
	ideal_character_age = 30
	total_positions = 3
	spawn_positions = 3
	alt_titles = list(
		"Artificier",
		"Roboticien",
		)
	allowed_branches = list(
		/datum/mil_branch/contractuel
	)
	access = list(access_robotics, access_tox, access_tox_storage, access_research, access_xenobiology, access_xenoarch, access_robotics, access_teleporter)
	minimal_access = list(access_tox, access_tox_storage, access_research, access_xenoarch, access_robotics, access_teleporter) // Rajouter les téléscienecs

/datum/job/doctor
	selection_color = "#633d63"
	title = "Medecin"
	supervisors = "le Superviseur"
	minimal_player_age = 19
	economic_modifier = 8
	ideal_character_age = 30
	total_positions = 3
	spawn_positions = 3
	alt_titles = list(
		"Chirurgien",
		"Infirmier",
		"Biologiste",
		)
	allowed_branches = list(
		/datum/mil_branch/contractuel
	)

/datum/job/hos
	title = "Marshall"
	supervisors = "votre Compagnie"
	minimal_player_age = 19
	economic_modifier = 10
	ideal_character_age = 30
	total_positions = 1
	spawn_positions = 1
	alt_titles = list(
		"Responsable de la Securite",
		"Mercenaire",
		)
	allowed_branches = list(
		/datum/mil_branch/contractuel
	)
	outfit_type = /decl/hierarchy/outfit/job/dreyfus/marshall

/datum/job/officer
	title = "Adjoint"
	supervisors = "votre Compagnie et le Marshall"
	minimal_player_age = 19
	economic_modifier = 8
	ideal_character_age = 30
	total_positions = 1
	spawn_positions = 1
	alt_titles = list(
		"Agent de Securite",
		"Garde du Corps",
		)
	allowed_branches = list(
		/datum/mil_branch/contractuel
	)
	outfit_type = /decl/hierarchy/outfit/job/dreyfus/adjoint

/datum/job/trader
	selection_color = "#2e7c3c"
	title = "Courtier"
	supervisors = "l'Offre et la Demande"
	minimal_player_age = 16
	economic_modifier = 8
	ideal_character_age = 21
	total_positions = 1
	spawn_positions = 1
	alt_titles = list(
		"Negociant",
		"Trader",
		)
	allowed_branches = list(
		/datum/mil_branch/contractuel
	)
	access = list(access_maint_tunnels, access_mailsorting, access_trader)
	minimal_access = list(access_maint_tunnels, access_mailsorting, access_trader)
	outfit_type = /decl/hierarchy/outfit/job/dreyfus/trader

/datum/job/qm
	selection_color = "#3d3315"
	title = "Contremaitre"
	supervisors = "le Directeur General"
	minimal_player_age = 21
	economic_modifier = 7
	ideal_character_age = 30
	total_positions = 1
	spawn_positions = 2
	alt_titles = list(
		"Directeur de Production",
		"Coordinateur de Production",
		)
	allowed_branches = list(
		/datum/mil_branch/administration,
		/datum/mil_branch/contractuel,
		/datum/mil_branch/ouvrier,
	)

/datum/job/engineer
	title = "Ingenieur"
	supervisors = "le Contremaitre"
	minimal_player_age = 16
	economic_modifier = 5
	ideal_character_age = 21
	total_positions = 3
	spawn_positions = 3
	alt_titles = list(
		"Mecanicien",
		"Technicien Machinerie",
		)
	outfit_type = /decl/hierarchy/outfit/job/dreyfus/inge/inge
	allowed_branches = list(
		/datum/mil_branch/contractuel,
		/datum/mil_branch/ouvrier,
	)
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage, access_tcomsat)
	minimal_access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage, access_tcomsat)

/datum/job/mining
	selection_color = "#7c6a2e"
	title = "Mineur"
	supervisors = "le Contremaitre"
	minimal_player_age = 16
	economic_modifier = 2
	ideal_character_age = 21
	total_positions = 2
	spawn_positions = 2
	alt_titles = list(
		"Raffineur",
		"Technicien Minier",
		)
	allowed_branches = list(
		/datum/mil_branch/ouvrier
	)
	access = list(access_maint_tunnels, access_mailsorting, access_manufacturing, access_cargo, access_cargo_bot, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_mailsorting, access_manufacturing, access_cargo, access_cargo_bot, access_mining, access_mining_station)

/datum/job/cargo_tech
	selection_color = "#7c6a2e"
	title = "Manutentionnaire"
	supervisors = "le Contremaitre"
	minimal_player_age = 16
	economic_modifier = 2
	ideal_character_age = 21
	total_positions = 2
	spawn_positions = 2
	alt_titles = list(
		"Technicien Logistique",
		"Prepose au Fret",
		)
	allowed_branches = list(
		/datum/mil_branch/ouvrier
	)
	access = list(access_maint_tunnels, access_mailsorting, access_manufacturing, access_cargo, access_cargo_bot, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_mailsorting, access_manufacturing, access_cargo, access_cargo_bot, access_mining, access_mining_station)

/datum/job/ouvrier
	selection_color = "#7c6a2e"
	title = "Ouvrier de Production"
	supervisors = "le Contremaitre"
	minimal_player_age = 16
	economic_modifier = 2
	ideal_character_age = 21
	total_positions = 5
	spawn_positions = 5
	department_flag = SUP
	department = "Supply"
	alt_titles = list(
		"Faconneur",
		"Ouvrier Polyvalent",
		)
	outfit_type = /decl/hierarchy/outfit/job/dreyfus/ouvrier
	allowed_branches = list(
		/datum/mil_branch/ouvrier
	)
	announced = 1
	access = list(access_cargo, access_maint_tunnels)
	minimal_access = list(access_cargo, access_maint_tunnels)

/datum/job/cgt
	selection_color = "#7c2f2e"
	title = "Responsable Ouvrier"
	supervisors = "le Contremaitre"
	minimal_player_age = 16
	economic_modifier = 2
	ideal_character_age = 21
	total_positions = 5
	spawn_positions = 5
	department_flag = SUP
	department = "Supply"
	alt_titles = list(
		"Delegue Syndical",
		"Representant Ouvrier",
		)
	outfit_type = /decl/hierarchy/outfit/job/dreyfus/cgt
	allowed_branches = list(
		/datum/mil_branch/ouvrier
	)
	announced = 1
	access = list(access_cargo, access_maint_tunnels)
	minimal_access = list(access_cargo, access_maint_tunnels)

/datum/job/chef
	title = "Cuisinier"
	supervisors = "les Directeurs"
	minimal_player_age = 16
	economic_modifier = 4
	ideal_character_age = 21
	total_positions = 1
	spawn_positions = 1
	alt_titles = list(
		"Chef",
		)
	allowed_branches = list(
		/datum/mil_branch/ouvrier,
		/datum/mil_branch/contractuel,
	)

/datum/job/chaplain
	title = "Aumonier"
	supervisors = "les Directeurs"
	minimal_player_age = 21
	economic_modifier = 6
	ideal_character_age = 30
	total_positions = 1
	spawn_positions = 1
	alt_titles = list(
		"Psychologue",
		)
	allowed_branches = list(
		/datum/mil_branch/contractuel
	)

/datum/job/janitor
	title = "Concierge"
	supervisors = "le Contremaitre"
	minimal_player_age = 16
	economic_modifier = 2
	ideal_character_age = 21
	total_positions = 1
	spawn_positions = 1
	alt_titles = list(
		"Technicien de Surface",
		)
	allowed_branches = list(
		/datum/mil_branch/ouvrier
	)

/datum/job/cyborg
	title = "Cyborg"
	alt_titles = list(
		"Robot",
		"Android",
		)