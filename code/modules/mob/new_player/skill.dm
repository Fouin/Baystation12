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
	HTML += "<b>Choisissez vos comp�tences</b><br>"
	HTML += "Niveau de comp�tence actuel: <b>[M.GetSkillClass(M.used_skillpoints)]</b> ([M.used_skillpoints])<br>"
	HTML += "<table>"
	for(var/V in SKILLS)
		HTML += "<tr><th colspan = 5><b>[V]</b>"
		HTML += "</th></tr>"
		for(var/datum/skill/S in SKILLS[V])
			var/level = M.skills[S.ID]
			HTML += "<tr style='text-align:left;'>"
			HTML += "<th>[S.name]</th>"
			HTML += "<th><font color=[(level == SKILL_NONE) ? "red" : "black"]>\[Inexperiment�\]</font></th>"
			// secondary skills don't have an amateur level
			if(S.secondary)
				HTML += "<th></th>"
			else
				HTML += "<th><font color=[(level == SKILL_BASIC) ? "red" : "black"]>\[Novice\]</font></th>"
			HTML += "<th><font color=[(level == SKILL_ADEPT) ? "red" : "black"]>\[Entra�n�\]</font></th>"
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
	field = "D�fense"

/datum/skill/engineering
	field = "Ing�nierie"

/datum/skill/research
	field = "Recherche"

/datum/skill/medical
	field = "M�decine"

var/global/list/SKILLS = null

// ONLY SKILL DEFINITIONS BELOW THIS LINE
// Category: Secondary

/datum/skill/secondary/management
    ID = "management"
    name = "Leadership"
    desc = "Votre abilit� � g�rer et donner des ordres � d'autres individus."
    desc_unskilled = "Vous ne savez presque rien en gestion, vous faites beaucoup d'erreurs et �tes inexperiment�. Vous perdez le fil des �venements et des gens facilement. G�rer une crise est probablement au dessus de vos comp�tences."
    desc_trained = "Vous �tes un bon commandant. Vous �tes capable de coordonner un groupe de personnes pour un but commun de fa�on efficace. Vous serez probablement quand m�me sur la touche en cas de crise, mais vous allez y survivre."
	desc_professional = "Vous �tes un excellent commandant. En plus de savoir faire votre boulot, vous savez comment inspirer la passion, la loyaut� et la peur, et savez g�rer les crises de fa�on efficace."

/datum/skill/secondary/EVA
    ID = "EVA"
    name = "Activit� Extra-V�hiculaire"
	desc = "Votre abilit� � maintenir, utiliser des combinaisons spatiales et � travailler en l'absence de gravit�."
	desc_unskilled = "Vous avez un entra�nement de base commun � tout ceux qui travaillent sur une station : Vous savez comment enfiler et utiliser vos syst�mes de survie, et vous �tes probablement capable de vous fourrer dans une combinaison spatiale si vous en avez vraiment besoin, bien que vous allez �tre maladroit. Vous �tes toujours capable de faire des erreurs qui vont vous faire respirer du vide."
	desc_trained = "Vous �tes � l'aise dans une combinaison spatiale, que vous utilisez souvent dans votre travail. V�rifier votre pression et votre air est une seconde nature pour vous, vous ne paniquez pas en cas d'urgence."
	desc_professional = "Vous �tes capable d'utiliser plusieurs types de combinaisons, m�me certaines versions sp�cialis�es. Vous �tes form� � l'usage du jet pack et �tes aussi � l'aise � l'ext�rieur qu'� l'int�rieur. Votre boulot implique probablement d'�tre presque tout le temps en SEV."

