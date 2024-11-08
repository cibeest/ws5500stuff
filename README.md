A Perlscript in case you don't want to use Apache or anoyher webserver toe retreive your Weatherdata





   If you have a Weatherstation like Alecto an WS-5500 or other brands with software/firmware "stationtype=EasyWeatherV1.6.9/model=WS2900_V2.01.18".
   If your Weatherstation uses WS view App you can use the experimental mode and use the Weatherunderground or EcoWitt protocol and use a own Web/Tcp 
   server to retreive the values with this simple quick and dirty perl script.

   #Fine Offset Electronics Co.,Ltd

   On the WS view App goto Devices ---> select your device --> push next button until Experimental mode --> select Enable and Ecowitt protocol --> 
   Change to your IP and Port number --> Save and finish

   Raw data from your Weatherstation

   POST /data/report/ HTTP/1.1
   HOST: 192.168.2.71
   Connection: Close
   Content-Type: application/x-www-form-urlencoded
   Content-Length: 464

   PASSKEY=<SECRET should be your code>&stationtype=EasyWeatherV1.6.9&dateutc=2024-11-05+18:29:30&tempinf=71.1&humidityin=43&baromrelin=29.997&baromabsin=30.269&tempf=42.6&humidity=91&winddir=108&windspeedmph=0.0&windgustmph=0.0&maxdailygust=8.1&rainratein=0.000&eventrainin=0.000&hourlyrainin=0.000&dailyrainin=0.012&weeklyrainin=0.012&monthlyrainin=0.063&yearlyrainin=45.453&totalrainin=45.453&solarradiation=0.00&uv=0&wh65batt=0&freq=868M&model=WS2900_V2.01.18



   Copyright by cibeest
   6-Nov-2024
   cibeest@hotmail.com



Requirements

perl

Perl modules:

IO::Socket::INET;

Usage:
#> perl ws5500ecowlisten.pl

