--------------------------------------------------
-- COMBINED DEFENDERS
-- One script, one State, two generated NPC groups
--------------------------------------------------

--------------------------------------------------
-- PACT DEFENDER
--------------------------------------------------
do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local respawnTime = 4
	local minDistance = 2
	local maxAttempts = 300

	local team = "tm_pact"
	local prefix = "PactArmy"

	-- ATTACK TARGET
	local targetX = 313
	local targetY = 75

	--------------------------------------------------
	-- ALLOWED SPAWN AREAS
	--------------------------------------------------

	local allowedSpawnAreas =
	{
		{
			MinX = 317,
			MaxX = 327,
			MinY = 100,
			MaxY = 106,
		},
	}

	local blockedSpawnAreas =
	{
	}

	--------------------------------------------------
	-- UNITS
	--------------------------------------------------

	local unitGroups =
	{
		{ UnitId = 79, Level = 6, Count = 12 },
		{ UnitId = 911, Level = 6, Count = 6 },
		{ UnitId = 901, Level = 6, Count = 6 },
		{ UnitId = 80, Level = 6, Count = 5 },
		{ UnitId = 910, Level = 6, Count = 4 },
		{ UnitId = 88, Level = 6, Count = 4 },
		{ UnitId = 337, Level = 6, Count = 12 },
		{ UnitId = 336, Level = 6, Count = 20 },
		{ UnitId = 338, Level = 6, Count = 13 },
		{ UnitId = 890, Level = 6, Count = 5 },
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
		for i = 1, table.getn(blockedSpawnAreas) do
			if IsInsideArea(x, y, blockedSpawnAreas[i]) == true then
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
		local areaIndex = math.random(1, table.getn(allowedSpawnAreas))
		local area = allowedSpawnAreas[areaIndex]

		local x = math.random(area.MinX, area.MaxX)
		local y = math.random(area.MinY, area.MaxY)

		return x, y
	end

	--------------------------------------------------
	-- RANDOM SPAWN POSITIONS
	--------------------------------------------------

	local spawnPositions = {}

	for i = 1, count do
		local found = false
		local attempts = 0

		while found == false and attempts < maxAttempts do
			attempts = attempts + 1

			local x, y = GetRandomAllowedPoint()

			if IsBlockedPoint(x, y) == false and IsTooClose(x, y, spawnPositions) == false then
				spawnPositions[i] =
				{
					X = x,
					Y = y,
				}

				found = true
			end
		end

		if found == false then
			local x, y = GetRandomAllowedPoint()

			spawnPositions[i] =
			{
				X = x,
				Y = y,
			}
		end
	end

	--------------------------------------------------
	-- INITIAL SPAWN AND ATTACK
	--------------------------------------------------

	local initActions = {}
	local actionIndex = 1

	for i = 1, count do
		local npc = units[i]

		local spawnX = spawnPositions[i].X
		local spawnY = spawnPositions[i].Y

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

	OnOneTimeEvent
	{
		Conditions = {},
		Actions = initActions,
	}

	--------------------------------------------------
	-- RESPAWN AND ATTACK
	--------------------------------------------------

	for i = 1, count do
		local npc = units[i]

		local spawnX = spawnPositions[i].X
		local spawnY = spawnPositions[i].Y

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
-- Clan ARMY
--------------------------------------------------
do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local respawnTime = 4
	local minDistance = 2
	local maxAttempts = 300

	local team = "tm_clan"
	local prefix = "ClanArmy"

	-- ATTACK TARGET
	local targetX = 313
	local targetY = 75

	--------------------------------------------------
	-- ALLOWED SPAWN AREAS
	--------------------------------------------------

	local allowedSpawnAreas =
	{
		{
			MinX = 400,
			MaxX = 408,
			MinY = 67,
			MaxY = 84,
		},
	}

	local blockedSpawnAreas =
	{
	}

	--------------------------------------------------
	-- UNITS
	--------------------------------------------------

	local unitGroups =
	{
		{ UnitId = 296, Level = 6, Count = 5 },
		{ UnitId = 297, Level = 6, Count = 7 },
		{ UnitId = 293, Level = 6, Count = 6 },
		{ UnitId = 294, Level = 6, Count = 12 },
		{ UnitId = 292, Level = 6, Count = 14 },
		{ UnitId = 291, Level = 6, Count = 13 },
		{ UnitId = 300, Level = 6, Count = 10 },
		{ UnitId = 452, Level = 6, Count = 8 },
		{ UnitId = 295, Level = 6, Count = 5 },
		{ UnitId = 299, Level = 6, Count = 4 },
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
		for i = 1, table.getn(blockedSpawnAreas) do
			if IsInsideArea(x, y, blockedSpawnAreas[i]) == true then
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
		local areaIndex = math.random(1, table.getn(allowedSpawnAreas))
		local area = allowedSpawnAreas[areaIndex]

		local x = math.random(area.MinX, area.MaxX)
		local y = math.random(area.MinY, area.MaxY)

		return x, y
	end

	--------------------------------------------------
	-- RANDOM SPAWN POSITIONS
	--------------------------------------------------

	local spawnPositions = {}

	for i = 1, count do
		local found = false
		local attempts = 0

		while found == false and attempts < maxAttempts do
			attempts = attempts + 1

			local x, y = GetRandomAllowedPoint()

			if IsBlockedPoint(x, y) == false and IsTooClose(x, y, spawnPositions) == false then
				spawnPositions[i] =
				{
					X = x,
					Y = y,
				}

				found = true
			end
		end

		if found == false then
			local x, y = GetRandomAllowedPoint()

			spawnPositions[i] =
			{
				X = x,
				Y = y,
			}
		end
	end

	--------------------------------------------------
	-- INITIAL SPAWN AND ATTACK
	--------------------------------------------------

	local initActions = {}
	local actionIndex = 1

	for i = 1, count do
		local npc = units[i]

		local spawnX = spawnPositions[i].X
		local spawnY = spawnPositions[i].Y

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

	OnOneTimeEvent
	{
		Conditions = {},
		Actions = initActions,
	}

	--------------------------------------------------
	-- RESPAWN AND ATTACK
	--------------------------------------------------

	for i = 1, count do
		local npc = units[i]

		local spawnX = spawnPositions[i].X
		local spawnY = spawnPositions[i].Y

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
-- REALM ARMY

do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local respawnTime = 4
	local minDistance = 2
	local maxAttempts = 300

	local team = "tm_realm"
	local prefix = "RealmArmy"

	-- ATTACK TARGET
	local targetX = 313
	local targetY = 75

	--------------------------------------------------
	-- ALLOWED SPAWN AREAS
	--------------------------------------------------

	local allowedSpawnAreas =
	{
		{
			MinX = 256,
			MaxX = 271,
			MinY = 75,
			MaxY = 100,
		},
	}

	local blockedSpawnAreas =
	{
	}

	--------------------------------------------------
	-- UNITS
	--------------------------------------------------

	local unitGroups =
	{
		{ UnitId = 311, Level = 6, Count = 12 },
		{ UnitId = 304, Level = 6, Count = 11 },
		{ UnitId = 305, Level = 6, Count = 6 },
		{ UnitId = 306, Level = 6, Count = 6 },
		{ UnitId = 308, Level = 6, Count = 7 },
		{ UnitId = 312, Level = 6, Count = 9 },
		{ UnitId = 313, Level = 6, Count = 9 },
		{ UnitId = 310, Level = 6, Count = 12 },
		{ UnitId = 309, Level = 6, Count = 9 },
		{ UnitId = 307, Level = 6, Count = 4 },
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
		for i = 1, table.getn(blockedSpawnAreas) do
			if IsInsideArea(x, y, blockedSpawnAreas[i]) == true then
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
		local areaIndex = math.random(1, table.getn(allowedSpawnAreas))
		local area = allowedSpawnAreas[areaIndex]

		local x = math.random(area.MinX, area.MaxX)
		local y = math.random(area.MinY, area.MaxY)

		return x, y
	end

	--------------------------------------------------
	-- RANDOM SPAWN POSITIONS
	--------------------------------------------------

	local spawnPositions = {}

	for i = 1, count do
		local found = false
		local attempts = 0

		while found == false and attempts < maxAttempts do
			attempts = attempts + 1

			local x, y = GetRandomAllowedPoint()

			if IsBlockedPoint(x, y) == false and IsTooClose(x, y, spawnPositions) == false then
				spawnPositions[i] =
				{
					X = x,
					Y = y,
				}

				found = true
			end
		end

		if found == false then
			local x, y = GetRandomAllowedPoint()

			spawnPositions[i] =
			{
				X = x,
				Y = y,
			}
		end
	end

	--------------------------------------------------
	-- INITIAL SPAWN AND ATTACK
	--------------------------------------------------

	local initActions = {}
	local actionIndex = 1

	for i = 1, count do
		local npc = units[i]

		local spawnX = spawnPositions[i].X
		local spawnY = spawnPositions[i].Y

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

	OnOneTimeEvent
	{
		Conditions = {},
		Actions = initActions,
	}

	--------------------------------------------------
	-- RESPAWN AND ATTACK
	--------------------------------------------------

	for i = 1, count do
		local npc = units[i]

		local spawnX = spawnPositions[i].X
		local spawnY = spawnPositions[i].Y

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

do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local respawnTime = 4
	local minDistance = 1
	local maxAttempts = 300

	local team = "tm_shaikan"
	local prefix = "ShaikanArmy"

	-- ATTACK TARGET
	local targetX = 313
	local targetY = 75

	--------------------------------------------------
	-- ALLOWED SPAWN AREAS
	--------------------------------------------------

	local allowedSpawnAreas =
	{
		{
			MinX = 275,
			MaxX = 308,
			MinY = 105,
			MaxY = 134,
		},
	}

	local blockedSpawnAreas =
	{
	}

	--------------------------------------------------
	-- UNITS
	--------------------------------------------------

	local unitGroups =
	{
		{ UnitId = 1126, Level = 6, Count = 5 },
		{ UnitId = 1128, Level = 6, Count = 6 },
		{ UnitId = 1141, Level = 6, Count = 3 },
		{ UnitId = 1125, Level = 6, Count = 4 },
		{ UnitId = 1146, Level = 6, Count = 5 },
		{ UnitId = 1121, Level = 6, Count = 5 },
		{ UnitId = 1149, Level = 6, Count = 4 },
		{ UnitId = 1119, Level = 6, Count = 6 },
		{ UnitId = 1122, Level = 6, Count = 6 },
		{ UnitId = 1120, Level = 6, Count = 7 },
		{ UnitId = 1127, Level = 6, Count = 5 },
		{ UnitId = 1134, Level = 6, Count = 3 },
		{ UnitId = 1143, Level = 6, Count = 7 },
		{ UnitId = 1142, Level = 6, Count = 3 },
		{ UnitId = 1123, Level = 6, Count = 4 },
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
		for i = 1, table.getn(blockedSpawnAreas) do
			if IsInsideArea(x, y, blockedSpawnAreas[i]) == true then
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
		local areaIndex = math.random(1, table.getn(allowedSpawnAreas))
		local area = allowedSpawnAreas[areaIndex]

		local x = math.random(area.MinX, area.MaxX)
		local y = math.random(area.MinY, area.MaxY)

		return x, y
	end

	--------------------------------------------------
	-- RANDOM SPAWN POSITIONS
	--------------------------------------------------

	local spawnPositions = {}

	for i = 1, count do
		local found = false
		local attempts = 0

		while found == false and attempts < maxAttempts do
			attempts = attempts + 1

			local x, y = GetRandomAllowedPoint()

			if IsBlockedPoint(x, y) == false and IsTooClose(x, y, spawnPositions) == false then
				spawnPositions[i] =
				{
					X = x,
					Y = y,
				}

				found = true
			end
		end

		if found == false then
			local x, y = GetRandomAllowedPoint()

			spawnPositions[i] =
			{
				X = x,
				Y = y,
			}
		end
	end

	--------------------------------------------------
	-- INITIAL SPAWN AND ATTACK
	--------------------------------------------------

	local initActions = {}
	local actionIndex = 1

	for i = 1, count do
		local npc = units[i]

		local spawnX = spawnPositions[i].X
		local spawnY = spawnPositions[i].Y

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

	OnOneTimeEvent
	{
		Conditions = {},
		Actions = initActions,
	}

	--------------------------------------------------
	-- RESPAWN AND ATTACK
	--------------------------------------------------

	for i = 1, count do
		local npc = units[i]

		local spawnX = spawnPositions[i].X
		local spawnY = spawnPositions[i].Y

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
			X = 313,
			Y = 75,
			Range = 150,
			Height = 10,
		},
		FogOfWarReveal
		{
			FogOfWarId = 0,
			X = 396,
			Y = 378,
			Range = 90,
			Height = 10,
		},
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
