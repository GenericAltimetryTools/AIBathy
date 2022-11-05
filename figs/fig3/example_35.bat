REM             GMT EXAMPLE xxxx
REM             2019-04-14 leiyang@fio.org.cn
REM Purpose:    Using grdmath to show the distance from GSHHG  coastline data
REM

gmt gmtset FORMAT_GEO_MAP = dddF MAP_FRAME_WIDTH=2p
gmt gmtset FONT_ANNOT_PRIMARY 7p,Helvetica,black FONT_LABEL 7p,Helvetica,black 

set ps=fig1.ps
set R=-15/5/-4/4
set J=M8c

gmt psbasemap -R%R% -J%J% -BWSen -Bxa5f5 -Bya2f2 -K > %ps%
gmt grd2cpt D:\gravity_depth\grav2depth\GeoModel\Magnetic_Anomalies_EMAG2\Magnetic_Anomalies_EMAG2\Magnetic_Anomalies_EMAG2.nc -R%R% -Cearth_mag.cpt -E> t.cpt
gmt grd2xyz D:\gravity_depth\grav2depth\GeoModel\Magnetic_Anomalies_EMAG2\Magnetic_Anomalies_EMAG2\Magnetic_Anomalies_EMAG2.nc -R%R% >tmp.d
gmt surface tmp.d -Gmag.nc -R%R% -I1m -T0.25
gmt grdimage mag.nc -R%R% -J%J% -K -Ct.cpt -O >> %ps%
gmt pscoast  -R%R% -J%J% -Dl -A10000/0/1 --FONT_TITLE=10p -W0.1p -K -O >> %ps%
echo -15 -3.5 (a)| gmt pstext -F+f8p,Helvetica,red+jML -R -J -To -P -K -O -D0.05 -Wwhite -Gwhite >> %ps%
gmt psscale -Ct.cpt -Dx0c/-1.c+w7c/0.3c+jTL+h -Bxaf -By+lnT -O -K >> %ps%


gmt psbasemap -R%R% -J%J% -BwSEn -Bxa5f5 -Bya2f2 -K -O -X9c>> %ps%
gmt surface D:\gravity_depth\grav2depth\GeoModel\depthtomoho.xyz\depthtomoho.xyz -Gmo.nc -R%R% -I1m -T0.25

gmt grd2cpt mo.nc -R%R% -Crainbow -E> t.cpt

gmt grdimage mo.nc -R%R% -J%J% -K -Ct.cpt -O >> %ps%
gmt pscoast  -R%R% -J%J% -Dl -A10000/0/1 --FONT_TITLE=10p -W0.1p -K -O >> %ps%
echo -15 -3.5 (b)| gmt pstext -F+f8p,Helvetica,red+jML -R -J -To -P -K -O -D0.05 -Wwhite -Gwhite >> %ps%
gmt psscale -Ct.cpt -Dx0c/-1.c+w7c/0.3c+jTL+h -Bxaf -By+lkm -O -K >> %ps%

gmt psbasemap -R%R% -J%J% -BWSen -Bxa5f5 -Bya2f2 -K -O -X-9c -Y6c>> %ps%
gmt grd2cpt D:\gravity_depth\grav2depth\GeoModel\Seafloor_Age_Grid\age.2020.1.GTS2012.1m.nc -R%R% -Ccrustal_age.cpt -E> t.cpt

gmt grdimage D:\gravity_depth\grav2depth\GeoModel\Seafloor_Age_Grid\age.2020.1.GTS2012.1m.nc -R%R% -J%J% -K -Ct.cpt -O >> %ps%
gmt pscoast  -R%R% -J%J% -Dl -A10000/0/1 --FONT_TITLE=10p -W0.1p -K -O >> %ps%
echo -15 -3.5 (c)| gmt pstext -F+f8p,Helvetica,red+jML -R -J -To -P -K -O -D0.05 -Wwhite -Gwhite >> %ps%
gmt psscale -Ct.cpt -Dx0c/-1.c+w7c/0.3c+jTL+h -Bxaf -By+lMyrs -O -K >> %ps%

gmt psbasemap -R%R% -J%J% -BwSEn -Bxa5f5 -Bya2f2 -K -O -X9c >> %ps%

gmt surface D:\gravity_depth\grav2depth\GeoModel\sedthk.xyz\sedthk.xyz -Gsed.nc -R%R% -I1m -T0.25


gmt grd2cpt sed.nc -R%R% -Cpolar -E> t.cpt

gmt grdimage sed.nc -R%R% -J%J% -K -Ct.cpt -O >> %ps%
gmt pscoast  -R%R% -J%J% -Dl -A10000/0/1 --FONT_TITLE=10p -W0.1p -K -O >> %ps%
echo -15 -3.5 (d)| gmt pstext -F+f8p,Helvetica,red+jML -R -J -To -P -K -O -D0.05 -Wwhite -Gwhite >> %ps%
gmt psscale -Ct.cpt -Dx0c/-1.c+w7c/0.3c+jTL+h -Bxaf -By+lkm -O >> %ps%

gmt psconvert %ps%  -A -P -Tf


del  gmt.* *.ps tmp.d
