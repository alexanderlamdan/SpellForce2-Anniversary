--*******************************************************
--***                                                 ***
--***             GreifenSammelscriptTeam02           ***
--***                    	                          ***
--*******************************************************



State
{	
	StateName = "INIT",
	OnOneTimeEvent
	{
    	
		Conditions =
		{
			
		},
		Actions =
		{
			FigureWalkToEntity	{TargetTag = "AimGreifenTeam02"},
		},
		
	},
	
	OnFigureRespawnEvent	
	{
		WaitTime = 13,
		X = GetEntityX(),
		Y = GetEntityY(),
		Conditions =
		{

		},
		Actions = 
		{
			FigureWalkToEntity	{TargetTag = "AimGreifenTeam02"},
		},
		DeathActions = 
		{
			
		}, 
		DelayedActions = 
		{
		}, 
		NoSpawnEffect = false, 
		IsSpawnOnlyWhen = false,
	},
	
	OnOneTimeEvent
	{
    	
		Conditions =
		{

		},
		Actions =
		{
			FigureVanish	{Tag = "Greif01"},
			FigureVanish	{Tag = "Greif02"},
			FigureVanish	{Tag = "Greif05"},
			FigureVanish	{Tag = "Greif06"},
		},
		
	},
	
};

