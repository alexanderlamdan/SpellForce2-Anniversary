State
{
	StateName = "INIT",
	OnFigureRespawnEvent
	{
		WaitTime = 10,
		X = 301,
		Y = 313,
		Conditions =
		{
		},
		Actions =
		{
			FigureWalk{Tag="SouthDefender1", X = 309, Y = 271},
			FigureWalk{Tag="SouthDefender2", X = 309, Y = 271},
			FigureWalk{Tag="SouthDefender3", X = 309, Y = 271},
			FigureWalk{Tag="SouthDefender4", X = 309, Y = 271},
			FigureWalk{Tag="SouthDefender5", X = 309, Y = 271},
			FigureWalk{Tag="SouthDefender6", X = 309, Y = 271},
			FigureWalk{Tag="SouthDefender7", X = 309, Y = 271},
			FigureWalk{Tag="SouthDefender8", X = 309, Y = 271},
		},
	},
}
