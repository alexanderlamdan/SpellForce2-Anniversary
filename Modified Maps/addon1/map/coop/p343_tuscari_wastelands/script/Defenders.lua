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

	local respawnTime = 5
	local minDistance = 1
	local maxAttempts = 300
	local level = 11

	local team = "tm_Human"
	local prefix = "RealmArmyLeft"

	-- ATTACK TARGET
-- 	local targetX = 313
-- 	local targetY = 75

	--------------------------------------------------
	-- ALLOWED SPAWN AREAS
	--------------------------------------------------

	local allowedSpawnAreas =
	{
		{
			MinX = 344,
			MaxX = 372,
			MinY = 183,
			MaxY = 206,
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
		{ UnitId = 312, Level = level, Count = 8 },
		{ UnitId = 313, Level = level, Count = 12 },
		{ UnitId = 309, Level = level, Count = 8 },
		{ UnitId = 310, Level = level, Count = 7 },
		{ UnitId = 305, Level = level, Count = 7 },
		{ UnitId = 304, Level = level, Count = 10 },
		{ UnitId = 311, Level = level, Count = 13 },
		{ UnitId = 306, Level = level, Count = 8 },
		{ UnitId = 307, Level = level, Count = 7 },
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

-- 		initActions[actionIndex] = FigureWalk
-- 		{
-- 			Tag = prefix .. i,
-- 			X = targetX,
-- 			Y = targetY,
-- 		}
-- 		actionIndex = actionIndex + 1
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

-- 				FigureWalk
-- 				{
-- 					Tag = prefix .. i,
-- 					X = targetX,
-- 					Y = targetY,
-- 				},

				MapFlagSetFalse{Name = "mf_" .. prefix .. "_Respawn" .. i},
			},
		}
	end
end
--------------------------------------------------
-- REALM ARMY RIGHT
--------------------------------------------------
do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local respawnTime = 6
	local minDistance = 0
	local maxAttempts = 300
	local level = 11

	local team = "tm_Human"
	local prefix = "RealmArmyRight"

	-- ATTACK TARGET
-- 	local targetX = 313
-- 	local targetY = 75

	--------------------------------------------------
	-- ALLOWED SPAWN AREAS
	--------------------------------------------------

	local allowedSpawnAreas =
	{
		{
			MinX = 385,
			MaxX = 406,
			MinY = 193,
			MaxY = 207,
		},
	}

	local blockedSpawnAreas =
	{
		{
			MinX = 390,
			MaxX = 407,
			MinY = 156,
			MaxY = 184,
		},
	}

	--------------------------------------------------
	-- UNITS
	--------------------------------------------------

	local unitGroups =
	{
		{ UnitId = 312, Level = level, Count = 7 },
		{ UnitId = 313, Level = level, Count = 8 },
		{ UnitId = 309, Level = level, Count = 9 },
		{ UnitId = 310, Level = level, Count = 7 },
		{ UnitId = 305, Level = level, Count = 7 },
		{ UnitId = 304, Level = level, Count = 10 },
		{ UnitId = 311, Level = level, Count = 12 },
		{ UnitId = 306, Level = level, Count = 7 },
		{ UnitId = 307, Level = level, Count = 7 },
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

-- 		initActions[actionIndex] = FigureWalk
-- 		{
-- 			Tag = prefix .. i,
-- 			X = targetX,
-- 			Y = targetY,
-- 		}
-- 		actionIndex = actionIndex + 1
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

-- 				FigureWalk
-- 				{
-- 					Tag = prefix .. i,
-- 					X = targetX,
-- 					Y = targetY,
-- 				},

				MapFlagSetFalse{Name = "mf_" .. prefix .. "_Respawn" .. i},
			},
		}
	end
end

do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local respawnTime = 7
	local minDistance = 1
	local maxAttempts = 300
	local level = 11

	local team = "tm_Human"
	local prefix = "RealmArmyDown"

	-- ATTACK TARGET
