R1ACNWKS ;VISN21/NLS - Bad Address Report #1,2,3,4 for Print Appt PostCard Proj
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
ONE      ;find patients who have NO collateral sponsor, BAI="", have NO street addrs #1, & eligibility code'="employee"
         S %ZIS="Q",%ZIS("B")="" D ^%ZIS I POP W ! G EXIT1
         I $D(IO("Q")) D  G EXIT1
         .S ZTDESC="Bad Addr Report #1",ZTRTN="DQ1^R1ACNWKS"
         .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
         .K ZTSK,IO("Q") D HOME^%ZIS
         W !
DQ1      U IO S POP=0
         S (R1ACDFN,R1ACCNT,R1ACFLG,R1ACFLGZ,R1ACPG)=0 W @IOF,! D HDR1
         F  S R1ACDFN=$O(^DPT(R1ACDFN)) Q:'R1ACDFN  Q:R1ACFLG=1  Q:R1ACFLGZ=1  S (R1ACADR,R1ACADR2,R1ACBAI)="" D
         .I $P($G(^DPT(R1ACDFN,0)),U,9)'>"" Q  ;No SSN
         .Q:$E($P($G(^DPT(R1ACDFN,0)),U,9),1,5)["00000"  ;Test Patient
         .Q:$E($P($G(^DPT(R1ACDFN,0)),U),1,2)["ZZ"  ;Not an active Patient
         .Q:$E($P($G(^DPT(R1ACDFN,0)),U),1,2)["zz"  ;Not an active Patient
         .Q:$P($G(^DPT(R1ACDFN,.35)),U)]""  ;Deceased Patient
         .;Q:$E($P($G(^DPT(R1ACDFN,0)),U),1,2)["C-" ;Colateral
         .S R1ACADR=$P($G(^DPT(R1ACDFN,.11)),U) ;Street Addr Line 1
         .S R1ACADR2=$P($G(^DPT(R1ACDFN,.11)),U,2) ;Street Addrs Line 2
         .Q:$G(R1ACADR)]""  ;Quit if patient has street address #1
         .S R1ACCOL="",R1ACCOL=$P($G(^DPT(R1ACDFN,.36)),U,11) ;Collateral Sponsor's Name
         .Q:$G(R1ACCOL)]""  ;Exclude patients who have a collateral sponsor's name
         .S R1ACBAI=$P($G(^DPT(R1ACDFN,.11)),U,16) ;Bad Address Indicator
         .Q:$G(R1ACBAI)]""   ;Exclude patients that already have a Bad Address Indicator
         .S (R1ACRLL,R1ACELG,R1ACEMP)="",R1ACRLL=$P($G(^DPT(R1ACDFN,"ENR")),U) I $G(R1ACRLL)]"" S R1ACELG=$P($G(^DGEN(27.11,R1ACRLL,
          "E")),U) I $G(R1ACELG)]"" S R1ACEMP=$P(^DIC(8.1,R1ACELG,0),U) ;Patient's Eligibility Code
         .Q:R1ACELG="EMPLOYEE"  ;Exclude patients who are employees
         .Q:R1ACFLGZ  D CHKL1 Q:R1ACFLGZ
         .W !,$P($G(^DPT(R1ACDFN,0)),U),?31,$P($G(^DPT(R1ACDFN,0)),U,9),?42,R1ACDFN,?50,$E(R1ACEMP,1,8),?60,$E(R1ACADR2,1,19) S R1AC
          CNT=R1ACCNT+1
         W !!,"Total Patient Count:  ",R1ACCNT
         G EXIT1
         Q
HDR1     S R1ACINS="",R1ACINS=$P(^DIC(4,DUZ(2),0),U)
         W !,?5,"*** ",R1ACINS," Bad Address Report #1 ***",!
HDR11    S R1ACNOW="",Y=DT X ^DD("DD") S R1ACNOW=Y
         W:R1ACPG>0 @IOF S R1ACPG=R1ACPG+1
         W !?40,"Run Date:  ",R1ACNOW,?70,"Page:  ",$G(R1ACPG),!
         W "Pts (alive) w/NO coll sponsor, BAI='', NO StrAddrs#1, & elig code NOT='employee'",!!
         W "Patient Name",?31,"SSN",?42,"IEN",?50,"Elig Code",?60,"Street Addr Line #2",!
         F I=1:1:80 W "="
         W !
         Q
