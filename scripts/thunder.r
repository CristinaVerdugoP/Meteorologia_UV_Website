#################
# Cálculo parámetros convectivos con thundeR 
# para datos de pronóstico GFS
#################

rm(list = ls())
library(thunder)
library(ncdf4)
source("/home/lipe/Documents/Matlab Workspace/Severe Storms/dewpoint.R")
cities= read.csv('/home/lipe/Documents/GFS_thundeR/cities.csv')
working_folder='/home/lipe/Documents/GFS_thundeR/Data/'
folders=list.files(path=working_folder)
for (n in 1:dim(cities)[1]) {dir.create(paste(working_folder,folders[length(folders)],'/',cities[n,1],sep=""))}

files=list.files(path=paste(working_folder,folders[length(folders)],'/',sep=""),pattern="nc_gfs*",recursive = TRUE)
ncFile=nc_open(paste(working_folder,folders[length(folders)],'/',files[1],sep=""))
t=ncvar_get(ncFile,"t")
xlat=ncvar_get(ncFile,"lat")
xlon=ncvar_get(ncFile,"lon")
pressure=ncvar_get(ncFile,"plev")/100

a=dim(t)[1];b=dim(t)[2];c=dim(t)[3];
rm(t)

MU_CAPE=array(,c(a,b));
SB_CAPE=array(,c(a,b));
ML_CAPE=array(,c(a,b));
ML_CIN=array(,c(a,b));
ML_LCL_HGT=array(,c(a,b));
LR_01km=array(,c(a,b));
LR_03km=array(,c(a,b));
LR_500700hPa=array(,c(a,b));
FRZG_HGT=array(,c(a,b));
Thetae_01km=array(,c(a,b));
PRCP_WATER=array(,c(a,b));
Moisture_Flux_02km=array(,c(a,b));
BS_0500m=array(,c(a,b));
BS_01km=array(,c(a,b));
BS_06km=array(,c(a,b));
BS_EFF_MU=array(,c(a,b));
BS_EFF_SB=array(,c(a,b));
BS_EFF_ML=array(,c(a,b));
SRH_100m_LM=array(,c(a,b));
SRH_500m_LM=array(,c(a,b));
SRH_1km_LM=array(,c(a,b));
SRH_3km_LM=array(,c(a,b));
STP_fix_LM=array(,c(a,b));
STP_new_LM=array(,c(a,b));
MU_WMAXSHEAR=array(,c(a,b));
SB_WMAXSHEAR=array(,c(a,b));
ML_WMAXSHEAR=array(,c(a,b));
MU_EFF_WMAXSHEAR=array(,c(a,b));
SB_EFF_WMAXSHEAR=array(,c(a,b));
ML_EFF_WMAXSHEAR=array(,c(a,b));
EHI_500m_LM=array(,c(a,b));
EHI_01km_LM=array(,c(a,b));
EHI_03km_LM=array(,c(a,b));
SHERBS3=array(,c(a,b));
SHERBE=array(,c(a,b));
SHERBS3_v2=array(,c(a,b));
SHERBE_v2=array(,c(a,b));

MU_LCL_HGT=array(,c(a,b));
SB_WMAX=array(,c(a,b));
Wind_Index=array(,c(a,b));
MW_0500m=array(,c(a,b));
TIP=array(,c(a,b));
EHI_01km_LM=array(,c(a,b));
SCP_new_LM=array(,c(a,b));


accuracy=2 # accuracy of computations where 3 = high (slow), 2 = medium (recommended), 1 = low (fast)
#options(digits=2) # change output formatting precision

hrs=seq(0,length(files)*3-3,3)
stp=array(,c(dim(cities)[1],length(files)+1));colnames(stp)=c(folders[length(folders)],hrs);stp[,1]=cities[,1]
scp=array(,c(dim(cities)[1],length(files)+1));colnames(scp)=c(folders[length(folders)],hrs);scp[,1]=cities[,1]
sherbe=array(,c(dim(cities)[1],length(files)+1));colnames(sherbe)=c(folders[length(folders)],hrs);sherbe[,1]=cities[,1]
ml_cape=array(,c(dim(cities)[1],length(files)+1));colnames(ml_cape)=c(folders[length(folders)],hrs);ml_cape[,1]=cities[,1]
mu_cape=array(,c(dim(cities)[1],length(files)+1));colnames(mu_cape)=c(folders[length(folders)],hrs);mu_cape[,1]=cities[,1]
sb_cape=array(,c(dim(cities)[1],length(files)+1));colnames(sb_cape)=c(folders[length(folders)],hrs);sb_cape[,1]=cities[,1]
srh_500m=array(,c(dim(cities)[1],length(files)+1));colnames(srh_500m)=c(folders[length(folders)],hrs);srh_500m[,1]=cities[,1]
srh_1km=array(,c(dim(cities)[1],length(files)+1));colnames(srh_1km)=c(folders[length(folders)],hrs);srh_1km[,1]=cities[,1]
bs_01km=array(,c(dim(cities)[1],length(files)+1));colnames(bs_01km)=c(folders[length(folders)],hrs);bs_01km[,1]=cities[,1]
bs_06km=array(,c(dim(cities)[1],length(files)+1));colnames(bs_06km)=c(folders[length(folders)],hrs);bs_06km[,1]=cities[,1]

