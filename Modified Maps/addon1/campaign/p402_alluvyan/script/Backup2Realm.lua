State
{
	StateName = "INIT",
	OnFigureRespawnEvent
	{
		WaitTime = 10,
		X = 466,
		Y = 229,
		Conditions =
		{
			MapFlagIsTrue {Name = "mf_EndMainGateCS"},
		},
		Actions =
		{
			FigureRun{Tag="Backup2Realm1", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm2", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm3", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm4", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm5", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm6", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm7", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm8", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm9", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm10", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm11", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm12", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm13", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm14", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm15", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm16", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm17", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm18", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm19", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm20", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm21", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm22", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm23", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm24", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm25", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm26", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm27", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm28", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm29", X = 324, Y = 407},
			FigureRun{Tag="Backup2Realm30", X = 324, Y = 407},
		},
	},
}
