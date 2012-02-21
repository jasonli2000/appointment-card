R1ACSXR1 ;VISN21/vhamachillsg - Postcards Transmission Report
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
         ;  This option is used to produce statistics on the R1AC APPOINTMENT CARD software.
         ;  The R1AC POSTCARD TRACKING FILE 612418.3) is used to produce the data.
         ;
         Q
RPT1     ;report 1 - detail + summary of daily transmissions
         W !!,"This will generate a summary or detailed report for Scheduling Postcards"
         W !,"that are sent to the Regional XEROX Postcard Printer.",!
         N DIR,SDTE,EDTE,N1,DETAIL,DTYPE,PAGE,LINE,QUIT,FROM,TO,EXCEL,PDETAIL,GRNTOT,DIRUT,NAPT,X1,X2
         K TMP
         S DIR("A")="Enter start date // ",DIR(0)="DOA" D ^DIR Q:$G(DIRUT)
         S (FROM,X1)=Y,X2=-1 D C^%DTC S SDTE=X
         S DIR("A")="Enter end date // ",DIR(0)="DOA^"_SDTE D ^DIR Q:$G(DIRUT)  S (TO,EDTE)=Y
         K DIR
         S FROM=$$FMTE^XLFDT(FROM,"1P"),TO=$$FMTE^XLFDT(TO,"1P")
         W !!,"You can select details which will list every postcard transmitted"
         W !," or just a summary on the number of postcards transmitted"
         S DIR("A")="Summary or Details?  ",DIR("B")="Summary"
         S DIR(0)="SOA^S:Summary;D:Details" D ^DIR Q:$G(DIRUT)  S DETAIL=$S(Y'["D":0,1:1)
         I DETAIL D  Q:$G(DIRUT)
         .S DIR("A")="   Details by Clinic or Patient?  ",DIR("B")="Patient"
         .S DIR(0)="SOA^P:Patient;C:Clinic" D ^DIR Q:$G(DIRUT)  S DTYPE=Y
         .I DTYPE="C" D  Q:$G(DIRUT)
         ..S DIR("A")="      Include patient information for clinics?  ",DIR("B")="No"
         ..S DIR(0)="YOA" D ^DIR Q:$G(DIRUT)  S PDETAIL=Y
         .S EXCEL=0
         .D:DTYPE="P"!($G(PDETAIL)) 
         ..S DIR("A")="   Excel format?  ",DIR("B")="No"
         ..S DIR(0)="YOA" D ^DIR Q:$G(DIRUT)  S EXCEL=Y
         W !
         N ZTSAVE
         S ZTSAVE("*")=""
         D EN^XUTMDEVQ("R1^R1ACSXR1","Xerox Postcard Trans Report",.ZTSAVE)
         Q
R1       ;
         U IO
         D HDR1
         S QUIT=0
         F  S SDTE=$O(^DIZ(612418.3,SDTE)) Q:SDTE=""!(SDTE>EDTE)!(QUIT)  D:+SDTE
         .I $D(^DIZ(612418.3,SDTE,1,0)) D
         ..N DOW,PDTE,VIPPREC,DFN,CLN,APT,PCARD,USR,DTECNT,TCRD,CTCRD,CTYPE
         ..S DOW=$$DOW^XLFDT(SDTE)
         ..S PDTE=$$FMTE^XLFDT(SDTE,"1P")
         ..D:(LINE+4)>IOSL HDR1
         ..W !,DOW_",",?11,PDTE S LINE=$G(LINE)+1
         ..S DTECNT=0
         ..S N1=0 K ^TMP($J,"VIPPRPT") F  S N1=$O(^DIZ(612418.3,SDTE,1,N1)) Q:N1=""!(QUIT)  D:+N1
         ...S CTYPE=$P($G(^DIZ(612418.3,SDTE,1,N1,0)),U,5)
         ...S DTECNT=$G(DTECNT)+1,TCRD(CTYPE)=$G(TCRD(CTYPE))+1,GRNTOT=$G(GRNTOT)+1
         ...Q:'DETAIL!('$D(^DIZ(612418.3,SDTE,1,N1,0)))
         ...S VIPPREC=^DIZ(612418.3,SDTE,1,N1,0)
         ...S DFN=$P(VIPPREC,U,2)
         ...S CLN=$P(VIPPREC,U,3)
         ...S APT=$P(VIPPREC,U,4)
         ...S PCARD=$P(VIPPREC,U,5)
         ...S USR=$P(VIPPREC,U,6)
         ...D SETARY
         ..I DTECNT>0 D
         ...W ?25,"# of cards sent is "_DTECNT S LINE=$G(LINE)+1
         ...D:$D(TCRD)
         ....N X,Y S X=0
         ....F  S X=$O(TCRD(X)) Q:X=""  S Y=$G(Y)_X_"="_TCRD(X)_","
         ....S Y=$E(Y,1,$L(Y)-1)
         ....W ?50,"["_Y_"]" S LINE=LINE+1
         ...Q:'DETAIL
         ...D:(LINE+6)>IOSL HDR1
         ...D HDR2
         ...S DFN="" F  S DFN=$O(^TMP($J,"VIPPRPT",DFN)) Q:DFN=""!(QUIT)  D
         ....I DTYPE="C"&'$G(EXCEL) D
         .....W !,DFN,?31,"(cards sent "_$J($P(TMP(DFN),U,16),3)_")"
         .....N I,X,Y,Z S X=0,Z=TMP(DFN)
         .....F I=1:1:15 S X=$P(TMP(DFN),U,I) I X'="" S Y=$G(Y)_I_"="_X_","
         .....S Y=$E(Y,1,$L(Y)-1)
         .....W ?50,"["_Y_"]",! S LINE=LINE+1
         ....I DTYPE="C"&'$G(PDETAIL) Q
         ....S CLN="" F  S CLN=$O(^TMP($J,"VIPPRPT",DFN,CLN)) Q:CLN=""!(QUIT)  D
         .....S APT="" F  S APT=$O(^TMP($J,"VIPPRPT",DFN,CLN,APT)) Q:APT=""!(QUIT)  D
         ......S PCARD=""  F  S PCARD=$O(^TMP($J,"VIPPRPT",DFN,CLN,APT,PCARD)) Q:PCARD=""!(QUIT)  D
         .......S USR="" F  S USR=$O(^TMP($J,"VIPPRPT",DFN,CLN,APT,PCARD,USR)) Q:USR=""!(QUIT)  D
         ........S NAPT=$S(APT>0:$E(APT,4,5)_"/"_$E(APT,6,7)_"/"_$E(APT,2,3),1:"")
         ........I '$G(EXCEL) D
         .........I DTYPE="P" W "("_PCARD_")",?6,$E(DFN,1,25),?33,$E(CLN,1,20),?57,NAPT,?68,"("_USR_")",!
         .........E  W ?18,"("_PCARD_")",?25,$E(CLN,1,25),?57,NAPT,?68,"("_USR_")",!
         .........S LINE=$G(LINE)+1 D:(LINE+2)>IOSL HDR1
         ........I $G(EXCEL) W SDTE_U_PCARD_U_DFN_U_CLN_U_NAPT_U_USR,!
         W !!,"*****  End of Report - # of cards found for date range is "_$G(GRNTOT)_"  *****"
         D ^%ZISC
         K ^TMP($J,"VIPPRPT"),TMP
         Q
         ;
