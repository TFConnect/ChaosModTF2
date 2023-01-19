#pragma semicolon 1
#pragma newdecls required

public void HideHUD_OnEnd(ChaosEffect effect)
{
	for (int client = 1; client <= MaxClients; client++)
	{
		if (!IsClientInGame(client))
			continue;
		
		SetEntProp(client, Prop_Send, "m_iHideHUD", 0);
	}
}

public void HideHUD_OnGameFrame(ChaosEffect effect)
{
	for (int client = 1; client <= MaxClients; client++)
	{
		if (!IsClientInGame(client))
			continue;
		
		SetEntProp(client, Prop_Send, "m_iHideHUD", HIDEHUD_HEALTH | HIDEHUD_MISCSTATUS | HIDEHUD_CROSSHAIR);
	}
}
