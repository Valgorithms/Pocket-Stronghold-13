/*
Mineral Sheets
	Contains:
		- Diamond
		- Gold
		- Silver
	Others:
		- Coal
*/


/*
 * Diamond
 */

/obj/item/stack/sheet/mineral/gem
	max_amount = 1
	novariants = TRUE
	righthand_file = 'dwarfs/icons/mob/inhand/righthand.dmi'
	lefthand_file = 'dwarfs/icons/mob/inhand/lefthand.dmi'

/obj/item/stack/sheet/mineral/gem/diamond
	name = "diamond"
	icon = 'dwarfs/icons/items/ores_gems.dmi'
	icon_state = "diamond"
	// inhand_icon_state = "sheet-diamond"
	singular_name = "diamond"
	merge_type = /obj/item/stack/sheet/mineral/gem/diamond

/obj/item/stack/sheet/mineral/gem/sapphire
	name = "sapphire"
	icon = 'dwarfs/icons/items/ores_gems.dmi'
	icon_state = "sapphire"
	// inhand_icon_state = "sheet-sapphire"
	singular_name = "sapphire"
	merge_type = /obj/item/stack/sheet/mineral/gem/sapphire

/obj/item/stack/sheet/mineral/gem/ruby
	name = "ruby"
	icon = 'dwarfs/icons/items/ores_gems.dmi'
	icon_state = "ruby"
	// inhand_icon_state = "sheet-ruby"
	singular_name = "ruby"
	merge_type = /obj/item/stack/sheet/mineral/gem/ruby
	
/obj/item/stack/sheet/mineral/gem/glowgem
	name = "glowgem"
	icon = 'dwarfs/icons/items/ores_gems.dmi'
	icon_state = "glowgem"
	// inhand_icon_state = "sheet-glowgem" (Not used?)
	singular_name = "glowgem"
	merge_type = /obj/item/stack/sheet/mineral/gem/glowgem
	light_color = "#00ffff"
	light_power = 1
	light_range = 5

/*
 * Gold
 */
/obj/item/stack/sheet/mineral/gold
	name = "gold"
	icon = 'dwarfs/icons/items/ores_gems.dmi'
	icon_state = "sheet-gold"
	inhand_icon_state = "sheet-gold"
	singular_name = "golden sheet"
	mats_per_unit = list(/datum/material/gold=MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/mineral/gold
	material_type = /datum/material/gold
	novariants = TRUE

GLOBAL_LIST_INIT(gold_recipes, list ())

/obj/item/stack/sheet/mineral/gold/get_main_recipes()
	. = ..()
	. += GLOB.gold_recipes

/****************************** Others ****************************/
/*
 * Coal
 */

/obj/item/stack/sheet/mineral/coal
	name = "coal lump"
	icon = 'dwarfs/icons/items/ores_gems.dmi'
	desc = "Black gold of the mountains, used to fuel furnaces"
	icon_state = "coal"
	singular_name = "coal lump"
	merge_type = /obj/item/stack/sheet/mineral/coal
	novariants = TRUE

/obj/item/stack/sheet/mineral/coal/get_fuel()
	return 15 * amount

/obj/item/stack/sheet/mineral/coal/attackby(obj/item/W, mob/user, params)
	if(W.get_temperature() > 300)//If the temperature of the object is over 300, then ignite
		var/turf/T = get_turf(src)
		message_admins("Coal ignited by [ADMIN_LOOKUPFLW(user)] in [ADMIN_VERBOSEJMP(T)]")
		log_game("Coal ignited by [key_name(user)] in [AREACOORD(T)]")
		fire_act(W.get_temperature())
		return TRUE
	else
		return ..()

/obj/item/stack/sheet/mineral/coal/fire_act(exposed_temperature, exposed_volume)
	qdel(src)

/obj/item/stack/sheet/mineral/coal/five
	amount = 5

/obj/item/stack/sheet/mineral/coal/ten
	amount = 10
