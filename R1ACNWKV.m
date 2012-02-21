R1ACNWKV ;VISN21/NLS/15Oct, 2007 - Clone of Don Donati's CSP ^ARHDEOS6 - Signout for transferring WP nodes from #612418.1 to #612418
           & Reverse
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;;2.5;CSP SignOut;;Aug 17, 2006;Build 47
         ;
ARCHIVE(BP,CLIN) --
          ;*** transferring WP nodes from #612418.1 to #612418
         I CLIN="@" Q
         N ARHDARCH,ARHDDATA,ARHDFDA,ARHDFILA,ARHDFILD,ARHD0DFN
         S (ARHDARCH,ARHDDATA,ARHDFDA,ARHDFILA,ARHDFILD,ARHD0DFN)=""
         N ARHDFILE,ARHDFLD,ARHDIENS,ARHDNODE,ARHDSPEC
         S (ARHDFILE,ARHDFLD,ARHDIENS,ARHDNODE,ARHDSPEC)=""
         S ARHD0DFN=BP
         D
         .S ARHDFILD=$$DDFILE ;#612418.1
         .S ARHDFILA=$$DDARCH ;#612418
         .K ^TMP("DILIST",$J)
         .S ARHDIENS=CLIN_","
         .S ARHDFILE=$$CREF^DILF($$GET1^DID(ARHDFILD,"","","GLOBAL NAME"))
         .S ARHDFLD=0
         .F  S ARHDFLD=$O(^DD(ARHDFILD,ARHDFLD)) Q:ARHDFLD'>0  D
         .. I $$GET1^DID(ARHDFILD,ARHDFLD,"","MULTIPLE-VALUED")'>0 D
         ...Q
         ..E  D
         ... S ARHDSPEC=$$GET1^DID(ARHDFILD,ARHDFLD,"","SPECIFIER")
         ... I $$GET1^DID(+ARHDSPEC,.01,"","SPECIFIER")["W" D
         .... S ARHDNODE=$P($$GET1^DID(ARHDFILD,ARHDFLD,"","GLOBAL SUBSCRIPT LOCATION"),";",1)
         .... S ARHDDATA=$NA(@ARHDFILE@(ARHD0DFN,ARHDNODE))
         .... S ARHDFDA(ARHDFILA,ARHDIENS,ARHDFLD)=ARHDDATA
         .... Q
         ... Q
         .. Q
         .D UPDATE^DIE("","ARHDFDA")
         .D CLEAN^DILF
         .Q
         Q
         ;
DDFILE() ;
         ; *** Data file number
         Q 612418.1
         ;
DDARCH() ;*** Archive file number
         Q 612418
         ;
ARCHV2(BP,CLIN) --
          ;
         ; *** transferring WP nodes from #612418 to #612418.1
         I BP="@" Q
         N ARHDARCH,ARHDDATA,ARHDFDA,ARHDFILA,ARHDFILD
         S (ARHDARCH,ARHDDATA,ARHDFDA,ARHDFILA,ARHDFILD)=""
         N ARHDFILE,ARHDFLD,ARHDIENS,ARHDNODE,ARHDSPEC
         S (ARHDFILE,ARHDFLD,ARHDIENS,ARHDNODE,ARHDSPEC)=""
         S ARHD0DFN=CLIN
         D
         .S ARHDFILD=$$DDFILE2 ;#612418
         .S ARHDFILA=$$DDARCH2 ;#612418.1
         .K ^TMP("DILIST",$J)
         .S ARHDIENS=BP_","
         .S ARHDFILE=$$CREF^DILF($$GET1^DID(ARHDFILD,"","","GLOBAL NAME"))
         .S ARHDFLD=0
         .F  S ARHDFLD=$O(^DD(ARHDFILD,ARHDFLD)) Q:ARHDFLD'>0  D
         .. I $$GET1^DID(ARHDFILD,ARHDFLD,"","MULTIPLE-VALUED")'>0 D
         ...Q
         ..E  D
         ... S ARHDSPEC=$$GET1^DID(ARHDFILD,ARHDFLD,"","SPECIFIER")
         ... I $$GET1^DID(+ARHDSPEC,.01,"","SPECIFIER")["W" D
         .... S ARHDNODE=$P($$GET1^DID(ARHDFILD,ARHDFLD,"","GLOBAL SUBSCRIPT LOCATION"),";",1)
         .... S ARHDDATA=$NA(@ARHDFILE@(ARHD0DFN,ARHDNODE))
         .... S ARHDFDA(ARHDFILA,ARHDIENS,ARHDFLD)=ARHDDATA
         .... Q
         ... Q
         .. Q
         .D UPDATE^DIE("","ARHDFDA")
         .D CLEAN^DILF
         .Q
         Q
          ;
DDFILE2() ;
         ; *** Data file number
         Q 612418
         ;
DDARCH2() ;
         ;*** Archive file number
         Q 612418.1
