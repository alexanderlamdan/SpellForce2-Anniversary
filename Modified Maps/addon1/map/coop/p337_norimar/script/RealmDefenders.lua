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
-- West Gates
do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local respawnTime = 4
	local minDistance = 2
	local maxAttempts = 300

	local team = "tm_HumanTeam"
	local prefix = "WestGateDefender"

	--------------------------------------------------
	-- ALLOWED HOME AREAS
	-- тут МОЖНО спавнить
	--------------------------------------------------

	local allowedHomeAreas =
	{
		-- Ворота у воды
		{
			MinX = 445,
			MaxX = 470,
			MinY = 569,
			MaxY = 576,
		},

		-- Подъём / проход вверх
-- 		{
-- 			MinX = 252,
-- 			MaxX = 260,
-- 			MinY = 574,
-- 			MaxY = 634,
-- 		},
	}

	--------------------------------------------------
	-- BLOCKED HOME AREAS
	-- тут НЕЛЬЗЯ спавнить
	-- запрет работает только когда X и Y вместе попали в область
	--------------------------------------------------

	local blockedHomeAreas =
	{
		-- пример: опасная зона возле воды/забора
-- 		{
-- 			MinX = 260,
-- 			MaxX = 301,
-- 			MinY = 627,
-- 			MaxY = 636,
-- 		},

		-- сюда добавляешь новые пятна:
		-- {
		-- 	MinX = 258,
		-- 	MaxX = 262,
		-- 	MinY = 580,
		-- 	MaxY = 590,
		-- },
	}

	--------------------------------------------------
	-- UNITS
	--------------------------------------------------

	local unitGroups =
	{
		{ UnitId = 312, Level = 3, Count = 12 },
		{ UnitId = 311,  Level = 3, Count = 18 },
		{ UnitId = 309, Level = 3, Count = 10 },
		{ UnitId = 304,  Level = 3, Count = 6 },
		{ UnitId = 307,  Level = 3, Count = 4 },
--[[		{ UnitId = 890, Level = 4, Count = 4 },
		{ UnitId = 338, Level = 4, Count = 12 },
		{ UnitId = 336, Level = 4, Count = 7 },
		{ UnitId = 337, Level = 4, Count = 10 },
		{ UnitId = 901, Level = 4, Count = 4 },
		{ UnitId = 910, Level = 4, Count = 5 },
		{ UnitId = 911, Level = 4, Count = 8 },
		{ UnitId = 80,  Level = 4, Count = 5 },
		{ UnitId = 79,  Level = 4, Count = 16 }]]
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
	-- HELPERS
	--------------------------------------------------

	local function IsInsideArea(x, y, area)

		if x >= area.MinX and x <= area.MaxX and y >= area.MinY and y <= area.MaxY then
			return true
		end

		return false

	end

	local function IsBlockedPoint(x, y)

		for i = 1, table.getn(blockedHomeAreas) do

			if IsInsideArea(x, y, blockedHomeAreas[i]) == true then
				return true
			end

		end

		return false

	end

	local function IsTooClose(x, y, points)

		for i = 1, table.getn(points) do

			local dx = points[i].X - x
			local dy = points[i].Y - y

			if dx * dx + dy * dy < minDistance * minDistance then
				return true
			end

		end

		return false

	end

	local function GetRandomAllowedPoint()

		local areaIndex = math.random(1, table.getn(allowedHomeAreas))
		local area = allowedHomeAreas[areaIndex]

		local x = math.random(area.MinX, area.MaxX)
		local y = math.random(area.MinY, area.MaxY)

		return x, y

	end

	--------------------------------------------------
	-- RANDOM HOME POSITIONS
	--------------------------------------------------

	local homePositions = {}

	for i = 1, count do

		local found = false
		local attempts = 0

		while found == false and attempts < maxAttempts do

			attempts = attempts + 1

			local x, y = GetRandomAllowedPoint()

			if IsBlockedPoint(x, y) == false and IsTooClose(x, y, homePositions) == false then

				homePositions[i] =
				{
					X = x,
					Y = y,
				}

				found = true

			end

		end

		if found == false then

			local fallbackFound = false
			local fallbackAttempts = 0

			while fallbackFound == false and fallbackAttempts < maxAttempts do

				fallbackAttempts = fallbackAttempts + 1

				local x, y = GetRandomAllowedPoint()

				if IsBlockedPoint(x, y) == false then

					homePositions[i] =
					{
						X = x,
						Y = y,
					}

					fallbackFound = true

				end

			end

			if fallbackFound == false then

				homePositions[i] =
				{
					X = 449,
					Y = 572,
				}

			end

		end

	end

	--------------------------------------------------
	-- INITIAL SPAWN
	--------------------------------------------------

	local initActions = {}
	local actionIndex = 1

	for i = 1, count do

		local npc = units[i]

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

	end

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

				MapFlagSetFalse{Name = "mf_" .. prefix .. "_Respawn" .. i},
			},
		}

	end
