R1UTCSPZ ;SFVAMC/DAD-Cache Server Pages (Non-SAC Compliant)
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
SETREQ(ARHDNAME,ARHDVALU,ARHDINDX) --
          ;
         ; *** Set a value into %request.Data()
         ; Input
         ;  ARHDNAME = The variable name (Req)
         ;  ARHDVALU = The value to set (Req)
         ;  ARHDINDX = The variable index (Opt)
         ; Output
         ;  None
         S %request.Data(ARHDNAME,$G(ARHDINDX,1))=ARHDVALU
         Q
         ;
GETREQ(ARHDNAME,ARHDDFLT,ARHDINDX) --
          ;
         ; *** Get a value from %request.Data()
         ; Input
         ;  ARHDNAME = The variable name (Req)
         ;  ARHDDFLT = The default value (Opt)
         ;  ARHDINDX = The variable index (Opt)
         ; Output
         ;  $$GETREQ() = Value of ARHDNAME, if undefined ARHDDFLT
         Q $G(%request.Data(ARHDNAME,$G(ARHDINDX,1)),$G(ARHDDFLT))
         ;
DATAREQ(ARHDNAME,ARHDINDX) --
          ;
         ; *** Get $Data of %request.Data()
         ; Input
         ;  ARHDNAME = The variable name (Req)
         ;  ARHDINDX = The variable index (Opt)
         ; Output
         ;  $$DATAREQ() = $Data value of ARHDNAME request variable
         Q $D(%request.Data(ARHDNAME,$G(ARHDINDX,1)))
         ;
KILLREQ(ARHDNAME,ARHDINDX) --
          ;
         ; *** Kill value(s) in %request.Data()
         ; Input
         ;  ARHDNAME = The variable name (Opt)
         ;  ARHDINDX = The variable index (Opt)
         ; Output
         ;  None
         S ARHDNAME=$G(ARHDNAME)
         S ARHDINDX=$G(ARHDINDX)
         I ARHDNAME]"" D
         . K:$G(ARHDINDX)="" %request.Data(ARHDNAME)
         . K:$G(ARHDINDX)]"" %request.Data(ARHDNAME,ARHDINDX)
         . Q
         E  D
         . F  S ARHDNAME=$O(%request.Data(ARHDNAME)) Q:ARHDNAME=""  D
         .. K:$G(ARHDINDX)="" %request.Data(ARHDNAME)
         .. K:$G(ARHDINDX)]"" %request.Data(ARHDNAME,ARHDINDX)
         .. Q
         . Q
         Q
         ;
SETSES(ARHDNAME,ARHDVALU) --
          ;
         ; *** Set a value into %session.Data()
         ; Input
         ;  ARHDNAME = The variable name (Req)
         ;  ARHDVALU = The value to set (Req)
         ; Output
         ;  None
         S %session.Data(ARHDNAME)=ARHDVALU
         Q
         ;
GETSES(ARHDNAME,ARHDDFLT) --
          ;
         ; *** Get a value from %session.Data()
         ; Input
         ;  ARHDNAME = The variable name (Req)
         ;  ARHDDFLT = The default value (Opt)
         ; Output
         ;  $$GETSES() = Value of ARHDNAME, if undefined ARHDDFLT
         Q $G(%session.Data(ARHDNAME),$G(ARHDDFLT))
         ;
DATASES(ARHDNAME) --
          ;
         ; *** Get $Data of %session.Data()
         ; Input
         ;  ARHDNAME = The variable name (Req)
         ; Output
         ;  $$DATASES() = $Data value of ARHDNAME session variable
         Q $D(%session.Data(ARHDNAME))
         ;
KILLSES(ARHDNAME) --
          ;
         ; *** Kill value(s) in %session.Data()
         ; Input
         ;  ARHDNAME = The variable name (Opt)
         ; Output
         ;  None
         S ARHDNAME=$G(ARHDNAME)
         I ARHDNAME]"" D
         . K %session.Data(ARHDNAME)
         . Q
         E  D
         . F  S ARHDNAME=$O(%session.Data(ARHDNAME)) Q:ARHDNAME=""  D
         .. K %session.Data(ARHDNAME)
         .. Q
         . Q
         Q
         ;
ENDSES   ;
         ; *** End a user's session
         ; Input
         ;  None
         ; Output
         ;  None
         S %session.EndSession=1
         Q
         ;
IDSES()  ;
         ; *** Returns the session ID
         ; Input
         ;  None
         ; Output
         ;  $$IDSES() = Session ID
         Q %session.SessionId
         ;
