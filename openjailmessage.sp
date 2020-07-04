// Uses parts of button watcher and JailDoors

#include <sdktools>
#include <sourcemod>
#include <colorvariables>

bool JailAlreadyOpen;

Handle AutoOpenJailTimer;

public Plugin myinfo =
{
	name = "OpenJailMessage",
	author = "azalty/rlevet",
	description = "Sends a message in the chat saying who opened jails",
	version = "1.0.3",
	url = "TheWalkingJail https://discord.gg/Q7b57yk"
};

public void OnPluginStart()
{
	HookEntityOutput("func_button", "OnPressed", Button_Pressed);
	HookEvent("round_start", OnRoundStart);
	HookEvent("round_end", OnRoundEnd);
	
	JailAlreadyOpen = false;
}

public void OnRoundStart(Handle event, const char[] name, bool dontBroadcast)
{
	JailAlreadyOpen = false;
	
	if (GameRules_GetProp("m_bWarmupPeriod") == 0)
	{
		AutoOpenJailTimer = CreateTimer(60.0, AutoOpenJail, _, TIMER_FLAG_NO_MAPCHANGE);
	}
}

public void OnRoundEnd(Handle event, const char[] name, bool dontBroadcast)
{
	delete AutoOpenJailTimer;
}

public Action AutoOpenJail(Handle timer)
{
	if (!JailAlreadyOpen)
	{
		JailAlreadyOpen = true;
		
		char CurrentMap[256];
		GetCurrentMap(CurrentMap, 256);
		
		// add each map here, and just comment inside if jails already auto-open to prevent double opening
		
		int index = -1;
		char entityname[512];
		
		while ((index = FindEntityByClassname(index, "func_button")) != -1)
		{
			GetEntPropString(index, Prop_Data, "m_iName", entityname, sizeof(entityname));
			
			if (StrEqual(CurrentMap, "ba_jail_minecraftparty_v6", true))
			{
				if (StrEqual(entityname, "knopf_jail_green", true))
				{
					AcceptEntityInput(index, "PressIn");
					break;
				}
			}
			else if (StrEqual(CurrentMap, "jb_clouds_beta02", true))
			{
				break;
			}
			else if (StrEqual(CurrentMap, "jb_undertale_v1e", true))
			{
				break;
			}
			else if (StrEqual(CurrentMap, "ba_jail_umbrella", true))
			{
				break;
			}
			else if (StrEqual(CurrentMap, "jb_moonjail_v2", true))
			{
				break;
			}
			else if (StrEqual(CurrentMap, "jb_cavern_v1b", true))
			{
				break;
			}
			else if (StrEqual(CurrentMap, "jb_spy_vs_spy_beta7", true))
			{
				break;
			}
			else if (StrEqual(CurrentMap, "ba_jail_reloaded", true))
			{
				break;
			}
			else if (StrEqual(CurrentMap, "jb_chicken_island", true))
			{
				break;
			}
			else
			{
				// don't say that jails weren't opened in time because map isn't setup yet, so we can't really know
				AutoOpenJailTimer = INVALID_HANDLE;
				return;
			}
		}
		
		CPrintToChatAll("{green}[Jails] {default}Les jails {red}n'ont pas été ouvertes à temps {default}-> {green}Quartier Libre !");
	}
	
	AutoOpenJailTimer = INVALID_HANDLE;
}

public void Button_Pressed(const char[] output, int caller, int activator, float delay)
{
	if (!IsValidClient(activator) || !IsValidEntity(caller)) return;
	
	if (JailAlreadyOpen) return;
	
	char entity[512];
	GetEntPropString(caller, Prop_Data, "m_iName", entity, sizeof(entity));
	
	char CurrentMap[256];
	GetCurrentMap(CurrentMap, 256);

	// manually enter map name and button name here
	if (StrEqual(CurrentMap, "jb_dystopian_b6", true))
	{
		if (!StrEqual(entity, "yard_game_but_man", true))
		{
			return;
		}
	}
	else if (StrEqual(CurrentMap, "ba_jail_minecraftparty_v6", true))
	{
		if (!StrEqual(entity, "knopf_jail_green", true))
		{
			return;
		}
	}
	else if (StrEqual(CurrentMap, "jb_clouds_beta02", true))
	{
		if (!StrEqual(entity, "zelle_button", true))
		{
			return;
		}
	}
	else if (StrEqual(CurrentMap, "jb_undertale_v1e", true))
	{
		if (!StrEqual(entity, "celldoors", true))
		{
			return;
		}
	}
	else if (StrEqual(CurrentMap, "ba_jail_umbrella", true))
	{
		if (!StrEqual(entity, "button_jails", true))
		{
			return;
		}
	}
	else if (StrEqual(CurrentMap, "jb_moonjail_v2", true))
	{
		if (!StrEqual(entity, "jails", true))
		{
			return;
		}
	}
	else if (StrEqual(CurrentMap, "jb_cavern_v1b", true))
	{
		if (caller != 493)
		{
			return;
		}
	}
	else if (StrEqual(CurrentMap, "jb_spy_vs_spy_beta7", true))
	{
		if (!StrEqual(entity, "cell_button", true))
		{
			return;
		}
	}
	else if (StrEqual(CurrentMap, "ba_jail_reloaded", true))
	{
		if (!StrEqual(entity, "open_jail", true))
		{
			return;
		}
	}
	else if (StrEqual(CurrentMap, "jb_chicken_island", true))
	{
		if (!StrEqual(entity, "jail_open_button", true))
		{
			return;
		}
	}
	else if (StrEqual(CurrentMap, "map_name", true))
	{
		if (!StrEqual(entity, "button_name", true))
		{
			return;
		}
	}
	else
	{
		return;
	}
	
	JailAlreadyOpen = true;
	
	if (GetClientTeam(activator) == 2)
	{
		CPrintToChatAll("{green}[Jails] {default}Le {red}prisonnier %N {default}a ouvert les jails -> {green}Quartier Libre !", activator);
	}
	else
	{
		CPrintToChatAll("{green}[Jails] {default}Le {darkblue}gardien %N {default}a ouvert les jails !", activator);
	}
	//PrintToChatAll(" \x02[BW] \x0C%N \x04pressed button\x0C %i %s", activator, caller, entity);
	// activator = client
	// caller = button number
	// entity = button name
}

public bool IsValidClient( int client ) 
{ 
    if ( !( 1 <= client <= MaxClients ) || !IsClientInGame(client) || !IsPlayerAlive(client) ) 
        return false; 
     
    return true; 
}
