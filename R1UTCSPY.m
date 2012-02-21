R1UTCSPY ;SFVAMC/DAD-Cache Server Pages (Misc Utility)
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
FORMTAG(ARHDATTR) --
          ;
         ; *** Make <form> tag
         ; Input
         ;  ARHDATTR = Form attributes (Opt)
         ; Output
         ;  $$FORMTAG() = <form attr1="value" ... >
         I $D(ARHDATTR("action"))#2'>0 S ARHDATTR("action")=$$ENCODURL^R1UTCSPZ($$GETURL^R1UTCSPZ)
         I $D(ARHDATTR("method"))#2'>0 S ARHDATTR("method")="post"
         I $D(ARHDATTR("name"))#2'>0 S ARHDATTR("name")="frmVistA"
         Q "<form"_$$ATTRIB(.ARHDATTR)_">"
         ;
INPUTTAG(ARHDTYPE,ARHDATTR) --
          ;
         ; *** Make <input> tag
         ; Input
         ;  ARHDTYPE = Type of input tag (Req)
         ;  ARHDATTR = Input attributes (Opt)
         ; Output
         ;  $$INPUTTAG() = <input attr1="value" ... >
         S ARHDTYPE=$$LOW^XLFSTR(ARHDTYPE) ;DBIA:10104
         S ARHDATTR("type")=ARHDTYPE
         Q "<input"_$$ATTRIB(.ARHDATTR)_" />"
         ;
ALPHASEL(ARHDROOT,ARHDATTR,ARHDSLCT) --
          ;
         ; *** Make alphabetic <select> tag
         ; Input
         ;  ARHDROOT = Closed array reference
         ;  ARHDATTR = <select> tag attributes
         ;  ARHDSLCT = The selected entry in list
         ; Output
         ;  ARHDROOT = Closed array reference containing the <select>
         N ARHDCHAR,ARHDINDX,ARHDRANG,ARHDTAG,ARHDTEMP
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),0)
         S ARHDTEMP=$$GETROOT^R1UTCSPX($NA(^TMP($T(+0)_"-TEMP",$$UNIQUE^R1UTCSPZ)),1)
         S @ARHDTEMP@("BEG"," "," ")=""
         F ARHDINDX=1:1:26 D
         . S ARHDCHAR=$C(ARHDINDX+64)
         . F ARHDRANG="AE","FJ","KO","PT","UZ" D
         .. S ARHDTAG=ARHDCHAR_$E(ARHDRANG,1)_" - "_ARHDCHAR_$E(ARHDRANG,2)
         .. S @ARHDTEMP@("BEG",ARHDTAG,$TR(ARHDTAG," "))=""
         .. Q
         . Q
         I $D(ARHDATTR("name"))#2'>0 S ARHDATTR("name")="cbxAlphabet"
         D SELECT(ARHDROOT,.ARHDATTR,ARHDSLCT,ARHDTEMP)
         K @ARHDTEMP
         Q
         ;
