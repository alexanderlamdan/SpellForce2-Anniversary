--*******************************************************
--***                                                 ***
--***             GreifenSammelscriptTeam01           ***
--***                    	                          ***
--*******************************************************



State
{	
	StateName = "INIT",
	OnFigureRespawnEvent	
	{
		WaitTime = 14,
		X = 427,
		Y = 407,
		Conditions =
		{
		},
		Actions = 
		{
			FigureRun	{X = GetEntityX(), Y = GetEntityY()},
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
	
};

