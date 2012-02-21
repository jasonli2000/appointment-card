R1ACNWKX ;VISN21/NLS/ - Display Individual Templates for Selected Boiler Plate
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         I $$GETREQ^R1UTCSPZ("cbxBP")]"" D
         .;W # ;SFVAMC/DAD/3-31-2011/Add form feed (W #) to reset $X and $Y
         .N CBXBP,CLIN,DA,DACLN S (CBXBP,CLIN,DA,DACLN)=""
         .S CBXBP="",CBXBP=$$GETREQ^R1UTCSPZ("cbxBP",1) I $G(CBXBP)>0 S DA="",DA=CBXBP
         .I $G(XXX(1))]"" S DA=$P(XXX(1),"value=",2) I $G(XXX(1))]"" S DA=$P(DA," />"),DA=$P(DA,"""",2),DA=$P(DA,"""") K XXX
         .W "</br>"
         .;W "<label for=""text"">Selected Boiler Plate is Attached to These Clinic(s):</label><br />"
         .;W "<TEXTAREA align=""center"" name=""BBC"" rows=""9"" cols=""52"" style=""color: #000000>"
         .; background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""8"">"
         .;N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT
         .;S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT)=""
         .;S R1ACCNT=0
         .S DACLN=0
         .F  S DACLN=$O(^DIZ(612418,"C",DA,DACLN)) Q:'DACLN  S CLIN="" D
         ..S CLIN=$P($G(^SC(DACLN,0)),U) W ! ;,CLIN
         ..Q
         .;W "</TEXTAREA><br><br><br>"
         .;END OF CLINIC DISPLAY
         .W "<label for=""text"">Please Call Us for an Appointment - [PC Type# 1]</label><br />"
         .W "<TEXTAREA align=""center"" name=""BB1"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""8"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,DIWP,NODE,R1ACQ,WP
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,DIWP,NODE,R1ACQ,WP)=""
         .S R1ACCNT=0,R1ACFLD=4,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Compensation & Pension - [PC Type# 2]</label><br />"
         .W "<TEXTAREA align=""center"" name=""BB2"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""9"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP)=""
         .S R1ACCNT=0,R1ACFLD=9,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Appointment + Bring ??? - [PC Type# 3]</label><br />"
         .W "<TEXTAREA align=""center"" name=""BB3"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""10"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP)=""
         .S R1ACCNT=0,R1ACFLD=10,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Appointment Coming up - [PC Type# 4]</label><br />"
         .W "<TEXTAREA align=""center"" name=""BB4"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""11"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP)=""
         .S R1ACCNT=0,R1ACFLD=11,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Phone Consultation - [PC Type# 5]</label><br />"
         .W "<TEXTAREA align=""center"" name=""BB5"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""12"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,DIWP,NODE,R1ACQ,WP)=""
         .S R1ACCNT=0,R1ACFLD=12,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Means Test Annual - 60-30 day letter - [PC Type# 6]</label><br />"
         .W "<TEXTAREA align=""center"" name=""BB6"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""13"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP)=""
         .S R1ACCNT=0,R1ACFLD=13,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Means Test - 0 day letter - [PC Type# 7]</label><br />"
         .W "<TEXTAREA align=""center"" name=""BB7"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""14"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP)=""
         .S R1ACCNT=0,R1ACFLD=18,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Mobile Services Appointment - [PC Type# 8]</label><br />"
         .W "<TEXTAREA align=""center"" name=""BB8"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""15"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,DIWP,NODE,R1ACQ,WP)=""
         .S R1ACCNT=0,R1ACFLD=15,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Appointment Location Changed - Alert - [PC Type# 9]</label><br />"
         .W "<TEXTAREA align=""center"" name=""BB9"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""16"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,DIWP,NODE,R1ACQ,WP)=""
         .S R1ACCNT=0,R1ACFLD=16,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">No Show - Please Call Us - [PC Type# 10]</label><br />"
         .W "<TEXTAREA align=""center"" name=""BB10"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""17"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,DIWP,NODE,R1ACQ,WP)=""
         .S R1ACCNT=0,R1ACFLD=17,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .D ^R1ACNX2
          Q
