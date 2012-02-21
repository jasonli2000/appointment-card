R1ACNWKY ;VISN21/NLS/-Display for Print Post Card Setup Templates
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         N ARHDEXIT,ARHDFDA,ARHDIENS,ARHDIENZ,BPDA,CBXC1,CBXC2,CBXT,CNT,DA,DAZ,DIWP,NODE,NTYPE,R1ACFLDZ,R1ACFLG,R1ACIEN,R1ACIENS,REF
         ;W # ;SFVAMC/DAD/3-31-2011/Add form feed (W #) to reset $X and $Y
         S (ARHDEXIT,ARHDFDA,ARHDIENS,ARHDIENZ,BPDA,CBXC1,CBXC2,CBXT,CNT,DA,DAZ,DIWP,NODE,NTYPE,R1ACFLDZ,R1ACFLG,R1ACIEN,R1ACIENS,RE
          F)=""
         S CBXT=$$GETREQ^R1UTCSPZ("cbxT") Q:'CBXT  ;Select Post Card Template Number
         S CBXC1="",CBXC1=$$GETREQ^R1UTCSPZ("cbxC1",1) I $G(CBXC1)>0 I $G(DA)'="@" S DA=CBXC1  ;Setup New Clinic
         S CBXC2="",CBXC2=$$GETREQ^R1UTCSPZ("cbxC2",1) I $G(CBXC2)>0 I $G(DA)'="@" S DA=CBXC2 ;Existing Clinic
         I $G(DA)'="@" S (R1ACIEN,DAZ)=$G(DA)
         I $$GETREQ^R1UTCSPZ("edtType",1)'="@" S BPDA=$$GETREQ^R1UTCSPZ("edtType",1) D  ;New BP
         .S DA="",DA=$P($G(^TMP("SSSXXX",$J)),U) I $G(DA)]"" D
         ..S REF=$NA(^DIZ(612418.1,DA,0)) K ^TMP("SSSXXX",$J)
         ..D LOCK^DILF(REF) I $T D
         ...K ARHDFDA S ARHDFDA(612418.1,DA_",",.02)=CBXT D FILE^DIE("","ARHDFDA") K ^TMP("SSSXXX") ;Set primary field in new boiler
           plate entries
         ...L -^DIZ(612418.1,DA,0)
         I $$GETREQ^R1UTCSPZ("cbxEType",1)'="@" S BPDA=$$GETREQ^R1UTCSPZ("cbxEType",1) ;Existing BP
         I $G(BPDA)]"" S NTYPE="",NTYPE=$O(^DIZ(612418.1,"B",BPDA,NTYPE)) ;IEN
         I $G(BPDA)']""&($G(DA)']"") Q
         I R1ACIEN="" Q
         W "<TEXTAREA align=""center"" name=""MEMOBBX"" rows=""9"" cols=""65"" style=""color: #000000>"
         W "<background-color:#FFFFFF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""8"">"
         I R1ACIEN>0 D
         .N ARHDFDA,ARHDFLD,ARHDERR,ARHDATTR,CBXT
         .S (ARHDFDA,ARHDFLD,ARHDERR,ARHDATTR,CBXT)=""
         .S CBXT=$$GETREQ^R1UTCSPZ("cbxT",1)
         .S R1ACFLD="",ARHDERR=0
         .S R1ACFLD=$S(CBXT=1:"4",CBXT=2:"9",CBXT=3:"10",CBXT=4:"11",CBXT=5:"12",CBXT=6:"13",CBXT=7:"14",CBXT=8:"15",CBXT=9:"16",CBX
          T=10:"17",CBXT=11:"18",CBXT=12:"19",CBXT=13:"20",CBXT=14:"21",CBXT=15:"22",1:"")
         .I $G(R1ACFLDZ)]"" S R1ACFLD=R1ACFLDZ
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSG,ARHDMSGS,ARHDWP,X
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSG,ARHDMSGS,ARHDWP,X)=""
         .S CNT=0,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,1,.CNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S (ARHD1,ARHDEXIT)=0
         .;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
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
         .W "<input type=""submit"" name=""btn2Save"" value=""6) Save Boiler Plate"" tabindex=""23"" onclick=""document.body.style.c
          ursor='wait';"" />"
         .I $G(BPDA)]""&($G(DAZ)]"") D ARCHV2^R1ACNWKV(BPDA,DAZ) S R1ACFLG=1 ;BP, CLIN1 - transfers wp lines from #612418 ==> #61241
          8.1
         .W "</br><input type=""button"" value=""7) Refresh Page before Next Clinic Selection"" tabindex=""24"" title=""clear drop d
          own box & all memo boxes"" onClick=""window.location.href=window.location.href"">"
         .Q
         I $G(R1ACFLG)]"" Q
         I $G(NTYPE)>0&(R1ACIEN="") S ARHDIENS=NTYPE D
         . S ARHDERR=0,ARHDIENZ=ARHDIENS
         . D FIND^DIC(612418.1,"",.01,"",ARHDIENS,"","","","","","")
         . S ARHDIENS="",ARHDIENS=$P($G(^TMP("DILIST",$J,2,1)),U)
         . S R1ACFLD=$S(CBXT=1:"4",CBXT=2:"9",CBXT=3:"10",CBXT=4:"11",CBXT=5:"12",CBXT=6:"13",CBXT=7:"14",CBXT=8:"15",CBXT=9:"16",CB
          XT=10:"17",CBXT=11:"18",CBXT=12:"19",CBXT=13:"20",CBXT=14:"21",CBXT=15:"22",1:"")
         . N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X
         . S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X)=""
         . S CNT=0,ARHDIENZ=ARHDIENZ_","
         . D WPOUTPUT^R1ACSUT2(612418.1,ARHDIENZ,R1ACFLD,0,.CNT)
         .; K ^UTILITY($J,"W")
         .; D GETS^DIQ(612418.1,""_ARHDIENZ_"",R1ACFLD,"","WP","")
         .; S (ARHD1,ARHDEXIT)=0
         .; F  S ARHD1=$O(WP(612418.1,""_ARHDIENZ_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;. S NODE="",NODE=WP(612418.1,""_ARHDIENZ_"",R1ACFLD,ARHD1)
         .;.D
         .;.. S X=NODE,DIWL=1,DIWR=65,DIWP="",CNT=CNT+1
         .;.. D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;.. Q
         .;. Q
         .I $G(R1ACIEN)]"" M ^DIZ(612418,R1ACIENS,CBXT)=^DIZ(612418.1,NTYPE,CBXT) ;Merge data
         .;K ^UTILITY($J,"W")
         .;K WP
         .W "</TEXTAREA>"
         .W "</br>"
         .W "<input type=""submit"" name=""btn2Save"" value=""Save Template"" tabindex=""23"" onclick=""document.body.style.cursor='
          wait';"" />"
         .Q:($G(BPDA)']"")
         Q
EDIT     ;
         N ARHDFDA,ARHDFLD,ARHDIENS,ARHDERR,ARHDATTR,R1ACLCK,R1ACDA,CNT,DIWP,NODE,R1ACQ,R1ACIEN
         ;W # ;SFVAMC/DAD/3-31-2011/Add form feed (W #) to reset $X and $Y
         S (ARHDFDA,ARHDFLD,ARHDIENS,ARHDERR,ARHDATTR,R1ACLCK,R1ACDA,CNT,DIWP,NODE,R1ACQ,R1ACIEN)=""
         W "<TEXTAREA align=""center"" name=""MEMOBBX"" rows=""9"" cols=""65"" style=""color: #000000; background-color:#00FFFF"">"
         W "<onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""8"">"
         D
         .S DA=CBXC1,ARHDERR=0
         .S CBXT=$$GETREQ^R1UTCSPZ("cbxT",1)
         .S R1ACFLD=""
         .S R1ACFLD=$S(CBXT=1:"4",CBXT=2:"9",CBXT=3:"10",CBXT=4:"11",CBXT=5:"12",CBXT=6:"13",CBXT=7:"14",CBXT=8:"15",CBXT=9:"16",CBX
          T=10:"17",CBXT=11:"18",CBXT=12:"19",CBXT=13:"20",CBXT=14:"21",CBXT=15:"22",1:"")
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X)=""
         .S CNT=0,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.CNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S (ARHD1,ARHDEXIT)=0
         .;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",CNT=CNT+1
         .;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
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
         W "<input type=""submit"" name=""btn2Save"" value=""Save Template"" tabindex=""23"" onclick=""document.body.style.cursor='w
          ait';"" />"
         W "&nbsp;"
         W "<input type=""submit"" name=""btnLogout"" value=""Logout"" tabindex=""24"" />"
         Q
SAVEDATA(DA,R1ACFLD) --
          ;
         ;Save the user's new templated data for each type
         K ARHDMSG
         K ARHDMSGS("*")
         N ARHDFDA,ARHDFILD,ARHDFNUM,ARHDFTYP,ARHDIEN,ARHDIENS,ARHDMSG,ARHDMSGS,R1ACDA,DAZ,R1ACFLDZ,TEXT
         S (ARHDFDA,ARHDFILD,ARHDFNUM,ARHDFTYP,ARHDIEN,ARHDIENS,ARHDMSG,ARHDMSGS,R1ACDA,DAZ,R1ACFLDZ,TEXT)=""
         N ARHDLIST,ARHDPIEC,ARHDSIGN,ARHDVALU,ARHDWP,PIECE,TXT,R1ACLCK,ARHDINDX,ARHDERR,ARHDROOT
         S (ARHDLIST,ARHDPIEC,ARHDSIGN,ARHDVALU,ARHDWP,PIECE,TXT,R1ACLCK,ARHDINDX,ARHDERR,ARHDROOT)=""
         S R1ACDA=DA
         D:R1ACDA'="@"
         .S ARHDROOT=$$GETROOT^R1UTCSPX("",1)
         .S (ARHDMSG,ARHDMSGS)=""
         .S ARHDMSGS="Post Card Text Saved to Boiler Plate."
         . D SET^R1UTCSPX(ARHDROOT,"<script type=""text/javascript"">")
         . D SET^R1UTCSPX(ARHDROOT,"alert("_$$QUOTEJS^R1UTCSPZ(ARHDMSGS)_");")
         . D SET^R1UTCSPX(ARHDROOT,"</script>")
         . D DISPLAY^R1UTCSPX(ARHDROOT)
         . K @ARHDROOT
         . Q
         I DA>0 D
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
         . S DAZ="",DAZ=+DA,R1ACFLDZ="" S R1ACFLDZ=R1ACFLD
         K ARHDFDA
         Q
SAVE2(ARHDIENS,R1ACFLD) --
          ;Save New Boiler Plate w/o attaching to a clinic
         K ARHDMSG
         K ARHDMSGS("*")
         N ARHDFDA,ARHDFILD,ARHDFNUM,ARHDFTYP,ARHDIEN,ARHZIEN,ARHZIENS,R1ACFLDZ,TEXT
         S (ARHDFDA,ARHDFILD,ARHDFNUM,ARHDFTYP,ARHDIEN,ARHZIEN,ARHZIENS,R1ACFLDZ,TEXT)=""
         N ARHDLIST,ARHDPIEC,ARHDSIGN,ARHDVALU,ARHDWP,PIECE,TXT,R1ACLCK,DAZ,ARHDROOT
         S (ARHDLIST,ARHDPIEC,ARHDSIGN,ARHDVALU,ARHDWP,PIECE,TXT,R1ACLCK,DAZ,ARHDROOT)=""
         I ARHDIENS]"" D
         .D FIND^DIC(612418.1,"",.01,"",ARHDIENS,"","","","","","")
         .S ARHDIENS="",ARHDIENS=$P($G(^TMP("DILIST",$J,2,1)),U)
         .S ARHZIENS=ARHDIENS
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
         .. D:ARHZIENS'="@"
         ...S ARHDROOT=$$GETROOT^R1UTCSPX("",1)
         ...S ARHDINDX=0
         ... S ARHDMSGS="",ARHDMSGS="Post Card Text Saved."
         ... D SET^R1UTCSPX(ARHDROOT,"<script type=""text/javascript"">")
         ... D SET^R1UTCSPX(ARHDROOT,"alert("_$$QUOTEJS^R1UTCSPZ(ARHDMSGS)_");")
         ... D SET^R1UTCSPX(ARHDROOT,"</script>")
         ... D DISPLAY^R1UTCSPX(ARHDROOT)
         ... K @ARHDROOT
         ... Q
         ..D CLEAN^DILF
         ..K ARHDMSGS
         ..K @ARHDWP
         .S DAZ="",DAZ=+DA,R1ACFLDZ="" S R1ACFLDZ=R1ACFLD
         K ARHDFDA
         Q
CLIN1(Y) ;X-Walk Clinic w/o attached Boiler Plate
         N RESULT
         S RESULT=1
         I $P($G(^DIZ(612418,+Y,17)),U)]"" S RESULT=0
         Q RESULT
CLIN2(Y) ;X-Walk Clinic with attached Boiler Plate
         N RESULT
         S RESULT=1
         I $P($G(^DIZ(612418,+Y,17)),U)']"" S RESULT=0
         Q RESULT
BP(Y)    ;Active Boiler Plate
         N RESULT
         S RESULT=1
         I $P($G(^DIZ(612418.1,+Y,0)),U,3)]""&($P($G(^DIZ(612418.1,+Y,0)),U,3)<DT) S RESULT=0
         Q RESULT
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
