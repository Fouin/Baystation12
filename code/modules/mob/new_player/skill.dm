var/const/SKILL_NONE = 0
var/const/SKILL_BASIC = 1
var/const/SKILL_ADEPT = 2
var/const/SKILL_EXPERT = 3

// Specific skill typepaths that won't show up on the skills panel.
// This is used to hide the category subtypes, without having to use special variable.
var/list/hidden_skill_types = list(\
	/datum/skill,\
	/datum/skill/secondary,\
	/datum/skill/security,\
	/datum/skill/engineering,\
	/datum/skill/research,\
	/datum/skill/medical\
	)


proc/setup_skills()
	if(SKILLS == null)
		SKILLS = list()
		for(var/T in (typesof(/datum/skill)-hidden_skill_types))
			var/datum/skill/S = new T
			if(S.ID != "none")
				if(!SKILLS.Find(S.field))
					SKILLS[S.field] = list()
				var/list/L = SKILLS[S.field]
				L += S

mob/living/carbon/human/proc/GetSkillClass(points)
	return CalculateSkillClass(points, age)

proc/show_skill_window(var/mob/user, var/mob/living/carbon/human/M)
	if(!istype(M)) return
	if(SKILLS == null)
		setup_skills()

	if(!M.skills || M.skills.len == 0)
		to_chat(user, "There are no skills to display.")
		return

	var/HTML = "<body>"
	HTML += "<b>Choisissez vos compétences</b><br>"
	HTML += "Niveau de compétence actuel: <b>[M.GetSkillClass(M.used_skillpoints)]</b> ([M.used_skillpoints])<br>"
	HTML += "<table>"
	for(var/V in SKILLS)
		HTML += "<tr><th colspan = 5><b>[V]</b>"
		HTML += "</th></tr>"
		for(var/datum/skill/S in SKILLS[V])
			var/level = M.skills[S.ID]
			HTML += "<tr style='text-align:left;'>"
			HTML += "<th>[S.name]</th>"
			HTML += "<th><font color=[(level == SKILL_NONE) ? "red" : "black"]>\[Inexperimenté\]</font></th>"
			// secondary skills don't have an amateur level
			if(S.secondary)
				HTML += "<th></th>"
			else
				HTML += "<th><font color=[(level == SKILL_BASIC) ? "red" : "black"]>\[Novice\]</font></th>"
			HTML += "<th><font color=[(level == SKILL_ADEPT) ? "red" : "black"]>\[Entraîné\]</font></th>"
			HTML += "<th><font color=[(level == SKILL_EXPERT) ? "red" : "black"]>\[Professionnel\]</font></th>"
			HTML += "</tr>"
	HTML += "</table>"

	user << browse(null, "window=preferences")
	user << browse(HTML, "window=show_skills;size=600x800")
	return

mob/living/carbon/human/verb/show_skills()
	set category = "IC"
	set name = "Show Own Skills"

	show_skill_window(src, src)


/datum/skill
    var/ID = "none"					// ID of this skill.
    var/name = "None" 				// Name of the skill. This is what the player sees.
    var/desc = "Placeholder skill" 	// Generic description of this skill.
    var/field = "Unset" 			// Category under which this skill will be listed.
    var/secondary = FALSE 			// Whether the skill is secondary. Secondary skills are cheaper and lack the Amateur level.

   	// Specific descriptions for specific skill levels.
    var/desc_unskilled = "Unskilled Descripton"
    var/desc_amateur = "Amateur Description"
    var/desc_trained = "Trained Description"
    var/desc_professional = "Expert Description"

/datum/skill/secondary
	field = "Secondaire"
	secondary = TRUE

/datum/skill/security
	field = "Défense"

/datum/skill/engineering
	field = "Ingénierie"

/datum/skill/research
	field = "Recherche"

/datum/skill/medical
	field = "Médecine"

var/global/list/SKILLS = null

// ONLY SKILL DEFINITIONS BELOW THIS LINE
// Category: Secondary

/datum/skill/secondary/management
    ID = "management"
    name = "Leadership"
    desc = "Votre abilité à gérer et donner des ordres à d'autres individus."
    desc_unskilled = "Vous ne savez presque rien en gestion, vous faites beaucoup d'erreurs et êtes inexperimenté. Vous perdez le fil des êvenements et des gens facilement. Gérer une crise est probablement au dessus de vos compétences."
    desc_trained = "Vous êtes un bon commandant. Vous êtes capable de coordonner un groupe de personnes pour un but commun de façon efficace. Vous serez probablement quand même sur la touche en cas de crise, mais vous allez y survivre."
	desc_professional = "Vous êtes un excellent commandant. En plus de savoir faire votre boulot, vous savez comment inspirer la passion, la loyauté et la peur, et savez gérer les crises de façon efficace."

