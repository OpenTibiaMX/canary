local mType = Game.createMonsterType("Soul Sphere")
local monster = {}

monster.description = "a soul sphere"
monster.experience = 0
monster.outfit = {
	lookType = 979,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 10000
monster.maxHealth = 10000
monster.corpse = 0
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -500, maxDamage = -1000 },
}

monster.defenses = {
	defense = 80,
	armor = 90,
	mitigation = 0.51,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

local moveTimeCount = 0
mType.onThink = function(monster, interval)
	moveTimeCount = moveTimeCount + interval
	if moveTimeCount == 3000 then
		monster:move(DIRECTION_WEST)
		moveTimeCount = 0
		local monsterPos = monster:getPosition()
		local nextPos = Position(monsterPos.x - 1, monsterPos.y, monsterPos.z)
		local tile = Tile(nextPos)
		if not tile then
			return
		end

		for _, creatureId in pairs(tile:getCreatures()) do
			local monster = Monster(creatureId)
			if monster and monster:getName() == "Goshnar's Greed" then
				monster:setHealth(monster:getMaxHealth())
				break
			end
		end
	end
end

mType:register(monster)