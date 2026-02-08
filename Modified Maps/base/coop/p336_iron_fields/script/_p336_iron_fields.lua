State
{
	StateName = "INIT",

	OnOneTimeEvent
	{
		Conditions =
		{
	    	-- fill_me
		},
		Actions =
		{
			FogOfWarReveal
			{
				FogOfWarId = 0,
				X = 620,
				Y = 593,
				Range = 90,
				Height = 10,
			},
			FogOfWarReveal
			{
				FogOfWarId = 0,
				X = 541,
				Y = 422,
				Range = 90,
				Height = 10,
			},
			FogOfWarReveal
			{
				FogOfWarId = 0,
				X = 357,
				Y = 298,
				Range = 90,
				Height = 10,
			},
		},
		GotoState = MAIN,
	},
};