/datum/skill/secondary/EVA
    ID = "EVA"
    name = "Activité Extra-Véhiculaire"
	desc = "Votre abilité à maintenir, utiliser des combinaisons spatiales et à travailler en l'absence de gravité."
	desc_unskilled = "Vous avez un entraînement de base commun à tout ceux qui travaillent sur une station : Vous savez comment enfiler et utiliser vos systèmes de survie, et vous êtes probablement capable de vous fourrer dans une combinaison spatiale si vous en avez vraiment besoin, bien que vous allez être maladroit. Vous êtes toujours capable de faire des erreurs qui vont vous faire respirer du vide."
	desc_trained = "Vous êtes à l'aise dans une combinaison spatiale, que vous utilisez souvent dans votre travail. Vérifier votre pression et votre air est une seconde nature pour vous, vous ne paniquez pas en cas d'urgence."
	desc_professional = "Vous êtes capable d'utiliser plusieurs types de combinaisons, même certaines versions spécialisées. Vous êtes formé à l'usage du jet pack et êtes aussi à l'aise à l'extérieur qu'à l'intérieur. Votre boulot implique probablement d'être presque tout le temps en SEV."

/datum/skill/secondary/law
    ID = "law"
    name = "Société"
	desc = "Votre connaissance des procédures légales et de la géopolitique. Cela inclut principalement la Déclaration des Droits des Sentients, et les lois dans l'espace de la République et de la Fédération. Une connaissance faible est typique des employés de l'administration, une connaissance elevée est typique des agents de sécurité."
	desc_unskilled = "Vous savez ce qui est légal ou pas dans votre vie de tout les jouers, bien que vous n'avez aucune idée de la portée des textes de lois, surtout si elle ne concerne pas votre travail."
	desc_trained = "Vous avez une connaissance des lois dans un sens pratique. Vous savez comment sont punis les crimes et vous pouvez comprendre un document de loi facilement. Vous êtes probablement un agent de sécurité ou un directeur."
	desc_professional = "Vous avez étudier la loi ou tout comme. Vous pouvez fabriquer des contrats, utiliser des failles légales et gérer des soucis entre particuliers. Vous avez une connaisance exhaustive de l'état de la géopolitique actuelle."

/datum/skill/secondary/botany
	ID = "botany"
	name = "Botanique"
	desc = "Votre abilité à faire pousser et à prendre soin des plantes."
	desc_unskilled = "Vous vous êtes déjà un peu occupé d'un jardin. Vous pouvez arroser, couper les mauvaises herbes, planter, récolter, et vous savez reconnaître les vermines. Il est possible que ce soit un hobby pour vous."
	desc_trained = "Vous êtes un botaniste ou un fermier, peut-être que vous faites pousser des plantations à grande échelle ou avez déjà pris part à de la recherche otanique. Vous connaissez les bases de la selection des gênes pour des plantations.
	desc_professional = "Vous êtes spécialisé en botanique. Vous êtes capable de prendre soin des spécimens de plantes les plus éxotiques, fragiles ou dangereux. Vous disposez des connaissances et de la méthode pour créer des hybrides ou manipuler les gênes des plantes."

/datum/skill/secondary/cooking
	ID = "cooking"
	name = "Cuisine"
	desc = "Vos compétenes en matière de préparation de repas et autres consommables. Cela inclut la préparation de mélanges à base d'alcool."
	desc_unskilled = "Vous savez préparer des repas simples et faire à manger pour votre famille. Des trucs comme les spaghettis, du fromage grillé ou des mélanges simples sont généralement à votre portée."
	desc_trained = "Vous savez cuisiner à grande échelle, et garder un équipage entier bien nourri. Vos repas sont bons et vous n'avez aucuns problème avec les recettes compliquées. Vous pouvez préparer la plupart des boissons souvent servies."
	desc_professional = "Non seulement vous savez très bien cuisiner et préparer des cocktails d'excellente facture, mais vous savez très bien gérer un groupe de cuisinier et préparer des repas pour des occasions spéciales. Vous êtes probablement renommé ou recompensé."

/datum/skill/secondary/barter
	ID = "barter"
	name = "Troc"
	desc = "Votre abilité à commercer, à connaître la valeur des choses et à être au courant des fluctuations du marché."
	desc_unskilled = "Vous connaissez la valeur de votre salaire et de la plupart des objets de votre quotidien. Vous ne savez pas exactement ce qui signifie l'offre et la demande, mais vous le vivez plutot bien."
	desc_trained = "Vendre des objets est votre métier. Vous êtes renseigné sur la valeur des produits qui composent votre stock. Vous avez l'expérience de la négociation et seriez probablement capable de faire passer une babiole pour une antiquité."
	desc_professional = "Vous êtes passé maître dans l'art de vendre les choses plus que ce qu'elles valent. Vous êtes très bien renseigné sur le cours de la Bourse. Vous êtes probablement un actionnaire."


