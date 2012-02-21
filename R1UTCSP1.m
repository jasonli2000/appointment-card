R1UTCSP1 ;SFVAMC/DAD-Cache Server Pages (Division)
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
DIVISION(ARHD0DIV,ARHDFRM,ARHDROOT) --
          ;
         ; *** Setup a user's division
         ; Input
         ;  ARHD0DIV = Pointer to the institution file (Req)
         ;  ARHDROOT = Closed array reference for messages (Req)
         ;  ARHDFRM = Form attributes (Opt, Pass by ref)
         ; Output
         ;  %session.Data("DUZ*") = The user's DUZ array
         ;  $$DIVISION() = -1 : Display division form
         ;                  0 : User has no divisions
         ;                  1 : User's division has been set
         ;                 "" : User logged out or has invalid division
         N ARHDCNT,ARHDLIST,ARHDMSG,ARHDOKAY
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),1)
         I $$GETREQ^R1UTCSPZ("btnLogout")]"" D
         . K @ARHDROOT
         . S ARHDOKAY=""
         . Q
         I $$GETREQ^R1UTCSPZ("btnDivision")]"" D
         . I $G(ARHD0DIV)'>0 D GETDIV(.ARHD0DIV)
         . D SETDIV(ARHDROOT,ARHD0DIV,.ARHDOKAY)
         . Q
         I $D(ARHDOKAY)#2'>0 D
         . D DIVLIST("ARHDLIST",DUZ)
         . S ARHDCNT=$G(ARHDLIST(0))
         . I ARHDCNT<1 D
         .. S ARHD0DIV=$$GET1^DIQ(8989.3,1,217,"I") ;DBIA:2056
         .. D SETDIV(ARHDROOT,ARHD0DIV,.ARHDOKAY,ARHD0DIV)
         .. S ARHDOKAY=0
         .. Q
         . I ARHDCNT=1 D
         .. S ARHD0DIV=$P($G(ARHDLIST(1)),U,1)
         .. D SETDIV(ARHDROOT,ARHD0DIV,.ARHDOKAY)
         .. Q
         . I ARHDCNT>1 D
         .. D DIVFORM(ARHDROOT,.ARHDLIST,.ARHDFRM)
         .. S ARHDOKAY=-1
         .. Q
         . Q
         D SETSES^R1UTCSPZ("ARHDDIV",ARHDOKAY)
         Q ARHDOKAY
         ;
DIVFORM(ARHDROOT,ARHDLIST,ARHDFRM) --
          ;
         ; *** Return the division selection form
         ; Input
         ;  ARHDROOT = Closed array reference for messages (Req)
         ;  ARHDLIST = The list of selectable divisions (Req, Pass by ref)
         ;  ARHDFRM = Form attributes (Opt, Pass by ref)
         ; Output
         ;  None
         N ARHD0DIV,ARHDATTR,ARHDDATA,ARHDDFLT,ARHDINDX
         N ARHDNAME,ARHDNUMB,ARHDTAG,ARHDTEMP
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),1)
         I $D(ARHDFRM("name"))#2'>0 S ARHDFRM("name")="frmVistADivision"
         D SET^R1UTCSPX(ARHDROOT,"<tr>")
         D SET^R1UTCSPX(ARHDROOT,"<td><h1>VA</h1></td>")
         D SET^R1UTCSPX(ARHDROOT,"<td>Division: ")
         K ARHDATTR
         S ARHDATTR("name")="cbxDivision"
         S ARHDATTR("tabindex")="1"
         S ARHDTEMP=$$GETROOT^R1UTCSPX($NA(^TMP($T(+0)_"-TEMP",$$UNIQUE^R1UTCSPZ)),1)
         S (ARHDINDX,ARHDDFLT)=0
         F  S ARHDINDX=$O(ARHDLIST(ARHDINDX)) Q:ARHDINDX'>0  D
         . S ARHDDATA=$G(ARHDLIST(ARHDINDX))
         . S ARHD0DIV=$P(ARHDDATA,U,1)
         . S ARHDNAME=$P(ARHDDATA,U,2)
         . I $P(ARHDDATA,U,3)>0 S ARHDDFLT=ARHD0DIV
         . S ARHDNUMB=$P(ARHDDATA,U,4)
         . S ARHDNAME=ARHDNAME_$S(ARHDNUMB]"":" ("_ARHDNUMB_")",1:"")
         . S @ARHDTEMP@("BEG",$$ESCAPE^R1UTCSPZ(ARHDNAME),ARHD0DIV)=""
         . Q
         D SELECT^R1UTCSPY(ARHDROOT,.ARHDATTR,ARHDDFLT,ARHDTEMP)
         D SET^R1UTCSPX(ARHDROOT,"</td>")
         D SET^R1UTCSPX(ARHDROOT,"<td>")
         K ARHDATTR
         S ARHDATTR("checked")="checked"
         S ARHDATTR("class")="button"
         S ARHDATTR("name")="btnDivision"
         S ARHDATTR("tabindex")="2"
         S ARHDATTR("value")="OK"
         D SET^R1UTCSPX(ARHDROOT,$$INPUTTAG^R1UTCSPY("submit",.ARHDATTR))
         D SET^R1UTCSPX(ARHDROOT,"</td>")
         D SET^R1UTCSPX(ARHDROOT,"<td>")
         K ARHDATTR
         S ARHDATTR("value")="Cancel"
         S ARHDATTR("tabindex")="3"
         D SET^R1UTCSPX(ARHDROOT,$$LOGOBTN^R1UTCSP2(.ARHDATTR))
         D SET^R1UTCSPX(ARHDROOT,"</td>")
         D SET^R1UTCSPX(ARHDROOT,"</tr>")
         D LOGFORM^R1UTCSP(ARHDROOT,.ARHDFRM,"Select a division")
         K @ARHDTEMP
         Q
         ;
