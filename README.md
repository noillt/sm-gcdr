# Game Chat to Discord Relay
Relay game chat in your source dedicated server to a discord chat.

## Dependencies

This plugin requires [sm-ripext](https://github.com/ErikMinekus/sm-ripext) extension.
1. Download latest `sm-ripext` from their [Releases](https://github.com/ErikMinekus/sm-ripext/releases)
2. Extract to `/path/to/cstrike/`
3. Within server run `sm exts load rip` or restart server

# Setup

1. Download latest version from [Releases](https://github.com/noillt/sm-gcdr/releases)
2. Extract to `/path/to/cstrike/`
3. Configure Webhook and Enable plugin in `/path/to/cstrike/cfg/sourcemod/gcdr.cfg`
4. Within server run `sm plugins load gcdr`

## Discord Webhook

1. Open the Discord channel you want to receive GitLab event notifications.
2. From the channel menu, select Edit channel.
3. Select Integrations.
4. If there are no existing webhooks, select Create Webhook. Otherwise, select View Webhooks then New Webhook.
5. Enter the name of the bot to post the message.
6. Optional. Edit the avatar.
7. Copy the URL from the WEBHOOK URL field.