for (p in 1:length(files))
#for (p in 1:1)
{
    ncFile=nc_open(paste(working_folder,folders[length(folders)],'/',files[p],sep=""))
    time=ncvar_get(ncFile,"time")
    u=ncvar_get(ncFile,"u")
    v=ncvar_get(ncFile,"v")
    z=round(ncvar_get(ncFile,"gh"))
    rh=ncvar_get(ncFile,"r")/100
    rh[which(rh==0)]=0.0001
    t=ncvar_get(ncFile,"t")
    ws=sqrt(u^2+v^2)*1.94 # wind speed on knots
    wd=(270-atan2(v,u)*180/pi)%%360 # wind direction [azimuth in degress]

    nc_close(ncFile)
    for (x in 1:a)
    {
	    for (y in 1:b)
	    {
	    	td=array(,c);
	    	for (lvl in 1:c) {td[lvl]=dewpoint(t[x,y,lvl],rh[x,y,lvl])}

	        s=sounding_compute(rev(pressure),rev(z[x,y,]),rev(t[x,y,]-273.15),rev(td-273.15),rev(wd[x,y,]),rev(ws[x,y,]),accuracy)

			MU_CAPE[x,y]=s[1]
			SB_CAPE[x,y]=s[24]
			ML_CAPE[x,y]=s[41]
			ML_CIN[x,y]=s[47]
			ML_LCL_HGT[x,y]=s[48]
			LR_01km[x,y]=s[59]
			LR_03km[x,y]=s[61]
			LR_500700hPa[x,y]=s[69]
			FRZG_HGT[x,y]=s[72]
			Thetae_01km[x,y]=s[78]
			PRCP_WATER[x,y]=s[83]
			Moisture_Flux_02km[x,y]=s[84]
			BS_0500m[x,y]=s[91]
			BS_01km[x,y]=s[92]
			BS_06km[x,y]=s[95]
			BS_EFF_MU[x,y]=s[101]
			BS_EFF_SB[x,y]=s[102]
			BS_EFF_ML[x,y]=s[103]
			SRH_100m_LM[x,y]=s[128]
			SRH_500m_LM[x,y]=s[130]
			SRH_1km_LM[x,y]=s[131]
			SRH_3km_LM[x,y]=s[132]
			STP_fix_LM[x,y]=s[174]
			STP_new_LM[x,y]=s[175]
			MU_WMAXSHEAR[x,y]=s[183]
			SB_WMAXSHEAR[x,y]=s[184]
			ML_WMAXSHEAR[x,y]=s[185]
			MU_EFF_WMAXSHEAR[x,y]=s[186]
			SB_EFF_WMAXSHEAR[x,y]=s[187]
			ML_EFF_WMAXSHEAR[x,y]=s[188]
			EHI_500m_LM[x,y]=s[192]
			EHI_01km_LM[x,y]=s[193]
			EHI_03km_LM[x,y]=s[194]
			SHERBS3[x,y]=s[195]
			SHERBE[x,y]=s[196]
			SHERBS3_v2[x,y]=s[197]
			SHERBE_v2[x,y]=s[198]

			MU_LCL_HGT[x,y]=s[8]
			SB_WMAX[x,y]=s[36]
			Wind_Index[x,y]=s[82]
			MW_0500m[x,y]=s[116]
			TIP[x,y]=s[201]
			SCP_new_LM[x,y]=s[179]
	    }
    }

	xdim <- ncFile$dim[['lon']]
	ydim <- ncFile$dim[['lat']]
	tdim <- ncFile$dim[['time']]

	#Creación variables en formato netCDF
	var_mu_cape <- ncvar_def('MU_CAPE','',list(xdim,ydim,tdim),missval=NULL)
	var_sb_cape <- ncvar_def('SB_CAPE','',list(xdim,ydim,tdim),missval=NULL)
	var_ml_cape <- ncvar_def('ML_CAPE','',list(xdim,ydim,tdim),missval=NULL)
	var_ml_cin <- ncvar_def('ML_CIN','',list(xdim,ydim,tdim),missval=NULL)
	var_ml_lcl_hgt <- ncvar_def('ML_LCL_HGT','',list(xdim,ydim,tdim),missval=NULL)
	var_lr_01km <- ncvar_def('LR_01km','',list(xdim,ydim,tdim),missval=NULL)
	var_lr_03km <- ncvar_def('LR_03km','',list(xdim,ydim,tdim),missval=NULL)
	var_lr_500700hpa <- ncvar_def('LR_500700hPa','',list(xdim,ydim,tdim),missval=NULL)
	var_frzg_hgt <- ncvar_def('FRZG_HGT','',list(xdim,ydim,tdim),missval=NULL)
	var_thetae_01km <- ncvar_def('Thetae_01km','',list(xdim,ydim,tdim),missval=NULL)
	var_prcp_water <- ncvar_def('PRCP_WATER','',list(xdim,ydim,tdim),missval=NULL)
	var_moisture_flux_02km <- ncvar_def('Moisture_Flux_02km','',list(xdim,ydim,tdim),missval=NULL)
	var_bs_0500m <- ncvar_def('BS_0500m','',list(xdim,ydim,tdim),missval=NULL)
	var_bs_01km <- ncvar_def('BS_01km','',list(xdim,ydim,tdim),missval=NULL)
	var_bs_06km <- ncvar_def('BS_06km','',list(xdim,ydim,tdim),missval=NULL)
	var_bs_eff_mu <- ncvar_def('BS_EFF_MU','',list(xdim,ydim,tdim),missval=NULL)
	var_bs_eff_sb <- ncvar_def('BS_EFF_SB','',list(xdim,ydim,tdim),missval=NULL)
	var_bs_eff_ml <- ncvar_def('BS_EFF_ML','',list(xdim,ydim,tdim),missval=NULL)
	var_srh_100m_lm <- ncvar_def('SRH_100m_LM','',list(xdim,ydim,tdim),missval=NULL)
	var_srh_500m_lm <- ncvar_def('SRH_500m_LM','',list(xdim,ydim,tdim),missval=NULL)
	var_srh_1km_lm <- ncvar_def('SRH_1km_LM','',list(xdim,ydim,tdim),missval=NULL)
	var_srh_3km_lm <- ncvar_def('SRH_3km_LM','',list(xdim,ydim,tdim),missval=NULL)
	var_stp_fix_lm <- ncvar_def('STP_fix_LM','',list(xdim,ydim,tdim),missval=NULL)
	var_stp_new_lm <- ncvar_def('STP_new_LM','',list(xdim,ydim,tdim),missval=NULL)
	var_mu_wmaxshear <- ncvar_def('MU_WMAXSHEAR','',list(xdim,ydim,tdim),missval=NULL)
	var_sb_wmaxshear <- ncvar_def('SB_WMAXSHEAR','',list(xdim,ydim,tdim),missval=NULL)
	var_ml_wmaxshear <- ncvar_def('ML_WMAXSHEAR','',list(xdim,ydim,tdim),missval=NULL)
	var_mu_eff_wmaxshear <- ncvar_def('MU_EFF_WMAXSHEAR','',list(xdim,ydim,tdim),missval=NULL)
	var_sb_eff_wmaxshear <- ncvar_def('SB_EFF_WMAXSHEAR','',list(xdim,ydim,tdim),missval=NULL)
	var_ml_eff_wmaxshear <- ncvar_def('ML_EFF_WMAXSHEAR','',list(xdim,ydim,tdim),missval=NULL)
	var_ehi_500m_lm <- ncvar_def('EHI_500m_LM','',list(xdim,ydim,tdim),missval=NULL)
	var_ehi_01km_lm <- ncvar_def('EHI_01km_LM','',list(xdim,ydim,tdim),missval=NULL)
	var_ehi_03km_lm <- ncvar_def('EHI_03km_LM','',list(xdim,ydim,tdim),missval=NULL)
	var_sherbs3 <- ncvar_def('SHERBS3','',list(xdim,ydim,tdim),missval=NULL)
	var_sherbe <- ncvar_def('SHERBE','',list(xdim,ydim,tdim),missval=NULL)
	var_sherbs3_v2 <- ncvar_def('SHERBS3_v2','',list(xdim,ydim,tdim),missval=NULL)
	var_sherbe_v2 <- ncvar_def('SHERBE_v2','',list(xdim,ydim,tdim),missval=NULL)

	var_MU_LCL_HGT <- ncvar_def('MU_LCL_HGT','',list(xdim,ydim,tdim),missval=NULL)
	var_SB_WMAX <- ncvar_def('SB_WMAX','',list(xdim,ydim,tdim),missval=NULL)
	var_Wind_Index <- ncvar_def('Wind_Index','',list(xdim,ydim,tdim),missval=NULL)
	var_MW_0500m <- ncvar_def('MW_0500m','',list(xdim,ydim,tdim),missval=NULL)
	var_TIP <- ncvar_def('TIP','',list(xdim,ydim,tdim),missval=NULL)
	var_SCP_new_LM <- ncvar_def('SCP_new_LM','',list(xdim,ydim,tdim),missval=NULL)

	#Creación archivo netCDF
	ncid_new <- nc_create(paste(working_folder,folders[length(folders)],'/thunder_',substr(files[p],12,25),'.nc',sep=""),
		list(var_mu_cape,
		var_sb_cape,
		var_ml_cape,
		var_ml_cin,
		var_ml_lcl_hgt,
		var_lr_01km,
		var_lr_03km,
		var_lr_500700hpa,
		var_frzg_hgt,
		var_thetae_01km,
		var_prcp_water,
		var_moisture_flux_02km,
		var_bs_0500m,
		var_bs_01km,
		var_bs_06km,
		var_bs_eff_mu,
		var_bs_eff_sb,
		var_bs_eff_ml,
		var_srh_100m_lm,
		var_srh_500m_lm,
		var_srh_1km_lm,
		var_srh_3km_lm,
		var_stp_fix_lm,
		var_stp_new_lm,
		var_mu_wmaxshear,
		var_sb_wmaxshear,
		var_ml_wmaxshear,
		var_mu_eff_wmaxshear,
		var_sb_eff_wmaxshear,
		var_ml_eff_wmaxshear,
		var_ehi_500m_lm,
		var_ehi_01km_lm,
		var_ehi_03km_lm,
		var_sherbs3,
		var_sherbe,
		var_sherbs3_v2,
		var_sherbe_v2,

		var_MU_LCL_HGT,
		var_SB_WMAX,
		var_Wind_Index,
		var_MW_0500m,
		var_TIP,
		var_SCP_new_LM
		))
	
	#Guardado varibles en archivo
	ncvar_put(ncid_new,var_mu_cape, MU_CAPE)
	ncvar_put(ncid_new,var_sb_cape, SB_CAPE)
	ncvar_put(ncid_new,var_ml_cape, ML_CAPE)
	ncvar_put(ncid_new,var_ml_cin, ML_CIN)
	ncvar_put(ncid_new,var_ml_lcl_hgt, ML_LCL_HGT)
	ncvar_put(ncid_new,var_lr_01km, LR_01km)
	ncvar_put(ncid_new,var_lr_03km, LR_03km)
	ncvar_put(ncid_new,var_lr_500700hpa, LR_500700hPa)
	ncvar_put(ncid_new,var_frzg_hgt, FRZG_HGT)
	ncvar_put(ncid_new,var_thetae_01km, Thetae_01km)
	ncvar_put(ncid_new,var_prcp_water, PRCP_WATER)
	ncvar_put(ncid_new,var_moisture_flux_02km, Moisture_Flux_02km)
	ncvar_put(ncid_new,var_bs_0500m, BS_0500m)
	ncvar_put(ncid_new,var_bs_01km, BS_01km)
	ncvar_put(ncid_new,var_bs_06km, BS_06km)
	ncvar_put(ncid_new,var_bs_eff_mu, BS_EFF_MU)
	ncvar_put(ncid_new,var_bs_eff_sb, BS_EFF_SB)
	ncvar_put(ncid_new,var_bs_eff_ml, BS_EFF_ML)
	ncvar_put(ncid_new,var_srh_100m_lm, SRH_100m_LM)
	ncvar_put(ncid_new,var_srh_500m_lm, SRH_500m_LM)
	ncvar_put(ncid_new,var_srh_1km_lm, SRH_1km_LM)
	ncvar_put(ncid_new,var_srh_3km_lm, SRH_3km_LM)
	ncvar_put(ncid_new,var_stp_fix_lm, STP_fix_LM)
	ncvar_put(ncid_new,var_stp_new_lm, STP_new_LM)
	ncvar_put(ncid_new,var_mu_wmaxshear, MU_WMAXSHEAR)
	ncvar_put(ncid_new,var_sb_wmaxshear, SB_WMAXSHEAR)
	ncvar_put(ncid_new,var_ml_wmaxshear, ML_WMAXSHEAR)
	ncvar_put(ncid_new,var_mu_eff_wmaxshear, MU_EFF_WMAXSHEAR)
	ncvar_put(ncid_new,var_sb_eff_wmaxshear, SB_EFF_WMAXSHEAR)
	ncvar_put(ncid_new,var_ml_eff_wmaxshear, ML_EFF_WMAXSHEAR)
	ncvar_put(ncid_new,var_ehi_500m_lm, EHI_500m_LM)
	ncvar_put(ncid_new,var_ehi_01km_lm, EHI_01km_LM)
	ncvar_put(ncid_new,var_ehi_03km_lm, EHI_03km_LM)
	ncvar_put(ncid_new,var_sherbs3, SHERBS3)
	ncvar_put(ncid_new,var_sherbe, SHERBE)
	ncvar_put(ncid_new,var_sherbs3_v2, SHERBS3_v2)
	ncvar_put(ncid_new,var_sherbe_v2, SHERBE_v2)

	ncvar_put(ncid_new,var_MU_LCL_HGT, MU_LCL_HGT)
	ncvar_put(ncid_new,var_SB_WMAX, SB_WMAX)
	ncvar_put(ncid_new,var_Wind_Index, Wind_Index)
	ncvar_put(ncid_new,var_MW_0500m, MW_0500m)
	ncvar_put(ncid_new,var_TIP, TIP)
	ncvar_put(ncid_new,var_SCP_new_LM, SCP_new_LM)

	nc_close(ncid_new)

	# Sondeos para cada ciudad
	for (cn in 1:dim(cities)[1])
	{							
		i=which(xlon==360+round(cities[cn,3]*4)/4)
		j=which(xlat==round(cities[cn,2]*4)/4)
		td=array(,c);
		for (lvl in 1:c) {td[lvl]=dewpoint(t[i,j,lvl],rh[i,j,lvl])}
		filename=paste(working_folder,folders[length(folders)],'/',cities[cn,1],'/',substr(files[p],23,25),'.png',sep="")
		title=paste(cities[cn,1],substr(files[p],18,19),substr(files[p],16,17),substr(files[p],12,15),'+',substr(files[p],21,23),sep=" ")
		#sounding_save(filename = filename, title = title, rev(pressure),rev(z[i,j,]),rev(t[i,j,]-273.15),rev(td-273.15),rev(wd[i,j,]),rev(ws[i,j,]))
		sounding_save(filename = filename, rev(pressure),rev(z[i,j,]),rev(t[i,j,]-273.15),rev(td-273.15),rev(wd[i,j,]),rev(ws[i,j,]))
		
		stp[cn,p+1]=STP_new_LM[i,j]
		scp[cn,p+1]=SCP_new_LM[i,j]
		sherbe[cn,p+1]=SHERBE[i,j]
		ml_cape[cn,p+1]=ML_CAPE[i,j]
		mu_cape[cn,p+1]=MU_CAPE[i,j]
		sb_cape[cn,p+1]=SB_CAPE[i,j]
		srh_500m[cn,p+1]=SRH_500m_LM[i,j]
		srh_1km[cn,p+1]=SRH_1km_LM[i,j]
		bs_01km[cn,p+1]=BS_01km[i,j]
		bs_06km[cn,p+1]=BS_06km[i,j]
	}

}
dir.create(paste(working_folder,folders[length(folders)],'/series/',sep=""))

