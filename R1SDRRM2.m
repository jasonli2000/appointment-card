R1SDRRM2 ;;R1SDRR/MAH;RECALL REMINDER PACKAGE/XEROX PRINTER; 04/07/2009
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;;This routine will allow for rerunning creation of file 
         ;;for those who have not called in. 
         ;;cards and will print on the XEROX VIPP
         ;;Support DBIA #4080
SELDT     D DQDD
         D DQDD1
         Q
DQDD     K ^TMP($J,"R1SDRR")
         S X="T+"_5 D ^%DT Q:Y<0  S R1SDZSDT=Y
         D FIND^DIC(403.5,"","@;.01I;4.5I;5I;6I;8","QP",R1SDZSDT,"","D","","","^TMP($J,""R1SDRR"",R1SDZSDT)")
         Q
DQDD1    N R1SDRDATE,R1SDDFN,R1SDCLINIC
         W !,R1SDZSDT S R1SDRRDT=0 F  S R1SDRRDT=$O(^TMP($J,"R1SDRR",R1SDZSDT,"DILIST",R1SDRRDT)) Q:'R1SDRRDT  S R1SDRRDTA=$G(^TMP($
          J,"R1SDRR",R1SDZSDT,"DILIST",R1SDRRDT,0)) D
         .Q:$P($G(R1SDRRDTA),"^",6)'="" 
         .S R1SDDFN=$P(R1SDRRDTA,"^",2)
         .S Y=R1SDZSDT D DD^%DT S R1SDRDATE=Y
         .Q:$$TESTPAT^VADPT(R1SDDFN)
         .S DFN=R1SDDFN
         .D ADD^VADPT,DEM^VADPT
         .I $G(VADM(6),U)'="" Q
         .;Support DBIA #4080
         .S R1SDCHECK=$$BADADR^DGUTL3 I R1SDCHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="R1SDRR(" D
         ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
         ..S R1SDRR(1)="Bad Address- card will not be printed for:"_"   "_$P(VADM(1),"^",1)_"   "_VA("BID")
         ..D ^XMD
         ..K XMY,XMSUB,XMTEXT,XMDUZ
         ..QUIT  ;BAI
         .S R1SDCLINIC=$P(R1SDRRDTA,"^",3)
         .N IO
         .D OFILE^R1ACSX() U IO H 1
         .D BLDDS^R1ACSX(R1SDDFN,R1SDCLINIC,R1SDRDATE,1)
         .D CFILE^R1ACSX
         .S DA=$P(R1SDRRDTA,"^",1)
         .I $P($G(R1SDRRDTA),"^",5)="" S DIE="^SD(403.5,",DR="6///^S X=DT" D ^DIE K DIE,DR
         .S DIE="^SD(403.5,",DR="8///^S X=DT" D ^DIE K DIE,DR
         .D ^%ZISC
QUIT     K DA,R1SDRRDT,X1,X2,R1SDRRDTA,R1SDATE,R1SDDATE1,R1SDDATE,R1SDIEN,R1SDZSDT,SDRR,R1SDRR,DFN
         K ^TMP($J,"R1SDRR")
         ;Calling KVAR^VADPT will kill off all VA* values
         D KVAR^VADPT
         Q
