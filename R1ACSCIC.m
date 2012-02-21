R1ACSCIC ;VISN21/vhamachillsg - Clinic in CrossWalk file
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ; This routine will produce a list of clinics that are not in the
         ; R1AC CROSSWALK CLINIC file (612418).
         ;R1/KJP 3/23/11 - Changed filename from IRMS XEROX CROSSWALK to R1AC CROSSWALK CLINIC file.
         Q
CIC      ; list clinics not in XEROX CrossWalk file
         N R1ACDASH,R1ACPCNT,R1ACLCNT,R1ACCIEN,R1ACCCNT,R1ACQUIT,ZTSAVE
         S ZTSAVE("R1AC*")=""
         W !!,"This option will create a listing that contains clinics not listed in"
         W !,"the R1AC CROSSWALK CLINIC file (#612418).  This report is used by the"  ;R1/KJP 3/23/11 CHANGED WORDING
         W !,"Appointment Postcard Coordinator in MAS."
         W !!,"Please specify device to print report"
         D EN^XUTMDEVQ("RPT^R1ACSCIC","Print clinics not contained in R1AC CROSSWALK CLINIC File")  ;R1/KJP 3/23/11 CHANGED WORDING
         Q
         ;
RPT      ; produce report
         D PHDR
         K ^TMP("R1ACSCIC",$J)
         S ^TMP("R1ACSCIC",$J,0)=DT_U_DT
         S R1ACCIEN=""
         ;
         ; build array of all clinics
         F  S R1ACCIEN=$O(^SC(R1ACCIEN)) Q:R1ACCIEN=""  D:+R1ACCIEN
         .I $$CLNSTAT S ^TMP("R1ACSCIC",$J,1,+R1ACCIEN,$P(^SC(+R1ACCIEN,0),U))=""
         .Q
         Q:'$D(^TMP("R1ACSCIC",$J,1))
         ;
         ; run thru clinic array and delete clinics found in crosswalk
         I $D(^TMP("R1ACSCIC",$J,1)) D
         .S R1ACCIEN=""
         .N CCIEN
         .F  S R1ACCIEN=$O(^DIZ(612418,R1ACCIEN)) Q:R1ACCIEN=""  S CCIEN=$P($G(^(R1ACCIEN,0)),U) I CCIEN K ^TMP("R1ACSCIC",$J,1,CCIE
          N)
         .S R1ACCIEN=""
         .; build alphabetical array based upon clinic name
         .F  S R1ACCIEN=$O(^TMP("R1ACSCIC",$J,1,R1ACCIEN)) Q:R1ACCIEN=""  S ^TMP("R1ACSCIC",$J,1,"CLINICS",$O(^TMP("R1ACSCIC",$J,1,R
          1ACCIEN,"")))=R1ACCIEN
         .S R1ACCIEN=""
         .F  S R1ACCIEN=$O(^TMP("R1ACSCIC",$J,1,"CLINICS",R1ACCIEN)) Q:R1ACCIEN=""  D:R1ACLCNT>(IOSL-3) PHDR Q:$G(R1ACQUIT)  W !,R1A
          CCIEN_"  ("_^TMP("R1ACSCIC",$J,1,"CLINICS",R1ACCIEN)_")" S R1ACCCNT=$G(R1ACCCNT)+1,R1ACLCNT=$G(R1ACLCNT)+1
         .W !!,"# of Clinics not in CrossWalk..."_R1ACCCNT
         .Q
         K ^TMP("R1ACSCIC",$J)
         Q
         ;
PHDR     ; Page header
         N R1ACCONT
         S R1ACLCNT=3,R1ACPCNT=$G(R1ACPCNT)+1
         I R1ACPCNT>1,($E($G(IOST),1,2)="C-") W !,"Press <ENTER> to continue or ""^"" to quit " R R1ACCONT:DTIME I R1ACCONT="^"!($T=
          0) S R1ACQUIT=1
         Q:$G(R1ACQUIT)
         W:R1ACPCNT>1 @IOF
         W !,"Clinics not in the R1AC CROSSWALK CLINIC file  (IEN)     Page: "_R1ACPCNT,!  ;R1/KJP 3/23/11 CHANGED WORDING
         F R1ACDASH=1:1:60 W "-"
         W !
         Q
         ;
CLNSTAT(X) --
          ; test to see if valid clinic
         N R1ACSTAT
         S R1ACSTAT=1
         I $P(^SC(+R1ACCIEN,0),"^",3)'="C" S R1ACSTAT=0
         S R1ACIN="" I $D(^SC(R1ACCIEN,"I")) S R1ACIN=$P($G(^SC(R1ACCIEN,"I")),U)
         S R1ACACT="" I $D(^SC(R1ACCIEN,"I")) S R1ACACT=$P($G(^SC(R1ACCIEN,"I")),U,2)
         I R1ACIN]""&(((R1ACIN<DT)&(R1ACACT=""))) S R1ACSTAT=0
         I (R1ACIN]""&(R1ACACT]""))&((R1ACIN<DT)&(R1ACACT>DT)) S R1ACSTAT=0
         I $D(^DIZ(612418,+R1ACCIEN,0)) S R1ACSTAT=0
         Q R1ACSTAT
