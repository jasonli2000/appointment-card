R1SDRRM  ;;R1SDRR/MAH;RECALL REMINDER PACKAGE/XEROX PRINTER; 01/15/2008
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;;This routine is called from Option R1CR TASK JOB
         ;;and will be called if Outpatient Clinic param entry is 
         ;;cards and will print on the XEROX VIPP replaces SDRRCTSK1
         ;;Support DBIA #4080
         ;;Call to ^SD(403.53 waived because there needs to be a check for file 403.53
         ;;This routine has a waiver inplace - it will be replaced at a later date
START    Q:'$D(^SD(403.53,0))
         D EN
         D EN1
         G QUIT
EN       K ^TMP("R1SDRR",$J)
         S CRP=0 F  S CRP=$O(^SD(403.53,CRP)) Q:'CRP  D
         .S DATE=$$GET1^DIQ(403.53,CRP_",",3)  ;IF NOT SET ROUTINE WILL QUIT
         .I DATE="" S DATE=30
         .S X="T+"_DATE D ^%DT S ZSDT=Y K Y,X
         .S TEAM=0
         .F  S TEAM=$O(^SD(403.54,"C",TEAM)) Q:'TEAM  D
         ..S R1DIV=$P($G(^SD(403.55,TEAM,0)),U,4) Q:R1DIV'=CRP  ;R1/KP 3/1/11 ACCOMODATE MULT DIV PRINTOUTS
         ..S PROV=0 F  S PROV=$O(^SD(403.54,"C",TEAM,PROV)) Q:'PROV  D
         ...S D0=0 F  S D0=$O(^SD(403.5,"C",PROV,D0)) Q:D0=""  D
         ....S DTA=$G(^SD(403.5,D0,0))
         ....S DFN=+DTA
         ....Q:$P(DTA,U,6)'=ZSDT
         ....Q:$$TESTPAT^VADPT(DFN)
         ....D ADD^VADPT,DEM^VADPT
         ....S PN=$P(VADM(1),U)
         ....I $G(VADM(6),U)'="" Q
         ....S APPT=$P(DTA,U,6) S Y=APPT D DD^%DT S APPT=Y
         ....S CLINIC=$P(DTA,U,2)
         ....;Support DBIA #4080
         ....S CHECK=$$BADADR^DGUTL3 I CHECK>0 S CHECK=1 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D
         .....S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
         .....D PID^VADPT S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
         .....D ^XMD
         .....K XMY,XMSUB,XMTEXT,XMDUZ
         .....QUIT  ;BAI
         ....S ^TMP("R1SDRR",$J,D0)=DFN_"^"_CLINIC_"^"_APPT
         .Q
         Q
EN1      S GRAB="" F  S GRAB=$O(^TMP("R1SDRR",$J,GRAB)) Q:'GRAB  D
         .S DFN=$P(^TMP("R1SDRR",$J,GRAB),"^",1),CLINIC=$P(^TMP("R1SDRR",$J,GRAB),"^",2),APPT=$P(^TMP("R1SDRR",$J,GRAB),"^",3)
         .;Added for creating VIPP cards
         .N IO
         .D OFILE^R1ACSX() U IO H 1
         .D BLDDS^R1ACSX(DFN,CLINIC,APPT,1)
         .D CFILE^R1ACSX
         .;****END OF MOD TO ROUTINE****** *
         .;ADDED THE DATE INFORMATION
         .S DA=GRAB
         .S DIE="^SD(403.5,",DR="6///^S X=DT" D ^DIE K DIE,DR
         D ^%ZISC
         K ^TMP("R1SDRR",$J),GRAB
         Q
QUIT     K ADTA,D0,DFN,DTA,I,L,PN,POP,Y,ZDIV,ZEDT,ZSDT,FAST,TYPE
         K CLINIC,DA,DATE,DEV1,DEVSB,PROV,TEAM,X,APPT,CRP,DOD,SDRR,VA,CHECK
         ;Calling KVAR^VADPT will kill off all VA* values
         D KVAR^VADPT
         Q