// Category: Security

/datum/skill/security/combat
	ID = "combat"
	name = "Corps à Corps"
	desc = "Votre abilité au pugilat et à l'utilisation d'arme de corps à corps. Bien que la maîtrise du combat rapproché devient rare à l'époque des armes à feu, les maîtres existent toujours parmis les athlètes."
	desc_unskilled = "Vous savez mettre un coup de poing ou un coup de pied, mais fort à parier que ça vous ferez perdre l'équilibre. Vous n'êtes pas entraîné et vous n'avez probablement jamais pris part à un vrai combat. Dans un combat, il est plus probable que vous mettiez à paniquer et courrir, ou que vous attrapiez un objet au hasard pour battre l'air avec."
	desc_amateur = "Soit vous avez un peu d'expérience en bagarre, soit vous avez suivi un entraînement aux art martiaux. Vous êtes capable de vous protéger en dernier recours, et si vous êtes un agent de sécurité, vous savez tenir une matraque suffisament bien pour pouvoir coffrer un criminel."
	desc_trained = "Vous êtes un bon combattant. Vous avez suivi un entraînement rigoureux au combat et faites probablement partie d'une unité de police ou miltiaire. Vous avez l'habitude des armes et êtes capable de réfléchir stratégiquement durant un combat. Vous êtes en bonne forme physique et vous passez du temps à vous entraîner."
	desc_professional = "Vous êtes spécialisé en combat rapproché. Vous maîtriser un ou plusieurs arts martiaux. Vous êtes en excellente forme physique et passez beaucoup de temps à vous entraîner. La plupart de vos ennemis ne peuvent pas vous résister avec une arme dans les mains. Vous êtes peut-être un athlète connu ou un membre des forces spéciales."

/datum/skill/security/weapons
	ID = "weapons"
	name = "Armement"
	desc = "Votre connaissance des armes et de leur utilisation. Un niveau faible implique une connaissance des armes simples, comme les flashs. Un haut niveau impliqué une connaissance des armes complexes,  comme des grenades spécialisés, des équipements anti-émeutes, des armes à énergie ou des bombes. Un niveau moyen est typique d'un agent de sécurité, un niveau elevé d'un soldat ou d'un mercenaire."
	desc_unskilled = "Vous savez reconnaître une arme quand vous en voyez une. Vous êtes capable d'utiliser un spray au poivre ou un flash, de façon un peu laborieuse tout de même. Il est probable que vous vous tiriez dans le pied par erreur ou oubliez de désactiver la sécurité de votre arme. Votre manque d'entraînement vous rends plus dangereux pour vos alliés que pour vos ennemis."
	desc_amateur = "Vous savez comment utiliser une arme en toute sécurité, et vous n'avez pas trop de problèmes avec les armes simples. Votre visée est correct et on peut vous faire confiance pour ne rien faire de stupide avec une arme. Cependant vos réflexes ne sont pas devenus automatiques et il est possible que vos performances se dégrandent dans une situation stressante."
	desc_trained = "Vous avez déjà utilisé des armes dans des situations compliquées, et les réflexes de bases sont devenus comme une seconde natur epour vous. Vous vous entraînez beaucoup au stand de tir. Votre visée est bonne. Vous êtes capable de réparer et d'entretenir vos armes. Vous avez probablement une expérience militaire ou policière et portez sans doute une arme pour votre travail."
	desc_professional = "Vous êtes un tirreur exceptionnel avec toutes sortes d'armes, des plus simples aux plus éxotiques. Non seulement vous êtes capable de faire mouche à coup sûr, mais vous êtes aussi capable de viser une partie spécifique d'une cible, comme les jambes d'un ennemi qui s'enfuit. Votre arme est comme une extension de votre corps. Vous êtes probablement un tireur d'élite.  Vous connaissez votre lot de tactiques, et vous êtes capable de concevoir ou de modifier votre armement."

