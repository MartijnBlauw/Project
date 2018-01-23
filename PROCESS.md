# 16-01-2018

Vandaag heb ik GoogleMaps en GooglePlaces toegevoegd aan mijn app. Onderstaand een aantal screenshots van complete ViewControllers.

<img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/LoginScreen.png" width="250"> <img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/IndexScreen.png" width="250"> <img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/MapScreen.png" width="250">

# 17-01-2018

Vandaag heb ik geprobeerd om place pickers te krijgen bij alle GooglePlaces, dit is alleen niet gelukt. Ook kwam ik er achter dat je via GoogleMaps geen geofence kan creëren, terwijl dit noodzakelijk is bij mijn app. Helaas waren er geen assistenten meer om mij te helpen hierbij. 

# 18-01-2018

Ik wilde vandaag de assistenten om hulp en advies vragen alleen door de strom kon dit niet. Nu ben ik Map Kit aan het gebruiken in plaats van GoogleMaps. De app kan nu de huidige locatie van de gebruiker opvragen, als de gebruiker toestemming geeft. Door middel van MKAnnotation kan ik nu ook locaties toevoegen. Door middel van een JSON wil ik alle barretjes en cafés gaan toevoegen.

# 22-01-2018

Vandaag heb ik een geschikte API gevonden: https://api.eet.nu/venues?query=cafes. Ik heb de namen en de coördinaten ingeladen in de app. Hierna heb ik de coördinaten omgeschreven naar MLocationCoordinate2D, zodat ik de cafes op mijn map kan inladen via MKAnnotation. Eigenlijk wil ik dit voor morgenochtend af hebben, zodat ik kan beginnen met de verificatie.

# 23-01-2018

 - Voorheen werkte mijn app met een tab bar, maar dit bleek niet handig te zijn als je data wilt doorsturen naar een andere ViewController. Daarom heb ik de tab bar verwijderd uit mijn app en maak ik nu gebruik van buttons om zo met 1 klik de user door te sturen naar een nieuw scherm.

- Als de user een credit collect dan wordt het aantal aangepast in de Index ViewController. Ook de 'free drink' button werkt nu, maar alleen als de user meer dan 10 credits heeft. In het geval dat dit niet zo is, krijgt de user een pop-up.

- Het model waarin mijn data uit de API wordt ingeladen heb ik omgeschreven, zodat ik morgen deze data gemakkelijker kan inladen in mijn map.

- Morgen wil de credits van de user gaan opslaan in Firebase, zodat dit continu wordt bijgehouden. Daarnaast wil de data van de API inladen in mijn map. Als dit gelukt is, kan ik beginnen met de functies waarmee de locatie van de user geverifieerd wordt met de locatie van de ingeladen cafés.
