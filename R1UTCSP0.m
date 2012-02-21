R1UTCSP0 ;SFVAMC/DAD-Cache Server Pages (Login)
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
LOGIN(ARHDACC,ARHDVER,ARHDFRM,ARHDROOT) --
          ;
         ; *** Cache Server Page Login
         ; Input
         ;  ARHDACC = Access code (Req)
         ;  ARHDVER = Verify code (Req)
         ;  ARHDFRM = Form attributes (Opt, Pass by ref)
         ;  ARHDROOT = Closed array reference for messages (Opt)
         ; Output
         ;  %session.Data("DUZ*") = The user's DUZ array
         ;  $$LOGIN() = -1 : Display login form
         ;               0 : User failed the login
         ;               1 : User is logged into VistA
         ;              "" : User cancelled
         N ARHDMSG,ARHDOKAY,X,Y
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),1)
         I $$GETREQ^R1UTCSPZ("btnLogout")]"" D
         . S ARHDOKAY=""
         . Q
         I $$GETREQ^R1UTCSPZ("btnLogin")]"" D
         . I $G(ARHDACC)="" D GETCODES(.ARHDACC,.ARHDVER)
         . I ($L(ARHDACC,";")=2)&(ARHDVER="") D
         .. S ARHDVER=$P(ARHDACC,";",2)
         .. S ARHDACC=$P(ARHDACC,";",1)
         .. Q
         . I ARHDACC]"" D
         .. D XUVOL^XUS ;DBIA:4762
         .. S ARHDOKAY=$$INHIBIT^XUSRB ;DBIA:3277
         .. S ARHDOKAY=$S(ARHDOKAY=1:"0^No signons allowed.",ARHDOKAY=2:"0^Maximum users reached.",1:1)
         .. S ARHDOKAY=$S(ARHDOKAY>0:$$USERSET^XUSRA(ARHDACC_";"_ARHDVER),1:ARHDOKAY) ;DBIA:None
         .. I ARHDOKAY>0 D
         ... D DUZ2SES^R1UTCSPX(.DUZ)
         ... S ARHDMSG="You are logged into VistA."
         ... D SET^R1UTCSPX(ARHDROOT,ARHDMSG,"",1)
         ... S ARHDOKAY=1
         ... Q
         .. E  D
         ... S ARHDMSG="You are NOT logged into VistA."
         ... D SET^R1UTCSPX(ARHDROOT,ARHDMSG,"",1)
         ... S ARHDMSG=$P(ARHDOKAY,U,2)
         ... I $P(ARHDOKAY,U,2)]"" D SET^R1UTCSPX(ARHDROOT,ARHDMSG,"",1)
         ... S ARHDOKAY=0
         ... Q
         .. Q
         . E  D
         .. I $$GETSES^R1UTCSPZ("DUZ")>0 D
         ... S ARHDOKAY=1
         ... Q
         .. E  D
         ... K ARHDOKAY
         ... Q
         .. Q
         . Q
         I $D(ARHDOKAY)#2'>0 D
         . D LOGIFORM(ARHDROOT,.ARHDFRM)
         . S ARHDOKAY=-1
         . Q
         D SETSES^R1UTCSPZ("ARHDCHG",''$$GETREQ^R1UTCSPZ("chkChgVerify"))
         D SETSES^R1UTCSPZ("ARHDLOG",ARHDOKAY)
         Q ARHDOKAY
         ;
LOGIFORM(ARHDROOT,ARHDFRM) --
          ;
         ; *** Return the VistA login form
         ; Input
         ;  ARHDROOT = Closed array reference for messages (Req)
         ;  ARHDFRM = Form attributes (Opt, Pass by ref)
         ; Output
         ;  None
         N ARHDATTR
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),1)
         I $D(ARHDFRM("name"))#2'>0 S ARHDFRM("name")="frmVistALogin"
         D SET^R1UTCSPX(ARHDROOT,"<tr>")
         D SET^R1UTCSPX(ARHDROOT,"<td class=""bottom"" rowspan=""3""><h1>VA</h1></td>")
         D SET^R1UTCSPX(ARHDROOT,"<td>Access Code: </td>")
         K ARHDATTR
         S ARHDATTR("maxlength")="20"
         S ARHDATTR("name")="edtAccessCode"
         S ARHDATTR("tabindex")="1"
         D SET^R1UTCSPX(ARHDROOT,"<td>"_$$INPUTTAG^R1UTCSPY("password",.ARHDATTR)_"</td>")
         K ARHDATTR
         S ARHDATTR("checked")="checked"
         S ARHDATTR("class")="button"
         S ARHDATTR("name")="btnLogin"
         S ARHDATTR("tabindex")="3"
         S ARHDATTR("value")="OK"
         D SET^R1UTCSPX(ARHDROOT,"<td>"_$$INPUTTAG^R1UTCSPY("submit",.ARHDATTR)_"</td>")
         D SET^R1UTCSPX(ARHDROOT,"</tr>")
         D SET^R1UTCSPX(ARHDROOT,"<tr>")
         D SET^R1UTCSPX(ARHDROOT,"<td>Verify Code: </td>")
         K ARHDATTR
         S ARHDATTR("maxlength")="20"
         S ARHDATTR("name")="edtVerifyCode"
         S ARHDATTR("tabindex")="2"
         D SET^R1UTCSPX(ARHDROOT,"<td>"_$$INPUTTAG^R1UTCSPY("password",.ARHDATTR)_"</td>")
         K ARHDATTR
         S ARHDATTR("value")="Cancel"
         S ARHDATTR("tabindex")="4"
         D SET^R1UTCSPX(ARHDROOT,"<td>"_$$LOGOBTN^R1UTCSP2(.ARHDATTR)_"</td>")
         D SET^R1UTCSPX(ARHDROOT,"</tr>")
         D SET^R1UTCSPX(ARHDROOT,"<tr>")
         D SET^R1UTCSPX(ARHDROOT,"<td></td>")
         D SET^R1UTCSPX(ARHDROOT,"<td>")
         K ARHDATTR
         S ARHDATTR("name")="chkChgVerify"
         S ARHDATTR("tabindex")="5"
         S ARHDATTR("value")="1"
         D SET^R1UTCSPX(ARHDROOT,$$INPUTTAG^R1UTCSPY("checkbox",.ARHDATTR)_" Change Verify Code")
         D SET^R1UTCSPX(ARHDROOT,"</td>")
         D SET^R1UTCSPX(ARHDROOT,"</tr>")
         D LOGFORM^R1UTCSP(ARHDROOT,.ARHDFRM,"Enter your access and verify codes")
         Q
         ;
GETCODES(ARHDACC,ARHDVER) --
          ;
         ; *** Get the access/verify codes
         ; Input
         ;  ARHDACC = Return variable for the access code (Req, Pass by ref)
         ;  ARHDVER = Return variable for the verify code (Req, Pass by ref)
         ; Output
         ;  None
         S ARHDACC=$S($G(ARHDACC)]"":ARHDACC,1:"edtAccessCode")
         S ARHDVER=$S($G(ARHDVER)]"":ARHDVER,1:"edtVerifyCode")
         S ARHDACC=$$GETREQ^R1UTCSPZ(ARHDACC)
         S ARHDVER=$$GETREQ^R1UTCSPZ(ARHDVER)
         Q
