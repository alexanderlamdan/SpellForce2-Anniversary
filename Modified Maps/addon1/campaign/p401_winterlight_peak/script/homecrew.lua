State
{
	StateName = "INIT",
	OnFigureRespawnEvent
	{
		WaitTime = 12,
		X = 126,
		Y = 103,
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
