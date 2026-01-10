--*******************************************************
--***                                                 ***
--***             GreifenSammelscriptTeam01           ***
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
			FigureWalkToEntity	{TargetTag = "AimGreifenTeam01"},
			MapFlagSetTrue {Name = "mf_StartOutcryFlyingSupport"},
		},
		
	},
	
	OnFigureRespawnEvent	
	{
		WaitTime = 12,
		X = GetEntityX(),
		Y = GetEntityY(),
		Conditions =
		{

		},
		Actions = 
		{
			FigureWalkToEntity	{TargetTag = "AimGreifenTeam01"},
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
			FigureVanish	{Tag = "Greif03"},
			FigureVanish	{Tag = "Greif04"},
			FigureVanish	{Tag = "Greif07"},
			FigureVanish	{Tag = "Greif08"},
		},
		
	},
	
};

