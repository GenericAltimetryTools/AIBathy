#!/usr/bin/env bash
#		GMT EXAMPLE 23
#
# Purpose:	Plot distances from Rome and draw shortest paths
# GMT modules:	grdmath, grdcontour, coast, plot, text, grdtrack
# Unix progs:	echo, cat
#
gmt gmtset FONT_LABEL 7p,4,black
gmt gmtset MAP_FRAME_WIDTH	= 0.3c 
gmt gmtset MAP_LABEL_OFFSET 2p
gmt gmtset MAP_GRID_PEN_PRIMARY	= 0.1p,0/0/0,2_1_0.25_1:0
gmt gmtset MAP_FRAME_TYPE plain MAP_TICK_LENGTH_PRIMARY -5p 
gmt set FORMAT_DATE_MAP "o dd" FORMAT_CLOCK_MAP hh:mm FONT_ANNOT_PRIMARY 7p FONT_ANNOT_SECONDARY 12p

ps=compare.ps

gmt grdtrack check_feizhou.txt -Gdepth_case1.nc | awk '{print $3,$4}' >draper.txt
gmt regress -Ey -N2 -Fxm  draper.txt | head

gmt psbasemap -R-6000/-100/-6000/-100 -JX5c/5c -P -K -Bxa1000f100+l"ship borne depth/m" -Bya1000f100+l"Predicted depth/m" -BWSne  > $ps
gmt regress -Ey -N2 -Fxmc -C95 draper.txt | gmt psxy -R -J -O -K -L+d -Glightorange >> $ps

gmt regress -Ey -N2 -Fxym draper.txt | awk '{printf "> error\n%s %s\n%s %s\n", $1, $2, $1, $3}' | gmt psxy -R -J -O -K -W0.1p,red,- >> $ps
gmt psxy -R -J -O -K draper.txt -Sc0.05c -Gblue >> $ps
gmt regress -Ey -N2 -Fxm  draper.txt | gmt psxy -R -J -O -K -W0.5p >> $ps
awk '{print $1-$2}' draper.txt| gmt gmtmath STDIN -Sl MEAN  =
awk '{print $1-$2}' draper.txt| gmt gmtmath STDIN -Sl STD  =
echo -6000 -6000 "(a)"| gmt pstext -F+f8p,Helvetica,red+jBL -R -J -To -P -K -O -D0.05 -Wwhite -Gwhite >> $ps

gmt grdtrack check_feizhou.txt -Gdepth_case3.nc | awk '{print $3,$4}' >draper.txt
gmt regress -Ey -N2 -Fxm  draper.txt | head

gmt psbasemap -R-6000/-100/-6000/-100 -JX5c/5c -P -K -Bxa1000f100 -Bya1000f100 -BWSne  -O -X6c>> $ps
gmt regress -Ey -N2 -Fxmc -C95 draper.txt | gmt psxy -R -J -O -K -L+d -Glightorange >> $ps

gmt regress -Ey -N2 -Fxym draper.txt | awk '{printf "> error\n%s %s\n%s %s\n", $1, $2, $1, $3}' | gmt psxy -R -J -O -K -W0.1p,red,- >> $ps
gmt psxy -R -J -O -K draper.txt -Sc0.05c -Gblue >> $ps
gmt regress -Ey -N2 -Fxm  draper.txt | gmt psxy -R -J -O -K -W0.5p >> $ps
awk '{print $1-$2}' draper.txt| gmt gmtmath STDIN -Sl MEAN  =
awk '{print $1-$2}' draper.txt| gmt gmtmath STDIN -Sl STD  =
echo -6000 -6000 "(b)"| gmt pstext -F+f8p,Helvetica,red+jBL -R -J -To -P -O -K -D0.05 -Wwhite -Gwhite >> $ps

gmt grdtrack check_feizhou.txt -Gdepth_case9.nc | awk '{print $3,$4}' >draper.txt
gmt regress -Ey -N2 -Fxm  draper.txt | head

gmt psbasemap -R-6000/-100/-6000/-100 -JX5c/5c -P -K -Bxa1000f100 -Bya1000f100 -BWSne  -O -X6c>> $ps
gmt regress -Ey -N2 -Fxmc -C95 draper.txt | gmt psxy -R -J -O -K -L+d -Glightorange >> $ps

gmt regress -Ey -N2 -Fxym draper.txt | awk '{printf "> error\n%s %s\n%s %s\n", $1, $2, $1, $3}' | gmt psxy -R -J -O -K -W0.1p,red,- >> $ps
gmt psxy -R -J -O -K draper.txt -Sc0.05c -Gblue >> $ps
gmt regress -Ey -N2 -Fxm  draper.txt | gmt psxy -R -J -O -K -W0.5p >> $ps
awk '{print $1-$2}' draper.txt| gmt gmtmath STDIN -Sl MEAN  =
awk '{print $1-$2}' draper.txt| gmt gmtmath STDIN -Sl STD  =
echo -6000 -6000 "(c)"| gmt pstext -F+f8p,Helvetica,red+jBL -R -J -To -P -O -K -D0.05 -Wwhite -Gwhite >> $ps

gmt grdtrack check_feizhou.txt -Gdepth_case1.nc | awk '{print $3-$4}'| gmt pshistogram -Bxaf+l"bathymetry (meter)" -Byaf+l"Counts" -BWSne -R-400/400/0/4000 -JX1.8i/1.5i -Ggray -Z0 -T10 -K -O -Y6c -X-12c >> $ps
gmt grdtrack check_feizhou.txt -Gdepth_case3.nc | awk '{print $3-$4}'| gmt pshistogram -JX -Ggray -R-400/400/0/4000 -Z0 -T10 -O -K -X6c -Bxaf+l"bathymetry (meter)" -Byaf -BWSne >> $ps
gmt grdtrack check_feizhou.txt -Gdepth_case9.nc | awk '{print $3-$4}'| gmt pshistogram -JX -Ggray -R-400/400/0/4000 -Z0 -T10 -O -X6c -Bxaf+l"bathymetry (meter)" -Byaf -BWSne >> $ps

gmt psconvert  $ps -P -Tg -A
# rm gmt.*
