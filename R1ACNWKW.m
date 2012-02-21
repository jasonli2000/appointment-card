R1ACNWKW ;VISN21/NLS/- Display for Print Appt Post Card Setup Templates
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         N CBXT,CNT,R1ACIEN
         ;W # ;SFVAMC/DAD/3-31-2011/Add form feed (W #) to reset $X and $Y
         S (CBXT,CNT,R1ACIEN)=""
         I $$GETREQ^R1UTCSPZ("cbxBP",1)="@"&($$GETREQ^R1UTCSPZ("edtType",1)']"") Q
         D SET^R1UTCSPX("TTT",$$INPUTTAG^R1UTCSPY("hidden",.ARHDATTR))
         S R1ACIEN="",R1ACIEN=$P(TTT(1),"value=",2) K TTT
         S R1ACIEN=$P(R1ACIEN," />") S R1ACIEN=$P(R1ACIEN,"""",2),R1ACIEN=$P(R1ACIEN,"""") ;.01 in #612418.1
         ;S REF=^DIZ(612418.1,R1ACIEN)
         S CBXT="",CBXT=$$GETREQ^R1UTCSPZ("cbxT",1) Q:'CBXT  ;Select Post Card
         W "<TEXTAREA align=""center"" name=""MEMOBBX"" rows=""9"" cols=""65"" style=""color: #000000>"
         W "<background-color:#FFFFFF"" onMouseover=""('Deminsion is 65 characters by 9 lines')"" tabindex=""8"">"
         I $G(R1ACIEN)]"" D
         .N ARHDFDA,ARHDFLD,ARHDMSGS,ARHDERR,ARHDATTR,ARHDEXIT,ARHDIENZ,NODE,DIWP,R1ACFLDZ,R1ACIEN,R1ACFLD
         .S (ARHDFDA,ARHDFLD,ARHDMSGS,ARHDATTR,ARHDEXIT,ARHDIENZ,NODE,DIWP,R1ACFLDZ,R1ACIEN)=""
         .S R1ACFLD="",ARHDERR=0
         .S R1ACFLD=$S(CBXT=1:"4",CBXT=2:"9",CBXT=3:"10",CBXT=4:"11",CBXT=5:"12",CBXT=6:"13",CBXT=7:"14",CBXT=8:"15",CBXT=9:"16",CBX
          T=10:"17",CBXT=11:"18",CBXT=12:"19",CBXT=13:"20",CBXT=14:"21",CBXT=15:"22",1:"")
         .I $G(R1ACFLDZ)]"" S R1ACFLD=R1ACFLDZ
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X)=""
         .S CNT=0,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,1,.CNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S (ARHD1,ARHDEXIT)=0
         .;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",CNT=CNT+1 I $L(NODE)>65 S ^XTMP("NODE")=CNT
         .;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .;K WP
         .W "</TEXTAREA>"
         .I $G(^XTMP("NODE"))>0 D ALERT1
         .I CNT>9 D ALERT2
         .W "</br>"
         .;W "</script>"
         .Q
         I $G(ARHDIENS)]"" D
         .N ARHDERR,ARHDIENZ
         .S ARHDERR=0,ARHDIENZ=ARHDIENS
         .D FIND^DIC(612418.1,"",.01,"",ARHDIENS,"","","","","","")
         .S ARHDIENS="",ARHDIENS=$P($G(^TMP("DILIST",$J,2,1)),U)
         .S ARHDIENS=ARHDIENS_","
         . N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,CNT,R1ACFLD,NODE,DIWP
         . S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,NODE,DIWP)=""
         . S CNT=0,R1ACFLD=""
         . S R1ACFLD=$S(CBXT=1:"4",CBXT=2:"9",CBXT=3:"10",CBXT=4:"11",CBXT=5:"12",CBXT=6:"13",CBXT=7:"14",CBXT=8:"15",CBXT=9:"16",CB
          XT=10:"17",CBXT=11:"18",CBXT=12:"19",CBXT=13:"20",CBXT=14:"21",CBXT=15:"22",1:"")
         . D WPOUTPUT^R1ACSUT2(612418.1,ARHDIENS,R1ACFLD,1,.CNT)
         . ;K ^UTILITY($J,"W")
         . ;D GETS^DIQ(612418.1,""_ARHDIENS_"",R1ACFLD,"","WP","")
         . ;S (ARHD1,ARHDEXIT)=0
         . ;F  S ARHD1=$O(WP(612418.1,""_ARHDIENS_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;. S NODE="",NODE=WP(612418.1,""_ARHDIENS_"",R1ACFLD,ARHD1)
         .;.D
         .;.. S X=NODE,DIWL=1,DIWR=65,DIWP="",CNT=CNT+1 I $L(NODE)>65 S ^XTMP("NODE")=CNT
         .;.. D ^DIWP S X=X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;.. Q
         .;K ^UTILITY($J,"W")
         .;K WP
         .W "</TEXTAREA>"
         .I $G(^XTMP("NODE"))>0 D ALERT1
         .I CNT>9 D ALERT2
         .;W "</br>"
          Q
EDIT     ;
         N ARHDFDA,ARHDFLD,ARHDIENS,ARHDMSGS,ARHDERR,ARHDATTR,R1ACLCK,R1ACDA,CBXC1,CBXT,CNT,R1ACQ,NODE,DIWP,R1ACIEN,R1ACFLD
         ;W # ;SFVAMC/DAD/3-31-2011/Add form feed (W #) to reset $X and $Y
         S (ARHDFDA,ARHDFLD,ARHDIENS,ARHDMSGS,ARHDERR,ARHDATTR,R1ACLCK,R1ACDA,CBXC1,CBXT,CNT,R1ACQ,NODE,DIWP,R1ACIEN,R1ACFLD)=""
         W "<TEXTAREA align=""center"" name=""MEMOBBX"" rows=""9"" cols=""65"" style=""color: #000000; background-color:#FFFFFF"">"
         W "<onMouseover=""('Deminsion is 65 characters by 9 lines')"" tabindex=""8"">"
         D
         .S DA=CBXC1,ARHDERR=0
         .S CBXT=$$GETREQ^R1UTCSPZ("cbxT",1)
         .S R1ACFLD=""
         .S R1ACFLD=$S(CBXT=1:"4",CBXT=2:"9",CBXT=3:"10",CBXT=4:"11",CBXT=5:"12",CBXT=6:"13",CBXT=7:"14",CBXT=8:"15",CBXT=9:"16",CBX
          T=10:"17",CBXT=11:"18",CBXT=12:"19",CBXT=13:"20",CBXT=14:"21",CBXT=15:"22",1:"")
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,DIWP
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,DIWP)=""
         .S CNT=0,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.CNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S (ARHD1,ARHDEXIT)=0
         .;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",CNT=CNT+1
         .;..D ^DIWP S X=X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=X=$$XYENABLE^R1UTCSPZ(1)
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;MERGE TO GO HERE<<<===
         .;K ^UTILITY($J,"W")
         .;K WP
         .W "</TEXTAREA>"
         W "</br>"
         ;W "<input type=""submit"" name=""btn2Save"" value=""6) Save Template"" tabindex=""23"" onclick=""document.body.style.curso
          r='wait';"" />"
         W "&nbsp;"
         W "<input type=""submit"" name=""btnLogout"" value=""Logout"" tabindex=""24"" />"
         Q
SAVEDATA(DA,R1ACFLD) --
          ;Save the user's new templated data for each type
         N ARHDFDA,ARHDFILD,ARHDFNUM,ARHDFTYP,ARHDIEN,ARHDIENS,ARHDMSG,ARHDMSGS,R1ACDA,DAZ,TEXT
         S (ARHDFDA,ARHDFILD,ARHDFNUM,ARHDFTYP,ARHDIEN,ARHDIENS,ARHDMSG,ARHDMSGS,R1ACDA,DAZ,TEXT)=""
         N ARHDLIST,ARHDPIEC,ARHDSIGN,ARHDVALU,ARHDWP,PIECE,TXT,R1ACLCK,ARHDINDX,ARHDERR,R1ACFLDZ
         S (ARHDLIST,ARHDPIEC,ARHDSIGN,ARHDVALU,ARHDWP,PIECE,TXT,R1ACLCK,ARHDINDX,ARHDERR,R1ACFLDZ)=""
         S R1ACDA=DA
         D:DA'="@"
         .S ARHDMSG="",ARHDMSG="Filing Data in VistA now" D
         ..D MSG^DIALOG("AE",.ARHDMSGS,70,0) ; Get FileMan error messages
         ..S ARHDMSGS(.1)=ARHDMSG,ARHDMSGS(.2)="" ;Add my msg to FM msg array
         ..W !,"<script type=""text/javascript"">" ; JavaScript to display popup
         ..W !,"alert("
         ..S ARHDINDX=0 ; Build and format popup text
         ..F  S ARHDINDX=$O(ARHDMSGS(ARHDINDX)) Q:ARHDINDX'>0  D
         ...W !,$$QUOTEJS^R1UTCSPZ(ARHDMSGS(ARHDINDX)) ; Quote/escape text
         ... W $S($O(ARHDMSGS(ARHDINDX))>0:" + '\n' + ",1:");")
         ... Q
         .. W !,"</","script>" ; Cannot have a closing script tag in a script
         .Q
         S ARHDERR=0
         I DA>0 D
         .D SETDUZ^R1UTCSPZ
         .S DA=DA_","
         .S ARHDWP=$NA(^TMP($J,"WP"))
         .K @ARHDWP
         .S TEXT="",TEXT=$$GETREQ^R1UTCSPZ("MEMOBBX",1)
         .F PIECE=1:1:$L(TEXT,$C(13,10)) D
         ..S TXT=$P(TEXT,$C(13,10),PIECE)
         ..S @ARHDWP@(PIECE)=TXT
         . S ARHDFDA(612418,DA,R1ACFLD)=ARHDWP
         . D UPDATE^DIE("","ARHDFDA","DA")
         . D CLEAN^DILF
         . K @ARHDWP
         .S DAZ="",DAZ=+DA,R1ACFLDZ="" S R1ACFLDZ=R1ACFLD
         .L -^DIZ(612418,DA)
         Q
SAVE2(ARHDIENS,R1ACFLD) --
          ;
         ;Save New Boiler Plate w/o attaching to a clinic
         N ARHDFDA,ARHDFILD,ARHDFNUM,ARHDFTYP,ARHDIEN,ARHZIEN,ARHZIENS,R1ACFLDZ
         S (ARHDFDA,ARHDFILD,ARHDFNUM,ARHDFTYP,ARHDIEN,ARHZIEN,ARHZIENS,R1ACFLDZ)=""
         N ARHDLIST,ARHDPIEC,ARHDSIGN,ARHDVALU,ARHDWP,PIECE,TXT,R1ACLCK,TEXT,ARHDMSG
         S (ARHDLIST,ARHDPIEC,ARHDSIGN,ARHDVALU,ARHDWP,PIECE,TXT,R1ACLCK,TEXT,ARHDMSG)=""
         I ARHDIENS]"" D
         .D FIND^DIC(612418.1,"",.01,"",ARHDIENS,"","","","","","")
         .S ARHDIENS=$P($G(^TMP("DILIST",$J,2,1)),U)
         .S ARHZIENS="",ARHZIENS=ARHDIENS
         .S ARHDIENS=ARHDIENS_","
         .S ARHDWP=$NA(^TMP($J,"WP"))
         .K @ARHDWP
         .S TEXT="",TEXT=$$GETREQ^R1UTCSPZ("MEMOBBX",1)
         .F PIECE=1:1:$L(TEXT,$C(13,10)) D
         ..S TXT=$P(TEXT,$C(13,10),PIECE)
         ..S @ARHDWP@(PIECE)=TXT
         . S ARHDFDA(612418.1,ARHDIENS,R1ACFLD)=ARHDWP
         . I $D(ARHDFDA) D
         .. D UPDATE^DIE("","ARHDFDA","ARHDIENS")
         .. S:ARHDMSG="" ARHDMSG="Filing Data in VistA now"
         .. I $G(ARHDMSG)]"" D
         ...D MSG^DIALOG("AE",.ARHDMSGS,70,0) ; Get FileMan error messages
         ...S ARHDMSGS(.1)=ARHDMSG,ARHDMSGS(.2)="" ;Add my msg to FM msg array
         ...W !,"<script type=""text/javascript"">" ; JavaScript to display popup
         ...W !,"alert("
         ...S ARHDINDX=0 ; Build and format popup text
         ... F  S ARHDINDX=$O(ARHDMSGS(ARHDINDX)) Q:ARHDINDX'>0  D
         .... W !,$$QUOTEJS^R1UTCSPZ(ARHDMSGS(ARHDINDX)) ; Quote/escape text
         .... W $S($O(ARHDMSGS(ARHDINDX))>0:" + '\n' + ",1:");")
         .... Q
         ... W !,"</","script>" ; Cannot have a closing script tag in a script
         ..D CLEAN^DILF
         ..K @ARHDWP
         . S DAZ="",DAZ=+DA,R1ACFLDZ="" S R1ACFLDZ=R1ACFLD
         Q
