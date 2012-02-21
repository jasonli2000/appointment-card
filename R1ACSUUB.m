R1ACSUUB ;VISN21/vhamachillsg - Update Universal Box
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
         ;  This routine used to create a file that will generate code for VIPP pertaining
         ;  to the Facility Information Area (universal box) on the postcard and transfer it
         ;  to VIPP.
         ;
         Q
UVB      ; Universal Box for postcards
         ; Max string for text is 253 characters
         ; get input from user, verify, ftp data to VIPP system
         D HOME^%ZIS
         N X,TEXT,YN
         W @IOF,!,"Please enter the text that the facility wishes to print."
         W !,"When you are done press the ENTER key and the information will be"
         W !,"redisplayed for verification.",!
         W !,"The facility UNIVERSAL BOX for scheduling postcards cannot"
         W !,"exceed 253 characters.  Double quotes ("") will be removed if entered.",!
         ;S DIR(0)="FOA^1:253",DIR("A")="Text: " D ^DIR Q:$D(DIRUT)
         W !,"     vvvv  Begin entering text  vvvv",!
         F  R X:+$G(DTIME) Q:X=""  D  Q:($G(YN)="N")
         .I $L(X)>253 W !!,"Text string longer than 253 characters, re-enter",!!,"     vvvv  Begin entering text  vvvv",! Q
         .S TEXT=$TR(X,"""","")
         .W @IOF,!,"     vvvvv   Text you entered   vvvvv",!!
         .N DIC,DILW,DIWESUB
         .K ^UTILITY($J,"W",1) S X=TEXT,DIWL=1,DIWR=40,DIWF="C65" D ^DIWP
         .S IOP=0 D ^DIWW
         .W !!,"     ^^^^^   Text you entered   ^^^^^",!!
         .W "Transmit text to VIPP printing system " R "(Yes/No)? No // ",YN:+$G(DTIME)
         .I (YN="")!("nN"[$E(YN)) S YN="N" Q
         .I YN'="","yY"[$E(YN) D
         ..N STATION,FILE,PATH
         ..S STATION=$P(^DIC(4.2,+$G(^XMB("NUM")),0),U,13),PATH=$$DEFDIR^%ZISH(),FILE="R1AC_"_STATION_"UVB.TXT"
         ..;
         ..; build text file
         ..D OPEN^%ZISH("UVB",PATH,FILE,"W",512) I POP W !,"Error opening TEXT file...",! Q
         ..U IO
         ..W "{",!
         ..W "ORITL",!
         ..W "/NHE 10 SETFONT",!
         ..W "50 SETLSP",!
         ..W "600 SETCOLWIDTH",!
         ..W "("_TEXT_") 3 SHP",!
         ..W "} FSHOW",!
         ..D CLOSE^%ZISH("UVB")
         ..;
         ..; build transmission file (FTP command procedure)
         ..D OPEN^%ZISH("UVBFTP",PATH,$P(FILE,".")_".COM","W",512) I POP W !,"Error creating transmission command procedure...",! Q
         ..U IO
         ..;SFVAMC/DAD/4-21-2011/Get FTP info from parameters file
         ..;SFVAMC/DAD/4-21-2011/Username & password deleted below
         ..;W "$FTP 10.173.116.33",!
         ..;W "",!
         ..;W "",!
         ..W "$FTP "_$$GET1^DIQ(612418.5,1,12.1),!
         ..W $$GET1^DIQ(612418.5,1,12.2),!
         ..W $$DECRYP^XUSRB1($$GET1^DIQ(612418.5,1,12.3)),!
         ..W "put "_PATH_FILE,!
         ..W "rename "_$$LOW^XLFSTR(FILE)_" "_$$LOW^XLFSTR($P(FILE,"R1AC_",2)),!
         ..W "bye",!
         ..W "$EXIT",!
         ..D CLOSE^%ZISH("UVB")
         ..N X
         ..D ZFEXEC^R1ACSUTL("@"_PATH_$P(FILE,".")_".COM") ; execute the command procedure
         ..;
         ..; clean up temporary command procedure & temporary text file
         ..N R1ACARY
         ..S R1ACARY(FILE)="",R1ACARY($P(FILE,".")_".COM")=""
         ..S X=$$DEL^%ZISH(PATH,$NA(R1ACARY))
         ..;
         ..D HOME^%ZIS U IO
         ..W !!,"Text transmitted to VIPP system",! S YN="N"
         ..Q
         .Q
         Q