-- 	local targetX = 313
-- 	local targetY = 75

	--------------------------------------------------
	-- ALLOWED SPAWN AREAS
	--------------------------------------------------

	local allowedSpawnAreas =
	{
		{
			MinX = 392,
			MaxX = 420,
			MinY = 149,
			MaxY = 155,
		},
	}

	local blockedSpawnAreas =
	{
		{
			MinX = 399,
			MaxX = 403,
			MinY = 145,
			MaxY = 148,
		},
	}

	--------------------------------------------------
	-- UNITS
	--------------------------------------------------

	local unitGroups =
	{
		{ UnitId = 312, Level = level, Count = 8 },
		{ UnitId = 309, Level = level, Count = 4 },
		{ UnitId = 305, Level = level, Count = 3 },
		{ UnitId = 304, Level = level, Count = 3 },
		{ UnitId = 311, Level = level, Count = 3 },
		{ UnitId = 307, Level = level, Count = 5 },
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

-- 		initActions[actionIndex] = FigureWalk
-- 		{
-- 			Tag = prefix .. i,
-- 			X = targetX,
-- 			Y = targetY,
-- 		}
-- 		actionIndex = actionIndex + 1
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

-- 				FigureWalk
-- 				{
-- 					Tag = prefix .. i,
-- 					X = targetX,
-- 					Y = targetY,
-- 				},

				MapFlagSetFalse{Name = "mf_" .. prefix .. "_Respawn" .. i},
			},
		}
	end
end

do
	--------------------------------------------------
	-- CONFIG
	--------------------------------------------------

	local respawnTime = 9
	local minDistance = 2
	local maxAttempts = 300
	local level = 11

	local team = "tm_Human"
	local prefix = "RealmArmyCenter"

	-- ATTACK TARGET
-- 	local targetX = 313
-- 	local targetY = 75

	--------------------------------------------------
	-- ALLOWED SPAWN AREAS
	--------------------------------------------------

	local allowedSpawnAreas =
	{
		{
			MinX = 354,
			MaxX = 386,
			MinY = 154,
			MaxY = 197,
		},
	}

	local blockedSpawnAreas =
	{
		{
			MinX = 366,
			MaxX = 386,
			MinY = 144,
			MaxY = 153,
		},
	}

	--------------------------------------------------
	-- UNITS
	--------------------------------------------------

	local unitGroups =
	{
		{ UnitId = 312, Level = level, Count = 14 },
		{ UnitId = 309, Level = level, Count = 10 },
		{ UnitId = 305, Level = level, Count = 8 },
		{ UnitId = 304, Level = level, Count = 12 },
		{ UnitId = 311, Level = level, Count = 15 },
		{ UnitId = 307, Level = level, Count = 5 },
		{ UnitId = 310, Level = level, Count = 12 },
		{ UnitId = 306, Level = level, Count = 6 },
		{ UnitId = 313, Level = level, Count = 12 },
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

-- 		initActions[actionIndex] = FigureWalk
-- 		{
-- 			Tag = prefix .. i,
-- 			X = targetX,
-- 			Y = targetY,
-- 		}
-- 		actionIndex = actionIndex + 1
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

-- 				FigureWalk
-- 				{
-- 					Tag = prefix .. i,
-- 					X = targetX,
-- 					Y = targetY,
-- 				},

				MapFlagSetFalse{Name = "mf_" .. prefix .. "_Respawn" .. i},
			},
		}
	end
end

-- REALM ARMY

