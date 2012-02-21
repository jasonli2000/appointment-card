R1UTCSP  ;SFVAMC/DAD-Cache Server Pages (Simple Log in/out)
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
LOGIN(ARHDURL,ARHDOPT) --
          ;
         ; *** Cache Server Page Full Login
         ; Input
         ;  ARHDURL = URL to go to after login (Req)
         ;  ARHDOPT = Context option (Opt)
         ; Output
         ;  Sets %session.Data("DUZ*") = The user's DUZ array
         N ARHDACC,ARHDCHG,ARHDCTX,ARHDCVC,ARHDDIV,ARHDLOG
         N ARHDROOT,ARHDVER,ARHDVER0,ARHDVER1,ARHDVER2
         D SETUP^R1UTCSPX()
         S ARHDLOG=$$GETSES^R1UTCSPZ("ARHDLOG")
         I ARHDLOG'>0 D
         . S ARHDLOG=$$LOGIN^R1UTCSP0(.ARHDACC,.ARHDVER,"",.ARHDROOT)
         . I ARHDLOG<0 D DISPLAY^R1UTCSPX(ARHDROOT)
         . I ARHDLOG=0 D POPBACK^R1UTCSPX(ARHDROOT),DISPLAY^R1UTCSPX(ARHDROOT)
         . I ARHDLOG="" D LOGOUT(ARHDROOT)
         . Q
         I ARHDLOG>0 D
         . S ARHDCVC=$$GETSES^R1UTCSPZ("ARHDCVC")
         . I ARHDCVC'>0 D
         .. S ARHDCHG=$$GETSES^R1UTCSPZ("ARHDCHG")
         .. S ARHDCVC=$$CHVERIFY^R1UTCSP3(.ARHDVER0,.ARHDVER1,.ARHDVER2,ARHDCHG,"",.ARHDROOT)
         .. I ARHDCVC<0 D DISPLAY^R1UTCSPX(ARHDROOT)
         .. I ARHDCVC=0 D POPBACK^R1UTCSPX(ARHDROOT),DISPLAY^R1UTCSPX(ARHDROOT)
         .. I ARHDCVC="" D LOGOUT(ARHDROOT)
         .. Q
         . I ARHDCVC>0 D
         .. S ARHDDIV=$$GETSES^R1UTCSPZ("ARHDDIV")
         .. I "^0^1^"'[(U_ARHDDIV_U) D
         ... S ARHDDIV=$$DIVISION^R1UTCSP1(.ARHD0DIV,"",.ARHDROOT)
         ... I ARHDDIV<0 D DISPLAY^R1UTCSPX(ARHDROOT)
         ... I ARHDDIV="" D LOGOUT(ARHDROOT)
         ... Q
         .. I "^0^1^"[(U_ARHDDIV_U) D
         ... S ARHDCTX=$$GETSES^R1UTCSPZ("ARHDCTX")
         ... I ARHDCTX'=1 D
         .... S ARHDCTX=$$CONTEXT^R1UTCSP4(ARHDOPT,.ARHDROOT)
         .... I ARHDCTX=0 D LOGOUT(ARHDROOT)
         .... Q
         ... I ARHDCTX=1 D
         .... D CLEANUP
         .... D GOURL^R1UTCSPX(ARHDROOT,ARHDURL,1)
         .... D DISPLAY^R1UTCSPX(ARHDROOT)
         .... Q
         ... Q
         .. Q
         . Q
         Q
         ;
LOGOUT(ARHDROOT) --
          ;
         ; *** Notify, Redirect, Logout
         ; Input
         ;  ARHDROOT = Closed array reference for messages (Req)
         ; Output
         ;  None
         D CLEANUP
         D POPUP^R1UTCSPX(ARHDROOT)
         D GOURL^R1UTCSPX(ARHDROOT,$$LOGOURL^R1UTCSP2)
         D DISPLAY^R1UTCSPX(ARHDROOT)
         D LOGOUT^R1UTCSP2
         Q
         ;
CLEANUP  ; *** Cleanup login variables
         ; Input
         ;  None
         ; Output
         ;  None
         N ARHDNAME
         K ARHDACC,ARHDVER,ARHDVER0,ARHDVER1,ARHDVER2,AV
         F ARHDNAME="ARHDLOG","ARHDCHG","ARHDCVC","ARHDDIV","ARHDCTX" D
         . D KILLSES^R1UTCSPZ(ARHDNAME)
         . Q
         Q
         ;
LOGFORM(ARHDROOT,ARHDATTR,ARHDHEAD) --
          ;
         ; *** VistA login form
         ; Input
         ;  ARHDROOT = Closed array reference for messages (Req)
         ;  ARHDATTR = Form attributes (Opt, Pass by ref)
         ;  ARHDHEAD = Header text (Opt)
         ; Output
         ;  None
         N ARHDENV,ARHDINDX,ARHDINTR,ARHDTEMP
         S ARHDTEMP=$$GETROOT^R1UTCSPX($NA(^TMP($T(+0)_"-TEMP",$$UNIQUE^R1UTCSPZ)),1)
         M @("@ARHDTEMP=@ARHDROOT")
         S ARHDROOT=$$GETROOT^R1UTCSPX($G(ARHDROOT),1)
         D SET^R1UTCSPX(ARHDROOT,$$FORMTAG^R1UTCSPY(.ARHDATTR))
         D SET^R1UTCSPX(ARHDROOT,"<table>")
         D SET^R1UTCSPX(ARHDROOT,"<tr><td colspan=""4""><h1>VistA Login</h1></td></tr>")
         I $G(ARHDHEAD)]"" D SET^R1UTCSPX(ARHDROOT,"<tr><td colspan=""4""><h3>"_$$ESCAPE^R1UTCSPZ(ARHDHEAD)_"</h3></td></tr>")
         D SET^R1UTCSPX(ARHDROOT,"<tr><td colspan=""4""><hr /></td></tr>")
         D SET^R1UTCSPX(ARHDROOT,"<tr>")
         D SET^R1UTCSPX(ARHDROOT,"<td colspan=""4""><pre>")
         D INTRO^XUSRB(.ARHDINTR) ;DBIA:4054
         S ARHDINDX=0
         F  S ARHDINDX=$O(ARHDINTR(ARHDINDX)) Q:ARHDINDX'>0  D
         . D SET^R1UTCSPX(ARHDROOT,$G(ARHDINTR(ARHDINDX)),"",1)
         . Q
         D SET^R1UTCSPX(ARHDROOT,"</pre><hr />")
         D SET^R1UTCSPX(ARHDROOT,"</tr>")
         S ARHDINDX=0
         F  S ARHDINDX=$O(@ARHDTEMP@(ARHDINDX)) Q:ARHDINDX'>0  D
         . D SET^R1UTCSPX(ARHDROOT,$G(@ARHDTEMP@(ARHDINDX)))
         . Q
         D SET^R1UTCSPX(ARHDROOT,"<tr><td colspan=""4""><hr /></td></tr>")
         D SET^R1UTCSPX(ARHDROOT,"<tr>")
         D GETENV^%ZOSV S ARHDENV=$G(Y) ;DBIA:10097
         D SET^R1UTCSPX(ARHDROOT,"<td>"_"Server: "_$P(ARHDENV,U,3)_"</td>")
         D SET^R1UTCSPX(ARHDROOT,"<td>"_"Volume: "_$P(ARHDENV,U,2)_"</td>")
         D SET^R1UTCSPX(ARHDROOT,"<td>UCI: "_$P(ARHDENV,U,1)_"</td>")
         D SET^R1UTCSPX(ARHDROOT,"<td>"_"Port: "_$$ESCAPE^R1UTCSPZ($$P^R1UTCSPZ)_"</td>")
         D SET^R1UTCSPX(ARHDROOT,"</tr>")
         D SET^R1UTCSPX(ARHDROOT,"<tr>")
         D SET^R1UTCSPX(ARHDROOT,"<td colspan=""4""><hr /></td>")
         D SET^R1UTCSPX(ARHDROOT,"</tr>")
         D SET^R1UTCSPX(ARHDROOT,"</table>")
         D SET^R1UTCSPX(ARHDROOT,"</form>")
         K @ARHDTEMP
         Q
         ;
EXAMPLE  ; *** Example CSP Login Page
         ;<html>
         ;<head>
         ;<csp:class super="%CSP.Page">
         ;<title>VistA Login</title>
         ;</head>
         ;<body>
         ;<script language="cache" runat="server">
         ; D LOGIN^R1UTCSP("/csp/dir/MyApp.csp","MyOption")
         ;</script>
         ;</body>
         ;</html>
