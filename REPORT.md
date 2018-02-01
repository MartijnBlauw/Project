# Booze Your Credit

**Description**

Via deze app kan de gebruiker zoeken naar dichtstbijzijnde horeca gelegenheden. De gebruiker kan als hij of zij langer dan 10 minuten bij een aangesloten café is een credit collecten. Als de gebruiker 10 credits in zijn wallet heeft, kan hij of zij dit inwisselen bij een van de aangesloten cafés voor een drankje. Naast het feit dat de consument hier iets aan heeft, krijgen de aangesloten bedrijven ook meer naamsbekendheid.

<img src="https://raw.githubusercontent.com/MartijnBlauw/Project/master/doc/Login.png" width="250">

**High level overview**

**LoginViewController.swift**

De code in deze file regelt het registeren en inloggen van de gebruiker. Als de gebruiker op de registerButton klikt dan krijgt hij of zij een UIAlertController te zien met twee textFields. De gebruiker kan hier een account aanmaken. Als het e-mail en wachtwoord aan de vereisten voldoen, wordt de nieuwe gebruiker geregisteerd in Firebase en direct doorgestuurd naar de IndexViewController. Zo niet, dan krijgt de gebruiker een foutmelding. Als de gebruiker op de loginButton klikt dan wordt er gecheckt of de gebruiker bestaat en het wachtwoord goed is. Als aan alle vereisten wordt voldaan, wordt de gebruiker doorgestuurd naar de IndexViewController. Zo niet, dan krijgt de gebruiker een foutmelding.

**IndexViewController.swift**


**MapViewController.swift**


**CollectViewController.swift**
**HelpViewController.swift**
**PlaceController.swift**
**ShowAlertController.swift**


- Firebase (https://firebase.google.com/)
- API (https://api.eet.nu/venues?query=cafes)
- CoreLocation
- Mapkit




[![BCH compliance](https://bettercodehub.com/edge/badge/MartijnBlauw/Project?branch=master)](https://bettercodehub.com/)
