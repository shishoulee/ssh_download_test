#!/bin/bash
# Argument1 ： File name of store list this week(New) Example: IMS_Store_Master_20170911.xlsx
# Argument2 ： File name of store list last week(Old) Example: IMS_Store_Master_20170918.xlsx
# Argument3 ： Date of receiving the new store list . Example: In case of 20170923 ⇒  Please enter 170923


if [ "$1" = "" ]
then
    echo " Please enter Argument1 ： File name of store list this week(New)"
    exit 1
elif [ "$2" = "" ]
then
    echo " Please enter Argument2 ： File name of store list last week(Old)"
    exit 1
elif [ "$3" = "" ]
then
    echo " Please enter Argument3 ： Date of receiving the new store list. Example: In case of 20170923 ⇒  you enter 170923 "
    exit 1
fi

rm -f *.csv

xlsx2csv $1 > lastweek.csv
xlsx2csv $2 > thisweek.csv

Date_Of_Today="$3"

awk -v awk_file="${Date_Of_Today}" -F "," '{ if(((substr($10, 7, 2)*10000 + substr($10, 1, 2)*100 + substr($10, 4, 2)) > '"${Date_Of_Today}"') && (((substr($10, 7, 1)*10) + substr($10, 8, 1)) < "60" )) print substr($10, 7, 2) substr($10, 1, 2) substr($10, 4, 2) , $3 , $5 , $6 , $9}' lastweek.csv | sort > extract_lastweek.csv
awk -v awk_file="${Date_Of_Today}" -F "," '{ if(((substr($10, 7, 2)*10000 + substr($10, 1, 2)*100 + substr($10, 4, 2)) > '"${Date_Of_Today}"') && (((substr($10, 7, 1)*10) + substr($10, 8, 1)) < "60" )) print substr($10, 7, 2) substr($10, 1, 2) substr($10, 4, 2) , $3 , $5 , $6 , $9}' thisweek.csv | sort > extract_thisweek.csv

echo "######################################################"
echo "# Also can get a different view to compare           #"
echo "# diff -y extract_lastweek.csv extract_thisweek.csv  #"
echo "######################################################"

diff -s extract_lastweek.csv extract_thisweek.csv > result.csv
echo ""
awk '/>|</ {i++ ; print $0; print $3} END{print ""; print "Total", i ,"records";print ""}' result.csv
# cat result.csv

echo "###################################################################################"
echo ""

# Generate store csv format
#awk -v Date_Of_Today="${Date_Of_Today}" -f 0932.awk result.csv | sort
# awk -v Date_Of_Today="${Date_Of_Today}" -f 0933.awk result.csv | sort
# awk -v Date_Of_Today="${Date_Of_Today}" -f 1002.awk result.csv | sort
awk -v Date_Of_Today="${Date_Of_Today}" -f 1004.awk result.csv | sort > country_result.csv
cat country_result.csv
rm -f all_store.csv

dir=UQ
if [ ! -e $dir ]; then 
    mkdir UQ/
else
# UQ
awk '/^US/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/US_store.csv
awk '/^CD/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/CD_store.csv
awk '/^UK/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/UK_store.csv
awk '/^FR/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/FR_store.csv
awk '/^DE/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/DE_store.csv
awk '/^ES/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/ES_store.csv
awk '/^BE/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/BE_store.csv
awk '/^RU/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/RU_store.csv
awk '/^TH/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/TH_store.csv
awk '/^ID/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/ID_store.csv
awk '/^CN/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/CN_store.csv
awk '/^HK/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/HK_store.csv
awk '/^SG/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/SG_store.csv
awk '/^TW/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/TW_store.csv
awk '/^PH/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/PH_store.csv
awk '/^MO/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/MO_store.csv
awk '/^MY/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/MY_store.csv
awk '/^JP/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/JP_store.csv
awk '/^KR/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/KR_store.csv
awk '/^AU/ && /UQ/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./UQ/AU_store.csv
fi

dir2=GU
if [ ! -e $dir2 ]; then 
    mkdir GU/
else
# GU
awk '/^CN/ && /GU/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./GU/CN_store.csv
awk '/^JP/ && /GU/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./GU/JP_store.csv
awk '/^TW/ && /GU/ {print $3, $4 ,$5, $6, $7, $8, $9}'  country_result.csv > ./GU/TW_store.csv
fi

if [ -s ./ ]; then echo " Please check Directory UQ and GU"
else echo "There is no size 0 file"
fi
# find ./ -size 0 -exec rm {} \;
echo ""
# cat all_store.csv
