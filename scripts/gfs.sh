#!/bin/bash
TOPLAT=-10
BOTTOMLAT=-60
LEFTLON=265
RIGTHLON=300
HH=12 # hora de inicio
TOP=72 # horas de pronóstico
STEP=3 # intervalo horas

DD=$(date +%d)
MM=$(date +%m)
YYYY=$(date +%Y)

TARGETDIR=/home/lipe/Documents/GFS_thundeR/Data/$YYYY$MM$DD$HH
mkdir -p $TARGETDIR
cd $TARGETDIR

for i in $( seq -f "%03g" 0 $STEP $TOP )
do
	
	FTPSOURCE="https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?dir=%2Fgfs.$YYYY$MM$DD%2F${HH}%2Fatmos&file=gfs.t${HH}z.pgrb2.0p25.f$i&var_RH=on&var_HGT=on&var_TMP=on&var_UGRD=on&var_VGRD=on&lev_1000_mb=on&lev_975_mb=on&lev_950_mb=on&lev_925_mb=on&lev_900_mb=on&lev_850_mb=on&lev_800_mb=on&lev_750_mb=on&lev_700_mb=on&lev_650_mb=on&lev_600_mb=on&lev_550_mb=on&lev_500_mb=on&lev_450_mb=on&lev_400_mb=on&lev_350_mb=on&lev_300_mb=on&lev_250_mb=on&lev_200_mb=on&lev_150_mb=on&lev_100_mb=on&subregion=&toplat=$TOPLAT&leftlon=$LEFTLON&rightlon=$RIGTHLON&bottomlat=$BOTTOMLAT"
	
	curl $FTPSOURCE -o gfs_025.$YYYY$MM$DD$HH.$i.grb
	cdo -f nc --double copy gfs_025.$YYYY$MM$DD$HH.$i.grb nc_gfs_025.$YYYY$MM$DD$HH.$i.nc

done

R CMD BATCH /home/lipe/Documents/GFS_thundeR/thunder.r
#rm nc_gfs* #netcdf
#rm gfs_* #gribs
