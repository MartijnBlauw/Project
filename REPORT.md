# Booze Your Credit

**Description**

Via deze app kan de gebruiker zoeken naar dichtstbijzijnde horeca gelegenheden. De gebruiker kan als hij of zij langer dan 10 minuten bij een aangesloten café is een credit collecten. Als de gebruiker 10 credits in zijn wallet heeft, kan hij of zij dit inwisselen bij een van de aangesloten cafés voor een drankje. Naast het feit dat de consument hier iets aan heeft, krijgen de aangesloten bedrijven ook meer naamsbekendheid.

<img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/Login.png" width="250">

**High level overview**

**LoginViewController.swift**

De code in deze file regelt het registeren en inloggen van de gebruiker. Als de gebruiker op de registerButton klikt dan krijgt hij of zij een UIAlertController te zien met twee textFields. De gebruiker kan hier een account aanmaken. Als het e-mail en wachtwoord aan de vereisten voldoen, wordt de nieuwe gebruiker geregisteerd in Firebase en direct doorgestuurd naar de IndexViewController. Zo niet, dan krijgt de gebruiker een foutmelding. Als de gebruiker op de loginButton klikt dan wordt er gecheckt of de gebruiker bestaat en het wachtwoord goed is. Als aan alle vereisten wordt voldaan, wordt de gebruiker doorgestuurd naar de IndexViewController. Zo niet, dan krijgt de gebruiker een foutmelding.

**IndexViewController.swift**

Op dit scherm kan de gebruiker zijn aantal credits zien en zijn credits verzilveren door op freeDrinkButtonTapped te klikken. Het aantal credits wordt opgehaald uit Firebase en als de gebruiker genoeg credits heeft dan wordt zijn of haar saldo verminderd met 10. Als de gebruiker nog niet genoeg credits heeft dan krijgt hij of zij een UIAlertController te zien met een melding. Verder kan de gebruiker zien hoe de app werkt, door te klikken op 'Help'. De gebruiker wordt dan doorgestuurd naar de HelpViewController, waar de handleiding te vinden is. Als de gebruiker klikt op de searchButtonTapped, dan wordt hij of zij doorgestuurd naar de MapViewController, zodra alle data is ingeladen op de map en niet eerder. Ook is er op dit scherm een mogelijkheid om uit te loggen, door simpelweg op de logOutButton te klikken.

**MapViewController.swift**

De gebruiker ziet op dit scherm een kaart met markers en zijn of haar locatie. De map is een onderdeel van MapKit en de locatie van de gebruiker wordt weergeven dankzij CoreLocation. Elke marker is een café die afkomstig is van deze API: https://api.eet.nu/venues?query=cafes. Als er op een marker geklikt wordt, dan ziet de gebruiker de naam van het café en een callout bubble. Op het moment dat de gebruiker op dezelfde locatie is als het café (marker), wordt de gebruiker doorgestuurd naar de CollectViewController, zodra hij of zij op de callout bubble klikt. Als de gebruiker niet dichtbij genoeg is, krijgt hij of zij een UIAlertController te zien met een melding.

**CollectViewController.swift**

Hier kan de gebruiker een credit collecten. In de viewDidLoad() wordt de naam het café ingeladen en de timer wordt gestart. Pas als de timer op nul staat, kan de gebruiker een credit collecten. Het aantal credits wordt dan opgehaald uit Firebase en bij die waarde wordt 1 opgeteld of als de waarde nul is, dan wordt daar 1 van gemaakt. Als de gebruiker eerder op de collectButtonTapped klikt dan krijgt hij of zij een UIAlertController te zien met een melding.

**HelpViewController.swift**

Deze code voorziet de labels van tekst en deze tekst helpt de gebruiker bij het gebruiken van de app.

**PlaceController.swift**

In deze controller wordt de data uit de API ingeladen en de JSON wordt gedecodeerd.

**ShowAlertController.swift**

In deze class staat een shared function voor de UIAlertController meerdere malen terug komt in de app.

**Challenges**

In het begin wilde ik gaan werken met GoogleMaps en GooglePlaces om zo cafés te kunnen zoeken en daarom had ik in de eerste week deze pods geïnstalleerd. Met behulp van geofence wilde ik verifiëren of de gebruiker op dezelfde locatie zou zijn als het betreffende café. Dit zag ik als een grote uitdaging, omdat wij met AppStudio hier nog niet mee gewerkt hadden.

Hierna heb ik het internet afgezocht naar informatie en filmpjes over geofence met GoogleMaps. Helaas was hier weinig over te vinden, maar ik zag wel veel informatie over geofence met MapKit voorbij komen en op de site van RayWenderlich is hier ook een tutorial over. Dat is de reden geweest om over te stappen naar MapKit in plaats van GoogleMaps. Hierdoor had ik een API nodig met informatie over cafés, zodat ik deze als markers kon plaatsen op de kaart. De coordinaten van de cafés werden alleen niet als het juiste type ingeladen en daarom kon ik de cafés niet inladen op de map via MKAnnotation. Aan mij dus de taak om coördinaten om te schrijven naar het juiste type.

Uiteindelijk had ik alle cafés via MKAnnotation zichtbaar op de kaart. Door middel van geofence was er ook een ronde cirkel (regio) te zien om de marker van de cafés. Op het moment dat een gebruiker regio betrad, wilde ik dat als hij of zij op de marker zou klikken doorgestuurd zou worden naar de CollectViewController. Maar aangezien het klikken op de marker en de regio ontstaan waren in twee aparte functies, wist ik niet hoe ik deze kon koppelen aan elkaar. Na enige tijd kwam ik erachter dat ik dit kon doen door middel van een boolean. Maar nu kon de gebruiker op alle markers klikken als hij of zij een regio betrad. Ik wilde dat de gebruiker alleen op de marker kon klikken van de regio die hij of zij betrad.

In de tussentijd ben ik begonnen met het koppelen aan Firebase, zodat ik dat in ieder geval af zou hebben. Op YouTube zijn veel filmpjes te vinden over Firebase en iOS en zo heb ik vrij makkelijk alle ViewControllers kunnen koppelen aan Firebase.

In de laatste week ben ik met mijn vraag over de het verifiëren van de locatie naar Marijn gegaan en die gaf aan dat het makkelijker was om met CLLocationDistance te werken in plaats van geofence. De geofence functies heb ik volledig uit mijn code gehaald.

**Other solutions** 
