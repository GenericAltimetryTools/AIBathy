#!/usr/bin/env bash
gmt gmtset FORMAT_GEO_MAP = dddF MAP_FRAME_WIDTH=1p
gmt gmtset FONT_ANNOT_PRIMARY 7p,Helvetica,black FONT_LABEL 7p,Helvetica,black 

ps=fig1.ps

gmt makecpt -Chaxby -T-6000/-500 > colors.cpt
gmt psbasemap -R-15/5/-4/4 -JM5c -BWSen -Bx5g5 -By2g2 -K --MAP_ANNOT_OBLIQUE=45 > $ps

gmt grdimage depth_case1.nc -R -J -K -Ccolors.cpt -O >> $ps
echo -15 -3.5 "(a)"| gmt pstext -F+f8p,Helvetica,red+jML -R -J -To -P -K -O -D0.05 -Wwhite -Gwhite >> $ps

gmt grdimage depth_case7.nc -R -BWSen -Bx5 -By2 -J -K -Ccolors.cpt -O -X6c>> $ps 
echo -15 -3.5 "(b)"| gmt pstext -F+f8p,Helvetica,red+jML -R -J -To -P -K -O -D0.05 -Wwhite -Gwhite >> $ps

# gmt grdmath depth_case6.nc depth_case2.nc SUB = new.nc
gmt grdimage depth_case2.nc -R -BWSen -Bx5 -By2 -J -K -Ccolors.cpt -O -X-6c -Y3c >> $ps 
echo -15 -3.5 "(c)"| gmt pstext -F+f8p,Helvetica,red+jML -R -J -To -P -K -O -D0.05 -Wwhite -Gwhite >> $ps

gmt grdimage ggm.grd -R -BWSen -Bx5 -By2 -J -K -Ccolors.cpt -O -X6c>> $ps 
echo -15 -3.5 "(d)"| gmt pstext -F+f8p,Helvetica,red+jML -R -J -To -P  -O -D0.05 -Wwhite -Gwhite -K >> $ps

gmt psscale -Ccolors.cpt -Dx-1c/-4.c+w6c/0.3c+jTC+h -Bxa1000f -By+lm -O >> $ps


gmt psconvert $ps  -A -P -Tf