-- do
-- 	--------------------------------------------------
-- 	-- CONFIG
-- 	--------------------------------------------------
--
-- 	local respawnTime = 4
-- 	local minDistance = 2
-- 	local maxAttempts = 300
--
-- 	local team = "tm_realm"
-- 	local prefix = "RealmArmy"
--
-- 	-- ATTACK TARGET
-- 	local targetX = 313
-- 	local targetY = 75
--
-- 	--------------------------------------------------
-- 	-- ALLOWED SPAWN AREAS
-- 	--------------------------------------------------
--
-- 	local allowedSpawnAreas =
-- 	{
-- 		{
-- 			MinX = 256,
-- 			MaxX = 271,
-- 			MinY = 75,
-- 			MaxY = 100,
-- 		},
-- 	}
--
-- 	local blockedSpawnAreas =
-- 	{
-- 	}
--
-- 	--------------------------------------------------
-- 	-- UNITS
-- 	--------------------------------------------------
--
-- 	local unitGroups =
-- 	{
-- 		{ UnitId = 311, Level = 6, Count = 12 },
-- 		{ UnitId = 304, Level = 6, Count = 11 },
-- 		{ UnitId = 305, Level = 6, Count = 6 },
-- 		{ UnitId = 306, Level = 6, Count = 6 },
-- 		{ UnitId = 308, Level = 6, Count = 7 },
-- 		{ UnitId = 312, Level = 6, Count = 9 },
-- 		{ UnitId = 313, Level = 6, Count = 9 },
-- 		{ UnitId = 310, Level = 6, Count = 12 },
-- 		{ UnitId = 309, Level = 6, Count = 9 },
-- 		{ UnitId = 307, Level = 6, Count = 4 },
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
-- 	-- HELPERS
-- 	--------------------------------------------------
--
-- 	local function IsInsideArea(x, y, area)
-- 		if x >= area.MinX and x <= area.MaxX and y >= area.MinY and y <= area.MaxY then
-- 			return true
-- 		end
--
-- 		return false
-- 	end
--
-- 	local function IsBlockedPoint(x, y)
-- 		for i = 1, table.getn(blockedSpawnAreas) do
-- 			if IsInsideArea(x, y, blockedSpawnAreas[i]) == true then
-- 				return true
-- 			end
-- 		end
--
-- 		return false
-- 	end
--
-- 	local function IsTooClose(x, y, points)
-- 		for i = 1, table.getn(points) do
-- 			local dx = points[i].X - x
-- 			local dy = points[i].Y - y
--
-- 			if dx * dx + dy * dy < minDistance * minDistance then
-- 				return true
-- 			end
-- 		end
--
-- 		return false
-- 	end
--
-- 	local function GetRandomAllowedPoint()
-- 		local areaIndex = math.random(1, table.getn(allowedSpawnAreas))
-- 		local area = allowedSpawnAreas[areaIndex]
--
-- 		local x = math.random(area.MinX, area.MaxX)
-- 		local y = math.random(area.MinY, area.MaxY)
--
-- 		return x, y
-- 	end
--
-- 	--------------------------------------------------
-- 	-- RANDOM SPAWN POSITIONS
-- 	--------------------------------------------------
--
-- 	local spawnPositions = {}
--
-- 	for i = 1, count do
-- 		local found = false
-- 		local attempts = 0
--
-- 		while found == false and attempts < maxAttempts do
-- 			attempts = attempts + 1
--
-- 			local x, y = GetRandomAllowedPoint()
--
-- 			if IsBlockedPoint(x, y) == false and IsTooClose(x, y, spawnPositions) == false then
-- 				spawnPositions[i] =
-- 				{
-- 					X = x,
-- 					Y = y,
-- 				}
--
-- 				found = true
-- 			end
-- 		end
--
-- 		if found == false then
-- 			local x, y = GetRandomAllowedPoint()
--
-- 			spawnPositions[i] =
-- 			{
-- 				X = x,
-- 				Y = y,
-- 			}
-- 		end
-- 	end
--
-- 	--------------------------------------------------
-- 	-- INITIAL SPAWN AND ATTACK
-- 	--------------------------------------------------
--
-- 	local initActions = {}
-- 	local actionIndex = 1
--
-- 	for i = 1, count do
-- 		local npc = units[i]
--
-- 		local spawnX = spawnPositions[i].X
-- 		local spawnY = spawnPositions[i].Y
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
-- 	end
--
-- 	OnOneTimeEvent
-- 	{
-- 		Conditions = {},
-- 		Actions = initActions,
-- 	}
--
-- 	--------------------------------------------------
-- 	-- RESPAWN AND ATTACK
-- 	--------------------------------------------------
--
-- 	for i = 1, count do
-- 		local npc = units[i]
--
-- 		local spawnX = spawnPositions[i].X
-- 		local spawnY = spawnPositions[i].Y
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
-- 	end
-- end
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

		}
	}
}
