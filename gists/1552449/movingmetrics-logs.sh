#!/bin/sh

ircfmt /home/stu/irclogs/foonetic/#movingmetrics.log | mycolorize.sh red stu | mycolorize.sh blue Brendan | mycolorize.sh yellow chris | ansi2html.sh > /var/www/metrics/htdocs/misc/irc-logs.html
echo /var/www/metrics/htdocs/misc/irc-logs.html
