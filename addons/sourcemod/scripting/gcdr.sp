#include <sourcemod>
#include <basecomm>
#include <ripext>

public Plugin myinfo =
{
	name = "gcdr",
	author = "noil.lt",
	description = "Game Chat to Discord Relay.",
	version = "0.3",
	url = "https://noil.lt/"
};

ConVar g_cvEnable;
ConVar g_cvWebhook;

public void OnPluginStart()
{
    g_cvEnable = CreateConVar("gcdr_enable", "0", "Toggle whether plugin is enabled. 1 = Enabled, 0 = Disabled");
    g_cvWebhook = CreateConVar("gcdr_discord_webhook_url", "", "Discord webhook full URL", FCVAR_PROTECTED);

    AutoExecConfig(true, "gcdr");
}

void OnRequestFinished(HTTPResponse response, any value, const char[] error)
{
    if (response.Status != HTTPStatus_NoContent) {
        LogMessage("Could not send message. Response Code: %d, Error: %s", response.Status, error);
    }
}

public void OnClientSayCommand_Post(int client, const char[] command, const char[] sArgs)
{
    // Do not run if either: Plugin Disabled, Player Gagged, Chat Trigger, Is Console
    if (!g_cvEnable.BoolValue) return;
    if (BaseComm_IsClientMuted(client) || IsChatTrigger()) return;
    if (client <= 0) return;

    char WebhookUrl[1024], msgContent[512], clientName[128], steamID[64];
    GetConVarString(g_cvWebhook, WebhookUrl, sizeof(WebhookUrl));
    GetClientName(client, clientName, sizeof(clientName));
    GetClientAuthId(client, AuthId_Steam2, steamID, sizeof(steamID));

    HTTPRequest request = new HTTPRequest(WebhookUrl);
    JSONObject payload = new JSONObject();

    ReplaceString(clientName, sizeof(clientName), "@", "", false);
    ReplaceString(clientName, sizeof(clientName), "\\", "", false);
    ReplaceString(clientName, sizeof(clientName), "\\\\", "", false);
    ReplaceString(clientName, sizeof(clientName), "`", "", false);

    FormatEx(clientName, sizeof(clientName), "%s (%s)", clientName, steamID);
    FormatEx(msgContent, sizeof(msgContent), "%s", sArgs);

    payload.SetString("username", clientName);
    payload.SetString("content", msgContent);

    request.Post(view_as<JSON>(payload), OnRequestFinished);
    delete payload;
}