TIMESES(ARHDVALU,ARHD0DUZ) --
          ;
         ; *** Set the session timeout value
         ; Input
         ;  ARHDVALU = The value to set (Opt)
         ;  ARHD0DUZ = Pointer to the New Person file (Opt)
         ; Output
         ;  None
         S ARHDVALU=$S($G(ARHDVALU)\1>0:ARHDVALU\1,1:$$DTIME^XUP($G(ARHD0DUZ))) ;DBIA:4409
         S %session.AppTimeout=ARHDVALU
         Q
         ;
EVENTSES(ARHDVALU) --
          ;
         ; *** Set the application event class
         ; Input
         ;  ARHDVALU = The name of the event class (Opt)
         ; Output
         ;  None
         I $G(ARHDVALU)]"" S %session.EventClass=ARHDVALU
         Q
         ;
ORDER(ARHDOBJ,ARHDINDX,ARHDDIR) --
          ;
         ; *** $Order through an object
         ; Input
         ;  ARHDOBJ = Object (e.g., %session.Data) to $Order through (Req)
         ;  ARHDINDX = Subscript variable (Req)
         ;  ARHDDIR = $Order direction (Opt)
         ; Output
         ;  $$ORDER() = The next/previous subscript
         Q $O(@ARHDOBJ@(ARHDINDX),$G(ARHDDIR,1))
         ;
GETURL() ;
         ; *** URL of the  current page
         ; Input
         ;  None
         ; Output
         ;  $$GETURL() = Page URL
         Q %request.URL
         ;
ENCODURL(ARHDURL) --
          ;
         ; *** Encode a URL with a CSP token
         ; Input
         ;  ARHDURL = A plain text URL (Req)
         ; Output
         ;  $$ENCODURL() = A URL with an appended CSPToken parameter
         Q ##class(%CSP.Page).Link(ARHDURL)
         ;
ESCAPE(ARHDDATA) --
          ;
         ; *** Converts normal HTML text into escaped HTML text
         ; Input
         ;  ARHDDATA = Normal text (Req)
         ; Output
         ;  $$ESCAPE() = Escaped HTML text
         Q ##class(%CSP.Page).EscapeHTML(ARHDDATA)
         ;
UNESCAPE(ARHDDATA) --
          ;
         ; *** Converts escaped HTML text into normal HTML text
         ; Input
         ;  ARHDDATA = Escaped text (Req)
         ; Output
         ;  $$UNESCAPE() = Escaped HTML text
         Q ##class(%CSP.Page).UnescapeHTML(ARHDDATA)
         ;
QUOTEJS(ARHDDATA) --
          ;
         ; *** Produces a javascript quoted string
         ; Input
         ;  ARHDDATA = Plain text (Req)
         ; Output
         ;  $$JSQUOTE() = Escaped/quoted JavaScript text
         Q ##class(%CSP.Page).QuoteJS(ARHDDATA)
         ;
EXPRRES(ARHDVALU) --
          ;
         ; *** Set the response expiration value
         ; Input
         ;  ARHDVALU = The value to set (Opt)
         ; Output
         ;  None
         I $IsObject($G(%response))>0 S %response.Expires=$G(ARHDVALU,0)
         Q
         ;
GETHDRES(ARHDNAME) --
          ;
         ; *** Get a response header value
         ; Input
         ;  ARHDNAME = The header name (Req)
         ; Output
         ;  $$GETHDRES() = Header value
         Q %response.GetHeader(ARHDNAME)
         ;
SETHDRES(ARHDNAME,ARHDVALU) --
          ;
         ; *** Set the response header value
         ; Input
         ;  ARHDNAME = The header name (Req)
         ;  ARHDVALU = The value to set (Opt)
         ; Output
         ;  None
         D %response.SetHeader(ARHDNAME,ARHDVALU)
         Q
         ;
DELHDRES(ARHDNAME) --
          ;
         ; *** Delete a response header
         ; Input
         ;  ARHDNAME = The header name (Req)
         ; Output
         ;  None
         D %response.DeleteHeader(ARHDNAME)
         Q
         ;
FLUSHRES ;
         ; *** Flush output buffer to web server
         ; Input
         ;  None
         ; Output
         ;  None
         D %response.Flush()
         Q
         ;
REDIR(ARHDURL) --
          ;
         ; *** Client-side redirect to a URL
         ; Input
         ;  ARHDURL = URL to redirect to (Req)
         ; Output
         ;  None
         S %response.Redirect=ARHDURL
         Q
         ;
