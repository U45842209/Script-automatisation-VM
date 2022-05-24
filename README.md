##### Marc TAHON-DUJARDIN
##### Louis BEGHIN
##### Groupe : :a:
## SAE21
Vous êtes employé dans la DSI d’une entreprise type PME. Cette société renouvelle son infra-structure IT, et le chef de service vous demande d’automatiser la création d’une maquette de la future infra, via un script de pilotage.

### Nous devions : :memo:
Pour cette SAE nous devions créer un script qui afin de mieux gerer la création des VMs, devait automatiser ce processus.
1. Créer des serveurs **TFTP** et **DHCP**
2. Créer une variable *Path* pour **VBoxManage**
3. Créer un script **Batch** ou **Shell**
4. **Gestion des erreurs** du script
5. Boot **PXE**
6. Boot automatique en Guest-Only
7. Installation automatique de l'**OS**
8. Avoir une **arborescence de versions**
9. Fichier d'explication *.md*

### Nous avons : :memo:
1. Serveurs DHCP et TFTP :heavy_check_mark:
2. Variable *path* pour **VBoxManage** :heavy_check_mark:
3. Script **Batch** ou **Shell** :heavy_check_mark:
4. **Gestion des erreurs** :heavy_check_mark:
5. Boot **PXE** :heavy_check_mark:
6. Boot automatique en Guest-Only :x:
7. Installation automatique de l'**OS** :heavy_exclamation_mark:
```
%path% unattended install "%MachineName%" --iso "C:\Users\Admin\Documents\ISO\debian.iso" --user=user --full-user-name="user" --password "user" --country=FR --package-selection-adjustment=minimal --language=FR
```
8. [**Arborescence de versions**](https://github.com/U45842209/SAE21/releases) :heavy_check_mark:
9. [Fichier d'explication](https://github.com/U45842209/SAE21) *.md* :heavy_check_mark:

### Problèmes rencontrés : :memo:
* Nous avons rencontré des problèmes sur le boot automatique en Guest-Only, nous n'arrivons pas à installer l'iso *VBoxGuestAdditions* sur les VMs donc impossible pour nous de faire cet exercice.
* Nous avons eu des problèmes avec les serveurs DHCP et TFTP pour le boot PXE, car le medium était *introuvable*, mais le problèmes est résolut.
