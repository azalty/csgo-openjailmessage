# csgo-openjailmessage
A plugin for french jailbreak/ba jail servers that writes on the chat who opened jails, and also auto opens after some time

### Comment ça marche ?
Vous devez modifier puis compiler le fichier .sp (avec spcomp.exe ou compile.exe)

Liste des choses à modifier :
- Ligne 35 : Vous pouvez modifier le temps après lequel les jails s'ouvrent toutes seules (def: 60.0)
- Ligne 62 : Vous pouvez modifer les maps prises en charge par l'ouverture auto. Copiez le code et changez le nom de la map et le nom du bouton pour ouvrir les jails. Si vous ne voulez pas ouvrir les jails toutes seules, tapez le nom de la map et faites break; - fiez-vous aux maps déjà faites
- Ligne 125 : Ajoutez chaque map et son bouton (de nouveau). Si le bouton n'a pas de son, regardez l'exemple ligne 169 (avec l'ID du bouton)

### J'ai besoin d'aide :O
Désolé, je ne peux pas vraiment fournir de l'aide si vous n'avez pas quelques connaissances en SourcePawn pour comprendre le code et le modifier. Le code n'a pas été pensé pour être donné à tout le monde, mais j'ai décidé de le donner.\
Support dispo sur discord: https://discord.gg/Sr33BEH

Vous avez trouvé un bug ? Signalez-le sur le discord support ou dans les [Issues de ce repo](https://github.com/rlevet/csgo-openjailmessage/issues), merci !

### Plugins nécéssaires ?
Vous devez avoir l'include [colorvariables.inc](https://forums.alliedmods.net/showthread.php?t=267743) (placez-le dans addons/sourcemod/scripting/include)