/datum/skill/secondary/law
    ID = "law"
    name = "Soci�t�"
	desc = "Votre connaissance des proc�dures l�gales et de la g�opolitique. Cela inclut principalement la D�claration des Droits des Sentients, et les lois dans l'espace de la R�publique et de la F�d�ration. Une connaissance faible est typique des employ�s de l'administration, une connaissance elev�e est typique des agents de s�curit�."
	desc_unskilled = "Vous savez ce qui est l�gal ou pas dans votre vie de tout les jouers, bien que vous n'avez aucune id�e de la port�e des textes de lois, surtout si elle ne concerne pas votre travail."
	desc_trained = "Vous avez une connaissance des lois dans un sens pratique. Vous savez comment sont punis les crimes et vous pouvez comprendre un document de loi facilement. Vous �tes probablement un agent de s�curit� ou un directeur."
	desc_professional = "Vous avez �tudier la loi ou tout comme. Vous pouvez fabriquer des contrats, utiliser des failles l�gales et g�rer des soucis entre particuliers. Vous avez une connaisance exhaustive de l'�tat de la g�opolitique actuelle."

/datum/skill/secondary/botany
	ID = "botany"
	name = "Botanique"
	desc = "Votre abilit� � faire pousser et � prendre soin des plantes."
	desc_unskilled = "Vous vous �tes d�j� un peu occup� d'un jardin. Vous pouvez arroser, couper les mauvaises herbes, planter, r�colter, et vous savez reconna�tre les vermines. Il est possible que ce soit un hobby pour vous."
	desc_trained = "Vous �tes un botaniste ou un fermier, peut-�tre que vous faites pousser des plantations � grande �chelle ou avez d�j� pris part � de la recherche otanique. Vous connaissez les bases de la selection des g�nes pour des plantations.
	desc_professional = "Vous �tes sp�cialis� en botanique. Vous �tes capable de prendre soin des sp�cimens de plantes les plus �xotiques, fragiles ou dangereux. Vous disposez des connaissances et de la m�thode pour cr�er des hybrides ou manipuler les g�nes des plantes."

/datum/skill/secondary/cooking
	ID = "cooking"
	name = "Cuisine"
	desc = "Vos comp�tenes en mati�re de pr�paration de repas et autres consommables. Cela inclut la pr�paration de m�langes � base d'alcool."
	desc_unskilled = "Vous savez pr�parer des repas simples et faire � manger pour votre famille. Des trucs comme les spaghettis, du fromage grill� ou des m�langes simples sont g�n�ralement � votre port�e."
	desc_trained = "Vous savez cuisiner � grande �chelle, et garder un �quipage entier bien nourri. Vos repas sont bons et vous n'avez aucuns probl�me avec les recettes compliqu�es. Vous pouvez pr�parer la plupart des boissons souvent servies."
	desc_professional = "Non seulement vous savez tr�s bien cuisiner et pr�parer des cocktails d'excellente facture, mais vous savez tr�s bien g�rer un groupe de cuisinier et pr�parer des repas pour des occasions sp�ciales. Vous �tes probablement renomm� ou recompens�."

/datum/skill/secondary/barter
	ID = "barter"
	name = "Troc"
	desc = "Votre abilit� � commercer, � conna�tre la valeur des choses et � �tre au courant des fluctuations du march�."
	desc_unskilled = "Vous connaissez la valeur de votre salaire et de la plupart des objets de votre quotidien. Vous ne savez pas exactement ce qui signifie l'offre et la demande, mais vous le vivez plutot bien."
	desc_trained = "Vendre des objets est votre m�tier. Vous �tes renseign� sur la valeur des produits qui composent votre stock. Vous avez l'exp�rience de la n�gociation et seriez probablement capable de faire passer une babiole pour une antiquit�."
	desc_professional = "Vous �tes pass� ma�tre dans l'art de vendre les choses plus que ce qu'elles valent. Vous �tes tr�s bien renseign� sur le cours de la Bourse. Vous �tes probablement un actionnaire."


// Category: Security

