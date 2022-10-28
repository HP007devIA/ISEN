# Importation des modules
import mysql.connector as mysqlpy
import random

# Variables de connexion à la DataBase

user = "root"
password = "example"
host = "localhost"
port = "3307"
database = "Binômotron"

bdd = mysqlpy.connect(user=user, password=password, host=host, port=port, database=database)
cursor = bdd.cursor()

# Déclaration des variables list

list_apprennts = []
list_groupe = []
list_groupe_date = []
apprenants_gr = []

# Requête de récupération des ID des personnes dans la tâble "personnes"

query="SELECT id_personne, nom, prenom FROM personnes"
cursor.execute(query)

# Insertion des apprenants dans la liste des apprenants

for apprenants in cursor:
    # print(apprenants[0])
    # print(apprenants[0], apprenants[1])
    list_apprennts.append((apprenants[0]))

# Spécification de la taille des groupes

taille_du_groupe = 2

# Fonction de récupération de l'ID maximum des groupes attribués

def recup_id_groupe():
    query_groupe_empty="SELECT COUNT(*) FROM groupe"    # Requête SQL pour connaitre le nombre d'entrée dans la table "groupe"
    cursor.execute(query_groupe_empty)
    nb_id_groupe = cursor.fetchall()
    if nb_id_groupe==[(0,)]:    # Si aucune entrée
        id_groupe_py = 1
    else:
        query_groupe="SELECT id_groupe FROM groupe" # Requête SQL pour récuperer les ID des groupes
        cursor.execute(query_groupe)
        for id_groupe in cursor:
            list_groupe.append((id_groupe[0]))
            id_groupe_py = max(list_groupe) + 1 
    return id_groupe_py

# Fonction de récupération de nombre de groupes total

def max_id_groupe():
    query_groupe_max="SELECT id_groupe FROM date_groupe" # Requête SQL pour récuperer tous les ID des groupes
    cursor.execute(query_groupe_max)
    for id_groupe in cursor:
        list_groupe_date.append((id_groupe[0]))
    id_groupe_max = max(list_groupe_date)   # Indique le nombre de groupe maximum
    return id_groupe_max
    
# Fonction d'attribution des apprenants dans les groupes

def f_groupe() :
    groupe= []
    for i in range(taille_du_groupe):   # Répète selon la taille du groupe
        if not list_apprennts:  # Si plus d'apprenants sort de la boucle
            break
        elif id_groupe_py >= id_groupe_max: # Si plus de groupe sort de la boucle
            break
        personne=random.choice(list_apprennts) # Sélectionne un apprenant au hasard
        groupe.append(personne) # Rajoute l'apprenants dans le groupe temporaire
        list_apprennts.remove(personne) # Retire l'apprenant de la liste d'apprenants
        export = "INSERT INTO groupe(id_personne, id_groupe) VALUES (%s, %s);" # Prépare la requête SQL pour rajouter les valeurs dans la table des groupes
        record = (personne,	id_groupe_py)
        print(export, record)
        cursor.execute(export, record)


def affichage() :
    


    query_app_gr="""SELECT `personnes`.`nom`, `personnes`.`prenom`, `groupe`.`id_groupe`, `date_groupe`.`date`
FROM `groupe`
    LEFT JOIN `date_groupe` ON `groupe`.`id_groupe` = `date_groupe`.`id_groupe`
    LEFT JOIN `personnes` ON `groupe`.`id_personne` = `personnes`.`id_personne`
WHERE (`groupe`.`id_groupe` IS NOT NULL)
"""
    cursor.execute(query_app_gr)

    # with open("mydocument.txt", mode = "a") as f:
    #     f.write('\n' + 'Nom : ' + (apprenants_gr[0]) + '\nPrénom : ' + (apprenants_gr[1]) + '\nGroupe : ' + str((apprenants_gr[2])) + '\nDate : ' + str((apprenants_gr[3])) + '\n')

    
    for apprenants_gr in cursor:
        print('Nom : ' + (apprenants_gr[0]) + '\nPrénom : ' + (apprenants_gr[1]) + '\nGroupe : ' + str((apprenants_gr[2])) + '\nDate : ' + str((apprenants_gr[3])) + '\n')
        with open("mydocument.txt", mode = "a") as f:
            f.write('\n' + 'Nom : ' + (apprenants_gr[0]) + '\nPrénom : ' + (apprenants_gr[1]) + '\nGroupe : ' + str((apprenants_gr[2])) + '\nDate : ' + str((apprenants_gr[3])) + '\n')



# Récupération de nombre de groupes total

id_groupe_max = max_id_groupe()

# Indique le nombre total d'apprenants

apprenant = len(list_apprennts)

# Récupération de l'ID maximum des groupes attribués

id_groupe_py = recup_id_groupe()

# Exécution de la fonction d'attribution des groupes jusqu'à ce que tous les apprenants aient un groupe

while apprenant>0 : 
    f_groupe()
    id_groupe_py = id_groupe_py + 1
    apprenant = apprenant - taille_du_groupe
    if not list_apprennts: 
        print('\n''Plus personne')
        break
    elif id_groupe_py == id_groupe_max:
        print(False)
        break
    elif id_groupe_py >= id_groupe_max: # Si plus de groupe sort de la boucle
        print('Pas assez de groupe')
        break

# Envoie des requettes SQL

bdd.commit()

affichage()

# Fermeture de la connection

if bdd.is_connected():
    cursor.close()
    bdd.close()
    print("\n""MySQL connection is closed")
