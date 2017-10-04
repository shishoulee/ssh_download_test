{
# Var from Shell
YOT = substr(Date_Of_Today,1,2)
MOT = substr(Date_Of_Today,3,2)
DOT = substr(Date_Of_Today,5,2)

# Year
y3 = substr($2,1,1)
y4 = substr($2,2,1)
YY2 = y3*10 + y4					# last 2-digit of year
if (YY2 >= 60) {YY1 = 19				# Bigger than 60 -> 19XX
} else if (YY2 < 60) { YY1 = 20}			# Smaller than 60 -> 20XX
y1 = substr(YY1,1,1)
y2 = substr(YY1,2,1)
YYYY = YY1*100 + YY2					# value of year

# Leap year process
if ((YY1*100+YY2)%4 == 0) { DateOfLeapMonth = 29 
} else if ((YY1*100+YY2)%4 != 0){DateOfLeapMonth = 28}
# print $2,YY1 YY2 m1 m2 d1 d2 , y1 y2 y3 y4, DateOfLeapMonth

# Month
m1 = substr($2,3,1)
m2 = substr($2,4,1)
MM = m1*10 + m2

# Day
d1 = substr($2,5,1)
d2 = substr($2,6,1)
DD = d1*10 + d2

# AU +10:00
UTC_Plus_1000 = "21:00:00"

# JP|KR +9:00
UTC_Plus_0900 = "22:00:00"

# TW|CN|HK|SG|PH|MO|MY +8:00
UTC_Plus_0800 = "23:00:00"

# TH|ID +7:00
UTC_Plus_0700 = "00:00:00"

# RU +3:00
UTC_Plus_0300 = "04:00:00"

# /FR|DE|ES|BE/ +1:00
UTC_Plus_0100 = "06:00:00"

# /UK/
UTC_Plus_0000 = "07:00:00"

# /US|CD/
UTC_Minus_0500= "12:00:00"
}