CHKL1    I $Y>(IOSL-4) D RET:($E(IOST,1,2)="C-") Q:R1ACFLGZ  D HDR11
         Q
RET      K DIR S DIR(0)="E" D ^DIR K DIR(0) I $D(DIRUT) S R1ACFLGZ=1
         Q
EXIT1    ;
         D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
         K R1ACFLG,R1ACPG,R1ACADR,R1ACADR2,R1ACBAI,R1ACCNT,R1ACCOL,R1ACDFN,R1ACELG,R1ACEMP
         K R1ACFLGZ,R1ACINS,R1ACRLL,I,R1ACNOW,X,Y,%ZIS,%ZIS("B"),DIRUT,XTDESC,ZTQUEUED,ZTREQ,ZTRTN
         Q
         ;
TWO      ;find patients whose 1st addr line contains: "none", "homeless", local VAMC addr
         S %ZIS="Q",%ZIS("B")="" D ^%ZIS I POP W ! G EXIT2
         I $D(IO("Q")) D  G EXIT2
         .S ZTDESC="Bad Addr Report #2",ZTRTN="DQ2^R1ACNWKS"
         .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
         .K ZTSK,IO("Q") D HOME^%ZIS
         W !
DQ2      U IO S POP=0
         S (R1ACDFN,R1ACCNT,R1ACFLG,R1ACFLGZ,R1ACPG)=0,(R1ACVA,R1ACIEN)="",R1ACIEN=$G(DUZ("2"))
         W @IOF,! D HDR2
         S R1ACVA=$S($P($G(^DIC(4,R1ACIEN,1)),U)]"":$P($G(^DIC(4,R1ACIEN,1)),U),($P($G(^DIC(4,R1ACIEN,4)),U)]""):($P($G(^DIC(4,R1ACI
          EN,4)),U)),1:"")
         F  S R1ACDFN=$O(^DPT(R1ACDFN)) Q:'R1ACDFN  Q:R1ACFLGZ=1  S (R1ACZFLG,R1ACADR,R1ACBAI)="" D
         .I $P($G(^DPT(R1ACDFN,0)),U,9)'>"" Q  ;No SSN
         .I $E($P(^DPT(R1ACDFN,0),U,9),1,5)["00000" Q  ;Test Patient
         .I $E($P(^DPT(R1ACDFN,0),U),1,2)["ZZ" Q  ;Not an active Patient
         .Q:$E($P($G(^DPT(R1ACDFN,0)),U),1,2)["zz"  ;Not an active Patient
         .I $P($G(^DPT(R1ACDFN,.35)),U)]"" Q  ;Deceased Patient
         .;Q:$E($P(^DPT(R1ACDFN,0),U),1,2)["C-" ;Colateral
         .S R1ACADR="",R1ACADR=$P($G(^DPT(R1ACDFN,.11)),U) ;STREET ADDRESS [LINE 1]
         .S R1ACCTY="",R1ACCTY=$P($G(^DPT(R1ACDFN,.11)),U,4) ;CITY
         .S R1ACST="",R1ACST=$P($G(^DPT(R1ACDFN,.11)),U,5) ;STATE
         .S R1ACZIP="",R1ACZIP=$P($G(^DPT(R1ACDFN,.11)),U,6) ;ZIP
         .S R1ACTMP="",R1ACTMP=$P($G(^DPT(R1ACDFN,.121)),U,9) ;TEMPORARY ADDRESS ACTIVE?
         .S R1ACZFLG="" I (R1ACADR="")&(R1ACCTY="")&(R1ACST="")&(R1ACZIP="")&(R1ACTMP="N") S R1ACZFLG="NONE",R1ACFLG=1
         .I R1ACADR["NONE"!(R1ACADR["None")!(R1ACADR["none") S R1ACFLG=1
         .I (R1ACADR["HOMELESS")!(R1ACADR["homeless")!(R1ACADR["Homeless") S R1ACFLG=1
         .I (R1ACADR=R1ACVA) S R1ACFLG=1
         .I R1ACFLG=1 S R1ACBAI=$P($G(^DPT(R1ACDFN,.11)),U,16) S R1ACBAI=$S(R1ACBAI=1:"UNDELIVERABLE",R1ACBAI=2:"HOMELESS",R1ACBAI=3
          :"OTHER",1:"")
         .Q:R1ACFLGZ  D CHKL2 Q:R1ACFLGZ
         .I R1ACFLG=1 W !,$P($G(^DPT(R1ACDFN,0)),U),?31,$P($G(^DPT(R1ACDFN,0)),U,9),?42,R1ACDFN,?50,R1ACBAI,?70,$G(R1ACZFLG) S R1ACC
          NT=R1ACCNT+1,R1ACFLG=0,R1ACZFLG=""
         W !!,"Total Patient Count:  ",R1ACCNT
         G EXIT2
         Q
CHKL2    I $Y>(IOSL-4) D RET:(IOST?1"C-".E) Q:R1ACFLGZ  D HDR22
         Q
EXIT2    ;
         D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
         K R1ACADR,R1ACFLG,R1ACFLGZ,R1ACPG,R1ACBAI,R1ACCTY,R1ACCNT,R1ACDFN,DUOUT,I,R1ACIEN,R1ACINS,R1ACNOW,POP,R1ACST,R1ACTMP,R1ACVA
          ,X,Y,R1ACZIP,R1ACZFLG
         K %ZIS,%ZIS("B"),DIRUT,ZTDESC,ZTQUEUED,ZTREQ,ZTRTN
         Q
HDR2     S R1ACINS="",R1ACINS=$P(^DIC(4,DUZ(2),0),U)
         W !?5,"*** ",R1ACINS," Bad Address Report #2 ***",!
HDR22    S R1ACNOW="",Y=DT X ^DD("DD") S R1ACNOW=Y
         W:R1ACPG>0 @IOF S R1ACPG=R1ACPG+1
         W !?40,"Run Date:  ",R1ACNOW,?70,"Page:  ",$G(R1ACPG),!
         W "Patients whose 1st street addr line contains: 'none', 'homeless', or 'VAMC addr';",!
         W "or no Perm Addr.   Evaluate for possible BAI flagging.",!!
         W "Patient Name",?31,"SSN",?42,"IEN",?50,"BAI",?70,"Addrs?",!
         F I=1:1:80 W "="
         W !
         Q
         ;
THREE    ;Find patients who have text in STREET ADDRESS [LINE 3]
         S %ZIS="Q",%ZIS("B")="" D ^%ZIS I POP W ! G EXIT3
         I $D(IO("Q")) D  G EXIT3
         .S ZTDESC="Bad Addr Report #3",ZTRTN="DQ3^R1ACNWKS"
         .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
         .K ZTSK,IO("Q") D HOME^%ZIS
         W !
DQ3      U IO S POP=0
         S (R1ACDFN,R1ACFLGZ,R1ACPG,R1ACCNT)=0 W @IOF,! D HDR3
         F  S R1ACDFN=$O(^DPT(R1ACDFN)) Q:'R1ACDFN  Q:R1ACFLGZ=1  S R1ACADR="",R1ACFLG=0 D
         .I $P($G(^DPT(R1ACDFN,0)),U,9)'>"" Q  ;No SSN
         .Q:$E($P($G(^DPT(R1ACDFN,0)),U,9),1,5)["00000"  ;Test Patient
         .Q:$E($P($G(^DPT(R1ACDFN,0)),U),1,2)["ZZ"  ;Not an active Patient
         .Q:$E($P($G(^DPT(R1ACDFN,0)),U),1,2)["zz"  ;Not an active Patient
         .Q:$P($G(^DPT(R1ACDFN,.35)),U)]""  ;Deceased Patient
         .;Q:$E($P($G(^DPT(R1ACDFN,0)),U),1,2)["C-" ;Colateral
         .S R1ACADR=$P($G(^DPT(R1ACDFN,.11)),U,3) I R1ACADR]"" S R1ACFLG=1 ;STREET ADDRESS [LINE 3]
         .Q:R1ACFLGZ  D CHKL3 Q:R1ACFLGZ
         .I R1ACFLG=1 W !,$P($G(^DPT(R1ACDFN,0)),U),?31,$P($G(^DPT(R1ACDFN,0)),U,9),?42,R1ACDFN,?50,$G(R1ACADR) S R1ACCNT=R1ACCNT+1,
          R1ACFLG=0
         W !!,"Total Patient Count:  ",R1ACCNT
         G EXIT3
         Q
CHKL3    I $Y>(IOSL-4) D RET:(IOST?1"C-".E) Q:R1ACFLGZ  D HDR33
         Q
EXIT3    ;
         D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
         K DUOUT,I,R1ACADR,R1ACFLG,R1ACFLGZ,R1ACPG,R1ACCNT,R1ACDFN,R1ACINS,R1ACNOW,X,Y
         K %ZIS,%ZIS("B"),DIRUT,ZTDESC,ZTQUEUED,ZTREQ,ZTRTN
         Q
HDR3     S R1ACINS="",R1ACINS=$P(^DIC(4,DUZ(2),0),U)
         W !?5,"*** ",R1ACINS," Bad Address Report #3 ***",!
HDR33    S R1ACNOW="",Y=DT X ^DD("DD") S R1ACNOW=Y
         W:R1ACPG>0 @IOF S R1ACPG=R1ACPG+1
         W !?40,"Run Date:  ",R1ACNOW,?70,"Page:  ",$G(R1ACPG),!
         W "Patients whose 3rd street addr line contains text.",!
         W "Evaluate for moving text so that Pt address contains only Two Lines.",!!
         W "Patient Name",?31,"SSN",?42,"IEN",?50,"Third Address Line",!
         F I=1:1:80 W "="
         W !
         Q
         ;
         ;
FOUR     ;Find patients who have text in TEMPORARY STREET [LINE 3]
         S %ZIS="Q",%ZIS("B")="" D ^%ZIS I POP W ! G EXIT4
         I $D(IO("Q")) D  G EXIT4
         .S ZTDESC="Bad Addr Report #4",ZTRTN="DQ4^R1ACNWKS"
         .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
         .K ZTSK,IO("Q") D HOME^%ZIS
         W !
DQ4      U IO S POP=0
         S (R1ACDFN,R1ACFLG,R1ACFLGZ,R1ACPG,R1ACCNT)=0 W @IOF,! D HDR4
         F  S R1ACDFN=$O(^DPT(R1ACDFN)) Q:'R1ACDFN  Q:R1ACFLGZ=1  S R1ACADR="",R1ACFLG=0 D
         .I $P($G(^DPT(R1ACDFN,0)),U,9)'>"" Q  ;No SSN
         .Q:$E($P($G(^DPT(R1ACDFN,0)),U,9),1,5)["00000"  ;Test Patient
         .Q:$E($P($G(^DPT(R1ACDFN,0)),U),1,2)["ZZ"  ;Not an active Patient
         .Q:$E($P($G(^DPT(R1ACDFN,0)),U),1,2)["zz"  ;Not an active Patient
         .Q:$P($G(^DPT(R1ACDFN,.35)),U)]""  ;Deceased Patient
         .;Q:$E($P($G(^DPT(R1ACDFN,0)),U),1,2)["C-" ;Colateral
         .S R1ACADR=$P($G(^DPT(R1ACDFN,.121)),U,3) I R1ACADR]"" S R1ACFLG=1 ;TEMPORARY STREET [LINE 3]
         .Q:R1ACFLGZ  D CHKL4 Q:R1ACFLGZ
         .I R1ACFLG=1 W !,$P($G(^DPT(R1ACDFN,0)),U),?31,$P($G(^DPT(R1ACDFN,0)),U,9),?42,R1ACDFN,?50,$G(R1ACADR) S R1ACCNT=R1ACCNT+1,
          R1ACFLG=0
         W !!,"Total Patient Count:  ",R1ACCNT
         G EXIT4
         Q
CHKL4    I $Y>(IOSL-4) D RET:(IOST?1"C-".E) Q:R1ACFLGZ  D HDR44
         Q
EXIT4    ;
         D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
         K I,R1ACADR,R1ACFLG,R1ACFLGZ,R1ACPG,R1ACCNT,R1ACDFN,R1ACINS,R1ACNOW,X,Y
         K %ZIS,%ZIS("B"),DIRUT,ZTDESC,ZTQUEUED,ZTREQ,ZTRTN
         Q
HDR4     S R1ACINS="",R1ACINS=$P(^DIC(4,DUZ(2),0),U)
         W !?5,"*** ",R1ACINS," Bad Address Report #4 ***",!
HDR44    S R1ACNOW="",Y=DT X ^DD("DD") S R1ACNOW=Y
         W:R1ACPG>0 @IOF S R1ACPG=R1ACPG+1
         W !?40,"Run Date:  ",R1ACNOW,?70,"Page:  ",$G(R1ACPG),!
         W "Patients whose TEMPORARY street addr line #3 contains text.",!
         W "Evaluate for moving text so that Pt address contains only Two Lines.",!!
         W "Patient Name",?31,"SSN",?42,"IEN",?50,"TEMP Third Address Line",!
         F I=1:1:80 W "="
         W !
         Q
