/decl/emote/visible
	key ="tail"
	emote_message_3p = "USER waves USER_THEIR tail."
	message_type = VISIBLE_MESSAGE

/decl/emote/visible/scratch
	key = "scratch"
	check_restraints = TRUE
	emote_message_3p = "USER se gratte."

/decl/emote/visible/drool
	key ="drool"
	emote_message_3p = "USER drools."
	conscious = 0

/decl/emote/visible/nod
	key ="nod"
	emote_message_3p = "USER acquiesce."

/decl/emote/visible/sway
	key ="sway"
	emote_message_3p = "USER n'arrive pas à marcher droit."

/decl/emote/visible/sulk
	key ="sulk"
	emote_message_3p = "USER a l'air triste."

/decl/emote/visible/dance
	key ="dance"
	check_restraints = TRUE
	emote_message_3p = "USER dance."

/decl/emote/visible/roll
	key ="roll"
	check_restraints = TRUE
	emote_message_3p = "USER roule."

/decl/emote/visible/shake
	key ="shake"
	emote_message_3p = "USER secoue sa tête."

/decl/emote/visible/jump
	key ="jump"
	emote_message_3p = "USER saute !"

/decl/emote/visible/hiss
	key ="hiss_"
	emote_message_3p = "USER siffle doucement."

/decl/emote/visible/shiver
	key ="shiver"
	emote_message_3p = "USER tremble."
	conscious = 0

/decl/emote/visible/collapse
	key ="collapse"
	emote_message_3p = "USER s'éffondre !"

/decl/emote/visible/collapse/do_extra(var/mob/user)
	if(istype(user))
		user.Paralyse(2)

/decl/emote/visible/flash
	key = "flash"
	emote_message_3p = "The lights on USER flash quickly."

/decl/emote/visible/blink
	key = "blink"
	emote_message_3p = "USER cligne des yeux."

/decl/emote/visible/airguitar
	key = "airguitar"
	check_restraints = TRUE
	emote_message_3p = "USER is strumming the air and headbanging like a safari chimp."

/decl/emote/visible/blink_r
	key = "blink_r"
	emote_message_3p = "USER cligne rapidement des yeux."

/decl/emote/visible/bow
	key = "bow"
	emote_message_3p_target = "USER s'incline vers TARGET."
	emote_message_3p = "USER bows."

/decl/emote/visible/salute
	key = "salute"
	emote_message_3p_target = "USER salue TARGET."
	emote_message_3p = "USER salutes."

/decl/emote/visible/flap
	key = "flap"
	check_restraints = TRUE
	emote_message_3p = "USER flaps USER_THEIR wings."

/decl/emote/visible/aflap
	key = "aflap"
	check_restraints = TRUE
	emote_message_3p = "USER flaps USER_THEIR wings ANGRILY!"

/decl/emote/visible/eyebrow
	key = "eyebrow"
	emote_message_3p = "USER lève un sourcil."

/decl/emote/visible/twitch
	key = "twitch"
	emote_message_3p = "USER convulse."
	conscious = 0

/decl/emote/visible/twitch_v
	key = "twitch_v"
	emote_message_3p = "USER convulse violemment."
	conscious = 0

/decl/emote/visible/faint
	key = "faint"
	emote_message_3p = "USER s'évanouit."

/decl/emote/visible/faint/do_extra(var/mob/user)
	if(istype(user) && user.sleeping <= 0)
		user.sleeping += 10

/decl/emote/visible/frown
	key = "frown"
	emote_message_3p = "USER fronce les sourcils."

/decl/emote/visible/blush
	key = "blush"
	emote_message_3p = "USER rougit."

/decl/emote/visible/wave
	key = "wave"
	emote_message_3p = "USER salue de sa main."
	emote_message_3p_target = "USER salue TARGET."

/decl/emote/visible/glare
	key = "glare"
	emote_message_3p = "USER assaille TARGET du regarde."
	emote_message_3p = "USER a l'air enervé."

/decl/emote/visible/stare
	key = "stare"
	emote_message_3p = "USER regarde fixement TARGET."
	emote_message_3p = "USER regarde fixement quelque chose."

/decl/emote/visible/look
	key = "look"
	emote_message_3p = "USER observe TARGET."
	emote_message_3p = "USER observe autour de lui."

/decl/emote/visible/point
	key = "point"
	check_restraints = TRUE
	emote_message_3p = "USER pointe quelque chose."
	emote_message_3p_target = "USER pointe TARGET."

/decl/emote/visible/raise
	key = "raise"
	check_restraints = TRUE
	emote_message_3p = "USER lève sa main."

/decl/emote/visible/grin
	key = "grin"
	emote_message_3p = "USER sourit malicieusement."

/decl/emote/visible/shrug
	key = "shrug"
	emote_message_3p = "USER hausse les épaules."

/decl/emote/visible/smile
	key = "smile"
	emote_message_3p = "USER sourit."

/decl/emote/visible/pale
	key = "pale"
	emote_message_3p = "USER devient pâle."

/decl/emote/visible/tremble
	key = "tremble"
	emote_message_3p = "USER tremble de peur !"

/decl/emote/visible/wink
	key = "wink"
	emote_message_3p = "USER fait un clin d'oeil."

/decl/emote/visible/hug
	key = "hug"
	check_restraints = TRUE
	emote_message_3p = "USER s'étreinds."
	emote_message_3p_target = "USER étreinds TARGET."

/decl/emote/visible/dap
	key = "dap"
	check_restraints = TRUE
	emote_message_3p = "USER sadly can't find anybody to give daps to, and daps USER_THEMself."
	emote_message_3p_target = "USER gives daps to TARGET."

/decl/emote/visible/signal
	key = "signal"
	check_restraints = TRUE
	emote_message_3p = "USER fait un signal."

/decl/emote/visible/signal/check_user(var/atom/user)
	return ismob(user)

/decl/emote/visible/bounce
	key = "bounce"
	emote_message_3p = "USER sautille sur place."

/decl/emote/visible/jiggle
	key = "jiggle"
	emote_message_3p = "USER rigole avec amusement !"

/decl/emote/visible/lightup
	key = "light"
	emote_message_3p = "USER s'allume rapidement, puis s'éteinds."

/decl/emote/visible/vibrate
	key = "vibrate"
	emote_message_3p = "USER vibre !"

/decl/emote/visible/deathgasp_robot
	key = "deathgasp"
	emote_message_3p = "USER vibre violemment pendant quelques secondes, puis ne bouge plus, ses yeux devenant de plus en plus sombres."

/decl/emote/visible/handshake
	key = "handshake"
	check_restraints = TRUE
	emote_message_3p = "USER se sert la main."
	emote_message_3p_target = "USER sert la main TARGET."
	message_type = VISIBLE_MESSAGE

/decl/emote/visible/handshake/get_emote_message_3p(var/atom/user, var/atom/target, var/extra_params)
	if(target && !user.Adjacent(target))
		return "USER tends la main vers TARGET."
	return ..()

/decl/emote/visible/signal
	key = "signal"
	emote_message_3p = "USER signals."
	emote_message_3p_target = "USER signals at TARGET."
	message_type = VISIBLE_MESSAGE

/decl/emote/visible/signal/get_emote_message_3p(var/mob/user, var/atom/target, var/extra_params)
	if(istype(user) && !(user.r_hand && user.l_hand))
		var/t1 = round(text2num(extra_params))
		if(isnum(t1) && t1 <= 5)
			return "USER lève [t1] doigt\s."
	return .. ()
