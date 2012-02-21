R1ACNWKO ;SFVAMC/NLS - Display Active Clinics at Your Facility
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
LOAD     ;Examine Active Clinics for your facility
         K ^TMP("CLINICSZZ")
         S %ZIS="Q",%ZIS("B")="" D ^%ZIS I POP W ! G EXIT
         I $D(IO("Q")) D  G EXIT
         .S ZTDESC="Current Active Clinics",ZTRTN="DQ^R1ACNWKO"
         .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
         .K ZTSK,IO("Q") D HOME^%ZIS
         W !
DQ       U IO S POP=0
         S (R1ACNUM,R1ACPG,R1ACFLGZ)=0
         F  S R1ACNUM=$O(^SC(R1ACNUM)) Q:'R1ACNUM  S (R1ACTYP,R1ACFLG)=0,R1ACROX="NO" D
         .S R1ACTYP=$P($G(^SC(R1ACNUM,0)),U,3)
         .S R1ACIN="" I $D(^SC(R1ACNUM,"I")) S R1ACIN=$P($G(^SC(R1ACNUM,"I")),U)
         .S R1ACACT="" I $D(^SC(R1ACNUM,"I")) S R1ACACT=$P($G(^SC(R1ACNUM,"I")),U,2)
         .S R1ACFLG=0 D TEST I R1ACFLG=0 D
         ..S (R1ACNAM,R1ACNAZ)="",R1ACNAM=$E($P(^SC(R1ACNUM,0),U),1,30)
         ..S R1ACFN="",R1ACFN=$P($G(^DIZ(612418,R1ACNUM,0)),U,3)
         ..I $D(^DIZ(612418,R1ACNUM)) S R1ACROX="YES"
         ..S (R1ACPER,R1ACPERZ)="",R1ACPER=$P($G(^DIZ(612418,R1ACNUM,"AUDIT")),U) I $G(R1ACPER)>0 S R1ACPERZ=$E($P(^VA(200,R1ACPER,0
          ),U),1,15)
         ..S (R1ACENT,R1ACENTZ)="",R1ACENT=$P($G(^DIZ(612418,R1ACNUM,"AUDIT")),U,2) I $G(R1ACENT)>0 S R1ACENTZ=$E(R1ACENT,4,5)_"/"_$
          E(R1ACENT,6,7)_"/"_$E(R1ACENT,2,3)
         ..S (R1ACINS,R1ACINZ)="",R1ACINS=$P($G(^SC(R1ACNUM,0)),U,4) I $G(R1ACINS)]"" S R1ACINZ=$E($P(^DIC(4,R1ACINS,0),U),1,11)
         ..I R1ACFLG=0 S ^TMP("CLINICSZZ",$J,R1ACNAM)=R1ACNAM_U_R1ACENTZ_U_R1ACPERZ_U_R1ACROX_U_R1ACINZ S R1ACFLG=0
         W:$E(IOST,1,2)="C-" @IOF D HDR1
         D LOAD2,EXIT
         Q
HDR1     ;
         S R1ACINS="",R1ACINS=$P(^DIC(4,DUZ(2),0),U)
         W !?17,"***  ",R1ACINS," Active Clinics  ***"
HDR      ;
         S R1ACNOW="",Y=DT X ^DD("DD") S R1ACNOW=Y
         I R1ACPG>0,($E(IOST,1,2)="C-") S DIR(0)="E" D ^DIR W ! I $D(DTOUT)!(X[U)!($D(DUOUT)) S R1ACFLGZ=1
         W:R1ACPG>0 @IOF S R1ACPG=R1ACPG+1
         W !?32,"Dt X-Walk",?58,"Linked In",?71,"Inst",!
         W "CLINIC NAME",?32,"Added",?42,"By Whom",?58,"In X-Walk?",?71,"Link",!
         F I=1:1:80 W "="
         W !
         Q 
         ;
CHKL      S R1ACFLGZ=0 I $Y>(IOSL-4) D RET:($E(IOST,1,2)="C-") Q:R1ACFLGZ  D HDR
         Q
RET      K DIR S DIR(0)="E" D ^DIR K DIR(0) I $D(DIRUT) S R1ACFLGZ=1
         Q
LOAD2    ;
         S R1ACNAM="",(R1ACCNT,R1ACFLGZ)=0
         F  S R1ACNAM=$O(^TMP("CLINICSZZ",$J,R1ACNAM)) Q:R1ACNAM=""  Q:R1ACFLGZ=1  S R1ACNOD="" D
         .S R1ACNOD=^TMP("CLINICSZZ",$J,R1ACNAM)
         .D CHKL Q:R1ACFLGZ
         .W !,$E($P(R1ACNOD,U),1,23),?32,$P($G(R1ACNOD),U,2),?42,$P($G(R1ACNOD),U,3),?60,$P(R1ACNOD,U,4),?69,$P(R1ACNOD,U,5) S R1ACC
          NT=R1ACCNT+1
         .I $Y+15>IOSL,($E(IOST,1,2)="C-") S DIR(0)="E" D HDR S:POP R1ACFLGZ=1
         .I $Y+15>IOSL,($E(IOST,1,2)="C-") K DIR S DIR(0)="E" D ^DIR I $D(DTOUT)!(X[U)!($D(DUOUT)) S R1ACFLGZ=1 K DIR,DUOUT,DTOUT,DI
          RUT
         W !!,"Total Count:  ",R1ACCNT
         G EXIT
         Q
TEST     ;
         I R1ACTYP'="C" S R1ACFLG=1 Q
         I R1ACIN]""&(((R1ACIN<DT)&(R1ACACT=""))) S R1ACFLG=1 Q
         I (R1ACIN]""&(R1ACACT]""))&((R1ACIN<DT)&(R1ACACT>DT)) S R1ACFLG=1 Q
         Q
