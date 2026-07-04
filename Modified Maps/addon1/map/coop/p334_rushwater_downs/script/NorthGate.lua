--------------------------------------------------
-- COMBINED DEFENDERS
-- One script, one State, two generated NPC groups
--------------------------------------------------

--------------------------------------------------
-- EAST DEFENDERS
--------------------------------------------------

do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local columns = 5
	local spacing = 3

	local homeX = 345
	local homeY = 317

	local spawnX = 302
	local spawnY = 317

	local respawnTime = 10

	local team = "tm_Coop"
	local prefix = "EastGate"

	local unitGroups =
	{
		{ UnitId = 309, Level = 3, Count = 9 },
		-- { UnitId = 309, Level = 3, Count = 5 },
		-- { UnitId = 315, Level = 4, Count = 3 },
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

	--------------------------------------------------
	-- INITIAL SPAWN
	--------------------------------------------------

	local initActions = {}
	local actionIndex = 1

	for i = 1, count do

		local npc = units[i]

		local row = math.floor((i - 1) / columns)
		local col = math.mod(i - 1, columns)

		local targetX = homeX + col * spacing
		local targetY = homeY + row * spacing

		initActions[actionIndex] = FigureNpcSpawn
		{
			Tag = prefix .. i,
			Level = npc.Level,
			UnitId = npc.UnitId,
			X = spawnX,
			Y = spawnY,
			Team = team,
		}
		actionIndex = actionIndex + 1

		initActions[actionIndex] = FigureWalk
		{
			Tag = prefix .. i,
			X = targetX,
			Y = targetY,
		}
		actionIndex = actionIndex + 1

	end

	--------------------------------------------------
	-- INITIAL EVENT
	--------------------------------------------------

	OnOneTimeEvent
	{
		Conditions = {},
		Actions = initActions,
	}

	--------------------------------------------------
	-- RESPAWN
	--------------------------------------------------

	for i = 1, count do

		local npc = units[i]

		local row = math.floor((i - 1) / columns)
		local col = math.mod(i - 1, columns)

		local targetX = homeX + col * spacing
		local targetY = homeY + row * spacing

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
					X = spawnX,
					Y = spawnY,
					Team = team,
				},

				FigureWalk
				{
					Tag = prefix .. i,
					X = targetX,
					Y = targetY,
				},

				MapFlagSetFalse{Name = "mf_" .. prefix .. "_Respawn" .. i},
			},
		}

	end
end

--------------------------------------------------
-- NORTH GATE
--------------------------------------------------