/datum/skill/security/forensics
	ID = "forensics"
	name = "Enquête"
	desc = "Votre abilité à appliquer les procédures criminalistiques de base et à identifier des indices. Ne concerne pas votre capacité d'analyse, et donc n'est pas totalement indicatif de votre aptitude à enquêter. Pour procéder à une autopsie, des compétences en chirurgie sont également requises."
	desc_unskilled = "Vous savez que les enquêteurs résolvent des affaires. Vous vous doutez peut-être que c'est pas bien de contaminer une scène de crimes, mais vous n'avez aucune idée des détails techniques."
	desc_amateur = "Vous savez comment ne pas contaminer une scène de crime. Vous savez comment utiliser les outils les plus évidents (scanner, bases de données), et vous êtes capable de mener un interrogatoire."
	desc_trained = "Vous êtes un agent de police, un légiste ou un détective. Vous savez sécurisert une scéne de crime, récolter des indices, interroger  des témoins, et connecter les indices pour mener à une arrestation. Si vous avez des compétences en anatomie, vous pouvez effectuer une autopsie."
	desc_professional = "Vous êtes spécialisé en criminalistique. Vos abilités à récolter et analyser des indices ont été forgés par des études longues ou des années de pratiques, souvent les deux. Vous êtes capable de retrouver un suspect ou de leur tendre un piège.  Bien que vous agissez dans l'ombre et n'avez probablement jamais vu le criminel, votre expérience est ce qui fait la différence entre un crime non-résolu et un homme derrière les barreaux."

// Category: Engineering

/datum/skill/engineering/construction
    ID = "construction"
    name = "Construction"
    desc = "Votre capacité à bâtir des constructions variées, comme des murs, des sols, des tables, etc. Notez que construire des appareils tels que des APCs requiert également des compétences en électronique. Un niveau faible dans cette compétence est typique des concierges, un niveau élevé est typique des ingénieurs."
    desc_unskilled = "Vous pouvez déplacer le mobilier, monter ou démonter des chaises et des tables, casser une vitre, ouvrir une caisse, ou forcer une porte qui n'est plus alimentée. Vous pouvez reconnaitre et utiliser des outils basiques et les murs gonflable, mais pas facilement."
    desc_amateur = "Vous pouvez démonter ou construire un mur ou une fenêtre, construire du mobilier, redécorer une pièce et remplacer le sol. Vous savez vous servir d'un soudeur en toute sécurité sans vous brûler les yeux, et vous avez l'habitude d'utiliser toutes sortes d'outils."
    desc_trained = "Vous savez réparer une brèche, reconstruire la tuyauterie endommagée et réparer les dégâts majeurs. Vous connaissez les bases de l'ingénierie structurelle."
    desc_professional = "Vous êtes un ingénieur ou un ouvrier de chantier. Si on vous donnait les matériaux, vous pourriez reconstruire toute l'installation à partir de rien. Vous êtes efficace et compétent pour réparer les dégâts."

/datum/skill/engineering/electrical
    ID = "electrical"
    name = "Électronique"
    desc = "Votre connaissance de l'électronique et de la physique sous-jacente. Un niveau faible implique vous savez brancher un cable ou intéragir avec un disjoncteur, un niveau elevé est requis pour travailler sur des installations électriques complexes comme des circuits ou des robots"
    desc_unskilled = "Vous savez que les cables électriques, c'est dangereux, et que se faire électriser est rarement une bonne chose ; vous êtes capable de reconnaître et de signaler des installations endommagées. Vous êtes capable de changer une ampoule ou de remplacer une batterie."
    desc_amateur = "Vous êtes capable des câblages de base ; vous êtes capable de brancher les panneaux solaires ou le moteur. Vous êtes capable de réparer un cable endommagé ou de construire des installations simples comme des APCs ou des luminaires. Vous connaissez la base des circuits imprimés et vous savez comment vous protéger des électrocutions. Avec de l'aide, vous pouvez probablement pirater une machine à café."
    desc_trained = "Vous savez réparer ou brancher toutes sortes d'équipements et vous le faites tout les jours. Vous pouvez faire le diagnostic de systèmes électriques et surveiller l'état de la grille. Vous savez probablement pirater un sas."
    desc_professional = "Vous êtes un électricien ou équivalent. Vous pouvez conçevoir, améliorer ou modifier des installations électriques et maximiser le rendement. Vous savez tout pirater et êtes formé à gérer des pannes rapidement."