/datum/skill/security/combat
	ID = "combat"
	name = "Corps � Corps"
	desc = "Votre abilit� au pugilat et � l'utilisation d'arme de corps � corps. Bien que la ma�trise du combat rapproch� devient rare � l'�poque des armes � feu, les ma�tres existent toujours parmis les athl�tes."
	desc_unskilled = "Vous savez mettre un coup de poing ou un coup de pied, mais fort � parier que �a vous ferez perdre l'�quilibre. Vous n'�tes pas entra�n� et vous n'avez probablement jamais pris part � un vrai combat. Dans un combat, il est plus probable que vous mettiez � paniquer et courrir, ou que vous attrapiez un objet au hasard pour battre l'air avec."
	desc_amateur = "Soit vous avez un peu d'exp�rience en bagarre, soit vous avez suivi un entra�nement aux art martiaux. Vous �tes capable de vous prot�ger en dernier recours, et si vous �tes un agent de s�curit�, vous savez tenir une matraque suffisament bien pour pouvoir coffrer un criminel."
	desc_trained = "Vous �tes un bon combattant. Vous avez suivi un entra�nement rigoureux au combat et faites probablement partie d'une unit� de police ou miltiaire. Vous avez l'habitude des armes et �tes capable de r�fl�chir strat�giquement durant un combat. Vous �tes en bonne forme physique et vous passez du temps � vous entra�ner."
	desc_professional = "Vous �tes sp�cialis� en combat rapproch�. Vous ma�triser un ou plusieurs arts martiaux. Vous �tes en excellente forme physique et passez beaucoup de temps � vous entra�ner. La plupart de vos ennemis ne peuvent pas vous r�sister avec une arme dans les mains. Vous �tes peut-�tre un athl�te connu ou un membre des forces sp�ciales."

/datum/skill/security/weapons
	ID = "weapons"
	name = "Armement"
	desc = "Votre connaissance des armes et de leur utilisation. Un niveau faible implique une connaissance des armes simples, comme les flashs. Un haut niveau impliqu� une connaissance des armes complexes,  comme des grenades sp�cialis�s, des �quipements anti-�meutes, des armes � �nergie ou des bombes. Un niveau moyen est typique d'un agent de s�curit�, un niveau elev� d'un soldat ou d'un mercenaire."
	desc_unskilled = "Vous savez reconna�tre une arme quand vous en voyez une. Vous �tes capable d'utiliser un spray au poivre ou un flash, de fa�on un peu laborieuse tout de m�me. Il est probable que vous vous tiriez dans le pied par erreur ou oubliez de d�sactiver la s�curit� de votre arme. Votre manque d'entra�nement vous rends plus dangereux pour vos alli�s que pour vos ennemis."
	desc_amateur = "Vous savez comment utiliser une arme en toute s�curit�, et vous n'avez pas trop de probl�mes avec les armes simples. Votre vis�e est correct et on peut vous faire confiance pour ne rien faire de stupide avec une arme. Cependant vos r�flexes ne sont pas devenus automatiques et il est possible que vos performances se d�grandent dans une situation stressante."
	desc_trained = "Vous avez d�j� utilis� des armes dans des situations compliqu�es, et les r�flexes de bases sont devenus comme une seconde natur epour vous. Vous vous entra�nez beaucoup au stand de tir. Votre vis�e est bonne. Vous �tes capable de r�parer et d'entretenir vos armes. Vous avez probablement une exp�rience militaire ou polici�re et portez sans doute une arme pour votre travail."
	desc_professional = "Vous �tes un tirreur exceptionnel avec toutes sortes d'armes, des plus simples aux plus �xotiques. Non seulement vous �tes capable de faire mouche � coup s�r, mais vous �tes aussi capable de viser une partie sp�cifique d'une cible, comme les jambes d'un ennemi qui s'enfuit. Votre arme est comme une extension de votre corps. Vous �tes probablement un tireur d'�lite.  Vous connaissez votre lot de tactiques, et vous �tes capable de concevoir ou de modifier votre armement."

