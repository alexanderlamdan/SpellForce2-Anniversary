--------------------------------------------------
-- COMBINED DEFENDERS
-- One script, one State, two generated NPC groups
--------------------------------------------------

--------------------------------------------------
-- PACT WAVE
--------------------------------------------------

-- do
-- 	--------------------------------------------------
-- 	-- CONFIG
-- 	--------------------------------------------------
--
-- 	local columns = 3
-- 	local spacing = 2
--
-- 	local homeX = 561
-- 	local homeY = 404
--
-- 	local spawnX = 282
-- 	local spawnY = 281
--
-- 	local respawnTime = 17
--
-- 	local team = "tm_Enemy"
-- 	local prefix = "PactWave"
--
-- 	local unitGroups =
-- 	{
-- 		{ UnitId = 901, Level = 3, Count = 4 },
-- 		{ UnitId = 890, Level = 3, Count = 6 },
-- 		{ UnitId = 88, Level = 3, Count = 3 },
-- 		{ UnitId = 910, Level = 3, Count = 4 },
-- 		{ UnitId = 80, Level = 3, Count = 5 },
-- 		{ UnitId = 338, Level = 3, Count = 14 },
-- 		{ UnitId = 79, Level = 3, Count = 10 },
-- 		{ UnitId = 336, Level = 3, Count = 18 },
-- 		{ UnitId = 337, Level = 3, Count = 12 },
-- 		{ UnitId = 911, Level = 3, Count = 5 },
-- 	}
--
-- 	local units = {}
--
-- 	for _, group in ipairs(unitGroups) do
-- 		for n = 1, group.Count do
-- 			table.insert(units,
-- 			{
-- 				UnitId = group.UnitId,
-- 				Level = group.Level,
-- 			})
-- 		end
-- 	end
--
-- 	local count = table.getn(units)
--
-- 	--------------------------------------------------
-- 	-- INITIAL SPAWN
-- 	--------------------------------------------------
--
-- 	local initActions = {}
-- 	local actionIndex = 1
--
-- 	for i = 1, count do
--
-- 		local npc = units[i]
--
-- 		local row = math.floor((i - 1) / columns)
-- 		local col = math.mod(i - 1, columns)
--
-- 		local targetX = homeX + col * spacing
-- 		local targetY = homeY + row * spacing
--
-- 		initActions[actionIndex] = FigureNpcSpawn
-- 		{
-- 			Tag = prefix .. i,
-- 			Level = npc.Level,
-- 			UnitId = npc.UnitId,
-- 			X = spawnX,
-- 			Y = spawnY,
-- 			Team = team,
-- 		}
-- 		actionIndex = actionIndex + 1
--
-- 		initActions[actionIndex] = FigureWalk
-- 		{
-- 			Tag = prefix .. i,
-- 			X = targetX,
-- 			Y = targetY,
-- 		}
-- 		actionIndex = actionIndex + 1
--
-- 	end
--
-- 	--------------------------------------------------
-- 	-- INITIAL EVENT
-- 	--------------------------------------------------
--
-- 	OnOneTimeEvent
-- 	{
-- 		Conditions = {},
-- 		Actions = initActions,
-- 	}
--
-- 	--------------------------------------------------
-- 	-- RESPAWN
-- 	--------------------------------------------------
--
-- 	for i = 1, count do
--
-- 		local npc = units[i]
--
-- 		local row = math.floor((i - 1) / columns)
-- 		local col = math.mod(i - 1, columns)
--
-- 		local targetX = homeX + col * spacing
-- 		local targetY = homeY + row * spacing
--
-- 		OnEvent
-- 		{
-- 			Conditions =
-- 			{
-- 				FigureIsDead{Tag = prefix .. i},
-- 				MapFlagIsFalse{Name = "mf_" .. prefix .. "_Respawn" .. i},
-- 			},
--
-- 			Actions =
-- 			{
-- 				MapFlagSetTrue{Name = "mf_" .. prefix .. "_Respawn" .. i},
-- 				MapTimerStart{Name = "mt_" .. prefix .. "_Respawn" .. i},
-- 			},
-- 		}
--
-- 		OnEvent
-- 		{
-- 			Conditions =
-- 			{
-- 				MapFlagIsTrue{Name = "mf_" .. prefix .. "_Respawn" .. i},
-- 				MapTimerIsElapsed{Name = "mt_" .. prefix .. "_Respawn" .. i, Seconds = respawnTime},
-- 			},
--
-- 			Actions =
-- 			{
-- 				FigureNpcSpawn
-- 				{
-- 					Tag = prefix .. i,
-- 					Level = npc.Level,
-- 					UnitId = npc.UnitId,
-- 					X = spawnX,
-- 					Y = spawnY,
-- 					Team = team,
-- 				},
--
-- 				FigureWalk
-- 				{
-- 					Tag = prefix .. i,
-- 					X = targetX,
-- 					Y = targetY,
-- 				},
--
-- 				MapFlagSetFalse{Name = "mf_" .. prefix .. "_Respawn" .. i},
-- 			},
-- 		}
--
-- 	end
-- end

