R1UTCSPW ;SFVAMC/DAD-Cache Server Pages (Misc Utility)
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
GETFMRPT(ARHDROOT) --
          ;
         ; *** Get a VA FileMan report
         ; Input
         ;  ARHDROOT = Closed array reference for the report text
         ;  Set the needed EN1^DIP variables in the calling routine
         ; Output
         ;  $$GETFMRPT() = Success(1) or Failure (0)
         ;  ARHDROOT() = The text of the report
         N ARHDFILE,ARHDINDX,ARHDIO,ARHDOKAY,ARHDPATH,DIFIXPT,DIOSL,POP
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),0)
         S ARHDOKAY=0
         S ARHDIO=$$I^R1UTCSPZ
         S ARHDPATH=$$PWD^%ZISH ;DBIA:2320
         S ARHDFILE="FMReport-"_$$UNIQUE^R1UTCSPZ_".txt"
         D OPEN^%ZISH($$UNIQUE^R1UTCSPZ,ARHDPATH,ARHDFILE,"W") ;DBIA:2320
         I '$G(POP) D
         . U IO
         . S DIFIXPT=1,DIOSL=IOSL D EN1^DIP ;DBIA:10010
         . D CLOSE^%ZISH($$UNIQUE^R1UTCSPZ) ;DBIA:2320
         . S ARHDINDX(0)=$O(@ARHDROOT@(1E25),-1)
         . S ARHDINDX=ARHDINDX(0)+1
         . S ARHDOKAY=''$$FTG^%ZISH(ARHDPATH,ARHDFILE,$NA(@ARHDROOT@(ARHDINDX)),$QL(ARHDROOT)+1) ;DBIA:2320
         . S ARHDFILE(ARHDFILE)=""
         . I $$DEL^%ZISH(ARHDPATH,$NA(ARHDFILE)) ;DBIA:2320
         . S ARHDINDX=ARHDINDX(0)
         . F  S ARHDINDX=$O(@ARHDROOT@(ARHDINDX)) Q:ARHDINDX'>0  D
         .. D SET^R1UTCSPX(ARHDROOT,$G(@ARHDROOT@(ARHDINDX)),ARHDINDX,1)
         .. Q
         . U ARHDIO
         . Q
         Q ARHDOKAY
         ;
         ;
HOURGLAS(ARHDBOOL) --
          ;
         ; *** Javascript hourglass cursor on/off
         ; Input
         ;  ARHDBOOL = Enable(1) / disable(0) hourglass cursor code (Req)
         ; Output
         ;  None
         Q "document.body.style.cursor = '"_$S(''ARHDBOOL:"wait",1:"default")_"';"
         ;
STYLESHT(ARHDROOT) --
          ;
         ; *** Basic style sheet
         ; Input
         ;  ARHDROOT = Closed array reference for the style sheet
         ; Output
         ;  None
         S ARHDROOT=$$GETROOT^R1UTCSPX(.ARHDROOT,0)
         D SET^R1UTCSPX(ARHDROOT,"<style type=""text/css"">")
         D SET^R1UTCSPX(ARHDROOT,"<!--")
         D SET^R1UTCSPX(ARHDROOT,"body {color: #000000; background-color: #f0f8ff}")
         D SET^R1UTCSPX(ARHDROOT,"h1 {text-align: center}")
         D SET^R1UTCSPX(ARHDROOT,"h2 {text-align: center}")
         D SET^R1UTCSPX(ARHDROOT,"h3 {text-align: center}")
         D SET^R1UTCSPX(ARHDROOT,"h4 {text-align: center}")
         D SET^R1UTCSPX(ARHDROOT,"hr {text-align: center; width: 100%;}")
         D SET^R1UTCSPX(ARHDROOT,"input.button {width: 100px;}")
         D SET^R1UTCSPX(ARHDROOT,"table {border-width: 0px}")
         D SET^R1UTCSPX(ARHDROOT,"td {text-align: left; vertical-align: top;}")
         D SET^R1UTCSPX(ARHDROOT,"td.center {text-align: center; vertical-align: top;}")
         D SET^R1UTCSPX(ARHDROOT,"td.bottom {text-align: left; vertical-align: bottom;}")
         D SET^R1UTCSPX(ARHDROOT,"-->")
         D SET^R1UTCSPX(ARHDROOT,"</style>")
         Q
         ;
