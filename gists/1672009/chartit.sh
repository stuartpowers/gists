#!/bin/bash

# Stuart Powers
# http://sente.cc/
# creates a webpage/pie-chart using google charts with data from STDIN
# example http://c.sente.cc/tE7h/chartit.sh.html


DATA=$(
while read a b;
   do printf "['%s',%s],\n" "$b" "$a";
done
)


TEMPLATE=$(cat <<EOF
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>look i'm a title</title>
    <script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript"> google.load('visualization', '1', {packages: ['corechart']}); </script>
    <script type="text/javascript">
        function drawVisualization() {
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'str');
            data.addColumn('number', 'num');
            data.addRows([
                $DATA
            ]);

        new google.visualization.PieChart(document.getElementById('visualization')).
        draw(data, {title:"look im a title"});
        }
        google.setOnLoadCallback(drawVisualization);
    </script>
  </head>
  <body style="font-family: Arial;border: 0 none;">
    <div id="visualization" style="width: 600px; height: 400px;"></div>
  </body>
</html>
EOF
)

echo "$TEMPLATE" 
