#!/usr/bin/env bash
gmt gmtset FORMAT_GEO_MAP = dddF MAP_FRAME_WIDTH=1p
gmt gmtset FONT_ANNOT_PRIMARY 7p,Helvetica,black FONT_LABEL 7p,Helvetica,black 

ps=fig1.ps

gmt pscoast -JM4.5i -R-16/10/-6/10 -Dl -A10000/0/1 -Slightblue -Glightyellow -BWSen -Bx5g5 -By2g2 --FONT_TITLE=10p -K  -W0.1p --MAP_ANNOT_OBLIQUE=45  > $ps

# awk 'NR%10==0 {print $1,$2,$3}' ../../data/guinea.txt | gmt psxy -R -J -Sc0.01 -Ggray -O -K >> $ps
# awk 'NR%400==0 {print $1,$2,$3}' ../NCEI_global_singlebeam/NCEI_global_singlebeam.xyz | gmt psxy -R -J -Sc0.01 -Ggray -O -K >> $ps

gmt select ../../data/guinea.txt -R-15/5/-4/4 -fg > subset.d
gmt info subset.d
awk 'NR%5==0 {print $1,$2,$3}' subset.d | gmt psxy -R-16/10/-6/10  -J -Sc0.03 -Gred -O -K >> $ps

gmt pscoast -Rg -JG-0/0/4c  -Dc -A5000 -Gpink -Swhite  -O -X3.3i -Y1.6i -K >> $ps
echo -15 -4 >tmp.d
echo -15 4 >>tmp.d
echo 5 4 >>tmp.d
echo 5 -4 >>tmp.d
echo -15 -4 >>tmp.d
gmt psxy tmp.d -W1p,red -R -J -O  >> $ps

gmt psconvert $ps  -A -P -Tf
rm *.ps *.d gmt.*