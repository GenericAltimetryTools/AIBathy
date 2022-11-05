#!/usr/bin/env bash

gmt gmtset FONT_LABEL 7p,4,black
gmt gmtset MAP_FRAME_WIDTH	= 0.3c 
gmt gmtset MAP_LABEL_OFFSET 2p
gmt gmtset MAP_GRID_PEN_PRIMARY	= 0.1p,0/0/0,2_1_0.25_1:0
gmt gmtset MAP_FRAME_TYPE plain MAP_TICK_LENGTH_PRIMARY -5p 
gmt set FORMAT_DATE_MAP "o dd" FORMAT_CLOCK_MAP hh:mm FONT_ANNOT_PRIMARY 7p FONT_ANNOT_SECONDARY 12p

ps=ts.ps

gmt grdtrack check_feizhou.txt -Gdepth_case1.nc | awk '{print NR, $3,$4}' > draper.txt
gmt psbasemap -R1/150/-6000/-500 -JX10c/3c -P -K -Bxaf+l"Number of points" -Byaf+l"Depth/m" -BWSne  > $ps
awk '{print  $1,$2}' draper.txt | gmt psxy -R1500/1650/-6000/-500 -J -O -K -W0.5p,gray >> $ps

awk '{print  $1,$2}' draper.txt | gmt psxy -R -J -O -K -Si0.1c -Gred >> $ps
awk '{print  $1,$3}' draper.txt | gmt psxy -R -J -O -K -St0.1c -Gblue >> $ps



gmt grdtrack check_feizhou.txt -Gdepth_case3.nc | awk '{print NR, $3,$4}' > draper.txt
awk '{print  $1,$3}' draper.txt | gmt psxy -R -J -O -K -Sx0.1c -Ggreen >> $ps

gmt grdtrack check_feizhou.txt -Gdepth_case9.nc | awk '{print NR, $3,$4}' > draper.txt
awk '{print  $1,$3}' draper.txt | gmt psxy -R -J -O -K -S+0.1c -Gblack >> $ps

echo N 4 >le.d
echo S 0.1c i 0.2c red - 0.3c ship >>le.d
echo S 0.1c t 0.2c blue - 0.3c case1 >>le.d
echo S 0.1c x 0.2c green - 0.3c case3 >>le.d
echo S 0.1c + 0.2c black - 0.3c case9 >>le.d

gmt pslegend -D+w1.5i+jBL+o0.3c/2.4c -R -J -O -F+p0.5p+gwhite --FONT_ANNOT_PRIMARY=5p le.d >> $ps

gmt psconvert  $ps -P -Tf -A
# rm gmt.*
