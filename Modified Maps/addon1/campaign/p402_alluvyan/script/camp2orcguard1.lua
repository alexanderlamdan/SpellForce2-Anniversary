
--*******************************************************
--***                                                 ***
--***             OrcMeleeTeam01    		          ***
--***                    	                          ***
--*******************************************************



State
{	
	StateName = "INIT",
	OnFigureRespawnEvent	
	{
		WaitTime = 11,
		X = 399,
		Y = 393,
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

