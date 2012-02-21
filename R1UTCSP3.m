R1UTCSP3 ;SFVAMC/DAD-Cache Server Pages (Change Verify Code)
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
CHVERIFY(ARHDVER0,ARHDVER1,ARHDVER2,ARHDCHG,ARHDFRM,ARHDROOT) --
          ;
         ; *** Cache Server Page Login
         ; Input
         ;  ARHDVER0 = Old verify code (Req)
         ;  ARHDVER1 = New verify code (Req)
         ;  ARHDVER2 = New verify code (Req)
         ;  ARHDCHG  = Boolean force verify code change (Opt)
         ;  ARHDFRM = Form attributes (Opt, Pass by ref)
         ;  ARHDROOT = Closed array reference for messages (Opt)
         ; Output
         ;  $$CHVERIFY() = -1 : Display chabge verify form
         ;                  0 : User failed the verify code change
         ;                  1 : User has changed their verify code
         ;                 "" : User cancelled verify code change
         N ARHDMSG,ARHDOKAY,I,X,XOPT,Y
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),1)
         D XOPT^XUS ;DBIA:4762
         I ($G(ARHDCHG)>0)!($$VCVALID^XUSRB=1) D  ;DBIA:4054
         . I $$GETREQ^R1UTCSPZ("btnLogout")]"" D
         .. S ARHDOKAY=""
         .. Q
         . I $$GETREQ^R1UTCSPZ("btnChgVerify")]"" D
         .. I ($G(ARHDVER0)="")!($G(ARHDVER1)="")!($G(ARHDVER2)="") D
         ... D GETCODES(.ARHDVER0,.ARHDVER1,.ARHDVER2)
         ... Q
         .. I ($G(ARHDVER1)]"")&($G(ARHDVER2)]"") D
         ... K ARHDRSLT
         ... S ARHDVER0=$$UP^XLFSTR(ARHDVER0) ;DBIA:10104
         ... S ARHDVER1=$$UP^XLFSTR(ARHDVER1) ;DBIA:10104
         ... S ARHDVER2=$$UP^XLFSTR(ARHDVER2) ;DBIA:10104
         ... I ARHDVER1=ARHDVER2 D
         .... S ARHDVER0=$$ENCRYP^XUSRB1(ARHDVER0) ;DBIA:2240
         .... S ARHDVER1=$$ENCRYP^XUSRB1(ARHDVER1) ;DBIA:2240
         .... S ARHDVER2=$$ENCRYP^XUSRB1(ARHDVER2) ;DBIA:2240
         .... D CVC^XUSRB(.ARHDRSLT,ARHDVER0_U_ARHDVER1_U_ARHDVER2) ;DBIA:4054
         .... Q
         ... E  D
         .... S ARHDRSLT(0)=-1
         .... S ARHDRSLT(1)="The confirmation code does not match."
         .... Q
         ... I $G(ARHDRSLT(0))=0 D
         .... D DUZ2SES^R1UTCSPX(.DUZ)
         .... S ARHDMSG="You are logged into VistA."
         .... D SET^R1UTCSPX(ARHDROOT,ARHDMSG,"",1)
         .... S ARHDOKAY=1
         .... Q
         ... E  D
         .... S ARHDMSG="You are NOT logged into VistA."
         .... D SET^R1UTCSPX(ARHDROOT,ARHDMSG,"",1)
         .... S ARHDINDX=0
         .... F  S ARHDINDX=$O(ARHDRSLT(ARHDINDX)) Q:ARHDINDX'>0  D
         ..... D SET^R1UTCSPX(ARHDROOT,$G(ARHDRSLT(ARHDINDX)),"",1)
         ..... Q
         .... S ARHDOKAY=0
         .... Q
         ... Q
         .. Q
         . I $D(ARHDOKAY)#2'>0 D
         .. D CVCFORM(ARHDROOT,.ARHDFRM)
         .. S ARHDOKAY=-1
         .. Q
         . Q
         E  D
         . S ARHDMSG="You are logged into VistA."
         . D SET^R1UTCSPX(ARHDROOT,ARHDMSG,"",1)
         . S ARHDOKAY=1
         . Q
         D SETSES^R1UTCSPZ("ARHDCVC",ARHDOKAY)
         Q ARHDOKAY
         ;