do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local spacing = 3
	local homePadding = 3

	-- SPAWN AREA
	local spawnMinX = 300
	local spawnMaxX = 304
	local spawnMinY = 317
	local spawnMaxY = 325

	-- HOME AREA
	local homeMinX = 289
	local homeMaxX = 310
	local homeMinY = 376
	local homeMaxY = 396

	local respawnTime = 10

	local team = "tm_Coop"
	local prefix = "NorthGate"

	local unitGroups =
	{
		{ UnitId = 304, Level = 3, Count = 9 },
		{ UnitId = 311, Level = 3, Count = 5 },
		{ UnitId = 305, Level = 3, Count = 3 },
	}

	--------------------------------------------------
	-- BUILD UNIT LIST
	--------------------------------------------------

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

	--------------------------------------------------
	-- GRID CALC
	--------------------------------------------------

	local spawnColumns = math.floor((spawnMaxX - spawnMinX) / spacing) + 1
	local homeColumns = math.floor(((homeMaxX - homeMinX) - homePadding * 2) / spacing) + 1

	--------------------------------------------------
	-- INITIAL SPAWN
	--------------------------------------------------

	local initActions = {}
	local actionIndex = 1

	for i = 1, count do

		local npc = units[i]

		local spawnRow = math.floor((i - 1) / spawnColumns)
		local spawnCol = math.mod(i - 1, spawnColumns)

		local homeRow = math.floor((i - 1) / homeColumns)
		local homeCol = math.mod(i - 1, homeColumns)

		local spawnX = spawnMinX + spawnCol * spacing
		local spawnY = spawnMinY + spawnRow * spacing

		local homeX = homeMinX + homePadding + homeCol * spacing
		local homeY = homeMinY + homePadding + homeRow * spacing

		initActions[actionIndex] = FigureNpcSpawn
		{
			Tag = prefix .. i,
			Level = npc.Level,
			UnitId = npc.UnitId,
			X = spawnX,
			Y = spawnY,
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

	--------------------------------------------------
	-- INITIAL EVENT
	--------------------------------------------------

	OnOneTimeEvent
	{
		Conditions = {},
		Actions = initActions,
	}

	--------------------------------------------------
	-- RESPAWN
	--------------------------------------------------

	for i = 1, count do

		local npc = units[i]

		local spawnRow = math.floor((i - 1) / spawnColumns)
		local spawnCol = math.mod(i - 1, spawnColumns)

		local homeRow = math.floor((i - 1) / homeColumns)
		local homeCol = math.mod(i - 1, homeColumns)

		local spawnX = spawnMinX + spawnCol * spacing
		local spawnY = spawnMinY + spawnRow * spacing

		local homeX = homeMinX + homePadding + homeCol * spacing
		local homeY = homeMinY + homePadding + homeRow * spacing

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
					X = spawnX,
					Y = spawnY,
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


do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local spacing = 2
	local homePadding = 1

	-- SPAWN AREA
	local spawnMinX = 300
	local spawnMaxX = 304
	local spawnMinY = 317
	local spawnMaxY = 325

	-- HOME AREA
	local homeMinX = 303
	local homeMaxX = 312
	local homeMinY = 271
	local homeMaxY = 278

	local respawnTime = 10

	local team = "tm_Coop"
	local prefix = "SouthGate"

	local unitGroups =
	{
		{ UnitId = 312, Level = 3, Count = 4 },
		{ UnitId = 313, Level = 3, Count = 4 },
-- 		{ UnitId = 305, Level = 3, Count = 3 },
	}

	--------------------------------------------------
	-- BUILD UNIT LIST
	--------------------------------------------------

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

	--------------------------------------------------
	-- GRID CALC
	--------------------------------------------------

	local spawnColumns = math.floor((spawnMaxX - spawnMinX) / spacing) + 1
	local homeColumns = math.floor(((homeMaxX - homeMinX) - homePadding * 2) / spacing) + 1

	--------------------------------------------------
	-- INITIAL SPAWN
	--------------------------------------------------

	local initActions = {}
	local actionIndex = 1

	for i = 1, count do

		local npc = units[i]

		local spawnRow = math.floor((i - 1) / spawnColumns)
		local spawnCol = math.mod(i - 1, spawnColumns)

		local homeRow = math.floor((i - 1) / homeColumns)
		local homeCol = math.mod(i - 1, homeColumns)

		local spawnX = spawnMinX + spawnCol * spacing
		local spawnY = spawnMinY + spawnRow * spacing

		local homeX = homeMinX + homePadding + homeCol * spacing
		local homeY = homeMinY + homePadding + homeRow * spacing

		initActions[actionIndex] = FigureNpcSpawn
		{
			Tag = prefix .. i,
			Level = npc.Level,
			UnitId = npc.UnitId,
			X = spawnX,
			Y = spawnY,
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

	--------------------------------------------------
	-- INITIAL EVENT
	--------------------------------------------------

	OnOneTimeEvent
	{
		Conditions = {},
		Actions = initActions,
	}

	--------------------------------------------------
	-- RESPAWN
	--------------------------------------------------

	for i = 1, count do

		local npc = units[i]

		local spawnRow = math.floor((i - 1) / spawnColumns)
		local spawnCol = math.mod(i - 1, spawnColumns)

		local homeRow = math.floor((i - 1) / homeColumns)
		local homeCol = math.mod(i - 1, homeColumns)

		local spawnX = spawnMinX + spawnCol * spacing
		local spawnY = spawnMinY + spawnRow * spacing

		local homeX = homeMinX + homePadding + homeCol * spacing
		local homeY = homeMinY + homePadding + homeRow * spacing

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
					X = spawnX,
					Y = spawnY,
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

-- VILLAGE DEFENDERS

do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local spacing = 2
	local minDistance = 3

	-- SPAWN AREA
	local spawnMinX = 611
	local spawnMaxX = 618
	local spawnMinY = 98
	local spawnMaxY = 102

	-- HOME AREA / VILLAGE RANDOM
	local homeMinX = 597
	local homeMaxX = 621
	local homeMinY = 107
	local homeMaxY = 151

	local respawnTime = 10

	local team = "tm_Coop"
	local prefix = "VillageDefender"

	local unitGroups =
	{
		{ UnitId = 312, Level = 3, Count = 6 },
		{ UnitId = 305, Level = 3, Count = 4 },
		{ UnitId = 304, Level = 3, Count = 8 },
		{ UnitId = 313, Level = 3, Count = 7 },
		{ UnitId = 309, Level = 3, Count = 7 },
		{ UnitId = 310, Level = 3, Count = 10 },
		{ UnitId = 307, Level = 3, Count = 3 },
		{ UnitId = 306, Level = 3, Count = 5 },
		{ UnitId = 311, Level = 3, Count = 10 },
	}

	--------------------------------------------------
	-- BUILD UNIT LIST
	--------------------------------------------------

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

	--------------------------------------------------
	-- SPAWN GRID CALC
	--------------------------------------------------

	local spawnColumns = math.floor((spawnMaxX - spawnMinX) / spacing) + 1

	--------------------------------------------------
	-- RANDOM HOME POSITIONS
	--------------------------------------------------

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

	--------------------------------------------------
	-- INITIAL SPAWN
	--------------------------------------------------

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
			X = spawnX,
			Y = spawnY,
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

	--------------------------------------------------
	-- INITIAL EVENT
	--------------------------------------------------

	OnOneTimeEvent
	{
		Conditions = {},
		Actions = initActions,
	}

	--------------------------------------------------
	-- RESPAWN
	--------------------------------------------------

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
					X = spawnX,
					Y = spawnY,
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
	StateName = "COMBINED_DEFENDERS_MAIN",
}
