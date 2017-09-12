var/global/list/seen_citizenships = list()
var/global/list/seen_systems = list()
var/global/list/seen_factions = list()
var/global/list/seen_religions = list()

//Commenting this out for now until I work the lists it into the event generator/journalist/chaplain.
/proc/UpdateFactionList(mob/living/carbon/human/M)
	/*if(M && M.client && M.client.prefs)
		seen_citizenships |= M.client.prefs.citizenship
		seen_systems      |= M.client.prefs.home_system
		seen_factions     |= M.client.prefs.faction
		seen_religions    |= M.client.prefs.religion*/
	return

var/global/list/citizenship_choices = list(
	"Terra",
	"Mars",
	"Charnay-4",
	"Augiéras",
	"Delalande",
	"Ièoc"
	)

var/global/list/home_system_choices = list(
	"Sol",
	"Nyx",
	"Iota-Pavonis",
	"Hydrus 421",
	"Ghimel 552"
	)

var/global/list/faction_choices = list(
	"Fédération Solaire",
	"République de Pavonis",
	"Nanotrasen Industries",
	"ConcSag Ressources",
	"Rexgène Co.",
	"Nouveau-Monde",
	"Pacte",
	"Fondation Omega"
	)

var/global/list/religion_choices = list(
	"Jéovah",
	"Dismas",
	"Marik",
	"Athéiste",
	"Agnostique",
	"Déiste"
	)