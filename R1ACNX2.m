R1ACNX2  ;VISN21/NLS/- Cont. Display Individual Templates for Selected Boiler Plate
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;W # ;SFVAMC/DAD/3-31-2011/Add form feed (W #) to reset $X and $Y
         W "</TEXTAREA><br><br><br>"
         W "<label for=""text"">Cancelled Appointment + New Appointment - Alert - [Template 11]</label><br />"
         W "<TEXTAREA align=""center"" name=""BB11"" rows=""9"" cols=""65"" style=""color: #000000>"
         W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""18"">"
         N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP,R1ACIEN
         S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,DIWP,NODE,R1ACQ,WP)=""
         S R1ACCNT=0,R1ACFLD=18,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         ;K ^UTILITY($J,"W")
         ;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         ;S ARHD1=0
         ;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         ;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         ;.D
         ;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         ;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         ;..Q
         ;.E  D
         ;..S R1ACQ=""
         ;..Q
         ;.Q
         ;K ^UTILITY($J,"W")
         W "</TEXTAREA><br><br><br>"
         W "<label for=""text"">Group Orientation Appointment - Alert - [PC Type# 12]</label><br />"
         W "<TEXTAREA align=""center"" name=""BB12"" rows=""9"" cols=""65"" style=""color: #000000>"
         W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""17"">"
         N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP,R1ACIEN
         S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,DIWP,NODE,R1ACQ,WP)=""
         S R1ACCNT=0,R1ACFLD=19,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         ;K ^UTILITY($J,"W")
         ;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         ;S ARHD1=0
         ;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         ;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         ;.D
         ;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         ;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         ;..Q
         ;.E  D
         ;..S R1ACQ=""
         ;..Q
         ;.Q
         ;K ^UTILITY($J,"W")
         W "</TEXTAREA><br><br><br>"
         W "<label for=""text"">Cancel Appointment/No reschedule - Alert - [PC Type# 13]</label><br />"
         W "<TEXTAREA align=""center"" name=""BB13"" rows=""9"" cols=""65"" style=""color: #000000>"
         W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""20"">"
         N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP,R1ACIEN
         S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,DIWP,NODE,R1ACQ,WP)=""
         S R1ACCNT=0,R1ACFLD=20,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         ;K ^UTILITY($J,"W")
         ;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         ;S ARHD1=0
         ;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         ;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         ;.D
         ;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         ;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         ;..Q
         ;.E  D
         ;..S R1ACQ=""
         ;..Q
         ;.Q
         ;K ^UTILITY($J,"W")
         W "</TEXTAREA><br><br><br>"
         W "<label for=""text"">Fee-Based Service at Non-VA site - [PC Type# 14]</label><br />"
         W "<TEXTAREA align=""center"" name=""BB14"" rows=""9"" cols=""65"" style=""color: #000000>"
         W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""21"">"
         N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP,R1ACIEN
         S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,DIWP,NODE,R1ACQ,WP)=""
         S R1ACCNT=0,R1ACFLD=21,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         ;K ^UTILITY($J,"W")
         ;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         ;S ARHD1=0
         ;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         ;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         ;.D
         ;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         ;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         ;..Q
         ;.E  D
         ;..S R1ACQ=""
         ;..Q
         ;.Q
         ;K ^UTILITY($J,"W")
         W "</TEXTAREA><br><br><br>"
         W "<label for=""text"">Birthday - [PC Type# 15]</label><br />"
         W "<TEXTAREA align=""center"" name=""BB15"" rows=""9"" cols=""65"" style=""color: #000000>"
         W "<background-color:#f0f8ff"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""22"">"
         N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACCNT,DIWP,NODE,R1ACQ,WP,R1ACIEN
         S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,DIWP,NODE,R1ACQ,WP)=""
         S R1ACCNT=0,R1ACFLD=22,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
         D WPOUTPUT^R1ACSUT2(612418.1,R1ACIEN,R1ACFLD,0,.R1ACCNT)
         ;K ^UTILITY($J,"W")
         ;D GETS^DIQ(612418.1,""_R1ACIEN_"",R1ACFLD,"","WP","")
         ;S ARHD1=0
         ;F  S ARHD1=$O(WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
         ;.S NODE="",NODE=WP(612418.1,""_R1ACIEN_"",R1ACFLD,ARHD1)
         ;.D
         ;..S X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
         ;..D ^DIWP S X=$$XYENABLE^R1UTCSPZ(0) D ^DIWW S X=$$XYENABLE^R1UTCSPZ(1)
         ;..Q
         ;.E  D
         ;..S R1ACQ=""
         ;..Q
         ;.Q
         ;K ^UTILITY($J,"W")
         K DA
         W "</TEXTAREA>"
         W "<table>"
         W "<tbody>"
         Q
