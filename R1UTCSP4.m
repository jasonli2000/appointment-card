R1UTCSP4 ;SFVAMC/DAD-Cache Server Pages (Option Context)
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
CONTEXT(ARHDOPT,ARHDROOT) --
          ;
         ; *** Cache Server Page Option Context
         ; Input
         ;  ARHDOPT = Context option (Opt)
         ;  ARHDROOT = Closed array reference for messages (Opt)
         ; Output
         ;  $$CONTEXT() = 0 : User failed option context check
         ;                1 : User passed option context check
         N ARHD0OPT,ARHDMESS,ARHDMSG,ARHDOKAY
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),1)
         I $G(ARHDOPT)]"" D
         . I $$OPTION(DUZ,ARHDOPT,.ARHDMESS)>0 D
         .. S ARHDMSG="You are logged into VistA."
         .. D XQY2SES^R1UTCSPX(ARHDOPT)
         .. D SET^R1UTCSPX(ARHDROOT,ARHDMSG,"",1)
         .. S ARHDOKAY=1
         .. Q
         . E  D
         .. S ARHDMSG="You are NOT authorized to run this application"
         .. D SET^R1UTCSPX(ARHDROOT,ARHDMSG,"",1)
         .. S ARHD0OPT=$$LKOPT^XPDMENU(ARHDOPT) ;DBIA:1157
         .. S ARHDMSG=$$GET1^DIQ(19,ARHD0OPT,.01)_" ["_ARHDOPT_"]" ;DBIA:2056
         .. D SET^R1UTCSPX(ARHDROOT,ARHDMSG,"",1)
         .. I $G(ARHDMESS)]"" D SET^R1UTCSPX(ARHDROOT,ARHDMESS,"",1)
         .. S ARHDOKAY=0
         .. Q
         . Q
         E  D
         . S ARHDMSG="You are logged into VistA."
         . D SET^R1UTCSPX(ARHDROOT,ARHDMSG,"",1)
         . S ARHDOKAY=1
         . Q
         D SETSES^R1UTCSPZ("ARHDCTX",ARHDOKAY)
         Q ARHDOKAY
         ;
OPTION(ARHD0DUZ,ARHDOPT,ARHDMSG) --
          ;
         ; *** Does the user have access to the context option
         ; Input
         ;  ARHD0DUZ = Pointer to New Person (Req)
         ;  ARHDOPT = Option name/IEN (Req)
         ;  ARHDMSG = Return array for error messages (Opt)
         ; Output
         ;  $$OPTION() = If > 0 then the user has access to the option
         ;               or the user holds the XUPROGMODE security key
         N ARHDFLAG,ARHDAOPT,ARHDOKAY,ARHDPMOD,XQCODES,XQCY,XQJMP,XQSAV,XQY,XQY0
         K ARHDMSG S ARHDMSG=""
         S ARHDPMOD=$$KCHK^XUSRB("XUPROGMODE",ARHD0DUZ) ;DBIA:2120
         I ARHDPMOD>0 D
         . S ARHDOKAY=1
         . Q
         E  D
         . S ARHDAOPT=$$ACCESS^XQCHK(ARHD0DUZ,ARHDOPT) ;DBIA:10078
         . I ARHDAOPT>0 D
         .. I ARHDOPT'=+ARHDOPT S ARHDOPT=$$FIND1^DIC(19,"","X",ARHDOPT) ;DBIA:2051
         .. S XQCY=ARHDOPT
         .. D ^XQCHK ;DBIA:None
         .. S ARHDFLAG=+$G(XQCY)
         .. I ARHDFLAG=-1 S ARHDMSG="Option is out of order: '"_$$GET1^DIQ(19,ARHDOPT,2)_"'." ;DBIA:2056
         .. I ARHDFLAG=-2 S ARHDMSG="Option is locked."
         .. I ARHDFLAG=-3 S ARHDMSG="Option is reverse locked."
         .. I ARHDFLAG=-4 S ARHDMSG="Option is not allowed to run at this time."
         .. I ARHDFLAG=-5 S ARHDMSG="Option is not allowed to run on this device."
         .. S ARHDOKAY=$S(ARHDFLAG>0:1,1:0)
         .. Q
         . E  D 
         .. I +ARHDAOPT=0 S ARHDMSG="User does not have access to the option or key."
         .. I +ARHDAOPT=-1 S ARHDMSG="No such user in the New Person file."
         .. I +ARHDAOPT=-2 S ARHDMSG="User terminated or has no access code."
         .. I +ARHDAOPT=-3 S ARHDMSG="No such option in the Option file."
         .. S ARHDMSG=$S(ARHDMSG]"":ARHDMSG,1:"Access denied.")
         .. S ARHDOKAY=0
         .. Q
         . Q
         Q ARHDOKAY
