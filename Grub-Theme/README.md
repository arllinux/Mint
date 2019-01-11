# Steam Big Picture: Grub theme

### Latest Screenshot

![ScreenShot](http://i.imgur.com/yQCOjnR.png)

Ok, alors pour les premières étapes, vous allez vouloir déterminer quelles résolutions sont supportées par grub, vous pouvez le trouver en installant `hwinfo`, et en lançant :

```
hwinfo --framebuffer
```

Ou en redémarrant et dans le menu grub, ouvrez la ligne de commande avec 'C', et entrez

```
vbeinfo
```

Les sorties peuvent être différentes. Donc, une fois que vous avez trouvé vos résolutions prises en charge, notez celle qui correspond à votre résolution prise en charge la plus élevée (ou à la suivante en dessous). Maintenant, pour l’installer exécutez la commande suivant pour récupérer l'ensemble du dépot git :
---
git clone https://github.com/arllinux/mint
---

Entrez dans le répertoire :
---
cd Grub-Theme
---

### Exigences :

Vous aurez besoin d'installer le paquet mscorefonts et le paquet imagemagick. Sur Ubuntu, la commande est :

```
sudo apt install ttf-mscorefonts-installer imagemagick
```
Pour lancer l'installation :
---
./install.sh
---
Il suffit de répondre aux quelques questions qui ont été traduites en français par le sloteur fou...

### Problèmes connus :

L’image `UserName.png` doit être convertie en RVB dans Gimp après l’installation. L'image que vous devez éditer sera située dans `/ boot / grub / themes / SteamBP` dans Ubuntu. D'autres distributions placent ce répertoire ailleurs. J'essaie de comprendre pourquoi ImageMagick le garde en niveaux de gris.
### FAQ:

1.  **Pourquoi ne faites-vous pas des versions grand écran ? **

   Par expérience, même lorsque grub prend en charge une résolution d’écran large, le thème semble insignifiant. De plus, je m'en tiens aux résolutions standard de l'extension VESA BIOS Extension. Cependant, vous êtes libre d'expérimenter des thèmes indépendants de la résolution.

2.  **Comment puis-je le désactiver ?**

    Ouvrez `/ etc /default/grub` en root dans votre éditeur de texte de votre choix et trouvez la ligne« GRUB_THEME = / some / directory », puis commentez-la (mettez un« # »au début de la ligne) ou effacez-le, puis enregistrez-le.

     Ensuite, faites une commande `update-grub` avec root (probablement Ubuntu uniquement) ou exécutez le script` mkconfig` de grub avec root (présent dans `/grub`,` /boot/grub` ou `/boot/grub2`)

     Vous pouvez aussi lancer

        grub-mkconfig -o /path/to/grub.cfg
        grub2-mkconfig -o /path/to/grub.cfg

    sur votre distribution en tant que root

3.  **Puis-je ajouter l'icone de ma distribution ?**

    Oui. Je serais ravi de le faire, mais il faudrait que vous sachiez comment nommer l'icône, ce que vous pouvez trouver en ouvrant votre fichier `grub.cfg` et en localisant l'entrée du menu de votre distribution, pour que vous ' ll y aura une ligne comme

        menuentry "Gentoo" --class gentoo --class os...

    En gros, j'ai besoin de connaître le nom de la classe de distribution pour savoir comment nommer l'icône.

4.  **Fontionne-t-il avex grub 1 legacy**

    Malheureusement grub 1 ne supporte pas les images

### Steam Big Picture Grub Theme TODO list

- ~~Move Progress bar to above buttons, but centered. Remove border and glow, but give grey background. Gradient on fill as well.~~

- ~~Change title to "Select OS" and center~~

- Make text in list bigger

- ~~Get colors and look more accurate.~~

- Figure out how to get all menu items to be capitalized.

- ~~Add bokeh dots to background~~

#### One more thing

You might noticed the GetProfileImage.sh.x and GetProfileImage.sh. The one with the .x extension is just the .sh file "compiled" with shc. The only thing different from them is that the .x file has an API key written into it.

### Screenshots:

**Old Version**
![ScreenShot](http://i.imgur.com/T4pbHXT.png)

**New Version**

### 1600x1200  OLD (Static Placement Version)
![ScreenShot](http://i.imgur.com/RbZttjy.png)

### 1600x1200 NEW (Relative Placement Version)
![ScreenShot](http://i.imgur.com/USD0JJP.png)

### 1024x768
![ScreenShot](http://i.imgur.com/bMxCQ4E.png)

### 800x600
![ScreenShot](http://i.imgur.com/HxX2EsO.png)

### 640x480 - NOT RECOMMENDED!!
![ScreenShot](http://i.imgur.com/l5aT9fE.png)


