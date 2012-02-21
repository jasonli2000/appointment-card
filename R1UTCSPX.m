R1UTCSPX ;SFVAMC/DAD-Cache Server Pages (Misc Utility)
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
DISPLAY(ARHDROOT) --
          ;
         ; *** Show msg
         ; Input
         ;  ARHDROOT = Msg array (Req)
         ; Output
         ;  None
         N ARHDINDX
         S ARHDROOT=$$GETROOT($G(ARHDROOT),0)
         S ARHDINDX=0
         F  S ARHDINDX=$O(@ARHDROOT@(ARHDINDX)) Q:ARHDINDX'>0  D
         . W $G(@ARHDROOT@(ARHDINDX)),!
         . Q
         K @ARHDROOT
         Q
         ;
POPUP(ARHDROOT,ARHDFUNC) --
          ;
         ; *** Show popup msg
         ; Input
         ;  ARHDROOT = Msg array (Req)
         ;  ARHDFUNC = Boolean create script/func (Opt)
         ; Output
         ;  None
         N ARHDDATA,ARHDINDX,ARHDTEMP
         S ARHDROOT=$$GETROOT($G(ARHDROOT),0)
         I $D(@ARHDROOT)>0 D
         . S ARHDTEMP=$$GETROOT($NA(^TMP($T(+0)_"-TEMP",$$UNIQUE^R1UTCSPZ)),1)
         . M @("@ARHDTEMP=@ARHDROOT")
         . K @ARHDROOT
         . D SET(ARHDROOT,"<script type=""text/javascript"">")
         . I $G(ARHDFUNC) D SET(ARHDROOT,"function PopUp() {")
         . D SET(ARHDROOT,"alert(")
         . S ARHDINDX=0
         . F  S ARHDINDX=$O(@ARHDTEMP@(ARHDINDX)) Q:ARHDINDX'>0  D
         .. S ARHDDATA=$G(@ARHDTEMP@(ARHDINDX))
         .. I ARHDDATA]"" D
         ... S ARHDDATA=$$UNESCAPE^R1UTCSPZ(ARHDDATA)
         ... S ARHDDATA=$$QUOTEJS^R1UTCSPZ(ARHDDATA)
         ... I $O(@ARHDTEMP@(ARHDINDX))>0 S ARHDDATA=ARHDDATA_" + '\n' + "
         ... D SET(ARHDROOT,ARHDDATA)
         ... Q
         .. Q
         . D SET(ARHDROOT,");")
         . I $G(ARHDFUNC) D SET(ARHDROOT,"return(true); }")
         . D SET(ARHDROOT,"</script>")
         . K @ARHDTEMP
         . Q
         Q
         ;
POPBACK(ARHDROOT) --
          ;
         ; *** Show popup msg & go back a page
         ; Input
         ;  ARHDROOT = Msg array (Req)
         ; Output
         ;  None
         D POPUP(ARHDROOT)
         D GOBAKFOR(ARHDROOT,0)
         Q
         ;
GOBAKFOR(ARHDROOT,ARHDDIR,ARHDFUNC) --
          ;
         ; *** Go backward/forward a page
         ; Input
         ;  ARHDROOT = Msg array (Req)
         ;  ARHDDIR = Direction: 0=Backward, 1=Forward (Opt)
         ;  ARHDFUNC = Boolean create script/func (Opt)
         ; Output
         ;  None
         S ARHDROOT=$$GETROOT($G(ARHDROOT),0)
         D SET(ARHDROOT,"<script type=""text/javascript"">")
         I $G(ARHDFUNC) D SET(ARHDROOT,"function GoBakFor() {")
         D SET(ARHDROOT,"window.history."_$S($G(ARHDDIR):"forward",1:"back")_"();")
         I $G(ARHDFUNC) D SET(ARHDROOT,"return(true); }")
         D SET(ARHDROOT,"</script>")
         Q
         ;
GOURL(ARHDROOT,ARHDURL,ARHDTKN,ARHDFUNC) --
          ;
         ; *** Go to URL
         ; Input
         ;  ARHDROOT = Msg array (Req)
         ;  ARHDURL = Redirect URL (Req)
         ;  ARHDTKN = Append CSPToken to URL (Opt)
         ;  ARHDFUNC = Boolean create script/func (Opt)
         ; Output
         ;  None
         S ARHDROOT=$$GETROOT($G(ARHDROOT),0)
         S ARHDURL=$S($G(ARHDTKN):$$ENCODURL^R1UTCSPZ(ARHDURL),1:ARHDURL)
         D SET(ARHDROOT,"<script type=""text/javascript"">")
         I $G(ARHDFUNC) D SET(ARHDROOT,"function GoURL() {")
         D SET(ARHDROOT,$$JSREDIR(ARHDURL,$G(ARHDTKN)))
         I $G(ARHDFUNC) D SET(ARHDROOT,"return(true); }")
         D SET(ARHDROOT,"</script>")
         Q
         ;
