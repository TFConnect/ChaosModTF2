#pragma semicolon 1
#pragma newdecls required

public bool InvertConVar_OnStart(ChaosEffect effect)
{
	if (!effect.data)
		return false;
	
	char szName[512];
	effect.data.GetString("convar", szName, sizeof(szName));
	
	ConVar convar = FindConVar(szName);
	if (!convar)
		return false;
	
	convar.FloatValue = -convar.FloatValue;
	
	return true;
}

public void InvertConVar_OnEnd(ChaosEffect effect)
{
	char szName[512];
	effect.data.GetString("convar", szName, sizeof(szName));
	
	ConVar convar = FindConVar(szName);
	convar.FloatValue = -convar.FloatValue;
}