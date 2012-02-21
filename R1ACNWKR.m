R1ACNWKR ;SFVAMC/NLS/ - Diagnostic for Xerox ADPAC's
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         S %ZIS="Q",%ZIS("B")="" D ^%ZIS I POP W ! G EXIT
         I $D(IO("Q")) D  G EXIT
         .S ZTDESC="Xerox ADPAC Dx Rpt",ZTRTN="DQ^R1ACNWKR"
         .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
         .K ZTSK,IO("Q") D HOME^%ZIS
         W !
         D DQ,HDR,EN2,EXIT
         Q
DQ       U IO S POP=0
         K ^XTMP("XEROX_DIAG")
         S R1ACDA=0
         F  S R1ACDA=$O(^DIZ(612418,R1ACDA)) Q:'R1ACDA  D
         .S R1ACTYP=$P($G(^SC(R1ACDA,0)),U,3)
         .S R1ACIN="" I $D(^SC(R1ACDA,"I")) S R1ACIN=$P($G(^SC(R1ACDA,"I")),U)
         .S R1ACACT="" I $D(^SC(R1ACDA,"I")) S R1ACACT=$P($G(^SC(R1ACDA,"I")),U,2)
         .S R1ACFLG=0 D TEST I R1ACFLG=0 D
         ..S R1ACNOD="",R1ACNOD=$G(^DIZ(612418,R1ACDA,17))
         ..I $G(R1ACNOD)]"" S (R1ACBLU,R1ACBLZ)="",R1ACBLU=$P($G(R1ACNOD),U) I $G(R1ACBLU)]"" S R1ACBLZ=$P($G(^DIZ(612418.1,R1ACBLU,
          0)),U)
         ..S R1ACCLN="",R1ACCLN=$P(^SC(R1ACDA,0),U)
         ..S (R1ACB1,R1ACB2,R1ACB3,R1ACB4,R1ACB5,R1ACB6,R1ACB7,R1ACB8,R1ACB9,R1ACB10,R1ACB11,R1ACB12,R1ACB13,R1ACB14,R1ACB15)=""
         ..I $G(^DIZ(612418,R1ACDA,1,1,0))]"" S R1ACB1="yes"
         ..I $G(^DIZ(612418,R1ACDA,3,1,0))]"" S R1ACB2="yes"
         ..I $G(^DIZ(612418,R1ACDA,4,1,0))]"" S R1ACB3="yes"
         ..I $G(^DIZ(612418,R1ACDA,5,1,0))]"" S R1ACB4="yes"
         ..I $G(^DIZ(612418,R1ACDA,6,1,0))]"" S R1ACB5="yes"
         ..I $G(^DIZ(612418,R1ACDA,7,1,0))]"" S R1ACB6="yes"
         ..I $G(^DIZ(612418,R1ACDA,8,1,0))]"" S R1ACB7="yes"
         ..I $G(^DIZ(612418,R1ACDA,9,1,0))]"" S R1ACB8="yes"
         ..I $G(^DIZ(612418,R1ACDA,10,1,0))]"" S R1ACB9="yes"
         ..I $G(^DIZ(612418,R1ACDA,11,1,0))]"" S R1ACB10="yes"
         ..I $G(^DIZ(612418,R1ACDA,12,1,0))]"" S R1ACB11="yes"
         ..I $G(^DIZ(612418,R1ACDA,13,1,0))]"" S R1ACB12="yes"
         ..I $G(^DIZ(612418,R1ACDA,14,1,0))]"" S R1ACB13="yes"
         ..I $G(^DIZ(612418,R1ACDA,15,1,0))]"" S R1ACB14="yes"
         ..I $G(^DIZ(612418,R1ACDA,16,1,0))]"" S R1ACB15="yes"
         ..S ^XTMP("XEROX_DIAG",R1ACCLN)=R1ACCLN_U_$G(R1ACBLZ)_U_R1ACB1_U_R1ACB2_U_R1ACB3_U_R1ACB4_U_R1ACB5_U_R1ACB6_U_R1ACB7_U_R1AC
          B8_U_R1ACB9_U_R1ACB10_U_R1ACB11_U_R1ACB12_U_R1ACB13_U_R1ACB14_U_R1ACB15
         ..S (R1ACB1,R1ACB2,R1ACB3,R1ACB4,R1ACB5,R1ACB6,R1ACB7,R1ACB8,R1ACB9,R1ACB10,R1ACB11,R1ACB12,R1ACB13,R1ACB14,R1ACB15)=""
         Q
EXIT     ;
         K ^XTMP("XEROX_DIAG")
         K R1ACB1,R1ACB10,R1ACB11,R1ACB12,R1ACB13,R1ACB14,R1ACB15,R1ACB2,R1ACB3,R1ACB4
         K R1ACB5,R1ACB6,R1ACB7,R1ACB8,R1ACB9,R1ACBLU,R1ACBLZ,R1ACCLN,R1ACDA
         K R1ACACT,R1ACFLG,R1ACIN,R1ACTYP,R1ACNOD,X,%ZIS,%ZIS("B"),POP,ZTDESC,ZTRTN
         Q
EN2      ;
         S R1ACCLN=""
         F  S R1ACCLN=$O(^XTMP("XEROX_DIAG",R1ACCLN)) Q:R1ACCLN=""  S R1ACNOD="" D
         .S R1ACNOD=^XTMP("XEROX_DIAG",R1ACCLN)
         .W !,R1ACNOD
         Q
HDR      ;
         W !,"Clinic"_U_"Boiler Plate"_U_"#1"_U_"#2"_U_"#3"_U_"#4"_U_"#5"_U_"#6"_U_"#7"_U_"#8"_U_"#9"_U_"#10"_U_"#11"_U_"#12"_U_"#13
          "_U_"#14"_U_"#15"
         Q
TEST     ;
          I R1ACTYP'="C" S R1ACFLG=1 Q
          I R1ACIN]""&(((R1ACIN<DT)&(R1ACACT=""))) S R1ACFLG=1 Q
          I (R1ACIN]""&(R1ACACT]""))&((R1ACIN<DT)&(R1ACACT>DT)) S R1ACFLG=1 Q
          Q
