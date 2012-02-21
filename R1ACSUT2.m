R1ACSUT2 ;VISN21/vhasfcdonatd - Utilities ;April 1, 2011
         ;;3.0;Region 1 Appointment Card;;April 1, 2011;Build 9
         ;
WPOUTPUT(R1ACFILE,R1ACIENS,R1ACFLDS,R1ACCHEK,R1ACNUMB) --
          ;
         ; *** Output WP text for <textarea> fields
         N R1ACDATA,R1ACINDX,R1ACTEXT
         D GETS^DIQ(R1ACFILE,R1ACIENS,R1ACFLDS,"","R1ACTEXT","")
         S R1ACINDX=0
         F  S R1ACINDX=$O(R1ACTEXT(R1ACFILE,R1ACIENS,R1ACFLDS,R1ACINDX)) Q:R1ACINDX'>0  D
         . S R1ACDATA=$G(R1ACTEXT(R1ACFILE,R1ACIENS,R1ACFLDS,R1ACINDX))
         . W R1ACDATA,!
         . S R1ACNUMB=R1ACNUMB+1
         . I (R1ACCHEK>0)&($L(R1ACDATA)>65) S ^XTMP("NODE")=R1ACNUMB
         . Q
         Q
