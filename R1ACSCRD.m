R1ACSCRD ;VISN21/vhamachillsg - Print Appointment Postcard Driver (1) ; Oct 7. 2007
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
         ;This routine will make calls to the SDAPI and retrieve scheduling 
         ;information to print portcards on a XEROX DOCUTech 128 printer.
         ;The XEROX DocuTech printer was purchased by the Western Region
         ;Logistical Service to assist in revamping patient correspondence.
         ;
         ;D PREAPP
         ;D NOSHOW
         ;D CANCEL
         Q
         ;
PREAPP   ; Pre-appointment postcards - PostCard #4
         ; Pre-appointment postcards (letters) are generated here.
         ; During this process, based upon criteria in the XEROX CrossWalk 
         ; and boilerplates associated with a clinic, other postcards can be
         ; generated.
         ;
         N DIRUT
         D CHKTST Q:$D(DIRUT)
         N SDAPSTAT,R1ACPC,SDSTART,SDEND,SDIOSTAT,X,Y
         S SDAPSTAT="R",SDIOSTAT="O",R1ACPC=4
         ;S (SDSTART,SDEND)=3070817
         S X=$S($P($G(^DIZ(612418.5,1,2)),U,5):$P(^(2),U,5),1:"14"),X="T+"_X D ^%DT
         S (SDSTART,SDEND)=Y
         D MAIN
         Q
         ;
NOSHOW   ; No-show postcards - Postcard #10
         N DIRUT
         D CHKTST Q:$D(DIRUT)
         N SDAPSTAT,R1ACPC,SDSTART,SDEND,SDIOSTAT,X,Y
         S SDAPSTAT="N",SDIOSTAT="",R1ACPC=10
         ;S (SDSTART,SDEND)=3070817
         S X=$S($P($G(^DIZ(612418.5,1,2)),U,8):$P(^(2),U,8),1:"2"),X="T-"_X D ^%DT
         S (SDSTART,SDEND)=Y
         D MAIN
         Q
         ;