ALPHASCR(ARHDVALU,ARHDALPH) --
          ;
         ; *** Alphabetic look-up screen
         ; Input
         ;  ARHDVALU = Value to be screened (Req)
         ;  ARHDALPH = Alphebetic range (AA-AM) (Req)
         ; Output
         ;  $$ALPHASCR() = Pass(1) or Fail(0)
         N ARHDBEG,ARHDEND,ARHDOKAY
         S ARHDOKAY=0
         S ARHDBEG=$P(ARHDALPH,"-",1)
         S ARHDEND=$P(ARHDALPH,"-",2)
         I $E(ARHDVALU,1,$L(ARHDBEG))=ARHDBEG S ARHDOKAY=1
         I $E(ARHDVALU,1,$L(ARHDEND))=ARHDEND S ARHDOKAY=1
         I (ARHDVALU]]ARHDBEG)&(ARHDVALU']]ARHDEND) S ARHDOKAY=1
         Q ARHDOKAY
         ;
SELECT(ARHDROOT,ARHDATTR,ARHD0,ARHDLIST,ARHDAPI,ARHDFILE,ARHDIENS,ARHDFLDS,ARHDFLAG,ARHDNUMB,ARHDFROM,ARHDVALU,ARHDXREF,ARHDSCRN,ARH
DIDEN)   ;
         ; *** Make <select> tag
         ; Input
         ;  ARHDROOT = Msg array (Req)
         ;  ARHDATTR = Select tag attributes (Opt)
         ;  ARHD0 = IEN of entry that should be selected (Opt)
         ;  ARHDLIST = List of options to add (Opt)
         ;  ARHDAPI = FIND or LIST the FM API to call 
         ;  Other args are same as for FIND^DIC and LIST^DIC
         ; Output
         ;  ARHDROOT(1..N) = A <select> ... </select> tag
         N ARHDDATA,ARHDIEN,ARHDIFN,ARHDINDX,ARHDLINE,ARHDRECS,ARHDSLCT,ARHDTARG
         S ARHDROOT=$$GETROOT^R1UTCSPX(.ARHDROOT,0)
         S ARHD0=$G(ARHD0),(ARHDIFN,ARHDSLCT)=0
         D SET^R1UTCSPX(ARHDROOT,"<select"_$$ATTRIB(.ARHDATTR)_">")
         D SELLIST(ARHDROOT,ARHDLIST,ARHD0,"BEG",$G(ARHDFILE),.ARHDSLCT)
         I $G(ARHDFILE)>0 D
         . S ARHDLINE=$TR($J("",20)," ","-")
         . I $P(ARHDFLDS,";",1)'="@" S ARHDFLDS="@;"_ARHDFLDS
         . D CLEAN^DILF ;DBIA:2054
         . S ARHDTARG=$$GETROOT^R1UTCSPX($NA(^TMP($T(+0)_"-DILIST",$$UNIQUE^R1UTCSPZ)),1)
         . I $$UP^XLFSTR($G(ARHDAPI))="LIST" D  ;DBIA:10104
         .. D LIST^DIC($G(ARHDFILE),$G(ARHDIENS),$G(ARHDFLDS),$G(ARHDFLAG),$G(ARHDNUMB),$G(ARHDFROM),$G(ARHDVALU),$G(ARHDXREF),$G(AR
          HDSCRN),$G(ARHDIDEN),ARHDTARG) ;DBIA:2051
         .. Q
         . I $$UP^XLFSTR($G(ARHDAPI))="FIND" D  ;DBIA:10104
         .. D FIND^DIC($G(ARHDFILE),$G(ARHDIENS),$G(ARHDFLDS),$G(ARHDFLAG),$G(ARHDVALU),$G(ARHDNUMB),$G(ARHDXREF),$G(ARHDSCRN),$G(AR
          HDIDEN),ARHDTARG) ;DBIA:2051
         .. Q
         . S ARHDRECS=$G(@ARHDTARG@("DILIST",0))
         . I ARHDRECS>0,ARHDLIST]"",$D(@ARHDLIST@("BEG"))>1 D OPTION(ARHDROOT,"",ARHDLINE,0,.ARHDSLCT)
         . S ARHDINDX=0
         . F  S ARHDINDX=$O(@ARHDTARG@("DILIST",ARHDINDX)) Q:ARHDINDX'>0  D
         .. S ARHDDATA=$G(@ARHDTARG@("DILIST",ARHDINDX,0)) Q:ARHDDATA=""
         .. S ARHDIEN=$P(ARHDDATA,U,1)
         .. I ARHDIFN'>0 S ARHDIFN=ARHDIEN
         .. S ARHDOPTN=$TR($P(ARHDDATA,U,2,$L(ARHDDATA,U)),U," ")
         .. D OPTION(ARHDROOT,ARHDIEN,ARHDOPTN,ARHD0,.ARHDSLCT)
         .. Q
         . I ARHDRECS>0,ARHDLIST]"",$D(@ARHDLIST@("END"))>1 D OPTION(ARHDROOT,"",ARHDLINE,0,.ARHDSLCT)
         . K @ARHDTARG
         . Q
         D SET^R1UTCSPX(ARHDROOT,"</select>")
         D SELLIST(ARHDROOT,ARHDLIST,ARHD0,"END",$G(ARHDFILE),.ARHDSLCT)
         I (ARHDIFN>0)&((ARHD0'>0)!($$FIND1^DIC($G(ARHDFILE),"","X","`"_ARHD0)'>0)) S ARHD0=ARHDIFN ;DBIA:2051
         Q
         ;
