State
{
	StateName = "INIT",
	OnFigureRespawnEvent
	{
		WaitTime = 11,
		X = 124,
		Y = 105,
		Conditions =
		{
			QuestIsNotSolved {Quest = "WinterlightPeak_LastStand"},
		},
		Actions =
		{
		},
		
	},
	OnIdleRunHomeFake
	{
		X = GetEntityX(),
		Y = GetEntityY() ,
		Conditions =
		{
		},
		Actions =
		{
		},
		HomeActions =
		{
			FigureLookAtDirection {}
		}
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			QuestIsSolved {Quest = "WinterlightPeak_LastStand"},
		},
		Actions =
		{
			FigureVanish {},
		},
	},
}