JSREDIR(ARHDURL,ARHDTKN,ARHDMET) --
          ;
         ; *** JavaScript URL redirect
         ; Input
         ;  ARHDURL = Redirect URL (Req)
         ;  ARHDTKN = Add CSPToken (Opt)
         ;  ARHDMET = Method A[ssign] or [re]L[oad] or R[eplace] (Dflt)
         ; Output
         ;  JavaScript redirect line
         S ARHDURL=$S(''$G(ARHDTKN):$$ENCODURL^R1UTCSPZ(ARHDURL),1:ARHDURL)
         S ARHDMET=$G(ARHDMET)
         S ARHDMET=$S(ARHDMET="A":"assign",ARHDMET="L":"reload",1:"replace")
         S ARHDMET=ARHDMET_"("_$S(ARHDMET'="reload":"'"_ARHDURL_"'",1:"")_")"
         Q "window.location."_ARHDMET
         ;
SETFOCUS(ARHDROOT,ARHDFORM) --
          ;
         ; *** Set focus script
         ; Input
         ;  ARHDROOT = Msg array (Req)
         ;  ARHDFORM = Form name (Opt)
         ; Output
         ;  None
         S ARHDROOT=$$GETROOT($G(ARHDROOT),0)
         S ARHDFORM=$S($G(ARHDFORM)]"":"'"_ARHDFORM_"'",1:0)
         D SET(ARHDROOT,"<script type=""text/javascript"">")
         D SET(ARHDROOT,"function SetFocus() {")
         D SET(ARHDROOT,"if (document.forms.length > 0) {")
         D SET(ARHDROOT,"var types = '^button^checkbox^password^radio^reset^select-one^submit^text^textarea^';")
         D SET(ARHDROOT,"var field = document.forms["_ARHDFORM_"];")
         D SET(ARHDROOT,"for (var i = 0; i < field.length; i++) {")
         D SET(ARHDROOT,"var type = '^' + field.elements[i].type.toString().toLowerCase() + '^';")
         D SET(ARHDROOT,"if (types.indexOf(type) != -1) {")
         D SET(ARHDROOT,"document.forms["_ARHDFORM_"].elements[i].focus();")
         D SET(ARHDROOT,"break; } } }")
         D SET(ARHDROOT,"return(true); }")
         D SET(ARHDROOT,"</script>")
         Q
         ;
