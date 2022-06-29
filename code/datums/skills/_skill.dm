GLOBAL_LIST_INIT(skill_types, subtypesof(/datum/skill))

/datum/skill
	var/name = "Skilling"
	var/title = "Skiller"
	var/desc = "the art of doing things"
	///Dictionary of modifier type - list of modifiers (indexed by level). 7 entries in each list for all 7 skill levels.
	var/modifiers = list(SKILL_SPEED_MODIFIER = list(1, 1, 1, 1, 1, 1, 1)) //Dictionary of modifier type - list of modifiers (indexed by level). 7 entries in each list for all 7 skill levels.
	///List associating different messages that appear on level up with different levels
	var/list/levelUpMessages = list()
	var/level = 1
	var/experience = 0

/datum/skill/proc/get_skill_modifier(modifier, level)
	return modifiers[modifier][level] //Levels range from 1 (None) to 7 (Legendary)
/**
 * new: sets up some lists.
 *
 *Can't happen in the datum's definition because these lists are not constant expressions
 */
/datum/skill/New()
	. = ..()
	levelUpMessages = list("<span class='nicegreen'>What the hell is [name]? Tell an admin if you see this message.</span>", //This first index shouldn't ever really be used
	"<span class='nicegreen'>I'm starting to figure out what [name] really is!</span>",
	"<span class='nicegreen'>I'm getting a little better at [name]!</span>",
	"<span class='nicegreen'>I'm getting much better at [name]!</span>",
	"<span class='nicegreen'>I feel like I've become quite proficient at [name]!</span>",
	"<span class='nicegreen'>After lots of practice, I've begun to truly understand the intricacies \
	and surprising depth behind [name]. I now consider myself a master [title].</span>",
	"<span class='nicegreen'>Through incredible determination and effort, I've reached the peak of my [name] abiltities. I'm finally able to consider myself a legendary [title]!</span>" )

/**
 * level_gained: Gives skill levelup messages to the user
 *
 * Only fires if the xp gain isn't silent, so only really useful for messages.
 * Arguments:
 * * mind - The mind that you'll want to send messages
 * * new_level - The newly gained level. Can check the actual level to give different messages at different levels, see defines in skills.dm
 * * old_level - Similar to the above, but the level you had before levelling up.
 */
/datum/skill/proc/level_gained(datum/mind/mind, new_level, old_level)//just for announcements (doesn't go off if the xp gain is silent)
	to_chat(mind.current, levelUpMessages[new_level]) //new_level will be a value from 1 to 6, so we get appropriate message from the 6-element levelUpMessages list
/**
 * level_lost: See level_gained, same idea but fires on skill level-down
 */
/datum/skill/proc/level_lost(datum/mind/mind, new_level, old_level)
	return

/**
 * try_skill_reward: Checks to see if a user is eligable for a tangible reward for reaching a certain skill level
 *
 * Currently gives the user a special cloak when they reach a legendary level at any given skill
 * Arguments:
 * * mind - The mind that you'll want to send messages and rewards to
 * * new_level - The current level of the user. Used to check if it meets the requirements for a reward
 */
/datum/skill/proc/try_skill_reward(datum/mind/mind, new_level)
	if (new_level != SKILL_LEVEL_LEGEND)
		return
	if (LAZYFIND(mind.skills_rewarded, src.type))
		// to_chat(mind.current, span_nicegreen("Похоже,  Ассоциация Профессионалов [title] не хочет давать мне больше символов навыка."))
		return
	LAZYADD(mind.skills_rewarded, src.type)