/datum/skill/security/forensics
	ID = "forensics"
	name = "Enqu�te"
	desc = "Votre abilit� � appliquer les proc�dures criminalistiques de base et � identifier des indices. Ne concerne pas votre capacit� d'analyse, et donc n'est pas totalement indicatif de votre aptitude � enqu�ter. Pour proc�der � une autopsie, des comp�tences en chirurgie sont �galement requises."
	desc_unskilled = "Vous savez que les enqu�teurs r�solvent des affaires. Vous vous doutez peut-�tre que c'est pas bien de contaminer une sc�ne de crimes, mais vous n'avez aucune id�e des d�tails techniques."
	desc_amateur = "Vous savez comment ne pas contaminer une sc�ne de crime. Vous savez comment utiliser les outils les plus �vidents (scanner, bases de donn�es), et vous �tes capable de mener un interrogatoire."
	desc_trained = "Vous �tes un agent de police, un l�giste ou un d�tective. Vous savez s�curisert une sc�ne de crime, r�colter des indices, interroger  des t�moins, et connecter les indices pour mener � une arrestation. Si vous avez des comp�tences en anatomie, vous pouvez effectuer une autopsie."
	desc_professional = "Vous �tes sp�cialis� en criminalistique. Vos abilit�s � r�colter et analyser des indices ont �t� forg�s par des �tudes longues ou des ann�es de pratiques, souvent les deux. Vous �tes capable de retrouver un suspect ou de leur tendre un pi�ge.  Bien que vous agissez dans l'ombre et n'avez probablement jamais vu le criminel, votre exp�rience est ce qui fait la diff�rence entre un crime non-r�solu et un homme derri�re les barreaux."

// Category: Engineering

/datum/skill/engineering/construction
    ID = "construction"
    name = "Construction"
    desc = "Votre capacit� � b�tir des constructions vari�es, comme des murs, des sols, des tables, etc. Notez que construire des appareils tels que des APCs requiert �galement des comp�tences en �lectronique. Un niveau faible dans cette comp�tence est typique des concierges, un niveau �lev� est typique des ing�nieurs."
    desc_unskilled = "Vous pouvez d�placer le mobilier, monter ou d�monter des chaises et des tables, casser une vitre, ouvrir une caisse, ou forcer une porte qui n'est plus aliment�e. Vous pouvez reconnaitre et utiliser des outils basiques et les murs gonflable, mais pas facilement."
    desc_amateur = "Vous pouvez d�monter ou construire un mur ou une fen�tre, construire du mobilier, red�corer une pi�ce et remplacer le sol. Vous savez vous servir d'un soudeur en toute s�curit� sans vous br�ler les yeux, et vous avez l'habitude d'utiliser toutes sortes d'outils."
    desc_trained = "Vous savez r�parer une br�che, reconstruire la tuyauterie endommag�e et r�parer les d�g�ts majeurs. Vous connaissez les bases de l'ing�nierie structurelle."
    desc_professional = "Vous �tes un ing�nieur ou un ouvrier de chantier. Si on vous donnait les mat�riaux, vous pourriez reconstruire toute l'installation � partir de rien. Vous �tes efficace et comp�tent pour r�parer les d�g�ts."

/datum/skill/engineering/electrical
    ID = "electrical"
    name = "�lectronique"
    desc = "Votre connaissance de l'�lectronique et de la physique sous-jacente. Un niveau faible implique vous savez brancher un cable ou int�ragir avec un disjoncteur, un niveau elev� est requis pour travailler sur des installations �lectriques complexes comme des circuits ou des robots"
    desc_unskilled = "Vous savez que les cables �lectriques, c'est dangereux, et que se faire �lectriser est rarement une bonne chose ; vous �tes capable de reconna�tre et de signaler des installations endommag�es. Vous �tes capable de changer une ampoule ou de remplacer une batterie."
    desc_amateur = "Vous �tes capable des c�blages de base ; vous �tes capable de brancher les panneaux solaires ou le moteur. Vous �tes capable de r�parer un cable endommag� ou de construire des installations simples comme des APCs ou des luminaires. Vous connaissez la base des circuits imprim�s et vous savez comment vous prot�ger des �lectrocutions. Avec de l'aide, vous pouvez probablement pirater une machine � caf�."
    desc_trained = "Vous savez r�parer ou brancher toutes sortes d'�quipements et vous le faites tout les jours. Vous pouvez faire le diagnostic de syst�mes �lectriques et surveiller l'�tat de la grille. Vous savez probablement pirater un sas."
    desc_professional = "Vous �tes un �lectricien ou �quivalent. Vous pouvez con�evoir, am�liorer ou modifier des installations �lectriques et maximiser le rendement. Vous savez tout pirater et �tes form� � g�rer des pannes rapidement."

