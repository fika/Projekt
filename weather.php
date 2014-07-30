<?php
$page = $_SERVER['PHP_SELF'];
$sec = "30";
?>
<html>
    <head>
    <meta http-equiv="refresh" content="<?php echo $sec?>;URL='<?php echo $page?>'">
    </head>
    <body>
        <?php
                $weather = simplexml_load_file('xml/weather.xml');

                echo "City: ";
                echo $weather->city[0]['name'];

                echo "<br />";

                $kelvin = $weather->temperature[0]['value'];
                $celsius = $kelvin-273;
                echo "Temperature: ";
                echo $celsius;
                echo " degrees celsius.";

                echo "<br />";

                echo "Wind speed: ";
                echo $weather->wind[0]->speed['value'];
                echo " m/s, a ";
                echo $weather->wind[0]->speed['name'];
                echo " ";
                echo $weather->wind[0]->direction['name'];

                echo "<br />";

                echo "Clouds: ";
                echo $weather->clouds[0]['name'];

        ?>

    </body>
</html>
