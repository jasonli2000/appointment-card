R1SDRRP  ;;R1SDRR/MAH;RECALL REMINDER PACKAGE/XEROX PRINTER; 01/22/2008
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;;CHECK TO SEE HOW A SITE HAS BEEN SETUP FOR CLINIC RECALL
         ;;in the RECALL PARAM FILE
         ;;Xerox printer printing of cards
STR      N DIRUT,R1SDTYPE
         W ! S DIR("A")="What Clinic Recall Division will you be printing From ",DIR(0)="P^403.53:AEMQZ" D ^DIR Q:$D(DIRUT)  S R1SDI
          EN=+Y K Y,Q,DIR
         S R1SDTYPE=$$GET1^DIQ(403.53,R1SDIEN_",",1)
         I R1SDTYPE="" S R1SDTYPE="CARDS" K R1SDIEN
         I R1SDTYPE["CARDS" D MEN^R1SDRRM1 Q
         I R1SDTYPE["L" Q
         Q
