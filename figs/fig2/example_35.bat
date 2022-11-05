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
gmt grd2cpt D:\gravity_depth\grav2depth\GeoModel\Free_Air_Gravity_Anomalies\Free_Air_Gravity_Anomalies.nc -R%R% -Cpolar -E> t.cpt

gmt grdimage D:\gravity_depth\grav2depth\GeoModel\Free_Air_Gravity_Anomalies\Free_Air_Gravity_Anomalies.nc -R%R% -J%J% -K -Ct.cpt -O >> %ps%
gmt pscoast  -R%R% -J%J% -Dl -A10000/0/1 --FONT_TITLE=10p -W0.1p -K -O >> %ps%
echo -15 -3.5 (a)| gmt pstext -F+f8p,Helvetica,red+jML -R -J -To -P -K -O -D0.05 -Wwhite -Gwhite >> %ps%
gmt psscale -Ct.cpt -Dx0c/-1.c+w7c/0.3c+jTL+h -Bxaf -By+lmGal -O -K >> %ps%


gmt psbasemap -R%R% -J%J% -BwSEn -Bxa5f5 -Bya2f2 -K -O -X9c>> %ps%
gmt grd2cpt D:\gravity_depth\grav2depth\GeoModel\Vertical_Gravity_Gradient\Vertical_Gravity_Gradient.nc -R%R% -Cpolar -E> t.cpt

gmt grdimage D:\gravity_depth\grav2depth\GeoModel\Vertical_Gravity_Gradient\Vertical_Gravity_Gradient.nc -R%R% -J%J% -K -Ct.cpt -O >> %ps%
gmt pscoast  -R%R% -J%J% -Dl -A10000/0/1 --FONT_TITLE=10p -W0.1p -K -O >> %ps%
echo -15 -3.5 (b)| gmt pstext -F+f8p,Helvetica,red+jML -R -J -To -P -K -O -D0.05 -Wwhite -Gwhite >> %ps%
gmt psscale -Ct.cpt -Dx0c/-1.c+w7c/0.3c+jTL+h -Bxaf -By+leotvos -O -K >> %ps%

gmt psbasemap -R%R% -J%J% -BWSen -Bxa5f5 -Bya2f2 -K -O -X-9c -Y6c>> %ps%
gmt grd2cpt D:\gravity_depth\grav2depth\data\east_32.1.nc -R%R% -Cpolar -E> t.cpt

gmt grdimage D:\gravity_depth\grav2depth\data\east_32.1.nc -R%R% -J%J% -K -Ct.cpt -O >> %ps%
gmt pscoast  -R%R% -J%J% -Dl -A10000/0/1 --FONT_TITLE=10p -W0.1p -K -O >> %ps%
echo -15 -3.5 (c)| gmt pstext -F+f8p,Helvetica,red+jML -R -J -To -P -K -O -D0.05 -Wwhite -Gwhite >> %ps%
gmt psscale -Ct.cpt -Dx0c/-1.c+w7c/0.3c+jTL+h -Bxaf -By+larcsecond -O -K >> %ps%

gmt psbasemap -R%R% -J%J% -BwSEn -Bxa5f5 -Bya2f2 -K -O -X9c >> %ps%
gmt grd2cpt D:\gravity_depth\grav2depth\data\north_32.1.nc -R%R% -Cpolar -E> t.cpt

gmt grdimage D:\gravity_depth\grav2depth\data\north_32.1.nc -R%R% -J%J% -K -Ct.cpt -O >> %ps%
gmt pscoast  -R%R% -J%J% -Dl -A10000/0/1 --FONT_TITLE=10p -W0.1p -K -O >> %ps%
echo -15 -3.5 (d)| gmt pstext -F+f8p,Helvetica,red+jML -R -J -To -P -K -O -D0.05 -Wwhite -Gwhite >> %ps%
gmt psscale -Ct.cpt -Dx0c/-1.c+w7c/0.3c+jTL+h -Bxaf -By+larcsecond -O >> %ps%

gmt psconvert %ps%  -A -P -Tf

del  gmt.* *.ps