/datum/skill/engineering/atmos
    ID = "atmos"
    name = "Syst�mes de Survie"
    desc = "Vos connaissances de la plomberie, de la distribution d'air et de la m�canique des fluides."
    desc_unskilled = "Vous savez que quand l'alarme est orange, l'air est mauvais, et quand il est rouge, il est mortel. Vous savez qu'une lumi�re qui clignote sur une porte coupe-feu veut dire danger de l'autre cot�. Vous savez que certains gazs sont dangereux, que la pression aussi, et que la plupart des trucs vivants ont besoin d'oxyg�ne pour vivre. Vous savez utiliser un extincteur ou un mur gonflable."
    desc_amateur = "Vous savez comment lire un scan atmosph�rique, comment utiliser une pompe � air et comment sceller une br�che. Vous pouvez poser une tuyauterie et travailler avec des bouteilles de gaz. Vous savez comment vous servir d'un extincteur et vous savez placer des murs gonflables de fa�on � ce qu'ils forment des p�rim�tres de s�curit�."
    desc_trained = "Vous �tes capable de mettre en route et modifier les Syst�mes de Survie. Vous savez comment surveiller la qualit� de l'air � travers toute l'installation, d�tecter les probl�mes, et les r�gler. Vous avez �t� form� � la lutte contre le feu, les br�ches, les fuites de gaz, et probablement aussi � l'utilisation des exosuits et � l'�quipement de lutte contre les flammes."
    desc_professional = "Vous �tes un sp�cialiste des syst�mes de survies. Vous surveillez, modifiez et optimisez naturellement les installations atmosph�riques, et vous �tes capable de g�rer rapidement et efficacement les situations d'urgences. Vous pouvez modifier les syst�mes de survie comme bon vous semble.  Vous luttez facilement contre les flammes et les br�ches, et avez l'habitude d'�tablir des p�rim�tres de s�curit� et de secourir les civils, mais vous pr�f�rez l'id�e d'emp�cher ce type de situation en premier lieu."

/datum/skill/engineering/engines
	ID = "engines"
	name = "G�n�rateurs""
	desc = "Vos connaissances des diff�rents types de moteurs � bord des stations spatiales et leur utilisation."
	desc_unskilled = "Vous savez que \"radiations"\ est quelque chose de pas cool et que vous devez probablement vous tenir loin des trucs qui brillent en bleu. Vous save qu'un g�n�rateur cr�e de la puissance, mais vous ne savez pas forc�ment l'expliquer. Si on devait vous demander de brancher le moteur, quelqu'un devrait vous guider pour chaque �tape, et m�me avec �a il est probable que vous fassiez une erreur fatale."
	desc_amateur = "Vous connaissez les bases th�oriques du fonctionnement d'un moteur. Vous pouvez essayer d'allumer le moteur par vous m�me, mais vous allez avoir besoin d'aide ou de supervision, ou vous allez faire des erreurs."
	desc_trained = "Vous pouvez monter le g�n�rateur, et ne pas trop l'endommager. Vous connaissez les risques et la fa�on de se prot�ger des radiations. Vous savez lire les informations du moteur et le garder allumer. Vous avez une connaissance exhaustive des types de moteurs auxquels vous avez �t� confront�. Une panne pourrait vous laisser perplexe, mais il est probable que vous soyez capable de la r�parer� en esp�rant que vous soyez capable de le faire suffisament vite pour �viter trop de d�g�ts."
	desc_professional = "Le moteur est votre b�b�. Vous connaissez chaque d�tails de son fonctionnement. Vous pouvez l'optimiser et avez probablement une version personnalis�e que vous pr�f�rez. Vous seriez capable de monter un g�n�rateur � partir de pi�ces d�tach�es. Quand les choses sont hors de contr�le, vous savez exactement ce qui c'est pass� et comment r�gler le probl�me."