HDR1     ; report header
         N X,CNT
         S PAGE=$G(PAGE)+1
         I PAGE>1,$E($G(IOST),1,2)="C-" R !,"Press ENTER to continue or '^' to Exit ",QUIT:$G(DTIME) I QUIT="^" S QUIT=1 Q
         W:$G(IOF) @IOF W !?18,"VistA to XEROX Postcard Transmission Report",?67,"Page: "_PAGE
         S X="Selected Date(s): "_FROM S:FROM'=TO X=X_" to "_TO S CNT=(80-$L(X))/2 W !?CNT,X
         I DETAIL W !?27,"Details by "_$S(DTYPE="P":"patient",1:"clinic")
         E  W !?30,"Summary Report"
         W !
         S LINE=4
         I PAGE>1,DETAIL W !,DOW_",",?11,PDTE_"  (continued)",! S LINE=$G(LINE)+2 I DETAIL D
         .I DTYPE="P" W !,"Card",?6,"Patient",?33,"Clinic",?58,"Appt",?69,"User"
         .E  W !,"Card",?6,"Clinic",?33,"Patient",?58,"Appt",?69,"User"
         .W !,"----",?6,"-------------------------",?33,"--------------------",?57,"--------",?68,"------",!
         .S LINE=LINE+3
         Q
         ;
