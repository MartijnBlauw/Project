# 16-01-2018

Vandaag heb ik GoogleMaps en GooglePlaces toegevoegd aan mijn app. Onderstaand een aantal screenshots van complete ViewControllers.

<img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/LoginScreen.png" width="250"> <img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/IndexScreen.png" width="250"> <img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/MapScreen.png" width="250">

# 17-01-2018

Vandaag heb ik geprobeerd om place pickers te krijgen bij alle GooglePlaces, dit is alleen niet gelukt. Ook kwam ik er achter dat het lastig is om via GoogleMaps gebruik te maken van geofence, terwijl dit noodzakelijk is bij mijn app. Helaas waren er geen assistenten meer om mij te helpen hierbij.

# 18-01-2018

Ik wilde vandaag de assistenten om hulp en advies vragen alleen door de storm kon dit niet. Nu ben ik MapKit aan het gebruiken in plaats van GoogleMaps. De app kan nu de huidige locatie van de gebruiker opvragen, als de gebruiker toestemming geeft. Door middel van MKAnnotation kan ik nu ook locaties toevoegen. Door middel van een JSON wil ik alle barretjes en cafés gaan toevoegen.

# 22-01-2018

Vandaag heb ik een geschikte API gevonden: https://api.eet.nu/venues?query=cafes. Ik heb de namen en de coördinaten ingeladen in de app. Hierna heb ik de coördinaten omgeschreven naar MLocationCoordinate2D, zodat ik de cafes op mijn map kan inladen via MKAnnotation. 

# 23-01-2018

 - Voorheen werkte mijn app met een tab bar, maar dit bleek niet handig te zijn als je data wilt doorsturen naar een andere ViewController. Daarom heb ik de tab bar verwijderd uit mijn app en maak ik nu gebruik van buttons om zo met 1 klik de user door te sturen naar een nieuw scherm.

- Als de user een credit collect dan wordt het aantal aangepast in de Index ViewController. Ook de 'free drink' button werkt nu, maar alleen als de user meer dan 10 credits heeft. In het geval dat dit niet zo is, krijgt de user een pop-up.

- Het model waarin mijn data uit de API wordt ingeladen heb ik omgeschreven, zodat ik morgen deze data gemakkelijker kan inladen in mijn map.

# 24-01-2018

De data uit mijn API: https://api.eet.nu/venues?query=cafes wordt nu van  de IndexViewController doorgestuurd naar de MapViewController. Verder heb ik functies toegevoegd zodat geo-fence werkt. Op het moment dat de user een regio binnen gaat, springt de MapViewController naar de CollectViewController, zodat hij of zij een credit kan innen. De data uit mijn API is nog steeds niet ingeladen op de kaart, omdat ik hier niet uit kom. Daarnaast ben ik bezig geweest met Firebase, zodat het aantal credits van de user wordt opgeslagen. Ook hier kwam ik niet uit.

# 25 - 01 -2018

Vandaag heb ik de data van de API ingeladen op de map. Op het moment dat de user een regio binnen loopt, gaat zijn scherm automatisch door naar de CollectViewController. De timer begint dan direct te lopen en zodra die onder de 0 seconde is, krijgt de user 1 credit erbij in zijn portfolio. 

<img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/IndexViewController.png" width="250"><img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/MapViewController.png" width="250"><img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/CollectViewController.png" width="250">

# 26-01-2018

De timer heb ik omgezet van secondes naar uren, minuten en secondes. Ik heb de button op de CollectViewController verbonden met Firebase, zodat bij elke klik het aantal credits toeneemt met 1. Het aantal credits wordt op de IndexViewController ingeladen vanuit Firebase, nu kan de gebruiker zijn of haar saldo checken. De button om een gratis drankje te krijgen is ook verbonden met Firebase. Alleen nu kan het saldo negatief worden, hier moet ik nog een oplossing voor vinden.

# 29-01-2018

Het saldo van de gebruiker kan niet meer negatief worden. Vandaag moest ik de markers van de cafés koppelen aan de locatie van de gebruiker, om zo te verifiëren dat de gebruiker daadwerkelijk op de locatie van het café is. Eerst wilde ik dit via geofence doen, maar Marijn gaf vandaag aan dat dat niet handig is. In de calloutAccessoryControlTapped functie worden nu de coordinaten van het desbetreffende café opgehaald. Deze worden vergeleken met de coordinaten van de gebruiker en de afstand tussen deze twee locaties wordt berekend. Als de afstand onder de 5 meter is, dan wordt de gebruiker doorgestuurd naar de CollectViewController en kan hij of zij een credit collecten als de timer op 0 seconden staat. De geofence functies heb ik volledig uit mijn code gehaald.

# 30-01-2018

In mijn app gebruik ik meerdere malen een UIAlertController. Vandaag heb ik daarvoor een static shared geschreven, zodat ik niet elke keer dezelfde code gebruik. Verder ben ik bezig geweest met het design van mijn app. Onderaan elke scherm heb ik het logo van mijn app geplaatst en de hoeken van mijn buttons heb ik rond gemaakt. Daarnaast ziet de gebruiker nu de naam van het café staan op de CollectViewController. Aan het einde van de dag heb ik een Code Review gedaan met Lotte.

# 31-01-2018

Ik ben de dag begonnen met het verwerken van de feedback van Lotte. Hierna heb ik de laatste bug uit mijn app verholpen. Als een nieuwe gebruiker zich zou registeren dan zou hij of zij nog geen credits hebben en dus ook geen waarde hebben in Firebase. Hierdoor crashte mijn app als ik een credit wilde collecten of als ik credits wilde verzilveren voor een drankje. Ik heb de bug verholpen door bij het registeren een waarde van nul op te slaan in Firebase. Ook heb ik een begin gemaakt aan mijn report.


