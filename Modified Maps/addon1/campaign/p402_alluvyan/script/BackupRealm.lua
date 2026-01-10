State
{
	StateName = "INIT",
	OnFigureRespawnEvent
	{
		WaitTime = 15,
		X = 281,
		Y = 204,
		Conditions =
		{
			MapFlagIsTrue {Name = "mf_EndMainGateCS"},
		},
		Actions =
		{

			FigureRun{Tag="BackupRealm1", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm2", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm3", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm4", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm5", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm6", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm7", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm8", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm9", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm10", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm11", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm12", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm13", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm14", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm15", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm16", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm17", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm18", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm19", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm20", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm21", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm22", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm23", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm24", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm25", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm26", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm27", X = 407, Y = 401},
			FigureRun{Tag="BackupRealm28", X = 407, Y = 401},

		},
	},
}