HDR2     ; sub header for detail
         I EXCEL D  Q
         .I DTYPE="P" W !,"VISTA PRINTED"_U_"POSTCARD"_U_"PATIENT"_U_"CLINIC"_U_"APPT"_U_"VISTA USER",! Q
         .E  W !,"VISTA PRINTED"_U_"POSTCARD"_U_"CLINIC"_U_"PATIENT"_U_"APPT"_U_"VISTA USER",! Q
         W !,"  ***Details***"
         I DTYPE="P" D 
         .W !,"Card",?6,"Patient",?33,"Clinic",?58,"Appt",?69,"User"
         .W !,"----",?6,"-------------------------",?33,"--------------------",?57,"--------",?68,"------",!
         E  D
         .W !,"Clinic",?18,"Card",?30,"Patient",?58,"Appt",?69,"User"
         .W !,"------------",?18,"----",?25,"--------------------",?57,"--------",?68,"------",!
         S LINE=$G(LINE)+4
         Q
         ;
SETARY   ; set data into temporary global
         N P
         I DTYPE="P" D
         .S ^TMP($J,"VIPPRPT",$P(^DPT(DFN,0),U),$P(^SC(CLN,0),U),APT,PCARD,USR)=""
         .S ^TMP($J,"VIPPRPT",$P(^SC(CLN,0),U))=$G(^TMP($J,"VIPPRPT",$P(^SC(CLN,0),U)))+1
         I DTYPE="C" D
         .S ^TMP($J,"VIPPRPT",$P(^SC(CLN,0),U),$P(^DPT(DFN,0),U),APT,PCARD,USR)=""
         .S ^TMP($J,"VIPPRPT",$P(^SC(CLN,0),U))=$G(^TMP($J,"VIPPRPT",$P(^SC(CLN,0),U)))+1
         .S CTCRD(CTYPE)=$G(CTCRD(CTYPE))+1
         .S P=CTYPE
         .;S $P(^TMP($J,"VIPPRPT",$P(^SC(CLN,0),U)),U,P)=$P(^TMP($J,"VIPPRPT",$P(^SC(CLN,0),U)),U,P)+1
         .;S $P(^TMP($J,"VIPPRPT",$P(^SC(CLN,0),U)),U,P)=$P($G(^TMP($J,"VIPPRPT",$P(^SC(CLN,0),U))),U,P)+1
         .;S $P(TMP($P(^SC(CLN,0),U)),U,P)=$P($G(TMP($P(^SC(CLN,0),U))),U,P)+1
         .S $P(TMP($P(^SC(CLN,0),U)),U,P)=$P($G(TMP($P(^SC(CLN,0),U))),U,P)+1
         .S $P(TMP($P(^SC(CLN,0),U)),U,16)=$P($G(TMP($P(^SC(CLN,0),U))),U,16)+1
         Q
         ;
TOT1     ; totals for summary
         Q
