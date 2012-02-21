R1ACNWKZ ;VISN21/- Display WP data in CSP
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         I $$GETREQ^R1UTCSPZ("cbxClinic")]"" D
         .;W # ;SFVAMC/DAD/3-31-2011/Add form feed (W #) to reset $X and $Y
         .N CBXCLIN,DA
         .S CBXCLIN="",CBXCLIN=$$GETREQ^R1UTCSPZ("cbxClinic",1) I $G(CBXCLIN)>0 S DA="",DA=CBXCLIN
         .I $G(XXX(1))]"" S DA=$P(XXX(1),"value=",2) I $G(XXX(1))]"" S DA=$P(DA," />"),DA=$P(DA,"""",2),DA=$P(DA,"""") K XXX
         .W "</br>"
         .W "<label for=""text"">Please Call Us for an Appointment - [PC Type# 1]</label><br />"
         .I $P($G(^DIZ(612418,DA,0)),U,6)]"" D
         ..W "Please call us at  ",$P($G(^DIZ(612418,DA,0)),U,6)
         ..W "<br>"
         ..W "to make an appointment"
         ..W "<br><br>"
         .W "<TEXTAREA align=""left"" name=""BB1"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""8"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ)=""
         .S R1ACCNT=0,R1ACFLD=4,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP,^DIWW
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .;K WP
         .W "</TEXTAREA><br><br>"
         .W "<label for=""text"">Compensation & Pension - [PC Type# 2]</label><br />"
         .I $P($G(^DIZ(612418,DA,0)),U,5)]"" D
         ..W "Can't make it?"
         ..W "<br>"
         ..W "Please call us"
         ..W "<br>"
         ..W "immediately at "
         ..W $P($G(^DIZ(612418,DA,0)),U,6)
         ..W "<br>"
         ..W "to cancel and reschedule."
         ..W "<br>"
         .W "<TEXTAREA align=""center"" name=""BB2"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""9"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACCNT,NODE,DIWP,R1ACQ)=""
         .S R1ACCNT=0,R1ACFLD=9,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP,^DIWW
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .;K WP
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Appointment + Bring ??? - [PC Type# 3]</label><br />"
         .I $P($G(^DIZ(612418,DA,0)),U,5)]"" D
         ..W "Can't make it?"
         ..W "<br>"
         ..W "Please call"
         ..W "<br>"
         ..W $P($G(^DIZ(612418,DA,0)),U,5)
         ..W " to cancel."
         ..W "<br>"
         .W "<TEXTAREA align=""center"" name=""BB3"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""10"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,NODE,DIWP,R1ACQ)=""
         .S R1ACCNT=0,R1ACFLD=10,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP,^DIWW
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .;K WP
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Appointment Coming up - [PC Type# 4]</label><br />"
         .I $P($G(^DIZ(612418,DA,0)),U,5)]"" D
         ..W "Can't make it?"
         ..W "<br>"
         ..W "Please call"
         ..W "<br>"
         ..W $P($G(^DIZ(612418,DA,0)),U,5)
         ..W " to cancel."
         ..W "<br>"
         .W "<TEXTAREA align=""center"" name=""BB4"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""11"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,NODE,DIWP,R1ACQ)=""
         .S R1ACCNT=0,R1ACFLD=11,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP,^DIWW
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .;K WP
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Phone Consultation - [PC Type# 5]</label><br />"
         .I $P($G(^DIZ(612418,DA,0)),U,5)]"" D
         ..W "Unavailable?"
         ..W "<br>"
         ..W "Please call us at "
         ..W $P($G(^DIZ(612418,DA,0)),U,5)
         ..W "<br>"
         .W "<TEXTAREA align=""center"" name=""BB5"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""12"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,NODE,DIWP,R1ACQ)=""
         .S R1ACCNT=0,R1ACFLD=12,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP,^DIWW
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .;K WP
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Means Test Annual - 60-30 day letter - [PC Type# 6]</label><br />"
         .I $P($G(^DIZ(612418,DA,0)),U,6)]"" D
         ..W "Please call us at"
         ..W "<br>"
         ..W $P($G(^DIZ(612418,DA,0)),U,6)
         ..W "<br>"
         .W "<TEXTAREA align=""center"" name=""BB6"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""13"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,NODE,DIWP,R1ACQ)=""
         .S R1ACCNT=0,R1ACFLD=13,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP,^DIWW
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Means Test - 0 day letter - [PC Type# 7]</label><br />"
         .I $P($G(^DIZ(612418,DA,0)),U,6)]"" D
         ..W "Please call us at"
         ..W "<br>"
         ..W $P($G(^DIZ(612418,DA,0)),U,6)
         ..W "<br>"
         .W "<TEXTAREA align=""center"" name=""BB7"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""14"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,NODE,DIWP,R1ACQ)=""
         .S R1ACCNT=0,R1ACFLD=18,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP,^DIWW
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .;K WP
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Mobile Services Appointment - [PC Type# 8]</label><br />"
         .I $P($G(^DIZ(612418,DA,0)),U,5)]"" D
         ..W "Can't make it?"
         ..W "<br>"
         ..W "Please call us at "
         ..W $P($G(^DIZ(612418,DA,0)),U,5)
         ..W "<br>"
         .W "<TEXTAREA align=""center"" name=""BB8"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""15"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,NODE,DIWP,R1ACQ)=""
         .S R1ACCNT=0,R1ACFLD=15,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP,^DIWW
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .;K WP
         .W "</TEXTAREA><br><br><br>"
         .W "<label for=""text"">Appointment Location Changed - Alert - [PC Type# 9]</label><br />"
         .I $P($G(^DIZ(612418,DA,0)),U,5)]"" D
         ..W "Can't make it?"
         ..W "<br>"
         ..W "We can offer this time"
         ..W "<br>"
         ..W "slot to a fellow veteran if"
         ..W "<br>"
         ..W "you call us to cancel at"
         ..W "<br>"
         ..W "least 24 hours ahead."
         ..W "<br>"
         ..W "Please call"
         ..W "<br>"
         ..W $P($G(^DIZ(612418,DA,0)),U,5)
         ..W " to cancel."
         ..W "<br>"
         .W "<TEXTAREA align=""center"" name=""BB9"" rows=""9"" cols=""65"" style=""color: #000000>"
         .W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""16"">"
         .N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
         .S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ)=""
         .S R1ACCNT=0,R1ACFLD=16,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         .D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         .;K ^UTILITY($J,"W")
         .;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
         .;S ARHD1=0
         .;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         .;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
         .;.D
         .;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         .;..D ^DIWP,^DIWW
         .;..Q
         .;.E  D
         .;..S R1ACQ=""
         .;..Q
         .;.Q
         .;K ^UTILITY($J,"W")
         .;K WP
         .W "</TEXTAREA><br><br><br>"
         .D ^R1ACNZ2
         Q
