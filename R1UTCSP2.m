R1UTCSP2 ;SFVAMC/DAD-Cache Server Pages (Logout)
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
LOGOUT   ; *** Cache Server Page Logout
         ; Input
         ;  None
         ; Output
         ;  None
         N XQNOHALT
         D SETUP^R1UTCSPX()
         D SESKOTH^R1UTCSPX
         D SESKXQY^R1UTCSPX
         D SESKDUZ^R1UTCSPX
         S XQNOHALT=1 D H^XUS ;DBIA:10044
         I $$XYENABLE^R1UTCSPZ(1)
         D ENDSES^R1UTCSPZ
         Q
         ;
LOGOFORM(ARHDROOT,ARHDATTR) --
          ;
         ; *** User logout form
         ; Input
         ;  ARHDROOT = Array used to pass the form (Req)
         ;  ARHDATTR = Form attributes (Opt)
         ; Output
         ;  None
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),1)
         I $D(ARHDATTR("name"))#2'>0 S ARHDATTR("name")="frmLogout"
         I $D(ARHDATTR("action"))#2'>0 S ARHDATTR("action")=$$ENCODURL^R1UTCSPZ($$GETURL^R1UTCSPZ)
         D SET^R1UTCSPX(ARHDROOT,$$FORMTAG^R1UTCSPY(.ARHDATTR))
         D SET^R1UTCSPX(ARHDROOT,$$LOGOBTN())
         D SET^R1UTCSPX(ARHDROOT,"</form>")
         Q
         ;
LOGOBTN(ARHDATTR) --
          ;
         ; *** Logout submit button
         ; Input
         ;  ARHDATTR = Button attributes (Opt)
         ; Output
         ;  $$LOGOBTN() = Logout submit button
         I $D(ARHDATTR("class"))#2'>0 S ARHDATTR("class")="button"
         I $D(ARHDATTR("name"))#2'>0 S ARHDATTR("name")="btnLogout"
         I $D(ARHDATTR("value"))#2'>0 S ARHDATTR("value")="Logout"
         Q $$INPUTTAG^R1UTCSPY("submit",.ARHDATTR)
         ;
LOGOURL(ARHDPAR) --
          ;
         ; *** URL to go to on logout
         ; Input
         ;  ARHDPAR = Parameter that holds the logout URL
         ; Output
         ;  A URL string
         N ARHDDUZ,ARHDENT,ARHDURL
         S ARHDDUZ=$S($G(DUZ)>0:DUZ,1:$$GETSES^R1UTCSPZ("DUZ"))
         S ARHDENT="USR.`"_(+ARHDDUZ)
         S ARHDENT=ARHDENT_"^SRV.`"_(+$$GET1^DIQ(200,+ARHDDUZ,29,"I"))
         S ARHDENT=ARHDENT_$S($G(DUZ(2))>0:"^DIV",1:"")
         S ARHDENT=ARHDENT_"^SYS"
         S ARHDURL(1)=$$GET^XPAR(ARHDENT,$S($G(ARHDPAR)]"":ARHDPAR,1:U))
         S ARHDURL(2)=$$GET^XPAR(ARHDENT,"R1UTCSP LOGOUT URL")
         S ARHDURL=$S(ARHDURL(1)]"":ARHDURL(1),ARHDURL(2)]"":ARHDURL(2),1:"about:blank")
         Q ARHDURL