/datum/skill/engineering/atmos
    ID = "atmos"
    name = "Systèmes de Survie"
    desc = "Vos connaissances de la plomberie, de la distribution d'air et de la mécanique des fluides."
    desc_unskilled = "Vous savez que quand l'alarme est orange, l'air est mauvais, et quand il est rouge, il est mortel. Vous savez qu'une lumière qui clignote sur une porte coupe-feu veut dire danger de l'autre coté. Vous savez que certains gazs sont dangereux, que la pression aussi, et que la plupart des trucs vivants ont besoin d'oxygène pour vivre. Vous savez utiliser un extincteur ou un mur gonflable."
    desc_amateur = "Vous savez comment lire un scan atmosphérique, comment utiliser une pompe à air et comment sceller une brèche. Vous pouvez poser une tuyauterie et travailler avec des bouteilles de gaz. Vous savez comment vous servir d'un extincteur et vous savez placer des murs gonflables de façon à ce qu'ils forment des périmètres de sécurité."
    desc_trained = "Vous êtes capable de mettre en route et modifier les Systèmes de Survie. Vous savez comment surveiller la qualité de l'air à travers toute l'installation, détecter les problèmes, et les régler. Vous avez été formé à la lutte contre le feu, les brèches, les fuites de gaz, et probablement aussi à l'utilisation des exosuits et à l'équipement de lutte contre les flammes."
    desc_professional = "Vous êtes un spécialiste des systèmes de survies. Vous surveillez, modifiez et optimisez naturellement les installations atmosphériques, et vous êtes capable de gérer rapidement et efficacement les situations d'urgences. Vous pouvez modifier les systèmes de survie comme bon vous semble.  Vous luttez facilement contre les flammes et les brèches, et avez l'habitude d'établir des périmètres de sécurité et de secourir les civils, mais vous préférez l'idée d'empêcher ce type de situation en premier lieu."

/datum/skill/engineering/engines
	ID = "engines"
	name = "Générateurs""
	desc = "Vos connaissances des différents types de moteurs à bord des stations spatiales et leur utilisation."
	desc_unskilled = "Vous savez que \"radiations"\ est quelque chose de pas cool et que vous devez probablement vous tenir loin des trucs qui brillent en bleu. Vous save qu'un générateur crée de la puissance, mais vous ne savez pas forcément l'expliquer. Si on devait vous demander de brancher le moteur, quelqu'un devrait vous guider pour chaque étape, et même avec ça il est probable que vous fassiez une erreur fatale."
	desc_amateur = "Vous connaissez les bases théoriques du fonctionnement d'un moteur. Vous pouvez essayer d'allumer le moteur par vous même, mais vous allez avoir besoin d'aide ou de supervision, ou vous allez faire des erreurs."
	desc_trained = "Vous pouvez monter le générateur, et ne pas trop l'endommager. Vous connaissez les risques et la façon de se protéger des radiations. Vous savez lire les informations du moteur et le garder allumer. Vous avez une connaissance exhaustive des types de moteurs auxquels vous avez été confronté. Une panne pourrait vous laisser perplexe, mais il est probable que vous soyez capable de la réparer… en espérant que vous soyez capable de le faire suffisament vite pour éviter trop de dégâts."
	desc_professional = "Le moteur est votre bébé. Vous connaissez chaque détails de son fonctionnement. Vous pouvez l'optimiser et avez probablement une version personnalisée que vous préférez. Vous seriez capable de monter un générateur à partir de pièces détachées. Quand les choses sont hors de contrôle, vous savez exactement ce qui c'est passé et comment régler le problème."

/datum/skill/engineering/mech
    ID = "mech"
    name = "Équipement Lourd"
    desc = "Votre expérience et vos connaissance de l'utilisation des équipements lourds, tels que les mechas et autres exosuits lourds. "
    desc_unskilled = "Vous savez ce qu'est un mecha et à quoi ca sert, et vous serez probablement capable d'identifier un type de mecha en particulier. Si votre département en utilise, vous savez de quoi ils sont capables. Si vous deviez être aux commandes, il y'a une chance sur deux que vous arriviez à faire un pas dans la direction que vous voulez."
    desc_amateur = "Vous êtes capable de conduire un mecha, mais vous êtes bien spécialisé dans un seul type que votre département utilise régulièrement. Vous n'êtes pas un expert et pouvez vous perdre dans les commandes, mais vous allez là où vous voulez aller et vous savez la signification de la majorité des boutons. Si vous êtes un mineur vous savez mettre en route votre perceuse ; si vous avez les compétences nécessaires en électronique, vous êtes probablement capable de monter un générateur de bouclier ou un laser."
    desc_trained = "Vous êtes très à l'aise avec le type d'exosuit que vous utilisez régulièrement. Vous passez probablement la majorité de votre relève à l'utiliser, et connaissez ses fonctions. Vous êtes capable de faire la maintenance de base. Vous savez utiliser la majorité des exosuits, sauf ceux particulièrement rares ou spécialisés. Si vous êtes électricien ou ingénieur, vous savez mettre en place un générateur de bouclier tout seul. Les mineurs à ce niveau peuvent utiliser la perceuse sans aucun problème."
    desc_professional = "Vous pouvez utiliser tout les types de mechas sans problèmes ni contraintes. Pour vous, un mecha est comme une seconde peau. Vous savez les entretenir, les réparer, et probablement aussi les construire."