CLIN1(Y) ;X-Walk Clinic w/o attached Boiler Plate
         S R1ACULT=1
         I $P($G(^DIZ(612418,+Y,17)),U)]"" S R1ACULT=0
         Q R1ACULT
CLIN2(Y) ;X-Walk Clinic with attached Boiler Plate
         S R1ACULT=1
         I $P($G(^DIZ(612418,+Y,17)),U)']"" S R1ACULT=0
         Q R1ACULT
EXIT     ;
         D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
         ;K ^TMP("CLINICSZZ")
         K R1ACFLG,R1ACFLGZ,R1ACENT,R1ACENTZ,R1ACFN,R1ACPG,R1ACCNT,R1ACPER,R1ACPERZ,R1ACINS
         K R1ACINZ,R1ACIN,R1ACNAM,R1ACNAZ,R1ACNOD,R1ACNOW,R1ACNUM,R1ACACT,R1ACTYP,X,R1ACROX,R1ACULT,Y
         K DA,DIC,DIK,DUOUT,I
         K %ZIS,%ZIS("B"),POP,ZTDESC,ZTQUEUED,ZTREQ,ZTRTN
         Q
BP(Y)    ;Active Boiler Plate
         S R1ACRES=1
         I $P($G(^DIZ(612418.1,+Y,0)),U,3)]""&($P($G(^DIZ(612418.1,+Y,0)),U,3)<DT) S R1ACRES=0 ;INACTIVE BP
         Q R1ACRES
         ;
KILL1    ;Deletes Boiler Plate in #612418.1 & all BLUEBOX TEMPLATES in #612418 pointing to that BP
         S R1ACDA=""
         F  S DIC="^DIZ(612418.1,",DIC(0)="AEMQ",DIC("A")="Select Boiler Plate to Delete:  " D ^DIC S R1ACDA=+Y D  I +Y<1 K DIC G EX
          IT2
         .I +R1ACDA<1 Q
         .S R1ACDAZ=0
         .F  S R1ACDAZ=$O(^DIZ(612418,R1ACDAZ)) Q:'R1ACDAZ  D
         ..I $P($G(^DIZ(612418,R1ACDAZ,17)),U)=R1ACDA D
         ...S DIK="^DIZ(612418,",DA=R1ACDAZ,DIK(1)=23 D EN2^DIK ;Get "C" X-REF
         ...K ^DIZ(612418,R1ACDAZ,17) W !,"Killing Entry #:  ",$G(R1ACDAZ)
         ...S DIK="^DIZ(612418.1,",DA=+R1ACDA D ^DIK
         Q
EXIT2    K DA,DAZ,DIK,Q,R1ACDA,R1ACDAZ,X,Y
         Q
         ;
KILL2    ;Deletes all blue box text for a given clinic in #612418
         N REF
         S REF=""
         F  S DIC="^DIZ(612418,",DIC(0)="AEMQ",DIC("A")="Slct Clinic where Blue Box Txt will be DELETED:  " D ^DIC S R1ACDA=+Y D  I 
          +R1ACDA<1 K DIC G EXIT3
         .I +R1ACDA<1 Q
         .S DA(1)=R1ACDA,DA=0
         .S REF=$NA(^DIZ(612418,DA(1),0))
         .D LOCK^DILF(REF) I $T D
         ..F DA=4,9:1:22 D
         ...K ARHDFDA S ARHDFDA(612418,DA(1)_",",DA)="@" D FILE^DIE("E","ARHDFDA")  W "."
         ..L -^DIZ(612418,DA(1),0)
         Q
EXIT3    K DA,DA(1),DA(2),DIC,DIK,I,Q,R1ACDA,X,Y,ARHDFDA(612418)
         Q
