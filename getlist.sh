#!/bin/bash
curl -H "Accept: application/xml" -H "Content-Type: application/xml" -X GET "http://api.sl.se/api2/realtimedepartures.xml?key=9e99975c83864b6f8dab6ab4baddaba8&siteid=4426&timewindow=60" > realtime.xml
xml2 < realtime.xml > realtime2.xml
cat realtime2.xml | sed -e "s/\/ResponseOfDepartures\/ResponseData//g" | egrep -vE 'ResponseOfDepartures|LatestUpdate|DataAge|@xmlns' | sed -e 's/\//=/g' > realtime.txt
FILE="realtime.txt"
i=0
echo "<html>" > bussar$i.html
echo "<p>" >> bussar$i.html
while read line; do
        if [ "$line" == "=Buses=Bus" ]; then
                echo "</p>" >> bussar$i.html
                echo "</html>" >> bussar$i.html
                i=$[$i+1]
                echo "<html>" > bussar$i.html
                echo "<p>" >> bussar$i.html
        else

                var=$(echo $i$line)
                echo $line >> bussar$i.html

        fi
done < $FILE
echo "</p>" >> bussar$i.html
echo "</html>" >> bussar$i.html
sed -i "/\b\(JourneyDirection\|SiteId\|StopAreaNumber\|StopPointNumber\|TimeTabledDateTime\|ExpectedDateTime\)\b/d" bussar*html
sed -i 's/TransportMode=BUS/Buss /g' bussar*html
sed -i 's/LineNumber=/LineNumber= /g' bussar*html
sed -i 's/Destination=/Destination= mot /g' bussar*html
sed -i 's/StopAreaName=/StopAreaName= från /g' bussar*html
sed -i 's/DisplayTime=/DisplayTime= avgår om /g' bussar*html
sed -i 's/=.*=//g' bussar*html