/datum/skill/engineering/pilot
    ID = "pilot"
    name = "Pilotage"
    desc = "Votre expérience et compréhension du pilotage du vaisseau et de la physique des technologies FTL, de la petite navette jusqu'à la corvette de combat."
    desc_unskilled = "Vous savez ce qu'est un vaisseau, et vous avez probablement une vague connaissance des différences entre chaque type de navette. Si votre département est impliqué dans l'utilisation de véhicules spatiaux, vous savez de quoi ils sont capables. Vous serez probablement capable d'en piloter un dans un jeu-vidéo. Si on vous donnez le contrôle d'un petit vaisseau, vous seriez peut être capable de le piloter avec un peu d'aide."
    desc_amateur = "Vous pouvez piloter un petit vaisseau courte portée en toute sécurité, mais les grands vaisseaux sont au delà de vos capacités. Vous n'êtes pas du tout un expert et n'avez aucun entraînement."
    desc_trained = "Vous êtes un pilote entraîné, vous êtes formé à l'utilisation des petits appareils civils et militaires. Vous pouvez piloter un vaisseau sur de longues sessions, et vous êtes au courrant des spécificités techniques des différents vaisseaux. Vous êtes capable de faire de la maintenance de base et de procéder à des manoevres simples. Vous pouvez utiliser les armes d'un vaisseau. Vous pouvez faire des calculs orbitaux simples. Un niveau typique des nouveaux pilotes."
    desc_professional = "Vous êtes un pilote chevronné.  Vous vivez probablement dans le vaisseau que vous pilotez, et vous savez tout ce qu'il y'a à savoir sur le voyage spatial. Non seulement vous savez piloter avec aisance, mais vous êtes capable de manoevres complexes, et de procéder à des calculs orbitaux très avancé. Ce niveau est typique des pilotes militaires. Vous avez reçu un entraînement particulier."

// Category: Research

/datum/skill/research/devices
    ID = "devices"
    name = "Dispositifs Complexes"
    desc = "Décrit la capacité d'assembler des dispositifs complexes, tels que des ordinateurs, des circuits, des imprimantes, des robots ou des assemblages de réservoirs de gaz (bombes). Notez que si un dispositif nécessite de l'éléctronique ou de la programmation, ces compétences sont également requises en plus de cette dernière."
    desc_unskilled = "Vous savez comment utiliser la technologie présente dans la société ou vous avez grandi. Vous pouvez voir quand quelque chose ne fonctionne pas, mais vous devez appeller le support technique pour le faire réparer."
    desc_amateur = "Vous utilisez et réparez de l'équipment high-tech au cours de votre travail quotidien. Vous pouvez régler des problèmes simples, et savez comment utiliser une imprimante de circuits ou un autolathe. Vous pouvez construire des robots simples tels que des medibots ou cleanbots. Si vous avez des connaissances médicales ou éléctriques pertinantes, vous pouvez réparer une prothèse ou un organe artificiel; sionon, ces objets sont au delà de vos capacités"
    desc_trained = "Vous pouvez construire ou réparer une exosuit oun chassis de cyborg, utiliser un protolathe et un analyseur destructif, et construire des prothèses. Vous pouvez transférer une MMI ou un cerveau positronique dans un chassis de cyborg en toute sécurité."
    desc_professional = "Vous êtes un inventeur, un chercheur ou un anomaliste. Vous pouvez concevoir, construire, et modifier des équipments dont la plupart des gens ne connaissent même pas l'existence. Vous êtes chez vous dans un labo ou un atelier et vous n'êtes jamais tombé sur un gadget que vous ne pouviez pas démonter, remonter, et répliquer."