/>/ {
# /US|CD/ -5:00 
if ($3 ~ /US|CD/) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" d1 d2 " "UTC_Minus_0500",開店日時まで除外 (20" YOT  "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else 

# /UK/ +0:00
if ($3 ~ /UK/) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" d1 d2 " "UTC_Plus_0000",開店日時まで除外 (20" YOT  "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else 

# /FR|DE|ES|BE/ +1:00
if ($3 ~ /FR|DE|ES|BE/) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" d1 d2 " "UTC_Plus_0100",開店日時まで除外 (20" YOT  "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else 

# /RU/ +3:00
if ($3 ~ /RU/) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" d1 d2 " "UTC_Plus_0300",開店日時まで除外 (20" YOT  "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else 

# /AU/ +10:00
if ($3 ~ /AU/ && (DD > 1) && (DD < 11) && (d1 >= 1) ) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" "0"(DD-1) " "UTC_Plus_1000",開店日時まで除外 (20" YOT  "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else 
if ($3 ~ /AU/ && (DD >= 11) && (d1 >= 1) ) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" (DD-1) " "UTC_Plus_1000",開店日時まで除外 (20" YOT  "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else 
if ($3 ~ /AU/ && (DD > 1) && (d1 < 1) ) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" "0" (DD-1) " "UTC_Plus_1000",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /AU/ && (DD == 1) && (MM == 1) ){print $3, $4, $5 ",*," (YYYY-1) "-" "12" "-" "31" " "UTC_Plus_1000",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /AU/ && (DD == 1) && (MM ~ /5|7|10/) ){print $3, $4, $5 ",*," YYYY "-"  "0" (MM-1) "-" "30" " "UTC_Plus_1000",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /AU/ && (DD == 1) && (MM ~ /12/) ){print $3, $4, $5 ",*," YYYY "-" (MM-1) "-" "30" " "UTC_Plus_1000",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /AU/ && (DD == 1) && (MM ~ /2|4|6|8|9|11/) ){print $3, $4, $5 ",*," YYYY "-" m1 (m2-1) "-" "31" " "UTC_Plus_1000",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /AU/ && (DD == 1) && (MM ~ /3/) ){print $3, $4, $5 ",*," YYYY "-" m1 (m2-1) "-" DateOfLeapMonth " "UTC_Plus_1000",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else

# /TW|CN|HK|SG|PH|MO|MY/ +8:00
if ($3 ~ /TW|CN|HK|SG|PH|MO|MY/ && (DD > 1) && (DD < 11) && (d1 >= 1) ) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" "0"(DD-1) " "UTC_Plus_0800",開店日時まで除外 (20" YOT  "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else 
if ($3 ~ /TW|CN|HK|SG|PH|MO|MY/ && (DD >= 11) && (d1 >= 1) ) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" (DD-1) " "UTC_Plus_0800",開店日時まで除外 (20" YOT  "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else 
if ($3 ~ /TW|CN|HK|SG|PH|MO|MY/ && (DD > 1) && (d1 < 1) ) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" "0" (DD-1) " "UTC_Plus_0800",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /TW|CN|HK|SG|PH|MO|MY/ && (DD == 1) && (MM == 1) ){print $3, $4, $5 ",*," (YYYY-1) "-" "12" "-" "31" " "UTC_Plus_0800",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /TW|CN|HK|SG|PH|MO|MY/ && (DD == 1) && (MM ~ /5|7|10/) ){print $3, $4, $5 ",*," YYYY "-"  "0" (MM-1) "-" "30" " "UTC_Plus_0800",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /TW|CN|HK|SG|PH|MO|MY/ && (DD == 1) && (MM ~ /12/) ){print $3, $4, $5 ",*," YYYY "-" (MM-1) "-" "30" " "UTC_Plus_0800",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /TW|CN|HK|SG|PH|MO|MY/ && (DD == 1) && (MM ~ /2|4|6|8|9|11/) ){print $3, $4, $5 ",*," YYYY "-" m1 (m2-1) "-" "31" " "UTC_Plus_0800",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /TW|CN|HK|SG|PH|MO|MY/ && (DD == 1) && (MM ~ /3/) ){print $3, $4, $5 ",*," YYYY "-" m1 (m2-1) "-" DateOfLeapMonth " "UTC_Plus_0800",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else

#/JP|KR/ +9:00
if ($3 ~ /JP|KR/ && (DD > 1) && (DD < 11) && (d1 >= 1) ) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" "0"(DD-1) " "UTC_Plus_0900",開店日時まで除外 (20" YOT  "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else 
if ($3 ~ /JP|KR/ && (DD > 1) && (DD >= 11) && (d1 >= 1) ) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" (DD-1) " "UTC_Plus_0900",開店日時まで除外 (20" YOT  "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else 
if ($3 ~ /JP|KR/ && (DD > 1) && (d1 < 1) ) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" "0"(DD-1) " "UTC_Plus_0900",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /JP|KR/ && (DD == 1) && (MM == 1) ){print $3, $4, $5 ",*," (YYYY-1) "-" "12" "-" "31" " "UTC_Plus_0900",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /JP|KR/ && (DD == 1) && (MM ~ /5|7|10/) ){print $3, $4, $5 ",*," YYYY "-"  "0" (MM-1) "-" "30" " "UTC_Plus_0900",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /JP|KR/ && (DD == 1) && (MM ~ /12/) ){print $3, $4, $5 ",*," YYYY "-" (MM-1) "-" "30" " "UTC_Plus_0900",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /JP|KR/ && (DD == 1) && (MM ~ /2|4|6|8|9|11/) ){print $3, $4, $5 ",*," YYYY "-" m1 (m2-1) "-" "31" " "UTC_Plus_0900",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /JP|KR/ && (DD == 1) && (MM ~ /3/) ){print $3, $4, $5 ",*," YYYY "-" m1 (m2-1) "-" DateOfLeapMonth " "UTC_Plus_0900",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else

#/TH|ID/  +7:00
if ($3 ~ /TH|ID/ && (DD > 1) && (DD < 11) && (d1 >= 1) ) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" "0"(DD-1) " "UTC_Plus_0700",開店日時まで除外 (20" YOT  "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else 
if ($3 ~ /TH|ID/&& (DD >= 11) && (d1 >= 1) ) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" (DD-1) " "UTC_Plus_0700",開店日時まで除外 (20" YOT  "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else 
if ($3 ~ /TH|ID/ && (DD > 1) && (d1 < 1) ) {print $3, $4, $5 ",*," y1 y2 y3 y4 "-" m1 m2 "-" "0"(DD-1) " "UTC_Plus_0700",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /TH|ID/ && (DD == 1) && (MM == 1) ){print $3, $4, $5 ",*," (YYYY-1) "-" "12" "-" "31" " "UTC_Plus_0700",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /TH|ID/ && (DD == 1) && (MM ~ /5|7|10/) ){print $3, $4, $5 ",*," YYYY "-"  "0" (MM-1) "-" "30" " "UTC_Plus_0700",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /TH|ID/ && (DD == 1) && (MM ~ /12/) ){print $3, $4, $5 ",*," YYYY "-" (MM-1) "-" "30" " "UTC_Plus_0700",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /TH|ID/ && (DD == 1) && (MM ~ /2|4|6|8|9|11/) ){print $3, $4, $5 ",*," YYYY "-" m1 (m2-1) "-" "31" " "UTC_Plus_0700",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} else
if ($3 ~ /TH|ID/ && (DD == 1) && (MM ~ /3/) ){print $3, $4, $5 ",*," YYYY "-" m1 (m2-1) "-" DateOfLeapMonth " "UTC_Plus_0700",開店日時まで除外 (20" YOT "/" MOT "/" DOT "記載)", $6,$7,$8,$9,$10,$11,$12,$13} ;
j++; # In order to count how many row of outputs
}

END{
print ""; 
print "There are ", j ," rows of output";print ""
}