/datum/skill/engineering/mech
    ID = "mech"
    name = "�quipement Lourd"
    desc = "Votre exp�rience et vos connaissance de l'utilisation des �quipements lourds, tels que les mechas et autres exosuits lourds. "
    desc_unskilled = "Vous savez ce qu'est un mecha et � quoi ca sert, et vous serez probablement capable d'identifier un type de mecha en particulier. Si votre d�partement en utilise, vous savez de quoi ils sont capables. Si vous deviez �tre aux commandes, il y'a une chance sur deux que vous arriviez � faire un pas dans la direction que vous voulez."
    desc_amateur = "Vous �tes capable de conduire un mecha, mais vous �tes bien sp�cialis� dans un seul type que votre d�partement utilise r�guli�rement. Vous n'�tes pas un expert et pouvez vous perdre dans les commandes, mais vous allez l� o� vous voulez aller et vous savez la signification de la majorit� des boutons. Si vous �tes un mineur vous savez mettre en route votre perceuse ; si vous avez les comp�tences n�cessaires en �lectronique, vous �tes probablement capable de monter un g�n�rateur de bouclier ou un laser."
    desc_trained = "Vous �tes tr�s � l'aise avec le type d'exosuit que vous utilisez r�guli�rement. Vous passez probablement la majorit� de votre rel�ve � l'utiliser, et connaissez ses fonctions. Vous �tes capable de faire la maintenance de base. Vous savez utiliser la majorit� des exosuits, sauf ceux particuli�rement rares ou sp�cialis�s. Si vous �tes �lectricien ou ing�nieur, vous savez mettre en place un g�n�rateur de bouclier tout seul. Les mineurs � ce niveau peuvent utiliser la perceuse sans aucun probl�me."
    desc_professional = "Vous pouvez utiliser tout les types de mechas sans probl�mes ni contraintes. Pour vous, un mecha est comme une seconde peau. Vous savez les entretenir, les r�parer, et probablement aussi les construire."

/datum/skill/engineering/pilot
    ID = "pilot"
    name = "Pilotage"
    desc = "Votre exp�rience et compr�hension du pilotage du vaisseau et de la physique des technologies FTL, de la petite navette jusqu'� la corvette de combat."
    desc_unskilled = "Vous savez ce qu'est un vaisseau, et vous avez probablement une vague connaissance des diff�rences entre chaque type de navette. Si votre d�partement est impliqu� dans l'utilisation de v�hicules spatiaux, vous savez de quoi ils sont capables. Vous serez probablement capable d'en piloter un dans un jeu-vid�o. Si on vous donnez le contr�le d'un petit vaisseau, vous seriez peut �tre capable de le piloter avec un peu d'aide."
    desc_amateur = "Vous pouvez piloter un petit vaisseau courte port�e en toute s�curit�, mais les grands vaisseaux sont au del� de vos capacit�s. Vous n'�tes pas du tout un expert et n'avez aucun entra�nement."
    desc_trained = "Vous �tes un pilote entra�n�, vous �tes form� � l'utilisation des petits appareils civils et militaires. Vous pouvez piloter un vaisseau sur de longues sessions, et vous �tes au courrant des sp�cificit�s techniques des diff�rents vaisseaux. Vous �tes capable de faire de la maintenance de base et de proc�der � des manoevres simples. Vous pouvez utiliser les armes d'un vaisseau. Vous pouvez faire des calculs orbitaux simples. Un niveau typique des nouveaux pilotes."
    desc_professional = "Vous �tes un pilote chevronn�.  Vous vivez probablement dans le vaisseau que vous pilotez, et vous savez tout ce qu'il y'a � savoir sur le voyage spatial. Non seulement vous savez piloter avec aisance, mais vous �tes capable de manoevres complexes, et de proc�der � des calculs orbitaux tr�s avanc�. Ce niveau est typique des pilotes militaires. Vous avez re�u un entra�nement particulier."