/datum/skill/research/computer
    ID = "computer"
    name = "Informatique"
    desc = "Décrit votre compréhension des ordinateurs, logiciels et réseaux. Non requis pour utiliser des ordinateurs, mais aide certainement. Utilisé dans les télécommunications et la programmation d'ordinateurs et IA."
    desc_unskilled = "Vous savez comment utiliser les ordinateurs et appareils de communication avec lesquels vous avez grandi. Vous pouvez utiliser une console, une radio portable ou murale, et votre casque ainsi que votre PDA. Vous savez ce qu'est une IA, mais vous les voyez comme \"des gens faits en silicone\" ou \"des simples machines\"; vous savez qu'elles doivent obéir à leur lois, mais ne savez pas grand chose à propos de comment ou pourquoi elles travaillent."
    desc_amateur = "Vous connaissez les bases de la programmation, mais vous n'y êtes pas très bon et ne pourriez pas en faire professionnelement. Vous avez une petite idée de comment les IA fonctionnent. Vous comprenez comment les informations sont stockées dans un ordinateur et vous pouvez régler les problèmes d'ordinateurs simples. Vous vous y connaissez en ordinateur, mais faites toujours des erreurs. Si vous essayiez de changer l'IA, vous pourriez faire des erreurs en formulant vos nouvelles lois."
    desc_trained = "A ce niveau, vous travaillez probablement avec des ordinateurs de manière quotidiennet. Vous comprenez et pouvez réparer le réseau de  télécommunications. Votre compréhension de la programmation et de la technologie des IA vous permet de régler des problèmes avec ces dernières ou avec des cyborgs--ou en créer, si vous les désirez. Vous pouvez programmer des ordinateurs et IA et changer leurs lois efficacement."
    desc_professional = "Les gens commencent à se demander si vous n'êtes pas un ordinateur vous-même. Le code informatique est vore premier langage; vous relativisez avec les IA aussi facilement que (probablement plus facilement qu'avec) les organiques. Vous pourriez mettre en place un réseau de télécommunications de zéro."

/datum/skill/research/science
	ID = "science"
	name = "Sciences"
	desc = "Votre éxpérience et connaissance des méthodes et procédés scientifiques."
	desc_unskilled = "Vous savez ce qu'est la science et avez probablement une vague idée de la méthode scientifiques grâce à vos cours de science au lycée."
	desc_amateur = "Vous vous tenez à jour avec les découvertes scientifiques. Vous vous y connaissez un petit peu avec tous les champs de recherche. Vous avez appris des compétences de laboratoire basiques. Vous vous informez peut-être par hobby; ou vous travaillez dans un domaine en rapport avec la science et avez appris de cette manière. Vous pouvez concevoir une expérience simple."
	desc_trained = "Vous êtes un scientifique, peut-être un étudiant ou un chercheur diplômé. Vous pouvez concevoir une expérience, analyser vos résultats, publier ces données, et fusionner ce que vous avez appris avec les recherches d'autres scientifiques. Vos capacités en laboratoire sont fiables, et vous savez comment trouver une information dont vous besoin quand vous recherchez un nouevau sujet scientifique."
	desc_professional = "Vous êtes un chercheur professionnel et avez fait de nombreuses découvertes dans votre domaine. Vos expériences sont bien conçues. Vous êtes connu comme une autorité dans votre spécialité et vos articles apparaissent fréquemment dans de prestigieuses publications. Vous pouvez diriger les efforts de recherche d'une équipe de scientifiques."


// Category: Medical

/datum/skill/medical/medical
    ID = "medical"
    name = "Médecine"
    desc = "Covers an understanding of the human body and medicine. At a low level, this skill gives a basic understanding of applying common types of medicine, and a rough understanding of medical devices like the health analyzer. At a high level, this skill grants exact knowledge of all the medicine available on the installation, as well as the ability to use complex medical devices like the body scanner or mass spectrometer."
    desc_unskilled = "You know basic first aid, such as how to apply a bandage or ointment to an injury. You can use an autoinjector designed for civilian use, probably by reading the directions printed on it. You can tell when someone is badly hurt and needs a doctor; you can see whether someone has a badly broken bone, is having trouble breathing, or is unconscious. You may not be able to tell the difference between unconscious and dead."
    desc_amateur = "You've taken a first-aid training, nursing, or EMT course. You can stop bleeding, do CPR, apply a splint, take someone's pulse, apply trauma and burn treatments, and read a handheld health scanner. You probably know that Dylovene helps poisoning and Dexalin helps people with breathing problems; you can use a syringe or start an IV. You've been briefed on the symptoms of common emergencies like a punctured lung, appendicitis, alcohol poisoning, or broken bones, and though you can't treat them, you know that they need a doctor's attention. You can recognize most emergencies as emergencies and safely stabilize and transport a patient."
    desc_trained = "You are an experienced EMT or experienced nurse, a medical resident, or a doctor. You know how to treat most illnesses and injuries, though exotic illnesses and unusual injuries may still stump you. You have probably begun to specialize in some sub-field of medicine. In emergencies, you can think fast enough to keep your patients alive, and even when you can't treat a patient, you know how to find someone who can. You probably have some skill in genetics, virology, and surgery, if only to the extent of being able to create an antibody, do a cloning scan, or assist a surgeon in the operating room. You can use a full-body scanner, and you know something's off about a patient with an alien parasite or cortical borer."
    desc_professional = "You are an experienced doctor. You've seen almost everything there is to see when it comes to injuries and illness and even when it comes to something you haven't seen, you can apply your wide knowledge base to put together a treatment. In a pinch, you can do just about any medicine-related task, but your specialty, whatever it may be, is where you really shine."