--------------------------------------------------
-- SKELETON WAVE
--------------------------------------------------

-- do
-- 	--------------------------------------------------
-- 	-- CONFIG
-- 	--------------------------------------------------
--
-- 	local spacing = 2
-- 	local homePadding = 2
--
-- 	-- SPAWN AREA
-- 	local spawnMinX = 275
-- 	local spawnMaxX = 285
-- 	local spawnMinY = 614
-- 	local spawnMaxY = 623
--
-- 	-- HOME AREA
-- 	local homeMinX = 555
-- 	local homeMaxX = 570
-- 	local homeMinY = 410
-- 	local homeMaxY = 423
--
-- 	local respawnTime = 23
--
-- 	local team = "tm_Enemy"
-- 	local prefix = "SkeletonWave"
--
-- 	local unitGroups =
-- 	{
-- 		{ UnitId = 893, Level = 3, Count = 4 },
-- 		{ UnitId = 160, Level = 3, Count = 3 },
-- 		{ UnitId = 1198, Level = 3, Count = 4 },
-- 		{ UnitId = 892, Level = 3, Count = 4 },
-- 		{ UnitId = 135, Level = 3, Count = 4 },
-- 		{ UnitId = 963, Level = 3, Count = 4 },
-- 		{ UnitId = 104, Level = 3, Count = 4 },
-- 		{ UnitId = 118, Level = 3, Count = 4 },
-- 		{ UnitId = 1180, Level = 3, Count = 4 },
-- 		{ UnitId = 157, Level = 3, Count = 4 },
-- 		{ UnitId = 133, Level = 3, Count = 4 },
-- 		{ UnitId = 1164, Level = 3, Count = 2 },
-- 		{ UnitId = 699, Level = 3, Count = 3 },
-- 		{ UnitId = 102, Level = 3, Count = 5 },
-- 		{ UnitId = 146, Level = 3, Count = 4 },
-- 		{ UnitId = 374, Level = 3, Count = 4 },
-- 		{ UnitId = 373, Level = 3, Count = 4 },
-- 		{ UnitId = 116, Level = 3, Count = 5 },
-- 		{ UnitId = 81, Level = 3, Count = 6 },
-- 		{ UnitId = 377, Level = 3, Count = 5 },
-- 		{ UnitId = 103, Level = 3, Count = 5 },
-- 		{ UnitId = 442, Level = 3, Count = 4 },
--
-- 	}
--
-- 	--------------------------------------------------
-- 	-- BUILD UNIT LIST
-- 	--------------------------------------------------
--
-- 	local units = {}
--
-- 	for _, group in ipairs(unitGroups) do
-- 		for n = 1, group.Count do
-- 			table.insert(units,
-- 			{
-- 				UnitId = group.UnitId,
-- 				Level = group.Level,
-- 			})
-- 		end
-- 	end
--
-- 	local count = table.getn(units)
--
-- 	--------------------------------------------------
-- 	-- GRID CALC
-- 	--------------------------------------------------
--
-- 	local spawnColumns = math.floor((spawnMaxX - spawnMinX) / spacing) + 1
-- 	local homeColumns = math.floor(((homeMaxX - homeMinX) - homePadding * 2) / spacing) + 1
--
-- 	--------------------------------------------------
-- 	-- INITIAL SPAWN
-- 	--------------------------------------------------
--
-- 	local initActions = {}
-- 	local actionIndex = 1
--
-- 	for i = 1, count do
--
-- 		local npc = units[i]
--
-- 		local spawnRow = math.floor((i - 1) / spawnColumns)
-- 		local spawnCol = math.mod(i - 1, spawnColumns)
--
-- 		local homeRow = math.floor((i - 1) / homeColumns)
-- 		local homeCol = math.mod(i - 1, homeColumns)
--
-- 		local spawnX = spawnMinX + spawnCol * spacing
-- 		local spawnY = spawnMinY + spawnRow * spacing
--
-- 		local homeX = homeMinX + homePadding + homeCol * spacing
-- 		local homeY = homeMinY + homePadding + homeRow * spacing
--
-- 		initActions[actionIndex] = FigureNpcSpawn
-- 		{
-- 			Tag = prefix .. i,
-- 			Level = npc.Level,
-- 			UnitId = npc.UnitId,
-- 			X = spawnX,
-- 			Y = spawnY,
-- 			Team = team,
-- 		}
-- 		actionIndex = actionIndex + 1
--
-- 		initActions[actionIndex] = FigureWalk
-- 		{
-- 			Tag = prefix .. i,
-- 			X = homeX,
-- 			Y = homeY,
-- 		}
-- 		actionIndex = actionIndex + 1
--
-- 	end
--
-- 	--------------------------------------------------
-- 	-- INITIAL EVENT
-- 	--------------------------------------------------
--
-- 	OnOneTimeEvent
-- 	{
-- 		Conditions = {},
-- 		Actions = initActions,
-- 	}
--
-- 	--------------------------------------------------
-- 	-- RESPAWN
-- 	--------------------------------------------------
--
-- 	for i = 1, count do
--
-- 		local npc = units[i]
--
-- 		local spawnRow = math.floor((i - 1) / spawnColumns)
-- 		local spawnCol = math.mod(i - 1, spawnColumns)
--
-- 		local homeRow = math.floor((i - 1) / homeColumns)
-- 		local homeCol = math.mod(i - 1, homeColumns)
--
-- 		local spawnX = spawnMinX + spawnCol * spacing
-- 		local spawnY = spawnMinY + spawnRow * spacing
--
-- 		local homeX = homeMinX + homePadding + homeCol * spacing
-- 		local homeY = homeMinY + homePadding + homeRow * spacing
--
-- 		OnEvent
-- 		{
-- 			Conditions =
-- 			{
-- 				FigureIsDead{Tag = prefix .. i},
-- 				MapFlagIsFalse{Name = "mf_" .. prefix .. "_Respawn" .. i},
-- 			},
--
-- 			Actions =
-- 			{
-- 				MapFlagSetTrue{Name = "mf_" .. prefix .. "_Respawn" .. i},
-- 				MapTimerStart{Name = "mt_" .. prefix .. "_Respawn" .. i},
-- 			},
-- 		}
--
-- 		OnEvent
-- 		{
-- 			Conditions =
-- 			{
-- 				MapFlagIsTrue{Name = "mf_" .. prefix .. "_Respawn" .. i},
-- 				MapTimerIsElapsed{Name = "mt_" .. prefix .. "_Respawn" .. i, Seconds = respawnTime},
-- 			},
--
-- 			Actions =
-- 			{
-- 				FigureNpcSpawn
-- 				{
-- 					Tag = prefix .. i,
-- 					Level = npc.Level,
-- 					UnitId = npc.UnitId,
-- 					X = spawnX,
-- 					Y = spawnY,
-- 					Team = team,
-- 				},
--
-- 				FigureWalk
-- 				{
-- 					Tag = prefix .. i,
-- 					X = homeX,
-- 					Y = homeY,
-- 				},
--
-- 				MapFlagSetFalse{Name = "mf_" .. prefix .. "_Respawn" .. i},
-- 			},
-- 		}
--
-- 	end
-- end

