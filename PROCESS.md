# 16-01-2018

Vandaag heb ik GoogleMaps en GooglePlaces toegevoegd aan mijn app. Onderstaand een aantal screenshots van complete ViewControllers.

<img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/LoginScreen.png" width="250"> <img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/IndexScreen.png" width="250"> <img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/MapScreen.png" width="250">

# 17-01-2018

Vandaag heb ik geprobeerd om place pickers te krijgen bij alle GooglePlaces, dit is alleen niet gelukt. Ook kwam ik er achter dat je via GoogleMaps geen geofence kan creëren, terwijl dit noodzakelijk is bij mijn app. Helaas waren er geen assistenten meer om mij te helpen hierbij. 

# 18-01-2018

Ik wilde vandaag de assistenten om hulp en advies vragen alleen door de strom kon dit niet. Nu ben ik Map Kit aan het gebruiken in plaats van GoogleMaps. De app kan nu de huidige locatie van de gebruiker opvragen, als de gebruiker toestemming geeft. Door middel van MKAnnotation kan ik nu ook locaties toevoegen. Door middel van een JSON wil ik alle barretjes en cafés gaan toevoegen.

# 22-01-2018

Vandaag heb ik een geschikte API gevonden: https://api.eet.nu/venues?query=cafes. Ik heb de namen en de coördinaten ingeladen in de app. Hierna heb ik de coördinaten omgeschreven naar MLocationCoordinate2D, zodat ik de cafes op mijn map kan inladen via MKAnnotation. Eigenlijk wil ik dit voor morgenochtend af hebben, zodat ik kan beginnen met de verificatie.

