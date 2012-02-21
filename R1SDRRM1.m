R1SDRRM1 ;;R1SDRR/MAH;RECALL REMINDER PACKAGE/XEROX PRINTER; 12/03/2006
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;;This routine will allow for rerunning creation of file 
         ;;for those who have not called in. 
         ;;cards and will print on the XEROX VIPP
         ;;Support DBIA #4080
         ;;waiver to $D to check for routine at a station
         ;;Call to ^SD(403.5 waived because there Find^dic does not function
CHECK    W:'$D(^ROUTINE("R1ACSX",0)) !!!,"You are Not set up to Run this option",!! Q
         ;If routine check passes
MEN      ;Main Menu
         K DIR,Y,DTOUT,DIROUT,DIRUT,DUOUT
         S DIR(0)="SO^1:Reprint VIPP Cards by Clinic:;2:Reprint for ONE Patient:"
         W ! S DIR("A")="Please select what you are looking for"
         D ^DIR G:$D(DUOUT)!($D(DTOUT)!($D(DIRUT))) QUIT
         K DIR
         I Y=1 G EN Q
         I Y=2 G PAT Q
EN       K ^TMP($J) W ! S %DT="AEX",%DT("A")="Patient Recall date needing reprint: " D ^%DT Q:Y<0  S R1SDZSDT=Y K Y,X,%DT("A"),%DT
         S R1SDDATE=$$GET1^DIQ(403.53,R1SDIEN_",",3) S X="T+"_R1SDDATE D ^%DT Q:Y<0  S R1SDDATE1=Y K Y,X
         I R1SDZSDT>R1SDDATE1!(R1SDZSDT=R1SDDATE1) W $C(7),!,"  The Date is Greater OR equal to what will be done during the Nightly
           Run - this Date must be less than" G EN
         S DIC="^SC(",DIC(0)="AEQMZ" D ^DIC Q:Y<0  S R1SDCLINIC=+Y K DIC
         D FIND^DIC(403.5,"","@;.01I;4.5I;5I;6I;8;","QP",R1SDZSDT,"","D","","","^TMP($J,""R1SDRR"",R1SDCLINIC)")
ENA      S R1SDRRDTA1=0 F  S R1SDRRDTA1=$O(^TMP($J,"R1SDRR",R1SDCLINIC,"DILIST",R1SDRRDTA1)) Q:'R1SDRRDTA1  S R1SDRRDTA=$G(^TMP($J,"
          R1SDRR",R1SDCLINIC,"DILIST",R1SDRRDTA1,0)) D
         .Q:$P(R1SDRRDTA,"^",3)'=R1SDCLINIC
         .S R1SDDFN=$P(R1SDRRDTA,"^",2)
         .Q:$$TESTPAT^VADPT(R1SDDFN)
         .S DFN=R1SDDFN
         .D ADD^VADPT,DEM^VADPT
         .S R1SDPN=$P(VADM(1),U)
         .I $G(VADM(6),U)'="" Q
         .S R1SDRDATE=$P(R1SDRRDTA,"^",4) S Y=R1SDRDATE D DD^%DT S R1SDRDATE=Y K Y
         .S R1SDRS=$P(R1SDRRDTA,"^",5)
         .;Support DBIA #4080
         .S R1SDCHECK=$$BADADR^DGUTL3 I R1SDCHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="R1SDRR(" D
         ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
         ..D PID^VADPT S R1SDRR(1)="Bad Address- card will not be printed for:"_"   "_R1SDPN_"   "_VA("BID")
         ..D ^XMD
         ..K XMY,XMSUB,XMTEXT,XMDUZ
         ..QUIT  ;BAI
         .N IO
         .D OFILE^R1ACSX() U IO H 1
         .D BLDDS^R1ACSX(DFN,R1SDCLINIC,R1SDRDATE,1)
         .D CFILE^R1ACSX
         .S DA=$P(R1SDRRDTA,"^",1)
         .I R1SDRS<1 S DIE="^SD(403.5,",DR="6///^S X=DT" D ^DIE K DIE,DR
         .I R1SDRS>1 S DIE="^SD(403.5,",DR="8///^S X=DT" D ^DIE K DIE,DR
         .D ^%ZISC
PAT      ;PRINT FOR ONE PATIENT AT A TIME
         N I,Y
         K ^TMP($J)
         K ^TMP("R1SDRR",$J)
         D ^DPTLK Q:Y<1
         S DFN=+Y
         I '$D(^SD(403.5,"B",DFN)) W !,"No Clinic Recall on file",! G QUIT
         D ADD^VADPT S R1SDCHECK=$$BADADR^DGUTL3 I R1SDCHECK>0 W !,"CARD WILL NOT PRINT - PATIENT FLAGGED WITH A BAD ADDRESS" G QUIT
EN1      D FIND^DIC(403.5,"","@;.01I;2.5;4;4.5I;5I;6I","QP",DFN,"","B","","","^TMP($J,""R1SDRR"",DFN)")
         S (R1SDC,R1SDI)=0 F R1SDI=0:0 S R1SDI=$O(^TMP($J,"R1SDRR",DFN,"DILIST",R1SDI)) Q:'R1SDI  I $D(^TMP($J,"R1SDRR",DFN,"DILIST"
          ,R1SDI,0)) S R1SDD=$G(^TMP($J,"R1SDRR",DFN,"DILIST",R1SDI,0)),R1SDC=R1SDC+1 S ^TMP("R1SDRR",$J,R1SDC)=R1SDI_"^"_R1SDD
         W !!!
         W !,"CHOOSE FROM:" F R1SDI=0:0 S R1SDI=$O(^TMP("R1SDRR",$J,R1SDI)) Q:'R1SDI   S R1SDCLINIC=$P($G(^TMP("R1SDRR",$J,R1SDI)),"
          ^",6) D
         .W !,$J(R1SDI,4),">  "
         .I R1SDCLINIC'="" S R1SDCLINIC=$$GET1^DIQ(44,R1SDCLINIC_",",.01)
         .I R1SDCLINIC="" S R1SDCLINIC="UNK. CLINIC"
         .S R1SDPROV=$P($G(^TMP("R1SDRR",$J,R1SDI)),"^",3)
         .I R1SDPROV="" S R1SDPROV="UNK. PROVIDER"
         .S R1SDRDT=$P(^TMP("R1SDRR",$J,R1SDI),"^",7) S Y=R1SDRDT D DD^%DT S R1SDRDT=Y
         .S R1SDRS=$P(^TMP("R1SDRR",$J,R1SDI),"^",8) S Y=R1SDRS D DD^%DT S R1SDRS=Y
         .S R1SDCOMM="",R1SDCOMM=$P(^TMP("R1SDRR",$J,R1SDI),"^",4)
         .W ?1,"CLINIC:"_$E(R1SDCLINIC,1,15),?28," R/DATE:"_R1SDRDT,?53," NOTICE SENT:"_R1SDRS
         .S R1SDZ=R1SDI I $G(R1SDCOMM)]"" W !,?5,$G(R1SDCOMM) S R1SDZ=R1SDI
         W !,"CHOOSE 1-",R1SDZ_" TO PRINT THE CARD" W:$D(^TMP("R1SDRR",$J,R1SDI+1)) !,"OR '^' TO QUIT" W ": " R X:DTIME I $S('$T!(X[
          "^"):1,X="":1,1:0) S R1SDER=1 G QUIT
         S R1SDZ=X
         I R1SDRS'="" W !!,"Card has been printed ONCE - this will now show as SECOND printing",!
         S DA=$P($G(^TMP("R1SDRR",$J,R1SDZ)),"^",2)
         S R1SDCLINIC=$P($G(^TMP("R1SDRR",$J,R1SDZ)),"^",6)
         S R1SDRDT=$P(^TMP("R1SDRR",$J,R1SDZ),"^",6) S Y=R1SDRDT D DD^%DT S R1SDRDT=Y K Y
         K ^TMP("R1SDRR",$J),^TMP($J)
         D OFILE^R1ACSX() U IO H 1
         D BLDDS^R1ACSX(DFN,R1SDCLINIC,R1SDRDT,1)
         D CFILE^R1ACSX
         I R1SDRS="" S DIE="^SD(403.5,",DR="6///^S X=DT" D ^DIE K DIE,DR
         I R1SDRS'="" S DIE="^SD(403.5,",DR="8///^S X=DT" D ^DIE K DIE,DR
         D ^%ZISC
QUIT     K R1SDADTA,DFN,R1SDDTA,R1SDI,R1SDPNY,R1SDRDT,R1SDRS,DIR,R1SDZ,R1SDDATE1
         K R1SDCLINIC,DA,R1SDDATE,R1SDPROV,R1SDC,R1SDCHECK,R1SDCOMM,R1SDDFN
         K R1SDER,R1SDIEN,R1SDRDATE,R1SDRRDTA,R1SDD,R1SDPN,R1SDRR
         K R1SDRRDTA1,R1SDZSDT,X
         D KVAR^VADPT
         Q