-- PACT DEFENDERS

do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local spacing = 1
	local minDistance = 2

	local spawnMinX = 525
	local spawnMaxX = 540
	local spawnMinY = 376
	local spawnMaxY = 386

	local homeMinX = 547
	local homeMaxX = 572
	local homeMinY = 397
	local homeMaxY = 425

	local respawnTime = 3

	local team = "tm_Human"
	local prefix = "ClanDefender"

	local unitGroups =
	{
		{ UnitId = 172, Level = 3, Count = 5 },
		{ UnitId = 337, Level = 3, Count = 12 },
		{ UnitId = 338, Level = 3, Count = 16 },
		{ UnitId = 88, Level = 3, Count = 4 },
		{ UnitId = 297, Level = 3, Count = 6 },
		{ UnitId = 296, Level = 3, Count = 10 },
		{ UnitId = 452, Level = 3, Count = 8 },
		{ UnitId = 295, Level = 3, Count = 4 },
		{ UnitId = 299, Level = 3, Count = 5 },
		{ UnitId = 291, Level = 3, Count = 13 },
	}

	local units = {}

	for _, group in ipairs(unitGroups) do
		for n = 1, group.Count do
			table.insert(units,
			{
				UnitId = group.UnitId,
				Level = group.Level,
			})
		end
	end

	local count = table.getn(units)
	local spawnColumns = math.floor((spawnMaxX - spawnMinX) / spacing) + 1

	local homePositions = {}

	for i = 1, count do
		local found = false
		local attempts = 0
		local maxAttempts = 100

		while found == false and attempts < maxAttempts do
			attempts = attempts + 1

			local x = math.random(homeMinX, homeMaxX)
			local y = math.random(homeMinY, homeMaxY)

			local good = true

			for p = 1, table.getn(homePositions) do
				local dx = homePositions[p].X - x
				local dy = homePositions[p].Y - y

				if dx * dx + dy * dy < minDistance * minDistance then
					good = false
				end
			end

			if good == true then
				homePositions[i] =
				{
					X = x,
					Y = y,
				}
				found = true
			end
		end

		if found == false then
			homePositions[i] =
			{
				X = math.random(homeMinX, homeMaxX),
				Y = math.random(homeMinY, homeMaxY),
			}
		end
	end

	local initActions = {}
	local actionIndex = 1

	for i = 1, count do
		local npc = units[i]

		local spawnRow = math.floor((i - 1) / spawnColumns)
		local spawnCol = math.mod(i - 1, spawnColumns)

		local spawnX = spawnMinX + spawnCol * spacing
		local spawnY = spawnMinY + spawnRow * spacing

		local homeX = homePositions[i].X
		local homeY = homePositions[i].Y

		initActions[actionIndex] = FigureNpcSpawn
		{
			Tag = prefix .. i,
			Level = npc.Level,
			UnitId = npc.UnitId,
			X = homeX,
			Y = homeY,
			Team = team,
		}
		actionIndex = actionIndex + 1

		initActions[actionIndex] = FigureWalk
		{
			Tag = prefix .. i,
			X = homeX,
			Y = homeY,
		}
		actionIndex = actionIndex + 1
	end

	OnOneTimeEvent
	{
		Conditions = {},
		Actions = initActions,
	}

	for i = 1, count do
		local npc = units[i]

		local spawnRow = math.floor((i - 1) / spawnColumns)
		local spawnCol = math.mod(i - 1, spawnColumns)

		local spawnX = spawnMinX + spawnCol * spacing
		local spawnY = spawnMinY + spawnRow * spacing

		local homeX = homePositions[i].X
		local homeY = homePositions[i].Y

		OnEvent
		{
			Conditions =
			{
				FigureIsDead{Tag = prefix .. i},
				MapFlagIsFalse{Name = "mf_" .. prefix .. "_Respawn" .. i},
			},

			Actions =
			{
				MapFlagSetTrue{Name = "mf_" .. prefix .. "_Respawn" .. i},
				MapTimerStart{Name = "mt_" .. prefix .. "_Respawn" .. i},
			},
		}

		OnEvent
		{
			Conditions =
			{
				MapFlagIsTrue{Name = "mf_" .. prefix .. "_Respawn" .. i},
				MapTimerIsElapsed{Name = "mt_" .. prefix .. "_Respawn" .. i, Seconds = respawnTime},
			},

			Actions =
			{
				FigureNpcSpawn
				{
					Tag = prefix .. i,
					Level = npc.Level,
					UnitId = npc.UnitId,
					X = homeX,
					Y = homeY,
					Team = team,
				},

				FigureWalk
				{
					Tag = prefix .. i,
					X = homeX,
					Y = homeY,
				},

				MapFlagSetFalse{Name = "mf_" .. prefix .. "_Respawn" .. i},
			},
		}

	end
end
--------------------------------------------------
-- STATE
--------------------------------------------------

State
{
	StateName = "NPC_SPAWNS_MAIN",
	OnOneTimeEvent
{
	Conditions = {},
	Actions =
	{
		FogOfWarReveal
		{
			FogOfWarId = 0,
			X = 284,
			Y = 264,
			Range = 90,
			Height = 10,
		},
		FogOfWarReveal
		{
			FogOfWarId = 0,
			X = 399,
			Y = 625,
			Range = 90,
			Height = 10,
		},
		FogOfWarReveal
		{
			FogOfWarId = 0,
			X = 285,
			Y = 616,
			Range = 90,
			Height = 10,
		},
	},
}
}