CVCFORM(ARHDROOT,ARHDFRM) --
          ;
         ; *** Return the change verify code form
         ; Input
         ;  ARHDROOT = Closed array reference for messages (Req)
         ;  ARHDFRM = Form attributes (Opt, Pass by ref)
         ; Output
         ;  None
         N ARHDATTR
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),1)
         I $D(ARHDFRM("name"))#2'>0 S ARHDFRM("name")="frmVistAChangeVerify"
         D SET^R1UTCSPX(ARHDROOT,"<tr>")
         D SET^R1UTCSPX(ARHDROOT,"<td class=""bottom"" rowspan=""3""><h1>VA</h1></td>")
         D SET^R1UTCSPX(ARHDROOT,"<td>Old Verify Code: </td>")
         K ARHDATTR
         S ARHDATTR("maxlength")="20"
         S ARHDATTR("name")="edtVerifyCodeOld"
         S ARHDATTR("tabindex")="1"
         D SET^R1UTCSPX(ARHDROOT,"<td>"_$$INPUTTAG^R1UTCSPY("password",.ARHDATTR)_"</td>")
         K ARHDATTR
         S ARHDATTR("checked")="checked"
         S ARHDATTR("class")="button"
         S ARHDATTR("name")="btnChgVerify"
         S ARHDATTR("tabindex")="4"
         S ARHDATTR("value")="OK"
         D SET^R1UTCSPX(ARHDROOT,"<td>"_$$INPUTTAG^R1UTCSPY("submit",.ARHDATTR)_"</td>")
         D SET^R1UTCSPX(ARHDROOT,"</tr>")
         D SET^R1UTCSPX(ARHDROOT,"<tr>")
         D SET^R1UTCSPX(ARHDROOT,"<td>New Verify Code: </td>")
         K ARHDATTR
         S ARHDATTR("maxlength")="20"
         S ARHDATTR("name")="edtVerifyCodeNew1"
         S ARHDATTR("tabindex")="2"
         D SET^R1UTCSPX(ARHDROOT,"<td>"_$$INPUTTAG^R1UTCSPY("password",.ARHDATTR)_"</td>")
         K ARHDATTR
         S ARHDATTR("value")="Cancel"
         S ARHDATTR("tabindex")="5"
         D SET^R1UTCSPX(ARHDROOT,"<td>"_$$LOGOBTN^R1UTCSP2(.ARHDATTR)_"</td>")
         D SET^R1UTCSPX(ARHDROOT,"</tr>")
         D SET^R1UTCSPX(ARHDROOT,"<tr>")
         D SET^R1UTCSPX(ARHDROOT,"<td>Confirm New Verify Code: </td>")
         K ARHDATTR
         S ARHDATTR("maxlength")="20"
         S ARHDATTR("name")="edtVerifyCodeNew2"
         S ARHDATTR("tabindex")="3"
         D SET^R1UTCSPX(ARHDROOT,"<td>"_$$INPUTTAG^R1UTCSPY("password",.ARHDATTR)_"</td>")
         D SET^R1UTCSPX(ARHDROOT,"</tr>")
         D LOGFORM^R1UTCSP(ARHDROOT,.ARHDFRM,"Change your verify code")
         Q
         ;
GETCODES(ARHDVER0,ARHDVER1,ARHDVER2) --
          ;
         ; *** Get the old/new verify codes
         ; Input
         ;  ARHDVER0 = Return variable for the old verify code (Req, Pass by ref)
         ;  ARHDVER1 = Return variable for the new verify code (Req, Pass by ref)
         ;  ARHDVER2 = Return variable for the new verify code (Req, Pass by ref)
         ; Output
         ;  None
         S ARHDVER0=$S($G(ARHDVER0)]"":ARHDVER0,1:"edtVerifyCodeOld")
         S ARHDVER1=$S($G(ARHDVER1)]"":ARHDVER1,1:"edtVerifyCodeNew1")
         S ARHDVER2=$S($G(ARHDVER2)]"":ARHDVER2,1:"edtVerifyCodeNew2")
         S ARHDVER0=$$GETREQ^R1UTCSPZ(ARHDVER0)
         S ARHDVER1=$$GETREQ^R1UTCSPZ(ARHDVER1)
         S ARHDVER2=$$GETREQ^R1UTCSPZ(ARHDVER2)
         Q