// Category: Research

/datum/skill/research/devices
    ID = "devices"
    name = "Dispositifs Complexes"
    desc = "D�crit la capacit� d'assembler des dispositifs complexes, tels que des ordinateurs, des circuits, des imprimantes, des robots ou des assemblages de r�servoirs de gaz (bombes). Notez que si un dispositif n�cessite de l'�l�ctronique ou de la programmation, ces comp�tences sont �galement requises en plus de cette derni�re."
    desc_unskilled = "Vous savez comment utiliser la technologie pr�sente dans la soci�t� ou vous avez grandi. Vous pouvez voir quand quelque chose ne fonctionne pas, mais vous devez appeller le support technique pour le faire r�parer."
    desc_amateur = "Vous utilisez et r�parez de l'�quipment high-tech au cours de votre travail quotidien. Vous pouvez r�gler des probl�mes simples, et savez comment utiliser une imprimante de circuits ou un autolathe. Vous pouvez construire des robots simples tels que des medibots ou cleanbots. Si vous avez des connaissances m�dicales ou �l�ctriques pertinantes, vous pouvez r�parer une proth�se ou un organe artificiel; sionon, ces objets sont au del� de vos capacit�s"
    desc_trained = "Vous pouvez construire ou r�parer une exosuit oun chassis de cyborg, utiliser un protolathe et un analyseur destructif, et construire des proth�ses. Vous pouvez transf�rer une MMI ou un cerveau positronique dans un chassis de cyborg en toute s�curit�."
    desc_professional = "Vous �tes un inventeur, un chercheur ou un anomaliste. Vous pouvez concevoir, construire, et modifier des �quipments dont la plupart des gens ne connaissent m�me pas l'existence. Vous �tes chez vous dans un labo ou un atelier et vous n'�tes jamais tomb� sur un gadget que vous ne pouviez pas d�monter, remonter, et r�pliquer."

/datum/skill/research/computer
    ID = "computer"
    name = "Informatique"
    desc = "D�crit votre compr�hension des ordinateurs, logiciels et r�seaux. Non requis pour utiliser des ordinateurs, mais aide certainement. Utilis� dans les t�l�communications et la programmation d'ordinateurs et IA."
    desc_unskilled = "Vous savez comment utiliser les ordinateurs et appareils de communication avec lesquels vous avez grandi. Vous pouvez utiliser une console, une radio portable ou murale, et votre casque ainsi que votre PDA. Vous savez ce qu'est une IA, mais vous les voyez comme \"des gens faits en silicone\" ou \"des simples machines\"; vous savez qu'elles doivent ob�ir � leur lois, mais ne savez pas grand chose � propos de comment ou pourquoi elles travaillent."
    desc_amateur = "Vous connaissez les bases de la programmation, mais vous n'y �tes pas tr�s bon et ne pourriez pas en faire professionnelement. Vous avez une petite id�e de comment les IA fonctionnent. Vous comprenez comment les informations sont stock�es dans un ordinateur et vous pouvez r�gler les probl�mes d'ordinateurs simples. Vous vous y connaissez en ordinateur, mais faites toujours des erreurs. Si vous essayiez de changer l'IA, vous pourriez faire des erreurs en formulant vos nouvelles lois."
    desc_trained = "A ce niveau, vous travaillez probablement avec des ordinateurs de mani�re quotidiennet. Vous comprenez et pouvez r�parer le r�seau de  t�l�communications. Votre compr�hension de la programmation et de la technologie des IA vous permet de r�gler des probl�mes avec ces derni�res ou avec des cyborgs--ou en cr�er, si vous les d�sirez. Vous pouvez programmer des ordinateurs et IA et changer leurs lois efficacement."
    desc_professional = "Les gens commencent � se demander si vous n'�tes pas un ordinateur vous-m�me. Le code informatique est vore premier langage; vous relativisez avec les IA aussi facilement que (probablement plus facilement qu'avec) les organiques. Vous pourriez mettre en place un r�seau de t�l�communications de z�ro."