DIVLIST(ARHDROOT,ARHD0DUZ) --
          ;
         ; *** Get a user's division list
         ; Input
         ;  ARHDROOT = Closed array reference for messages (Req)
         ;  ARHD0DUZ = Pointer to New Person (Req)
         ; Output
         ;  ARHDROOT(1..N) = IEN ^ StationName ^ Default ^ Station#
         N ARHD0DIV,ARHDCNT,ARHDDATA,ARHDDIV,ARHDINDX,ARHDNAME
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),1)
         D LIST^DIC(200.02,","_ARHD0DUZ_",","@;.01;1I","P","","","","","","","ARHDDIV") ;DBIA:2051
         S (ARHDINDX,ARHDCNT)=0
         F  S ARHDINDX=$O(ARHDDIV("DILIST",ARHDINDX)) Q:ARHDINDX'>0  D
         . S ARHDDATA=$G(ARHDDIV("DILIST",ARHDINDX,0))
         . S ARHD0DIV=$P(ARHDDATA,U,1)
         . S ARHDNAME=$P(ARHDDATA,U,2)
         . I (ARHD0DIV>0)&(ARHDNAME]"") D
         .. S ARHDCNT=ARHDCNT+1
         .. S $P(ARHDDATA,U,3)=''$P(ARHDDATA,U,3)
         .. S $P(ARHDDATA,U,4)=$$GET1^DIQ(4,ARHD0DIV,99) ;DBIA:2056
         .. D SET^R1UTCSPX(ARHDROOT,ARHDDATA)
         .. Q
         . Q
         S @ARHDROOT@(0)=ARHDCNT
         Q
         ;
GETDIV(ARHDDIV) --
          ;
         ; *** Get the selected division
         ; Input
         ;  ARHDDIV = Return variable for the division (Req, Pass by ref)
         ; Output
         ;  None
         S ARHDDIV=$S($G(ARHDDIV)]"":ARHDDIV,1:"cbxDivision")
         S ARHDDIV=$$GETREQ^R1UTCSPZ(ARHDDIV)
         Q
         ;
SETDIV(ARHDROOT,ARHD0DIV,ARHDOKAY,ARHDDFLT) --
          ;
         ; *** Set the selected division
         ; Input
         ;  ARHDROOT = Closed array reference for messages (Req)
         ;  ARHD0DIV = Pointer to Institution file (Req)
         ;  ARHDOKAY = Status return variable (Req, pass by ref)
         ;  ARHDDFLT = Default pointer to Institution file (Opt)
         ; Output
         ;  None
         S ARHD0DIV="`"_ARHD0DIV
         D DIVSET^XUSRB2(.ARHDOKAY,ARHD0DIV) ;DBIA:4055
         I $G(ARHDDFLT)>0 S ARHDOKAY=$$SETDUZ2^R1UTCSPZ(ARHDDFLT)
         I ARHDOKAY>0 D
         . S ARHDMSG="Division has been set for user."
         . D SET^R1UTCSPX(ARHDROOT,ARHDMSG,"",1)
         . D DUZ2SES^R1UTCSPX(.DUZ)
         . S ARHDOKAY=1
         . Q
         E  D
         . S ARHDMSG="Invalid division for user."
         . D SET^R1UTCSPX(ARHDROOT,ARHDMSG,"",1)
         . S ARHDOKAY=""
         . Q
         Q