/datum/skill/medical/anatomy
    ID = "anatomy"
    name = "Anatomie"
    desc = "Gives you a detailed insight of the human body. A high skill in this is required to perform surgery. This skill may also help in examining alien biology."
    desc_unskilled = "You know what organs, bones, and such are, and you know roughly where they are. You know that someone who's badly hurt or sick may need surgery."
    desc_amateur = "You've taken an anatomy class and you've spent at least some time poking around inside actual people. You know where everything is, more or less. You could assist in surgery, if you have the required medical skills. If you have the forensics knowledge, you could perform an autopsy. If you really had to, you could probably perform basic surgery such as an appendectomy, but you're not yet a qualified surgeon and you really shouldn't--not unless it's an emergency. If you're a xenobiologist, you know how to take out slime cores."
    desc_trained = "You're a surgical resident, or an experienced medical doctor. You can put together broken bones, fix a damaged lung, patch up a liver, or remove an appendix without problems. But tricky surgeries, with an unstable patient or delicate manipulation of vital organs like the heart and brain, are at the edge of your ability, and you prefer to leave them to specialized surgeons. You can recognize when someone's anatomy is noticeably unusual. You're trained in working with several species, but you're probably better at surgery on your own species."
    desc_professional = "You are an experienced surgeon. You can handle anything that gets rolled, pushed, or dragged into the OR, and you can keep a patient alive and stable even if there's no one to assist you. You can handle severe trauma cases or multiple organ failure, repair brain damage, and perform heart surgery. By now, you've probably specialized in one field, where you may have made new contributions to surgical technique. You can detect even small variations in the anatomy of a patient--even a changeling probably wouldn't slip by your notice, provided you could get one on the operating table."

/datum/skill/medical/virology
    ID = "virology"
    name = "Virologie"
    desc = "This skill implies an understanding of microorganisms and their effects on humans."
    desc_unskilled = "You know that diseases are contagious; you've probably heard you should wash your hands to stop their spread. You know that if you're sick, you can go to Medical and get treatment."
    desc_amateur = "You know how viruses work, and you can use the machinery in the virology lab to analyze a virus or create an antibody. You know the principles of quarantine and you know how to keep a virus from spreading. You know that spaceacillin will help the body fight off a virus. However, you're not specialized in virology, and you probably don't have a whole lot of experience in dealing with viruses. If you are a medical doctor, you know how to treat symptoms and keep sick patients stable."
    desc_trained = "You know how to analyze, modify, and cure viruses, and could probably do so even without most of the equipment in the virology lab. You know how to trigger mutations in a virus and how to isolate genes. If you really wanted to, you could create a deadly virus, provided you got lucky with the mutations."
    desc_professional = "You are a specialized virologist - either a medical doctor or a scientific researcher. You may be well-known in the field, having published in prestigious journals; or you may be a mad scientist working away in secret. You know how to use a virus as a tool or a weapon. You can cure any epidemic and if you wanted to, you could start one so deadly and contagious that your targets wouldn't know what hit them."

/datum/skill/medical/chemistry
	ID = "chemistry"
	name = "Chimie"
	desc = "Expérience avec des mélanges de produits chimique, et une recherche des effets qu'ils auront. Cela ne concerne pas la compréhension des effets des produits chimiques sur le corps humain, en tant que tel, des compétences médicales sont également nécessaires pour les chimistes médicaux"
	desc_unskilled = "Vous savez que les chimistes travaillent avec des produits chimique; vous savez aussi qu'ils peuvent faire des médicaments, du poison ou des produits très utile. Vous connaissez probablement quelques élements et vous avez quelques souvenir de réaction chimique qui datent de vos cours de chimie au lycée."
	desc_amateur = "Vous savez faire les bases au niveau de la chimie et des médicaments.. Des trucs comme du "Space-Cleaner" et de "l'anti-poison".Vous avez fais une formation pour la sécurité et vous n'exploserez pas le labo .. Normalement."
	desc_trained = "Vous travaillez comme chimiste, ou alors vous êtes un docteur avec une formation en chimie. Si vous êtes un chercheur en chimie, vous pouvez créer de puissante solution; si vous êtes pharmaciens, vous pouvez faire plus de médicaments. A ce stade, vous travaillez plus "by the book". Vous pouvez "armer" vos produits pour en faire des grenades, des fumigènes et des dispositifs similaires  "
	desc_professional = "Vous vous êtes spécialisés dans la chimie ou dans la pharmaceutique. Vous êtes soit un chercheur en médecine ou un professionel en chimie."