/datum/skill/research/science
	ID = "science"
	name = "Sciences"
	desc = "Votre �xp�rience et connaissance des m�thodes et proc�d�s scientifiques."
	desc_unskilled = "Vous savez ce qu'est la science et avez probablement une vague id�e de la m�thode scientifiques gr�ce � vos cours de science au lyc�e."
	desc_amateur = "Vous vous tenez � jour avec les d�couvertes scientifiques. Vous vous y connaissez un petit peu avec tous les champs de recherche. Vous avez appris des comp�tences de laboratoire basiques. Vous vous informez peut-�tre par hobby; ou vous travaillez dans un domaine en rapport avec la science et avez appris de cette mani�re. Vous pouvez concevoir une exp�rience simple."
	desc_trained = "Vous �tes un scientifique, peut-�tre un �tudiant ou un chercheur dipl�m�. Vous pouvez concevoir une exp�rience, analyser vos r�sultats, publier ces donn�es, et fusionner ce que vous avez appris avec les recherches d'autres scientifiques. Vos capacit�s en laboratoire sont fiables, et vous savez comment trouver une information dont vous besoin quand vous recherchez un nouevau sujet scientifique."
	desc_professional = "Vous �tes un chercheur professionnel et avez fait de nombreuses d�couvertes dans votre domaine. Vos exp�riences sont bien con�ues. Vous �tes connu comme une autorit� dans votre sp�cialit� et vos articles apparaissent fr�quemment dans de prestigieuses publications. Vous pouvez diriger les efforts de recherche d'une �quipe de scientifiques."


// Category: Medical

/datum/skill/medical/medical
    ID = "medical"
    name = "M�decine"
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
	desc = "Exp�rience avec des m�langes de produits chimique, et une recherche des effets qu'ils auront. Cela ne concerne pas la compr�hension des effets des produits chimiques sur le corps humain, en tant que tel, des comp�tences m�dicales sont �galement n�cessaires pour les chimistes m�dicaux"
	desc_unskilled = "Vous savez que les chimistes travaillent avec des produits chimique; vous savez aussi qu'ils peuvent faire des m�dicaments, du poison ou des produits tr�s utile. Vous connaissez probablement quelques �lements et vous avez quelques souvenir de r�action chimique qui datent de vos cours de chimie au lyc�e."
	desc_amateur = "Vous savez faire les bases au niveau de la chimie et des m�dicaments.. Des trucs comme du "Space-Cleaner" et de "l'anti-poison".Vous avez fais une formation pour la s�curit� et vous n'exploserez pas le labo .. Normalement."
	desc_trained = "Vous travaillez comme chimiste, ou alors vous �tes un docteur avec une formation en chimie. Si vous �tes un chercheur en chimie, vous pouvez cr�er de puissante solution; si vous �tes pharmaciens, vous pouvez faire plus de m�dicaments. A ce stade, vous travaillez plus "by the book". Vous pouvez "armer" vos produits pour en faire des grenades, des fumig�nes et des dispositifs similaires  "
	desc_professional = "Vous vous �tes sp�cialis�s dans la chimie ou dans la pharmaceutique. Vous �tes soit un chercheur en m�decine ou un professionel en chimie."