USEROKAY(ARHD0DUZ,ARHDOPT,ARHDMSG) --
          ;
         ; *** Check user's access to login and the context option
         ; Input
         ;  ARHD0DUZ = Pointer to New Person (Req)
         ;  ARHDOPT = Option name/IEN (Req)
         ;  ARHDMSG = Return array for error messages (Opt)
         ; Output
         ;  $$USEROKAY() = 1-User does have access, 0-User does not have access
         N ARHDFLAG
         K ARHDMSG S ARHDMSG=""
         S ARHDFLAG=$$ACTIVE^XUSER(ARHD0DUZ) ;DBIA:2343
         I ARHDFLAG>0 D
         . S ARHDFLAG=$$OPTION^R1UTCSP4(ARHD0DUZ,ARHDOPT,.ARHDMSG)
         . Q
         E  D
         . S ARHDMSG="User access denied: '"_$P(ARHDFLAG,U,2)_"'."
         . Q
         Q $S(ARHDFLAG>0:1,1:0)
         ;
IMPORT   ;
         ; *** Import CSPs from KIDS to the destination site
         ; Input
         ;  None
         ; Output
         ;  None
         N ARHDFILE,ARHDKIDS,ARHDOKAY,ARHDPATH,ARHDROOT
         I $G(XPDGREF)="" Q
         S ARHDPATH=$$PWD^%ZISH ;DBIA:2320
         S ARHDKIDS=$NA(@XPDGREF@("R1UTCSP"))
         I (ARHDPATH]"")&($O(@ARHDKIDS@(""))]"") D
         . D BMES^XPDUTL("Importing Cache Server Page(s)") ;DBIA:10141
         . D MES^XPDUTL("  Import path: "_ARHDPATH) ;DBIA:10141
         . S ARHDFILE=""
         . F  S ARHDFILE=$O(@ARHDKIDS@(ARHDFILE)) Q:ARHDFILE=""  D
         .. S ARHDROOT=$NA(@ARHDKIDS@(ARHDFILE))
         .. S ARHDOKAY=$$GTF^%ZISH($NA(@ARHDROOT@(1,0)),$QL(ARHDROOT)+1,ARHDPATH,ARHDFILE) ;DBIA:2320
         .. D MES^XPDUTL("  '"_ARHDFILE_"'"_$S(ARHDOKAY>0:"",1:" NOT")_" imported!") ;DBIA:10141
         .. Q
         . D MES^XPDUTL("Done") ;DBIA:10141
         . Q
         Q
         ;
