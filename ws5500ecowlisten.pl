#!/usr/bin/perl
#
#
#
#
#   If you have a Weatherstation like Alecto an WS-5500 or other brands with software/firmware "stationtype=EasyWeatherV1.6.9/model=WS2900_V2.01.18".
#   If your Weatherstation uses WS view App you can use the experimental mode and use the Weatherunderground or EcoWitt protocol and use a own Web/Tcp 
#   server to retreive the values with this simple quick and dirty perl script.
#
#   #Fine Offset Electronics Co.,Ltd
#
#   On the WS view App goto Devices ---> select your device --> push next button until Experimental mode --> select Enable and Ecowitt protocol --> 
#   Change to your IP and Port number --> Save and finish
#
#   Raw data from your Weatherstation
#
#   POST /data/report/ HTTP/1.1
#   HOST: 192.168.2.71
#   Connection: Close
#   Content-Type: application/x-www-form-urlencoded
#   Content-Length: 464
#
#   PASSKEY=<SECRET should be your code>&stationtype=EasyWeatherV1.6.9&dateutc=2024-11-05+18:29:30&tempinf=71.1&humidityin=43&baromrelin=29.997&baromabsin=30.269&tempf=42.6&humidity=91&winddir=108&windspeedmph=0.0&windgustmph=0.0&maxdailygust=8.1&rainratein=0.000&eventrainin=0.000&hourlyrainin=0.000&dailyrainin=0.012&weeklyrainin=0.012&monthlyrainin=0.063&yearlyrainin=45.453&totalrainin=45.453&solarradiation=0.00&uv=0&wh65batt=0&freq=868M&model=WS2900_V2.01.18
#
#
#
################################################################################################################
#
#   Copyright by cibeest
#   6-Nov-2024
#   cibeest@hotmail.com
#
#
################################################################################################################





use strict;
use warnings;

my $line;
my @line;

my	$PASSKEY	;
my	$stationtype	;
my	$dateutc	;
my	$tempinf	;
my	$humidityin	;
my	$baromrelin	;
my	$baromabsin	;
my	$tempf	;
my	$humidity	;
my	$winddir	;
my	$windspeedmph	;
my	$windgustmph	;
my	$maxdailygust	;
my	$rainratein	;
my	$eventrainin	;
my	$hourlyrainin	;
my	$dailyrainin	;
my	$weeklyrainin	;
my	$monthlyrainin	;
my	$yearlyrainin	;
my	$totalrainin	;
my	$solarradiation	;
my	$uv	;
my	$wh65batt	;
my	$freq	;
my	$model	;


my $tempinc;
my $tempc;

my $client_socket;

use IO::Socket::INET;
# auto-flush on socket
$| = 1;


# Creating a listening socket
my $socket = new IO::Socket::INET (
    LocalHost => '0.0.0.0',
    LocalPort => '7777',
    Proto => 'tcp',
    Listen => 5,
    Reuse => 1
);
die "Cannot create socket $!\n" unless $socket;