SELLIST(ARHDROOT,ARHDLIST,ARHD0,ARHDLOC,ARHDFILE,ARHDSLCT) --
          ;
         ; *** Add <option> tags
         N ARHDOPTN,ARHDTAG,ARHDVALU
         I ARHDLIST]"" D
         . I $D(@ARHDLIST@(ARHDLOC," "," "))#2 D
         .. D OPTION(ARHDROOT," ",$$NBSP(1),ARHD0,.ARHDSLCT)
         .. K @ARHDLIST@(ARHDLOC," "," ")
         .. Q
         . S ARHDOPTN=""
         . F  S ARHDOPTN=$O(@ARHDLIST@(ARHDLOC,ARHDOPTN)) Q:ARHDOPTN=""  D
         .. S ARHDVALU=""
         .. F  S ARHDVALU=$O(@ARHDLIST@(ARHDLOC,ARHDOPTN,ARHDVALU)) Q:ARHDVALU=""  D
         ... D OPTION(ARHDROOT,ARHDVALU,ARHDOPTN,ARHD0,.ARHDSLCT)
         ... Q
         .. Q
         . Q
         Q
         ;
OPTION(ARHDROOT,ARHDVALU,ARHDOPTN,ARHDVALS,ARHDSLCT) --
          ;
         ; *** Make <option> tag
         N ARHDTAG
         I ARHDVALU'?1"&"1(1.A,1"#"1.N)1";" S ARHDVALU=$$ESCAPE^R1UTCSPZ(ARHDVALU)
         I ARHDOPTN'?1"&"1(1.A,1"#"1.N)1";" S ARHDOPTN=$$ESCAPE^R1UTCSPZ(ARHDOPTN)
         S ARHDTAG="<option value="""_ARHDVALU_""""
         I (ARHDSLCT'>0)&(ARHDVALU=ARHDVALS) S ARHDTAG=ARHDTAG_" selected=""selected""",ARHDSLCT=1
         S ARHDTAG=ARHDTAG_">"_ARHDOPTN_"</option>"
         D SET^R1UTCSPX(ARHDROOT,ARHDTAG)
         Q
         ;
