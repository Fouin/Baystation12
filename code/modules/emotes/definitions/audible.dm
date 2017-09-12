/decl/emote/audible
	key = "burp"
	emote_message_3p = "USER rote."
	message_type = AUDIBLE_MESSAGE
	var/emote_sound

/decl/emote/audible/do_extra(var/atom/user)
	if(emote_sound)
		playsound(user.loc, emote_sound, 50, 0)

/decl/emote/audible/deathgasp_alien
	key = "deathgasp"
	emote_message_3p = "USER laisse échapper un cri guttural, du sang vert dégoulinant le long de sa machoire."

/decl/emote/audible/whimper
	key ="whimper"
	emote_message_3p = "USER chuchotte."

/decl/emote/audible/gasp
	key ="gasp"
	emote_message_3p = "USER halète."
	conscious = 0

/decl/emote/audible/scretch
	key ="scretch"
	emote_message_3p = "USER s'étire."

/decl/emote/audible/choke
	key ="choke"
	emote_message_3p = "USER s'étouffe."
	conscious = 0

/decl/emote/audible/gnarl
	key ="gnarl"
	emote_message_3p = "USER grogne et montre se dents.."

/decl/emote/audible/chirp
	key ="chirp"
	emote_message_3p = "USER chirpe !"
	emote_sound = 'sound/misc/nymphchirp.ogg'

/decl/emote/audible/alarm
	key = "alarm"
	emote_message_1p = "Vous émettez une alarme."
	emote_message_3p = "USER émet une alarme"

/decl/emote/audible/alert
	key = "alert"
	emote_message_1p = "Vous émettez un signal de détresse."
	emote_message_3p = "USER émet un signal de détresse."

/decl/emote/audible/notice
	key = "notice"
	emote_message_1p = "Vous jouez un gros bruit."
	emote_message_3p = "USER joue un gros bruit."

/decl/emote/audible/whistle
	key = "whistle"
	emote_message_1p = "Vous sifflez."
	emote_message_3p = "USER siffle."

/decl/emote/audible/boop
	key = "boop"
	emote_message_1p = "Vous faites boop."
	emote_message_3p = "USER fait boops."

/decl/emote/audible/sneeze
	key = "sneeze"
	emote_message_3p = "USER éternue."

/decl/emote/audible/sniff
	key = "sniff"
	emote_message_3p = "USER renifle."

/decl/emote/audible/snore
	key = "snore"
	emote_message_3p = "USER ronfle."
	conscious = 0

/decl/emote/audible/whimper
	key = "whimper"
	emote_message_3p = "USER gémit."

/decl/emote/audible/yawn
	key = "yawn"
	emote_message_3p = "USER baille."

/decl/emote/audible/clap
	key = "clap"
	emote_message_3p = "USER applaudit."

/decl/emote/audible/chuckle
	key = "chuckle"
	emote_message_3p = "USER clousse."

/decl/emote/audible/cough
	key = "cough"
	emote_message_3p = "USER tousse !"
	conscious = 0

/decl/emote/audible/cry
	key = "cry"
	emote_message_3p = "USER crie."

/decl/emote/audible/sigh
	key = "sigh"
	emote_message_3p = "USER soupire."

/decl/emote/audible/laugh
	key = "laugh"
	emote_message_3p = "USER rigole."

/decl/emote/audible/mumble
	key = "mumble"
	emote_message_3p = "USER marmonne !"

/decl/emote/audible/grumble
	key = "grumble"
	emote_message_3p = "USER gromelle !"

/decl/emote/audible/groan
	key = "groan"
	emote_message_3p = "USER grogne !"
	conscious = 0

/decl/emote/audible/moan
	key = "moan"
	emote_message_3p = "USER gémit !"
	conscious = 0

/decl/emote/audible/giggle
	key = "giggle"
	emote_message_3p = "USER ricane."

/decl/emote/audible/scream
	key = "scream"
	emote_message_3p = "USER crie !"

/decl/emote/audible/grunt
	key = "grunt"
	emote_message_3p = "USER gronde."