EXPORT(ARHDURL) --
          ;
         ; *** Export CSPs to KIDS from the source site
         ; Input
         ;  ARHDURL = Closed root reference holding the CSP URLs
         ; Output
         ;  None
         N ARHD0,ARHD1,ARHDDATA,ARHDFILE,ARHDINDX
         N ARHDKIDS,ARHDOKAY,ARHDPATH,ARHDROOT
         I $G(XPDGREF)="" Q
         S ARHDROOT=$$GETROOT^R1UTCSPX($NA(^TMP($T(+0)_"-CSP",$$UNIQUE^R1UTCSPZ)),1)
         D BMES^XPDUTL("Exporting Cache Server Page(s)") ;DBIA:10141
         S ARHDINDX=0
         F  S ARHDINDX=$O(@ARHDURL@(ARHDINDX)) Q:ARHDINDX'>0  D
         . S ARHDDATA=$G(@ARHDURL@(ARHDINDX))
         . S ARHDOKAY=0
         . S ARHDPATH=$P(ARHDDATA,"/",1,$L(ARHDDATA,"/")-1)_"/"
         . S ARHDFILE=$P(ARHDDATA,"/",$L(ARHDDATA,"/"))
         . I (ARHDPATH]"")&(ARHDFILE]"") D
         .. K @ARHDROOT
         .. D  ; Protect IO* variables
         ... N IO,IOBS,IOCPU,IOF,IOHG,IOM,ION,IOP,IOPAR,IOS,IOSL,IOST,IOT,IOUPAR,IOXY
         ... S ARHDOKAY=$$FTG^%ZISH($$PHYSPATH^R1UTCSPZ(ARHDPATH),ARHDFILE,$NA(@ARHDROOT@(1)),$QL(ARHDROOT)+1) ;DBIA:2320
         ... Q
         .. I ARHDOKAY>0 D
         ... S ARHDKIDS=$NA(@XPDGREF@("R1UTCSP",ARHDFILE))
         ... S ARHDDATA=""
         ... S ARHD0=0
         ... F  S ARHD0=$O(@ARHDROOT@(ARHD0)) Q:ARHD0'>0  D
         .... S ARHDDATA=ARHDDATA_$G(@ARHDROOT@(ARHD0))
         .... D PARSE(ARHDKIDS,.ARHDDATA)
         .... S ARHD1=0
         .... F  S ARHD1=$O(@ARHDROOT@(ARHD0,"OVF",ARHD1)) Q:ARHD1'>0  D
         ..... S ARHDDATA=ARHDDATA_$G(@ARHDROOT@(ARHD0,"OVF",ARHD1))
         ..... D PARSE(ARHDKIDS,.ARHDDATA)
         ..... Q
         .... Q
         ... I ARHDDATA]"" S ARHDDATA=ARHDDATA_$C(13,10) D PARSE(ARHDKIDS,.ARHDDATA)
         ... Q
         .. K @ARHDROOT
         .. Q
         . D MES^XPDUTL("  '"_ARHDPATH_ARHDFILE_"'"_$S(ARHDOKAY>0:"",1:" NOT")_" exported!") ;DBIA:10141
         . Q
         D MES^XPDUTL("Done") ;DBIA:10141
         Q
         ;
PARSE(ARHDKIDS,ARHDDATA) --
          ;
         ; *** Parse and save the CSP at the sending site
         N ARHDCRLF,ARHDINDX,ARHDTEXT
         S ARHDCRLF=$C(13,10)
         F  Q:ARHDDATA'[ARHDCRLF  D
         . S ARHDTEXT=$P(ARHDDATA,ARHDCRLF,1)
         . S ARHDDATA=$P(ARHDDATA,ARHDCRLF,2,$L(ARHDDATA,ARHDCRLF))
         . S ARHDINDX=1+$O(@ARHDKIDS@(1E25),-1)
         . S @ARHDKIDS@(ARHDINDX,0)=ARHDTEXT
         . Q
         Q
         ;