ATTRIB(ARHDATTR) --
          ;
         ; *** Build attribute list
         ; Input
         ;  ARHDATTR = Attr array, ARRAY("AttrName")="AttrValue" (Req)
         ; Output
         ;  $$ATTRIB() = Attribute string
         N ARHDATR,ARHDDATA
         S (ARHDATR,ARHDDATA)=""
         F  S ARHDATR=$O(ARHDATTR(ARHDATR)) Q:ARHDATR=""  D
         . S ARHDDATA=ARHDDATA_" "_$$LOW^XLFSTR(ARHDATR)_"="""_$G(ARHDATTR(ARHDATR))_"""" ;DBIA:10104
         . Q
         Q ARHDDATA
         ;
METATAGS(ARHDROOT,ARHDURL,ARHDTIME) --
          ;
         ; *** Meta tags (timeout, caching)
         ; Input
         ;  ARHDROOT = Msg array (Req)
         ;  ARHDURL = Timeout redirect URL (Opt)
         ;  ARHDTIME = Page timeout seconds (Opt)
         ; Output
         ;  None
         N ARHD0DUZ
         S ARHDROOT=$$GETROOT^R1UTCSPX(.ARHDROOT,0)
         S ARHDURL=$S($G(ARHDURL)]"":ARHDURL,1:$$LOGOURL^R1UTCSP2)
         S ARHD0DUZ=$S($G(DUZ)>0:DUZ,1:+$$GETSES^R1UTCSPZ("DUZ"))
         S ARHDTIME=$S($G(ARHDTIME)\1>0:ARHDTIME\1,1:$$DTIME^XUP(ARHD0DUZ))+5 ;DBIA:4409
         D SET^R1UTCSPX(ARHDROOT,"<meta http-equiv=""refresh"" content="""_ARHDTIME_";url="_ARHDURL_""" />")
         D SET^R1UTCSPX(ARHDROOT,"<meta http-equiv=""pragma"" content=""no-cache"" />")
         D SET^R1UTCSPX(ARHDROOT,"<meta http-equiv=""expires"" content=""-1"" />")
         D SET^R1UTCSPX(ARHDROOT,"<meta http-equiv=""cache-control"" content=""no-store, no-cache, must-revalidate, max-age=0"" />")
         Q
         ;
PREHTTP() ;
         ; *** OnPreHTTP code to prevent caching
         ; Input
         ;  None
         ; Output
         ;  $$PREHTTP() = 1
         N ARHDOKAY
         S ARHDOKAY=1
         D TIMESES^R1UTCSPZ(0,0)
         D EXPRRES^R1UTCSPZ(0)
         D SETHDRES^R1UTCSPZ("pragma","no-cache")
         D SETHDRES^R1UTCSPZ("expires","-1")
         D SETHDRES^R1UTCSPZ("cache-control","no-store, no-cache, must-revalidate, max-age=0")
         Q ARHDOKAY
         ;
NBSP(ARHDCNT) --
          ;
         ; *** Create a string of nonbreaking spaces
         ; Input
         ;  ARHDCNT = Number nonbreaking spaces to return (Opt)
         ; Output
         ;  $$NBSP() = A string of nonbreaking spaces
         Q $$REPEAT^XLFSTR("&nbsp;",$G(ARHDCNT)) ;DBIA:10104
         ;
HITCOUNT(ARHDPARM) --
          ;
         ; *** Page hit counter
         ; Input
         ;  ARHDPARM = Parameter that store page hit count (Req)
         ; Output
         ;  None
         N ARHDDATE,ARHDVALU
         I $$GETSES^R1UTCSPZ(ARHDPARM)'>0 D
         . D SETSES^R1UTCSPZ(ARHDPARM,1)
         . S ARHDDATE=$$DT^XLFDT
         . S ARHDVALU=$$GET^XPAR("SYS",ARHDPARM,ARHDDATE)+1
         . D EN^XPAR("SYS",ARHDPARM,ARHDDATE,ARHDVALU)
         . Q
         Q
         ;
PAGEHITS(ARHDPARM,ARHDTBEG,ARHDTEND) --
          ;
         ; *** Count of page hits over date range
         ; Input
         ;  ARHDPARM = Parameter that store page hit count (Req)
         ;  ARHDTBEG = Start date (Opt, Dflt: 0)
         ;  ARHDTEND = End date (Opt, Dflt: Today)
         ; Output
         ;  $$PAGEHITS() = Cumulative number hits over date range
         N ARHDDATE,ARHDHITS,ARHDLIST
         S ARHDTBEG=$S($G(ARHDTBEG)\1>0:ARHDTBEG\1,1:0)
         S ARHDTEND=$S($G(ARHDTEND)\1>0:ARHDTEND\1,1:$$DT^XLFDT)
         S ARHDLIST=$NA(^TMP($T(+0)_"-HITCNT",$$UNIQUE^R1UTCSPZ))
         K @ARHDLIST
         D GETLST^XPAR(.ARHDLIST,"SYS",ARHDPARM,"I","",1)
         S ARHDHITS=0
         S ARHDDATE=ARHDTBEG-.0000001
         F  S ARHDDATE=$O(@ARHDLIST@(ARHDDATE)) Q:(ARHDDATE'>0)!(ARHDDATE>(ARHDTEND+.24))  D
         . S ARHDHITS=ARHDHITS+$G(@ARHDLIST@(ARHDDATE))
         . Q
         K @ARHDLIST
         Q ARHDHITS