write.csv(stp,file=paste(working_folder,folders[length(folders)],'/series/stp.csv',sep=""),row.names=FALSE)
write.csv(scp,file=paste(working_folder,folders[length(folders)],'/series/scp.csv',sep=""),row.names=FALSE)
write.csv(sherbe,file=paste(working_folder,folders[length(folders)],'/series/sherbe.csv',sep=""),row.names=FALSE)
write.csv(ml_cape,file=paste(working_folder,folders[length(folders)],'/series/ml_cape.csv',sep=""),row.names=FALSE)
write.csv(mu_cape,file=paste(working_folder,folders[length(folders)],'/series/mu_cape.csv',sep=""),row.names=FALSE)
write.csv(sb_cape,file=paste(working_folder,folders[length(folders)],'/series/sb_cape.csv',sep=""),row.names=FALSE)
write.csv(srh_500m,file=paste(working_folder,folders[length(folders)],'/series/srh_500m.csv',sep=""),row.names=FALSE)
write.csv(srh_1km,file=paste(working_folder,folders[length(folders)],'/series/srh_1km.csv',sep=""),row.names=FALSE)
write.csv(bs_01km,file=paste(working_folder,folders[length(folders)],'/series/bs_01km.csv',sep=""),row.names=FALSE)
write.csv(bs_06km,file=paste(working_folder,folders[length(folders)],'/series/bs_06km.csv',sep=""),row.names=FALSE)

gc()
