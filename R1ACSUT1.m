R1ACSUT1 ;VISN21/vhamachillsg - CrossWalk checker (valid fields)
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
         ; This routine will check the XEROX CROSSWALK file for Clinic Blue boxes that exceed 65 characters
         ; and blue boxes that are empty.  These conditions will prevent a postcard from printing since the
         ; format may misaligned.  If ran in the background, a mail message will be generated to the appropriate
         ; MAIL GROUP specified in the XEROX parameter file.
         ; The (3) conditions that are checked are:
         ;    o   An empty blue boxes (special instructions)
         ;    o   Blue box lines exceeding 65 characters
         ;    o   All blue boxes are empty
         ;
         Q
         ;
XWLKCHK  ; CrossWalk check
         ; check the blue box for proper field lengths, notify if exceeding 65characters
         K ^TMP($J,"R1ACBAD")
         N R1ACMG,R1ACCNT,R1ACCNT2,R1ACLCNT,R1ACRDTE
         N R1ACBB1,R1ACBB2,R1ACBB3,R1ACBB4,R1ACBB5,R1ACBB6,R1ACBB7,R1ACBB8,R1ACBB9
         S (R1ACBB1,R1ACBB2,R1ACBB3,R1ACBB4,R1ACBB5,R1ACBB6,R1ACBB7,R1ACBB8,R1ACBB9)=""
         N R1ACBNOD,R1ACBB,R1ACCNME,R1ACCLN,R1ACBFND
         N R1ACLINE,R1ACCONT,R1ACQUIT,R1ACPCNT
         N X,XMSUB,XMTEXT,XMY,R1ACTST,DIC
         S R1ACRDTE=$$HTE^XLFDT($H,"2M")
         S R1ACMG=$$GET1^DIQ(3.8,+$P($G(^DIZ(612418.5,1,2)),U,6),.01)
         S R1ACMG=$S(R1ACMG'="":"G."_R1ACMG,1:DUZ)
         S X=""
         F  S X=$O(^DIZ(612418,X)) Q:X=""  D:+X  I +X&'$G(R1ACBFND) D ALERT
         .Q:$$ACTIVECL(X)<1
         .S R1ACBB="",R1ACBFND=0
         .S R1ACCNME=$P(^SC(X,0),U),R1ACCLN=X
         .F R1ACBB=1:1:1,3:1:16 I $D(^DIZ(612418,X,R1ACBB,0)) D
         ..S R1ACBFND=1
         ..S R1ACBB1=$G(^DIZ(612418,+X,R1ACBB,1,0))
         ..S R1ACBB2=$G(^DIZ(612418,+X,R1ACBB,2,0))
         ..S R1ACBB3=$G(^DIZ(612418,+X,R1ACBB,3,0))
         ..S R1ACBB4=$G(^DIZ(612418,+X,R1ACBB,4,0))
         ..S R1ACBB5=$G(^DIZ(612418,+X,R1ACBB,5,0))
         ..S R1ACBB6=$G(^DIZ(612418,+X,R1ACBB,6,0))
         ..S R1ACBB7=$G(^DIZ(612418,+X,R1ACBB,7,0))
         ..S R1ACBB8=$G(^DIZ(612418,+X,R1ACBB,8,0))
         ..S R1ACBB9=$G(^DIZ(612418,+X,R1ACBB,9,0))
         ..N BIGSTRG
         ..D
         ...S BIGSTRG=R1ACBB1_R1ACBB2_R1ACBB3_R1ACBB4_R1ACBB5_R1ACBB6_R1ACBB7_R1ACBB8_R1ACBB9
         ...I $TR(BIGSTRG," ","")="" S R1ACERR(0)="" D ALERT Q
         ...D  ;check and strip any control characters
         ....N Y,X,R1ACERR
         ....S X=BIGSTRG
         ....S Y="" F Y("CTRL1")=0:1:32,128:1:255 S Y=Y_$C(Y("CTRL1"))
         ....S X=$TR(X,Y,"") K Y I X="" S R1ACERR(0)=""
         ....I $L(R1ACBB1)>65 S R1ACERR(1)=""
         ....I $L(R1ACBB2)>65 S R1ACERR(2)=""
         ....I $L(R1ACBB3)>65 S R1ACERR(3)=""
         ....I $L(R1ACBB4)>65 S R1ACERR(4)=""
         ....I $L(R1ACBB5)>65 S R1ACERR(5)=""
         ....I $L(R1ACBB6)>65 S R1ACERR(6)=""
         ....I $L(R1ACBB7)>65 S R1ACERR(7)=""
         ....I $L(R1ACBB8)>65 S R1ACERR(8)=""
         ....I $L(R1ACBB9)>65 S R1ACERR(9)=""
         ....I '$D(R1ACERR) Q
         ....D ALERT Q
         ...Q
         ..Q
         .I 'R1ACBFND&$D(R1ACERR(0)) K R1ACERR(0)
         .S R1ACCNT=$G(R1ACCNT)+1
         .Q
         ; produce output if any
         I $D(^TMP($J,"R1ACBAD")) D
         .I +$G(R1ACINT)=0 D
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="Region 1 Xerox CrossWalk Checker @ "_R1ACRDTE
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="Clinic                           Code"
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="-------------------------       -------"
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)=""
         .E  D
         ..W "Region 1 Xerox CrossWalk Checker @ "_R1ACRDTE,?65,"Page: 1",!!
         ..W "Clinic",?33,"Code",!,"-------------------------",?33,"------"
         ..S R1ACPCNT=1
         E  Q
         S X="",(R1ACQUIT,R1ACLINE)=0
         F  S X=$O(^TMP($J,"R1ACBAD",X)) Q:X=""!(R1ACQUIT=1)  D
         .S R1ACCNT2=$G(R1ACCNT2)+1
         .I +$G(R1ACINT)=0 D
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)=$E($P(^SC(X,0),U),0,33)
         ..F  S XMTEXT(R1ACLCNT)=XMTEXT(R1ACLCNT)_" " Q:$L(XMTEXT(R1ACLCNT))>33
         ..S XMTEXT(R1ACLCNT)=XMTEXT(R1ACLCNT)_"("_^TMP($J,"R1ACBAD",X)_")"
         .E  D
         ..W !,$P(^SC(X,0),U),?33,"("_^TMP($J,"R1ACBAD",X)_")"
         ..S R1ACLINE=R1ACLINE+1 I R1ACLINE>(IOSL-3) D
         ...I $E($G(IOST),1,2)="C-" W !,"Press <ENTER> to continue or ""^"" to quit " R R1ACCONT:DTIME I R1ACCONT="^"!($T=0) S R1ACQ
          UIT=1 Q
         ...S R1ACPCNT=R1ACPCNT+1
         ...W @IOF,"Region 1 Xerox CrossWalk Checker @ "_R1ACRDTE,?65,"Page: "_R1ACPCNT,!!
         ...W "Clinic",?33,"Code",!,"-------------------------",?33,"------"
         ...S R1ACLINE=3
         Q:R1ACQUIT=1
         I $D(^TMP($J,"R1ACBAD")) D
         .K ^TMP($J,"R1ACBAD")
         .;  if not interactive send a mail message to postcard mail group
         .I +$G(R1ACINT)=0 D
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)=""
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)=""
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="Codes:"
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="  (1)...All postcard blue boxes are empty."
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="        Postcards for this clinic will not be printed"
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="        until at least one of the blue boxes information is filled in."
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="  (2)...A postcard blue box [n] is empty."
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="        Postcard #n for the clinic will not be printed"
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="        until the blue box information is filled in [blue box]."
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="  (3)...A postcard blue box line exceeds 65 characters."
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="        Line 'x' on postcard #n, postcard for the clinic will not print until
          "
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)="        blue box line is adjusted to fit within 65 characters [blue box,line]
          ."
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)=""
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)=+$G(R1ACCNT)_" clinics read the Xerox CrossWalk file"
         ..S R1ACLCNT=$G(R1ACLCNT)+1,XMTEXT(R1ACLCNT)=$G(R1ACCNT2)_" clinics found with errors"
         ..S XMSUB="XEROX Postcard CrossWalk Checker",XMTEXT="XMTEXT(",XMY(DUZ)="",XMY(R1ACMG)=""
         ..D ^XMD
         .E  D
         ..W !!,"Codes:"
         ..W !?3,"(1)...All postcard blue boxes are empty"
         ..W !?9,"Postcards for this clinic will not be printed"
         ..W !?9,"until at least one of the blue boxes information is filled in."
         ..W !?3,"(2)...A postcard blue box [n] is empty"
         ..W !?9,"Postcard #n for the clinic will not be printed"
         ..W !?9,"until the blue box information is filled in [blue box]."
         ..W !?3,"(3)...A postcard blue box line exceeds 65 characters"
         ..W !?9,"Line 'x' on postcard #n, postcard for the clinic will not print until"
         ..W !?9,"blue box line is adjusted to fit within 65 characters [blue box,line]."
         ..W !!,+$G(R1ACCNT)_" clinics read the Xerox CrossWalk file"
         ..W !,$G(R1ACCNT2)_" clinics found with errors"
         E  W:+$G(R1ACINT)=0 !,"No problems found in CrossWalk file",!
         Q
         ;