ALERT1   ;Line Length > 65 characters
         S (ARHDMSG,ARHDMSGS)=""
         S CNTZ="",CNTZ=$P($G(^XTMP("NODE")),U)
         S ARHDMSG="Only 63 keystrokes per line are permitted! Please re-adjust. At least this line # exceeds 63 characters:  #"_$G(
          CNTZ)
         D MSG^DIALOG("AE",.ARHDMSGS,70,0)
         S ARHDMSGS(.1)=ARHDMSG,ARHDMSGS(.2)=""
         W !,"<script type=""text/javascript"">"
         W !,"alert("
         S ARHDINDX=0
         F  S ARHDINDX=$O(ARHDMSGS(ARHDINDX)) Q:ARHDINDX'>0  D
         . W !,$$QUOTEJS^R1UTCSPZ(ARHDMSGS(ARHDINDX))
         . W $S($O(ARHDMSGS(ARHDINDX))>0:" + '\n' + ",1:");")
         . Q
         K ^XTMP("NODE"),CNTZ
         W !,"</","script>"
         Q
ALERT2   ;More than 9 lines
         S (ARHDMSG,ARHDMSGS)=""
         S ARHDMSG="Only 9 lines permitted!  Please re-adjust. The current number of lines in this Blue Box is:  "_CNT
         D MSG^DIALOG("AE",.ARHDMSGS,70,0)
         S ARHDMSGS(.1)=ARHDMSG,ARHDMSGS(.2)=""
         W !,"<script type=""text/javascript"">"
         W !,"alert("
         S ARHDINDX=0
         F  S ARHDINDX=$O(ARHDMSGS(ARHDINDX)) Q:ARHDINDX'>0  D
         . W !,$$QUOTEJS^R1UTCSPZ(ARHDMSGS(ARHDINDX))
         . W $S($O(ARHDMSGS(ARHDINDX))>0:" + '\n' + ",1:");")
         . Q
         S CNT=0
         W !,"</","script>"
         Q
