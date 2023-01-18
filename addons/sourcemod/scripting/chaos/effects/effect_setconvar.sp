#pragma semicolon 1
#pragma newdecls required

static StringMap g_hOldConvarValues;

public void SetConVar_Initialize(ChaosEffect effect)
{
	g_hOldConvarValues = new StringMap();
}

public bool SetConVar_OnStart(ChaosEffect effect)
{
	if (!effect.data)
		return false;
	
	char szName[512];
	effect.data.GetString("convar", szName, sizeof(szName));
	
	// Don't set the same convar twice
	if (FindKeyValuePairInActiveEffects(effect.effect_class, "convar", szName))
		return false;
	
	ConVar convar = FindConVar(szName);
	if (!convar)
		return false;
	
	char szValue[512], szOldValue[512];
	effect.data.GetString("value", szValue, sizeof(szValue));
	convar.GetString(szOldValue, sizeof(szOldValue));
	
	// Don't start effect if the convar value is already set to the desired value
	if (StrEqual(szOldValue, szValue))
		return false;
	
	g_hOldConvarValues.SetString(szName, szOldValue);
	convar.SetString(szValue, true);
	
	return true;
}

public void SetConVar_OnEnd(ChaosEffect effect)
{
	char szName[512], szValue[512];
	effect.data.GetString("convar", szName, sizeof(szName));
	g_hOldConvarValues.GetString(szName, szValue, sizeof(szValue));
	
	ConVar convar = FindConVar(szName);
	convar.SetString(szValue, true);
	g_hOldConvarValues.Remove(szName);
}
