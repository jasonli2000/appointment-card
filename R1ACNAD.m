R1ACNAD  ;VISN21/vhasfcshapin - Diagnose Incomplete Clinic Addresses
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;R1/KJP 3/23/11 - Commented statement to request guidance from N.Shapiro
         W !!,"1)  Please run this report & import into Excel if output is lengthy."
         W !,"(Fields are '^' delimited.)"
         W !!,"2) To fix incomplete CrossWalk Clinic Addresses either use FM Enter/Edit"
         W !,"to delete text in fields ADDRESS L1 & ADDRESS L2"
         W !,"      - or-"
         W !,"  Use List Manager VistA option: Post Card CrossWalk Edit [R1ACS EDIT CROSSWALK]"
         W !,"  to delete text in both address lines. Remember to save your edits before"
         W !,"  leaving option."
         W !!,"3) Then log into the CrossWalk - Screen #1 & reselect each clinic.  Clinic's"
         W !,"ENTIRE Address should appear in the CrossWalk to correct the problem."
         ;W !,"If it does not please notify nancy.shapiro@med.va.gov for further guidance."  ;R1/KJP 3/23/11 COMMENTED
         W !!!
         H 5
         S %ZIS="Q",%ZIS("B")="" D ^%ZIS I POP W ! G EXIT
         I $D(IO("Q")) D  G EXIT
         .S ZTDESC="TASK DESCRIPTION",ZTRTN="DQ^R1ACNAD"
         .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
         .K ZTSK,IO("Q") D HOME^%ZIS
         W !
DQ       U IO S POP=0
         D EN,HDR,EN2 ;,EXIT
         Q
EN       K ^XTMP("R1ACNAD")
         D NOW^%DTC
         S R1ACDA=0
          F  S R1ACDA=$O(^DIZ(612418,R1ACDA)) Q:'R1ACDA  S R1ACNDE="" D
         .S R1ACNDE=$G(^DIZ(612418,R1ACDA,2))
         .S R1ACCLN="",R1ACCLN=$P(^SC(R1ACDA,0),U)
         .S R1ACIN="" I $D(^SC(R1ACDA,"I")) S R1ACIN=$P($G(^SC(R1ACDA,"I")),U)
         .S R1ACACT="" I $D(^SC(R1ACDA,"I")) S R1ACACT=$P($G(^SC(R1ACDA,"I")),U,2)
         .S R1ACFLG=0 D TEST I R1ACFLG=0 D
         ..I R1ACNDE="" S ^XTMP("R1ACNAD",R1ACCLN)=R1ACCLN_U_R1ACDA_U_U_U_U_U
         ..S (R1ACCTY,R1ACSTE,R1ACZIP)=""
         ..S R1ACAD1="" I $G(R1ACNDE)]"" S R1ACAD1=$P($G(R1ACNDE),"^") I R1ACAD1="" S ^XTMP("R1ACNAD",R1ACCLN)=R1ACCLN_U_R1ACDA_U_R1ACAD1_U_U_U_U
         ..S R1ACAD2="" I $G(R1ACNDE)]"",(R1ACNDE'[$P(^DIZ(612418,R1ACDA,2),U,2)) S R1ACAD2="",^XTMP("R1ACNAD",R1ACCLN)=R1ACCLN_U_R1ACDA_U_$G(R1ACAD1)_U_R1ACAD2_U_U_U
         ..S R1ACAD2=$P($G(R1ACNDE),U,2) I R1ACAD2]"" I R1ACAD2[" " D ZIP,STATE,CITY
         ..S R1ACAD2=$P($G(R1ACNDE),U,2) I R1ACAD2]"" I R1ACAD2["  " D ZIP,STATE,CITY
         ..I (R1ACAD1="")!(R1ACAD2="")!(R1ACTY="")!(R1ACST="")!(R1ACZIP="") D
         ... S ^XTMP("R1ACNAD",R1ACCLN)=R1ACCLN_U_R1ACDA_U_R1ACAD1_U_R1ACAD2_U_R1ACCTY_U_R1ACSTE_U_R1ACZIP ;S (R1ACDA,R1ACAD1,R1ACAD 2,R1ACCTY,R1ACSTE,R1ACZIP)=""
         Q
HDR      ;
         W !,"CLINIC"_U_"IEN"_U_"Addr L1"_U_"Addr L2"_U_"City"_U_"State"_U_"Zip"
         Q
EN2      ;
         S R1ACCLN="",R1ACCNT=0
         F  S R1ACCLN=$O(^XTMP("R1ACNAD",R1ACCLN)) Q:R1ACCLN=""  S R1ACNDE="" D
         .S R1ACNDE=^XTMP("R1ACNAD",R1ACCLN)
         .W !,R1ACNDE S R1ACCNT=R1ACCNT+1
         I R1ACCNT=0 W !!,"<*** No Incomplete CrossWalk Addresses to Display ***>"
         Q
EXIT     ;
         K ^XTMP("R1ACNAD")
         K R1ACAD1,R1ACAD2,R1ACCTY,R1ACCLN,R1ACDA,R1ACNDE,R1ACSTE,R1ACZIP
         K R1ACFLG,R1ACNDE,R1ACST,R1ACCNT,X
         Q
TEST     ;for Active Clinic Status
         I R1ACIN]""&(((R1ACIN<DT)&(R1ACACT=""))) S R1ACFLG=1 Q
         I (R1ACIN]""&(R1ACACT]""))&((R1ACIN<DT)&(R1ACACT>DT)) S R1ACFLG=1 Q
         Q
ZIP      ;Check for 5 or 10 character Zip Code
         S (R1ACZIZ,R1ACZIY)=0,R1ACZIZ=($L(R1ACAD2)-9),R1ACZIY=$E(R1ACAD2,R1ACZIZ,$L(R1ACAD2)) I (R1ACZIY?5N1"-"4N) S R1ACZIP=R1ACZIY Q
         S (R1ACZIZ,R1ACZIY)=0,R1ACZIZ=($L(R1ACAD2)-4),R1ACZIY=$E(R1ACAD2,R1ACZIZ,$L(R1ACAD2)) I R1ACZIY?5N S R1ACZIP=R1ACZIY Q
         Q
STATE    ;Check for State Abbreviation
         S R1ACST="",R1ACST=$P(R1ACAD2,R1ACZIP)
         I $E(R1ACST,$L(R1ACST))=" " S R1ACST=$E(R1ACST,1,$L(R1ACST)-1)
         I $E(R1ACST,$L(R1ACST))=" " S R1ACST=$E(R1ACST,1,$L(R1ACST)-1)
         S R1ACST=$E(R1ACST,$L(R1ACST)-1,$L(R1ACST))
         Q
CITY     ;Get remaining portion
         S R1ACTY="",R1ACTY=$P(R1ACAD2,R1ACST) I $G(R1ACTY)]"" S R1ACTY=R1ACTY
         I R1ACTY="" S R1ACTY=R1ACAD2
         Q 