CANCEL   ; Cancel Clinic postcards - Postcard #13
         N DIRUT
         D CHKTST Q:$D(DIRUT)
         N SDAPSTAT,R1ACPC,SDSTART,SDEND,SDIOSTAT,X,Y
         S SDAPSTAT="C",SDIOSTAT="",R1ACPC=13
         S X=$S($P($G(^DIZ(612418.5,1,2)),U,7):$P(^(2),U,7),1:"14"),X="T+"_X D ^%DT
         S (SDSTART,SDEND)=Y,(R1ACCNT,R1ACCNT2,SDDFN)=0
         K ^TMP($J,"SDAMA301")
         I '$D(^TMP("R1ACSCRD",$J,1,"VIPP","R1ACTEST")) D OFILE^R1ACSX() U IO
         F  S SDDFN=$O(^DPT(SDDFN)) Q:'SDDFN  D
         .D MAIN2(SDDFN)
         I '$D(^TMP("R1ACSCRD",$J,1,"VIPP","R1ACTEST")) D CFILE^R1ACSX
         I $E($G(IOST),1,2)="C-" D
         .D HOME^%ZIS U IO
         W !,"Number of clinics processed from Xwalk...."_R1ACCNT
         W !,"Number of patient appointments processed.."_R1ACCNT2
         W:$G(^TMP("R1ACSCRD",$J,"VIPP",1,"R1ACTEST","CNT")) !,"Number of patient postcards produced......"_+$G(^TMP($J,"VIPP","R1AC
          TEST","CNT"))
         K ^TMP("R1ACSCRD",$J)
         Q
         ;
         ;
CHKTST   ;
         ; If interactive job, ask if running a test
         K ^TMP("R1ACSCRD",$J)
         I $E($G(IOST),1,2)="C-" D  Q:$D(DIRUT)
         .K DIR
         .S DIR("A")="   Is this a TEST run? ",DIR("B")="No"
         .S DIR(0)="YOA" D ^DIR
         .I Y=1 D
         ..S ^TMP("R1ACSCRD",$J,0)=DT_U_DT
         ..S ^TMP("R1ACSCRD",$J,1,"VIPP","R1ACTEST")=1
         ..W !,"Test switch set...",!!
         ..Q
         .K DIR
         .Q
         Q
         ;
MAIN2(SDDFN) --
          ;Use ^SDAMA301 to retrieve Cancelled Clinics
         S R1ACPC=13
         N SDARRAY,SDDATE,SDCLIEN,ARRAY,SDCOUNT
         S SDARRAY(1)=SDSTART_";"_SDEND
         S SDARRAY(4)=SDDFN
         S SDARRAY(3)="CC;CCR" ;For Canceled Clinics
         S SDARRAY("FLDS")="1;3;4"
         S ARRAY("SORT")="P" ;Patient Filter
         S SDCOUNT=$$SDAPI^SDAMA301(.SDARRAY) Q:SDCOUNT'>0
         S SDDFN="" F  S SDDFN=$O(^TMP($J,"SDAMA301",SDDFN)) Q:'SDDFN  D
         . S SDCLIEN=0 F  S SDCLIEN=$O(^TMP($J,"SDAMA301",SDDFN,SDCLIEN)) Q:'SDCLIEN  D
         ..S SDDATE=0 F  S SDDATE=$O(^TMP($J,"SDAMA301",SDDFN,SDCLIEN,SDDATE)) Q:'SDDATE  D
         ... D:R1ACPC=4 ACCHK
         ... I $D(^DIZ(612418,SDCLIEN)) D BLDDS^R1ACSX(SDDFN,SDCLIEN,SDDATE,R1ACPC,SDDATE,SDCLIEN) S R1ACCNT2=R1ACCNT2+1
         ... I $D(R1ACHPC) S R1ACPC=R1ACHPC K R1ACHPC
         ...Q
         ..Q
         .S R1ACCNT=R1ACCNT+1
         .Q
         Q
         ;
MAIN     ;
         K ^TMP($J,"SDAMA202")
         N R1ACCLN,R1ACCNT,R1ACCNT2,R1ACHPC
         I '$D(^TMP("R1ACSCRD",$J,1,"VIPP","R1ACTEST")) D OFILE^R1ACSX() U IO
         S R1ACCLN="",(R1ACCNT,R1ACCNT2)=0
         F  S R1ACCLN=$O(^DIZ(612418,R1ACCLN)) Q:R1ACCLN=""  D:R1ACCLN
         .D
         ..K ^TMP($J,"SDAMA202")
         ..N SDRESULT
         ..D GETPLIST^SDAMA202(R1ACCLN,"1;4",SDAPSTAT,SDSTART,SDEND,.SDRESULT,SDIOSTAT)
         ..I SDRESULT<1 Q
         ..N R1ACI,R1ACDFN,R1ACADT
         ..F R1ACI=1:1:SDRESULT D
         ...;W ^TMP($J,"SDAMA202","GETPLIST",R1ACI,4),!
         ...S R1ACDFN=$P($G(^TMP($J,"SDAMA202","GETPLIST",R1ACI,4)),U)
         ...S R1ACADT=$P($G(^TMP($J,"SDAMA202","GETPLIST",R1ACI,1)),U)
         ...;W R1ACDFN_U_R1ACCLN_U_R1ACADT_U_R1ACPC,!
         ...S R1ACCNT2=R1ACCNT2+1
         ...;
         ...; check and see if postcard type needs to be changed appointment type
         ...D:R1ACPC=4 ACCHK
         ...D BLDDS^R1ACSX(R1ACDFN,R1ACCLN,R1ACADT,R1ACPC)
         ...I $D(R1ACHPC) S R1ACPC=R1ACHPC K R1ACHPC
         ...Q
         ..Q
         .S R1ACCNT=R1ACCNT+1
         .Q
         I '$D(^TMP("R1ACSCRD",$J,1,"VIPP","R1ACTEST")) D CFILE^R1ACSX
         I $E($G(IOST),1,2)="C-" D
         .D HOME^%ZIS U IO
         .W !,"Number of clinics processed from Xwalk...."_R1ACCNT
         .W !,"Number of patient appointments processed.."_R1ACCNT2
         .W:$G(^TMP("R1ACSCRD",$J,"VIPP",1,"R1ACTEST","CNT")) !,"Number of patient postcards produced......"_+$G(^TMP($J,"VIPP","R1A
          CTEST","CNT"))
         .Q
         K ^TMP("R1ACSCRD",$J)
         Q
         ;
ACCHK    ; Check postcard type "4" and see if it needs to be adjusted for #612418.4 matching
         ; on 3rd piece . Credit Stop Match
         ; on 4th piece . Partial String Match
         ; a match in either place can potentially make the card
         ; Post Card #2 Comp & Pen
         ; Post Card #3 Appt - Bring
         ; Post Card #5 Phone Consult
         ; Post Card #7 Means Test:  0 day
         ; Post Card #8 Mobile Svcs Appt
         ; Post Card #12 Group Orientation Appt Alert
         ;
         N CLNNME,STOPCD,CNAME,STRING,X,PCARD
         S (CLNNME,STOPCD,CNAME)=""
         S CNAME=$P($G(^SC(+R1ACCLN,0)),U)
         S CLNNME=$P($G(^DIZ(612418,+R1ACCLN,0)),U)
         S STOPCD=$P(^SC(+R1ACCLN,0),U,18),X=0  ;Credit Stop Code field pointing to CLINIC STOP file.
         F  S X=$O(^DIZ(612418.4,X)) Q:'X  I $D(^(X,0)) S STRING="" D
         .I $P($G(^DIZ(612418.4,X,0)),U,4)'="" S STRING=$P($G(^DIZ(612418.4,X,0)),U,4) I CNAME[STRING S PCARD=$P(^DIZ(612418.4,X,0),
          U,2) Q
         .I $P($G(^DIZ(612418.4,X,0)),U,3)'="",$P($G(^DIZ(612418.4,X,0)),U,3)=STOPCD S PCARD=$P(^DIZ(612418.4,X,0),U,2) Q
         I $D(PCARD) S R1ACHPC=4,R1ACPC=PCARD
         Q