DUZ2SES(ARHDDUZ) --
          ;
         ; *** Set DUZ into session
         ; Input
         ;  ARHDDUZ = A DUZ array
         ; Output
         ;  None
         N ARHDINDX,ARHDSUB
         D SESKDUZ
         I $D(ARHDDUZ)#2 D SETSES^R1UTCSPZ("DUZ",ARHDDUZ)
         F ARHDINDX=0,1,2,"AG","AUTO","BUF","LANG","NEWCODE","SAV" D
         . I $D(ARHDDUZ(ARHDINDX))#2 D
         .. S ARHDSUB=$S(ARHDINDX'=+ARHDINDX:""""_ARHDINDX_"""",1:ARHDINDX)
         .. D SETSES^R1UTCSPZ("DUZ("_ARHDSUB_")",ARHDDUZ(ARHDINDX))
         .. Q
         . Q
         Q
         ;
SES2DUZ  ; *** Set DUZ from session
         ; Input
         ;  None
         ; Output
         ;  None
         D SETDUZ^R1UTCSPZ
         Q
         ;
SESKDUZ  ; *** Kill DUZ session
         ; Input
         ;  None
         ; Output
         ;  None
         N ARHDINDX,ARHDSUB
         D KILLSES^R1UTCSPZ("DUZ")
         F ARHDINDX=0,1,2,"AG","AUTO","BUF","LANG","NEWCODE","SAV" D
         . S ARHDSUB=$S(ARHDINDX'=+ARHDINDX:""""_ARHDINDX_"""",1:ARHDINDX)
         . D KILLSES^R1UTCSPZ("DUZ("_ARHDSUB_")")
         . Q
         Q
         ;
SES2XQY  ; *** Set XQY* from session
         ; Input
         ;  None
         ; Output
         ;  None
         N ARHDINDX
         K XQY,XQY0
         F ARHDINDX="XQY","XQY0" I $$DATASES^R1UTCSPZ(ARHDINDX)#2 D
         . S @(ARHDINDX_"=$$GETSES^R1UTCSPZ(ARHDINDX)")
         . Q
         Q
         ;
XQY2SES(ARHDOPT) --
          ;
         ; *** Set XQY* into session
         ; Input
         ;  ARHDOPT = An option name
         ; Output
         ;  None
         I $G(ARHDOPT)]"" D
         . D SESKXQY
         . D SETSES^R1UTCSPZ("XQY",$$OPTLK^XQCS(ARHDOPT)) ;DBIA:2124
         . D SETSES^R1UTCSPZ("XQY0",ARHDOPT)
         . Q
         Q
         ;
SESKXQY  ; *** Kill DUZ session
         ; Input
         ;  None
         ; Output
         ;  None
         N ARHDINDX
         F ARHDINDX="XQY","XQY0" D KILLSES^R1UTCSPZ(ARHDINDX)
         Q
         ;
SES2OTH  ; *** Set other variables from session
         ; Input
         ;  None
         ; Output
         ;  None
         D SETOTH^R1UTCSPZ
         Q
         ;
OTH2SES  ; *** Set other variables into session
         ; Input
         ;  None
         ; Output
         ;  None
         N ARHDDUZ
         S ARHDDUZ=$$GETSES^R1UTCSPZ("DUZ")
         D SESKOTH
         D SETSES^R1UTCSPZ("DISYS",$P($G(^%ZOSF("OS")),U,2)) ;DBIA:10096
         D SETSES^R1UTCSPZ("DT",$$DT^XLFDT) ;DBIA:10103
         D SETSES^R1UTCSPZ("DTIME",$$DTIME^XUP($G(ARHD0DUZ))) ;DBIA:4409
         Q
         ;
SESKOTH  ; *** Kill other session variables
         ; Input
         ;  None
         ; Output
         ;  None
         N ARHDINDX
         F ARHDINDX="DISYS","DT","DTIME" D
         . D KILLSES^R1UTCSPZ(ARHDINDX)
         . Q
         Q
         ;
SET(ARHDROOT,ARHDDATA,ARHDINDX,ARHDESCP) --
          ;
         ; *** Set data into return array
         ; Input
         ;  ARHDROOT = Msg array (Req)
         ;  ARHDDATA = Data to add (Opt)
         ;  ARHDINDX = Subscript to store data at (Opt)
         ;  ARHDESCP = Boolean HTML escape data (Opt)
         ; Output
         ;  None
         S ARHDINDX=$S($G(ARHDINDX)]"":ARHDINDX,1:1+$O(@ARHDROOT@(1E25),-1))
         S ARHDDATA=$S($G(ARHDESCP):$$ESCAPE^R1UTCSPZ($G(ARHDDATA)),1:$G(ARHDDATA))
         S @ARHDROOT@(ARHDINDX)=ARHDDATA
         Q
         ;
SETUP(ARHDTIME,ARHDEVNT) --
          ;
         ; *** Setup basic vars
         ; Input
         ;  ARHDTIME = Timeout in seconds (Opt)
         ;  ARHDEVNT = Application event class (Opt)
         ; Output
         ;  None
         N DIQUIET
         I $$XYENABLE^R1UTCSPZ(0)
         S DIQUIET=1
         D DT^DICRW ;DBIA:10005
         D SES2DUZ
         D SES2XQY
         D OTH2SES,SES2OTH
         D DT^DICRW ;DBIA:10005
         D TIMESES^R1UTCSPZ($G(ARHDTIME),DUZ)
         D EXPRRES^R1UTCSPZ()
         D EVENTSES^R1UTCSPZ($G(ARHDEVNT))
         Q
         ;
GETROOT(ARHDROOT,ARHDKILL) --
          ;
         ; *** Setup return array
         ; Input
         ;  ARHDROOT = Closed array reference (Opt)
         ;  ARHDKILL = Boolean kill @ARHDROOT (Opt)
         ; Output
         ;  $$GETROOT() = Closed array reference
         S ARHDROOT=$S($G(ARHDROOT)]"":ARHDROOT,1:$NA(^TMP($T(+0),$$UNIQUE^R1UTCSPZ)))
         I $G(ARHDKILL)>0 K @ARHDROOT
         Q ARHDROOT
