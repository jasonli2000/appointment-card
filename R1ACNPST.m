R1ACNPST ;SFVAMC/NLS Post Install Message
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;;R1/KJP 2/11/11 - Modified XMY
         S (QDT,NAME)=""
         S NAME=$P($G(^VA(200,DUZ,0)),U)
         S Y=DT X ^DD("DD") S QDT=Y
         S XMTEXT(1)="R1AC Region 1 Appointment Card version 3.0 installed "_QDT
         S XMTEXT(2)="By "_NAME_" at station "_DUZ(2)
         ;S XMY="SHAPIRO.NANCY@SANFRANCISCO.MED.VA.GOV"  ;R1/KJP 2/11/11 COMMENTED ORIGINAL LINE
         S XMY("PRATT,KATHLEEN J@ANCHORAGE.MED.VA.GOV")=""  ;R1/KJP 2/11/11 CHANGED
         S XMY("DONATI,DON A@SANFRANCISCO.MED.VA.GOV")=""  ;R1/KJP 2/11/11 CHANGED
         S XMTEXT="XMTEXT(",XMSUB="R1AC Region 1 Appointment Card Version 3.0 Installed"
         S XMDUZ=DUZ D ^XMD
         K NAME,QDT,XMDUZ,XMSUB,XMTEXT,XMTEXT(1),XMTEXT(2),XMY,Y
         Q