SVRREDIR(ARHDURL) --
          ;
         ; *** Server-side redirect to a URL
         ; Input
         ;  ARHDURL = URL to redirect to (Req)
         ; Output
         ;  None
         S %response.ServerSideRedirect=ARHDURL
         Q
         ;
PHYSPATH(ARHDPATH) --
          ;
         ; *** Get the Cache physical path
         ; Input
         ;  ARHDPATH = Logical path specification (Req)
         ; Output
         ;  $$PHYSPATH() = Cache physical path
         Q $System.CSP.GetFileName(ARHDPATH)
         ;
DEBUG(ARHDDBUG) --
          ;
         ; *** Debugging display
         ; Input
         ;  ARHDDBUG = Boolean to enable/disable debugging info (Opt)
         ; Output
         ;  None
         S %response.TraceDump=''$G(ARHDDBUG)
         Q
         ;
UNIQUE() ;
         ; *** Get a unique identifier
         ; Input
         ;  None
         ; Output
         ;  $$UNIQUE() = The CSP session ID or the $Job number
         Q $S($IsObject($G(%session))>0:$$IDSES,1:$J)
         ;
I()      ; *** $IO
         Q $I
         ;
P()      ; *** $PRINCIPAL
         Q $P
         ;
ERRTRAP(ARHDETXT) --
          ;
         ; *** Set the Kernel error trap
         ; Input
         ;  ARHDETXT = Error to set into the trap (Opt)
         ; Output
         ;  None
         S $ZE=$G(ARHDETXT) D @^%ZOSF("ERRTN") S $ZE=""
         Q
         ;
DECOMPER(ARHDETXT) --
          ;
         ; *** Decompose an error
         ; Input
         ;  ARHDETXT = Return array for the error info (Req)
         ; Output
         ;  None
         K ARHDETXT
         D ##class(%CSP.Error).DecomposeError($$GETREQ("Error:ErrorCode"),.ARHDETXT)
         Q
         ;
DISPERR(ARHDETXT) --
          ;
         ; *** Decompose an error (from DECOMPER)
         ; Input
         ;  ARHDETXT = Error info array (Req)
         ; Output
         ;  None
         D ##class(%CSP.Error).DisplayError(.ARHDETXT)
         Q
         ;
DISPOBJS ;
         ; *** Display all objects
         ; Input
         ;  None
         ; Output
         ;  None
         D ##class(%CSP.Utils).DisplayAllObjects()
         Q
         ;
XYENABLE(ARHDVALU) --
          ;
         ; *** $X/$Y Read/Enable/Disable
         ; Input
         ;  ARHDVALU = Undefined / 0 / 1 (Opt)
         ; Output
         ;  $$XYENABLE() = 0 / 1
         Q $S($G(ARHDVALU)="":$ZUTIL(68,55),1:$ZUTIL(68,55,''ARHDVALU))
         ;
SETDUZ   ;
         ; *** Set the DUZ variables
         ; Input
         ;  None
         ; Output
         ;  None
         N ARHDINDX,ARHDSUB
         K DUZ
         I $$DATASES("DUZ")#2 S DUZ=$$GETSES("DUZ")
         F ARHDINDX=0,1,2,"AG","AUTO","BUF","LANG","NEWCODE","SAV" D
         . S ARHDSUB=$S(ARHDINDX'=+ARHDINDX:""""_ARHDINDX_"""",1:ARHDINDX)
         . I $$DATASES("DUZ("_ARHDSUB_")")#2 D
         .. S DUZ(ARHDINDX)=$$GETSES("DUZ("_ARHDSUB_")")
         .. Q
         . Q
         Q
         ;
SETDUZ2(ARHDDUZ2) --
          ;
         ; *** Set DUZ(2)
         ; Input
         ;  ARHDDUZ2 = Pointer to the institution file (Req)
         ; Output
         ;  $$SETDUZ2() = 1:DUZ(2) has been set, 0:DUZ(2) has NOT been set
         N ARHDOKAY
         S ARHDOKAY=0
         I $$GET1^DIQ(4,+$G(ARHDDUZ2),.01)]"" S DUZ(2)=ARHDDUZ2,ARHDOKAY=1
         Q ARHDOKAY
         ;
SETOTH   ;
         ; *** Set the other variables
         ; Input
         ;  None
         ; Output
         ;  None
         N ARHDINDX
         K DISYS,DT,DTIME
         F ARHDINDX="DISYS","DT","DTIME" D
         . I $$DATASES(ARHDINDX)#2 D
         .. S @(ARHDINDX_"=$$GETSES^R1UTCSPZ(ARHDINDX)")
         .. Q
         . Q
         Q