end

-- EAST GATES

do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local respawnTime = 4
	local minDistance = 2
	local maxAttempts = 300

	local team = "tm_HumanTeam"
	local prefix = "EastGateDefender"

	--------------------------------------------------
	-- ALLOWED HOME AREAS
	-- тут МОЖНО спавнить
	--------------------------------------------------

	local allowedHomeAreas =
	{
		-- Ворота у воды
-- 		{
-- 			MinX = 250,
-- 			MaxX = 303,
-- 			MinY = 637,
-- 			MaxY = 646,
-- 		},

		-- Подъём / проход вверх
		{
			MinX = 366,
			MaxX = 386,
			MinY = 578,
			MaxY = 583,
		},
	}

	--------------------------------------------------
	-- BLOCKED HOME AREAS
	-- тут НЕЛЬЗЯ спавнить
	-- запрет работает только когда X и Y вместе попали в область
	--------------------------------------------------

	local blockedHomeAreas =
	{
		-- пример: опасная зона возле воды/забора
-- 		{
-- 			MinX = 260,
-- 			MaxX = 301,
-- 			MinY = 627,
-- 			MaxY = 636,
-- 		},
--
-- -- 		сюда добавляешь новые пятна:
-- 		{
-- 			MinX = 242,
-- 			MaxX = 256,
-- 			MinY = 590,
-- 			MaxY = 652,
-- 		},
	}

	--------------------------------------------------
	-- UNITS
	--------------------------------------------------

	local unitGroups =
	{
		{ UnitId = 312, Level = 3, Count = 12 },
		{ UnitId = 311,  Level = 3, Count = 18 },
		{ UnitId = 309, Level = 3, Count = 10 },
		{ UnitId = 304,  Level = 3, Count = 6 },
		{ UnitId = 307,  Level = 3, Count = 4 },
		{ UnitId = 305,  Level = 3, Count = 3 },
		{ UnitId = 306,  Level = 3, Count = 5 },
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
	-- HELPERS
	--------------------------------------------------

	local function IsInsideArea(x, y, area)

		if x >= area.MinX and x <= area.MaxX and y >= area.MinY and y <= area.MaxY then
			return true
		end

		return false

	end

	local function IsBlockedPoint(x, y)

		for i = 1, table.getn(blockedHomeAreas) do

			if IsInsideArea(x, y, blockedHomeAreas[i]) == true then
				return true
			end

		end

		return false

	end

	local function IsTooClose(x, y, points)

		for i = 1, table.getn(points) do

			local dx = points[i].X - x
			local dy = points[i].Y - y

			if dx * dx + dy * dy < minDistance * minDistance then
				return true
			end

		end

		return false

	end

	local function GetRandomAllowedPoint()

		local areaIndex = math.random(1, table.getn(allowedHomeAreas))
		local area = allowedHomeAreas[areaIndex]

		local x = math.random(area.MinX, area.MaxX)
		local y = math.random(area.MinY, area.MaxY)

		return x, y

	end

	--------------------------------------------------
	-- RANDOM HOME POSITIONS
	--------------------------------------------------

	local homePositions = {}

	for i = 1, count do

		local found = false
		local attempts = 0

		while found == false and attempts < maxAttempts do

			attempts = attempts + 1

			local x, y = GetRandomAllowedPoint()

			if IsBlockedPoint(x, y) == false and IsTooClose(x, y, homePositions) == false then

				homePositions[i] =
				{
					X = x,
					Y = y,
				}

				found = true

			end

		end

		if found == false then

			local fallbackFound = false
			local fallbackAttempts = 0

			while fallbackFound == false and fallbackAttempts < maxAttempts do

				fallbackAttempts = fallbackAttempts + 1

				local x, y = GetRandomAllowedPoint()

				if IsBlockedPoint(x, y) == false then

					homePositions[i] =
					{
						X = x,
						Y = y,
					}

					fallbackFound = true

				end

			end

			if fallbackFound == false then

				homePositions[i] =
				{
					X = 250,
					Y = 637,
				}

			end

		end

	end

	--------------------------------------------------
	-- INITIAL SPAWN
	--------------------------------------------------

	local initActions = {}
	local actionIndex = 1

	for i = 1, count do

		local npc = units[i]

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

	end

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
-- 		FogOfWarReveal
-- 		{
-- 			FogOfWarId = 0,
-- 			X = 543,
-- 			Y = 418,
-- 			Range = 90,
-- 			Height = 10,
-- 		},
-- 		FogOfWarReveal
-- 		{
-- 			FogOfWarId = 0,
-- 			X = 620,
-- 			Y = 595,
-- 			Range = 90,
-- 			Height = 10,
-- 		},
-- 		FogOfWarReveal
-- 		{
-- 			FogOfWarId = 0,
-- 			X = 352,
-- 			Y = 303,
-- 			Range = 90,
-- 			Height = 10,
-- 		},
	}
}
}
