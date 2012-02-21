R1ACSCR1 ;VISN21/vhamachillsg - Xerox CrossWalk report for date entered
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         Q
         ;
RPT1     ; this report will provide a listing containing clinic name, date created, created by, and blue box template
         N DIR,DIRUT,DIC,FLDS,BY,FR,TO,L,X,ALTY
         K DIR,DIRUT S DIR(0)="SOA^C:CLINIC NAME;D:DATE ENTERED",DIR("A")="Sort by (C)linic name or (D)ate entered? " D ^DIR Q:$D(DI
          RUT)
         S ALTY=Y
         I ALTY="C" D
         .S L=0,DIC="^DIZ(612418,",FLDS=".01,.03,23",BY=".01" D EN1^DIP
         .Q
         I ALTY="D" D
         .S L=0,DIC="^DIZ(612418,",FLDS=".03,.01,23",BY=".03,.01",FR="?,",TO="?," D EN1^DIP
         .Q
         Q
