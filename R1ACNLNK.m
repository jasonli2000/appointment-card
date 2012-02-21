R1ACNLNK ;VISN21/NLS/- Bottom Links for Xerox Printing Project
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
SETUP    ;Setup commonly used Variables for Xerox Web Page
         N NAME,DFN,SSN
         D SETDUZ^R1UTCSPZ
         D SETSES^R1UTCSPZ("DTIME",$$DTIME^XUP($G(DUZ))) ;DBIA:4409 - Sets Timeout
         S U="^"
         I $G(DUZ)']"" Q
         S (NAME,DFN,SSN)="" I $G(DUZ)]"" S SSN=$P($G(^VA(200,DUZ,1)),"^",9)
         S NAME=$P(^VA(200,DUZ,0),"^")
         ;SET %session.Data("SSN")=SSN
         ;SET %session.Data("NAME")=NAME
         ;SET %session.Data("DFN")=DFN
         D SETSES^R1UTCSPZ("SSN",SSN)
         D SETSES^R1UTCSPZ("NAME",NAME)
         D SETSES^R1UTCSPZ("DFN",DFN)
         Q
BTM1     ;
         W "<font face='Bold' size='4'>"
         W "SCREEN NAVIGATION:<br/>"
         W "<table border='2' id='table2' cellspacing='0' cellpadding='6' width='767' bordercolor='BLACK'><tr>"
         W "<td height='2' bgcolor='#f0f8ff' style='color: #000000; border-left-style: solid; border-left-width: 1px; font color='BL
          ACK'>"
         W "<border-right-style: solid; border-right-width: 1px; border-top-width: 1px; border-bottom-style: solid; border-bottom-wi
          dth: 1px' colspan='3'>"
         ;
         K ARHDATTR
         N ARHDROOT,ARHDHREF,ARHDATTR,ARHDNAME,ARHDINPT
         S ARHDROOT=$$GETROOT^R1UTCSPX("",1)
         S ARHDATTR("size")="2"
         S ARHDATTR("class")="button"
         S ARHDNAME="",ARHDNAME="DEMOGRAPHICS",ARHDREF="",ARHDHREF="R1ACNWK3.CSP"
         S ARHDATTR("name")="btn"_ARHDNAME
         S ARHDATTR("onclick")="javascript:"_$$JSREDIR^R1UTCSPX(ARHDHREF,1,"A")
         S ARHDATTR("value")="1) Demographics"
         S ARHDINPT=$$INPUTTAG^R1UTCSPY("button",.ARHDATTR)
         D SET^R1UTCSPX(ARHDROOT,"<tr>")
         D SET^R1UTCSPX(ARHDROOT,"<td><p>"_ARHDINPT_"</p></td>")
         D DISPLAY^R1UTCSPX(ARHDROOT)
         ;
         K ARHDATTR
         N ARHDROOT,ARHDHREF,ARHDATTR,ARHDNAME,ARHDINPT
         S ARHDROOT=$$GETROOT^R1UTCSPX("",1)
         S ARHDATTR("class")="button"
         S ARHDNAME="",ARHDNAME="BOILER_PLATES",ARHDREF="",ARHDHREF="R1ACNWK1.CSP"
         S ARHDATTR("name")="btn"_ARHDNAME
         S ARHDATTR("onclick")="javascript:"_$$JSREDIR^R1UTCSPX(ARHDHREF,1,"A")
         S ARHDATTR("value")="2) Boiler Plates"
         S ARHDINPT=$$INPUTTAG^R1UTCSPY("button",.ARHDATTR)
         D SET^R1UTCSPX(ARHDROOT,"<td><p>"_ARHDINPT_"</p></td>")
         D DISPLAY^R1UTCSPX(ARHDROOT)
         ;
         K ARHDATTR
         N ARHDROOT,ARHDHREF,ARHDATTR,ARHDNAME,ARHDINPT
         S ARHDROOT=$$GETROOT^R1UTCSPX("",1)
         S ARHDATTR("class")="button"
         S ARHDNAME="",ARHDNAME="DISPLAY",ARHDREF="",ARHDHREF="R1ACNWK2.CSP"
         S ARHDATTR("name")="btn"_ARHDNAME
         S ARHDATTR("onclick")="javascript:"_$$JSREDIR^R1UTCSPX(ARHDHREF,1,"A")
         S ARHDATTR("value")="3) Display"
         S ARHDINPT=$$INPUTTAG^R1UTCSPY("button",.ARHDATTR)
         D SET^R1UTCSPX(ARHDROOT,"<td><p>"_ARHDINPT_"</p></td>")
         D DISPLAY^R1UTCSPX(ARHDROOT)
         ;
         K ARHDATTR
         N ARHDROOT,ARHDHREF,ARHDATTR,ARHDNAME,ARHDINPT
         S ARHDROOT=$$GETROOT^R1UTCSPX("",1)
         S ARHDATTR("class")="button"
         S ARHDNAME="",ARHDNAME="ClONE",ARHDREF="",ARHDHREF="R1ACNWK5.CSP"
         S ARHDATTR("name")="btn"_ARHDNAME
         S ARHDATTR("onclick")="javascript:"_$$JSREDIR^R1UTCSPX(ARHDHREF,1,"A")
         S ARHDATTR("value")="4) Clone BP"
         S ARHDINPT=$$INPUTTAG^R1UTCSPY("button",.ARHDATTR)
         D SET^R1UTCSPX(ARHDROOT,"<td><p>"_ARHDINPT_"</p></td>")
         D DISPLAY^R1UTCSPX(ARHDROOT)
         ;
         K ARHDATTR
         N ARHDROOT,ARHDHREF,ARHDATTR,ARHDNAME,ARHDINPT
         S ARHDROOT=$$GETROOT^R1UTCSPX("",1)
         S ARHDATTR("class")="button"
         S ARHDNAME="",ARHDNAME="ATTACH",ARHDREF="",ARHDHREF="R1ACNWK4.CSP"
         S ARHDATTR("name")="btn"_ARHDNAME
         S ARHDATTR("onclick")="javascript:"_$$JSREDIR^R1UTCSPX(ARHDHREF,1,"A")
         S ARHDATTR("value")="5) Attach BP"
         S ARHDINPT=$$INPUTTAG^R1UTCSPY("button",.ARHDATTR)
         D SET^R1UTCSPX(ARHDROOT,"<td><p>"_ARHDINPT_"</p></td>")
         D DISPLAY^R1UTCSPX(ARHDROOT)
         ;
         K ARHDATTR
         N ARHDROOT,ARHDHREF,ARHDATTR,ARHDNAME,ARHDINPT
         S ARHDROOT=$$GETROOT^R1UTCSPX("",1)
         S ARHDATTR("class")="button"
         S ARHDNAME="",ARHDNAME="SUBMIT",ARHDREF="",ARHDHREF="R1ACNWK9.CSP"
         S ARHDATTR("name")="btn"_ARHDNAME
         S ARHDATTR("onclick")="javascript:"_$$JSREDIR^R1UTCSPX(ARHDHREF,1,"A")
         S ARHDATTR("value")="6) Over-ride"
         S ARHDINPT=$$INPUTTAG^R1UTCSPY("button",.ARHDATTR)
         D SET^R1UTCSPX(ARHDROOT,"<td><p>"_ARHDINPT_"</p></td>")
         D DISPLAY^R1UTCSPX(ARHDROOT)
         ;
         K ARHDATTR
         N ARHDROOT,ARHDHREF,ARHDATTR,ARHDNAME,ARHDINPT
         S ARHDROOT=$$GETROOT^R1UTCSPX("",1)
         S ARHDATTR("class")="button"
         S ARHDNAME="",ARHDNAME="MAIN",ARHDREF="",ARHDHREF="R1ACNMAIN.CSP"
         S ARHDATTR("name")="btn"_ARHDNAME
         S ARHDATTR("onclick")="javascript:"_$$JSREDIR^R1UTCSPX(ARHDHREF,1,"A")
         S ARHDATTR("value")="7) Main Menu"
         S ARHDINPT=$$INPUTTAG^R1UTCSPY("button",.ARHDATTR)
         D SET^R1UTCSPX(ARHDROOT,"<td><p>"_ARHDINPT_"</p></td>")
         D SET^R1UTCSPX(ARHDROOT,"</tr>")
         D DISPLAY^R1UTCSPX(ARHDROOT)
         Q 