$SIG{INT} = sub { $socket->close(); exit 0; };


 while (my $client_socket = $socket->accept()) {

   # Get information about a newly connected client
   my $client_address = $client_socket->peerhost();

   # Read up to 1024 characters from the connected client
   my $data = "";

   my $timestamp = localtime(time);

##############################################################
#
# Format the Rawline into single Variables "keys with value" 
#
#PASSKEY=<SECRET should be your code>
#stationtype=EasyWeatherV1.6.9
#dateutc=2024-11-04+10:38:03
#tempinf=68.9
#humidityin=48
#baromrelin=30.133
#baromabsin=30.405
#tempf=48.2
#humidity=83
#winddir=102
#windspeedmph=5.4
#windgustmph=5.8
#maxdailygust=10.3
#rainratein=0.000
#eventrainin=0.000
#hourlyrainin=0.000
#dailyrainin=0.000
#weeklyrainin=0.000
#monthlyrainin=0.051
#yearlyrainin=45.441
#totalrainin=45.441
#solarradiation=36.52
#uv=0
#wh65batt=0
#freq=868M
#model=WS2900_V2.01.18

   while ( <$client_socket>) {
 
    @line = $_;

        # Read until Line match with TEXT field PASSCODE
        #################################################################
	if ( $_ =~ m/PASSKEY/) {
	    $PASSKEY=(split(/&/,$line[$#line]))[0];
        $stationtype=(split(/&/,$line[$#line]))[1];
        $dateutc=(split(/&/,$line[$#line]))[2];
        $tempinf=(split(/&/,$line[$#line]))[3];
        $humidityin=(split(/&/,$line[$#line]))[4];
        $baromrelin=(split(/&/,$line[$#line]))[5];
        $baromabsin=(split(/&/,$line[$#line]))[6];
        $tempf=(split(/&/,$line[$#line]))[7];
        $humidity=(split(/&/,$line[$#line]))[8];
        $winddir=(split(/&/,$line[$#line]))[9];
        $windspeedmph=(split(/&/,$line[$#line]))[10];
        $windgustmph=(split(/&/,$line[$#line]))[11];
        $maxdailygust=(split(/&/,$line[$#line]))[12];
        $rainratein=(split(/&/,$line[$#line]))[13];
        $eventrainin=(split(/&/,$line[$#line]))[14];
        $hourlyrainin=(split(/&/,$line[$#line]))[15];
        $dailyrainin=(split(/&/,$line[$#line]))[16];
        $weeklyrainin=(split(/&/,$line[$#line]))[17];
        $monthlyrainin=(split(/&/,$line[$#line]))[18];
        $yearlyrainin=(split(/&/,$line[$#line]))[19];
        $totalrainin=(split(/&/,$line[$#line]))[20];
        $solarradiation=(split(/&/,$line[$#line]))[21];
        $uv=(split(/&/,$line[$#line]))[22];
        $wh65batt=(split(/&/,$line[$#line]))[23];
        $freq=(split(/&/,$line[$#line]))[24];
        $model=(split(/&/,$line[$#line]))[25];
        
         
           		
	    print "***************** Current $timestamp Weather data ***************** \n\n";

###################################################################
#
#  Some examples to convert default Fahrenheit Values to Celcius   
#
###################################################################
        my @tempinc = split(/\=/,$tempinf);
        $tempinc = ($tempinc[1] - 32) * (5/9);
        print "Fahr $tempinf and C $tempinc\n";

        my @tempc = split(/\=/,$tempf);
        $tempc = ($tempc[1] - 32) * (5/9);
        print "Fahr $tempf and C $tempc\n";

#######################################################
#                                                     #
#    Print everything                                 #
#######################################################

    print "\n\n\n$PASSKEY\n"	;
    print "$stationtype\n"	;
    print "IPadr_weatherstation= $client_address\n";
    print "$dateutc\n"	;
    print "$tempinf\n"	;
    print "$humidityin\n"	;
    print "$baromrelin\n"	;
    print "$baromabsin\n"	;
    print "$tempf\n"	;
    print "$humidity\n"	;
    print "$winddir\n"	;
    print "$windspeedmph\n"	;
    print "$windgustmph\n"	;
    print "$maxdailygust\n"	;
    print "$rainratein\n"	;
    print "$eventrainin\n"	;
    print "$hourlyrainin\n"	;
    print "$dailyrainin\n"	;
    print "$weeklyrainin\n"	;
    print "$monthlyrainin\n"	;
    print "$yearlyrainin\n"	;
    print "$totalrainin\n"	;
    print "$solarradiation\n"	;
    print "$uv\n"	;
    print "$wh65batt\n"	;
    print "$freq\n"	;
    print "$model\n"	;
    
        }
        # If line is no match or if is False Do nothing and continue with loop
    }
}