POPUPERR(ARHDROOT,ARHDURL,ARHDTOKN,ARHDRDR) --
          ;
         ; *** Pop-up an error display and optionally redirect
         ; Input
         ;  ARHDROOT = Closed array reference for the script
         ;  ARHDURL = Redirect URL (Req)
         ;  ARHDTKN = Add CSPToken (Opt)
         ;  ARHDRDR = Redirect to ARHDURL flag (1:Always, 0:Never, -1:If error in list)
         ; Output
         ;  None
         N ARHDCRLF,ARHDENUM,ARHDETXT,ARHDINDX
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),1)
         S ARHDCRLF=" + '\n' +"
         D DECOMPER^R1UTCSPZ(.ARHDETXT)
         D SET^R1UTCSPX(ARHDROOT,"<script type=""text/javascript"">")
         D SET^R1UTCSPX(ARHDROOT,"alert(")
         D SET^R1UTCSPX(ARHDROOT,$$QUOTEJS^R1UTCSPZ("*** Error Alert *** Error Alert *** Error Alert ***")_ARHDCRLF)
         D SET^R1UTCSPX(ARHDROOT,$$QUOTEJS^R1UTCSPZ(" ")_ARHDCRLF)
         F ARHDINDX=1:1:$G(ARHDETXT) D
         . D SET^R1UTCSPX(ARHDROOT,$$QUOTEJS^R1UTCSPZ($G(ARHDETXT(ARHDINDX,"Desc")))_ARHDCRLF)
         . D SET^R1UTCSPX(ARHDROOT,$$QUOTEJS^R1UTCSPZ(" ")_ARHDCRLF)
         . D SET^R1UTCSPX(ARHDROOT,$$QUOTEJS^R1UTCSPZ("  Error: "_$G(ARHDETXT(ARHDINDX,"Error")))_ARHDCRLF)
         . D SET^R1UTCSPX(ARHDROOT,$$QUOTEJS^R1UTCSPZ("  ErrorNo: "_$G(ARHDETXT(ARHDINDX,"ErrorNo")))_ARHDCRLF)
         . D SET^R1UTCSPX(ARHDROOT,$$QUOTEJS^R1UTCSPZ("  CSP Page: "_$G(ARHDETXT(ARHDINDX,"URL")))_ARHDCRLF)
         . D SET^R1UTCSPX(ARHDROOT,$$QUOTEJS^R1UTCSPZ("  Namespace: "_$G(ARHDETXT(ARHDINDX,"Namespace")))_ARHDCRLF)
         . D SET^R1UTCSPX(ARHDROOT,$$QUOTEJS^R1UTCSPZ("  Class: "_$G(ARHDETXT(ARHDINDX,"Class")))_ARHDCRLF)
         . I $G(ARHDETXT(ARHDINDX,"Routine"))]"" D
         .. D SET^R1UTCSPX(ARHDROOT,$$QUOTEJS^R1UTCSPZ("  Routine: "_ARHDETXT(ARHDINDX,"Routine"))_ARHDCRLF)
         .. D SET^R1UTCSPX(ARHDROOT,$$QUOTEJS^R1UTCSPZ("  Location: "_$G(ARHDETXT(ARHDINDX,"Location")))_ARHDCRLF)
         .. I $G(ARHDETXT(ARHDINDX,"Line"))]"" D
         ... D SET^R1UTCSPX(ARHDROOT,$$QUOTEJS^R1UTCSPZ("  Line: "_ARHDETXT(ARHDINDX,"Line"))_ARHDCRLF)
         ... Q
         .. Q
         . D SET^R1UTCSPX(ARHDROOT,"''"_$S(ARHDINDX<ARHDETXT:ARHDCRLF,1:""))
         . Q
         D SET^R1UTCSPX(ARHDROOT,");")
         I $G(ARHDURL)]"" D
         . S ARHDENUM=$$GETREQ^R1UTCSPZ("Error:ErrorNumber")
         . S ARHDRDR=$G(ARHDRDR)
         . ; CacheError(5002) FailedToCreateClass(5908) CSPIllegalRequest(5916) CSPSessionTimeout(5918) InvalidDecrypt(5919)
         . S ARHDRDR=$S((ARHDRDR=-1)&("^5002^5908^5916^5918^5919^"[(U_ARHDENUM_U)):1,ARHDRDR=1:1,1:0)
         . I ARHDRDR>0 D
         .. D SET^R1UTCSPX(ARHDROOT,$$JSREDIR^R1UTCSPX(ARHDURL,$G(ARHDTOKN)))
         .. Q
         . Q
         D SET^R1UTCSPX(ARHDROOT,"</script>")
         Q
         ;
ERRTRAP  ;