ACTIVECL(CLINIC) --
          ;
         I CLINIC<1!('$D(^SC(+CLINIC,0))) Q 0
         N REACT,INACT,RESULT,ZZ
         S RESULT=1 ;Active Clinic with no entry in X-Walk File
         I $P(^SC(+CLINIC,0),"^",3)'="C" Q 0
         S INACT="" I $D(^SC(+CLINIC,"I")) S INACT=$P($G(^SC(+CLINIC,"I")),U)
         S REACT="" I $D(^SC(+CLINIC,"I")) S REACT=$P($G(^SC(+CLINIC,"I")),U,2)
         I INACT]""&(((INACT<DT)&(REACT=""))) S RESULT=0
         I (INACT]""&(REACT]""))&((INACT<DT)&(REACT>DT)) S RESULT=0
         S ZZ=$TR($E($P(^SC(+CLINIC,0),"^"),1,2),"z","Z")
         I ZZ="ZZ" S RESULT=0
         Q RESULT
         ;
ALERT    ;ALERT CROSSWALK COORDINATORS
         ;
         N BLUEBOX,X,R1ACCODE
         S R1ACCODE=0
         S BLUEBOX=$S(R1ACBB=1:1,1:R1ACBB-1)
         K XMTEXT
         S (X,Y)="" F  S X=$O(R1ACERR(X)) Q:X=""  S Y=$G(Y)_X_","
         S Y=$E(Y,1,$L(Y)-1)
         I '$G(R1ACBFND)&'$D(R1ACERR(0)) D
         .S R1ACCODE=1
         .Q
         I $D(R1ACERR(0))&$G(R1ACBFND)&(R1ACBB'=16) D
         .S R1ACCODE=2_", ["_$S(R1ACBB>1:R1ACBB-1,1:R1ACBB)_"]"
         .Q
         I $D(R1ACERR)&'$D(R1ACERR(0)) D
         .S R1ACCODE=3_", ["_$S(R1ACBB>1:R1ACBB-1,1:R1ACBB)_","_Y_"]"
         .Q
         S ^TMP($J,"R1ACBAD",R1ACCLN)=$G(R1ACCODE)
         Q
         ;
INTACT   ; interactive user call
         N R1ACINT,ZTSAVE
         S R1ACINT=1
         W !!,"This procedure will check the Xerox CrossWalk file"
         W !,"(#612418) 'Blue Box/Special instructions' to ensure"
         W !,"the data does not exceed the printable area dimensions."
         W !!,"Select device for the report:"
         S ZTSAVE("R1ACINT")=""
         D EN^XUTMDEVQ("XWLKCHK^R1ACSUT1","Print Xerox CrossWalk Blue Box exceptions",.ZTSAVE)
         Q
*****   ERRORS & WARNINGS IN R1ACSUT1   *****
