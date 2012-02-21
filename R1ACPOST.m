R1ACPOST ;VISN21/DAD/- Post Install Routine ;April 22, 2011
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
POST     ;
         ; *** Post install entry point
         K ^DIC("B","IRMS XEROX BLUEBOX BOILER PLATES",612418.1)
         K ^DIC("B","IRMS XEROX POSTCARD RETURN ADDRESS",612418.7)
         Q
