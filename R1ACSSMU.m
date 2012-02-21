R1ACSSMU ;VISN21/vhamachillsg - SCREENMAN utilities
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;
         Q
BLUEBOX(R1ACIEN,R1ACNODE) --
          ;
         ; per XEROX - The current dimensions on the blue box are:
         ;             5"  x 1.78" with 0.125 rounded corners
         ;             Type is 11 pt Franklin Gothic (Book or Demi)
         ;             with 12 pt leading 65 characters per line
         ;             9 lines per box
         N AMNUBB,D0,DDGLZOSF,DIWF,DIWL,DIWR,DX,DY,IOP,R1ACBB,YN
         ;
         N R1ACTXT,R1ACZZ
         N DIC,DILW,DIWESUB
         M R1ACTXT=^DIZ(612418,R1ACIEN,R1ACNODE)
         K ^UTILITY($J,"W",1)
         F R1ACZZ=1:1:9 D:$D(R1ACTXT(R1ACZZ,0))
         . S X=R1ACTXT(R1ACZZ,0),DIWL=1,DIWR=65,DIWF="C65" D ^DIWP
         I $D(^UTILITY($J,"W",1,10)) D
         . F R1ACZZ=10:1 Q:'$D(^UTILITY($J,"W",1,R1ACZZ))  K ^UTILITY($J,"W",1,R1ACZZ)
         . S ^UTILITY($J,"W",1)=9
         K R1ACTXT M R1ACTXT=^UTILITY($J,"W",1)
         W !!,"vvvvvvvvvvvvvv  FORMATTED BLUE BOX  vvvvvvvvvvvvvv",!
         W "123456789.123456789.123456789.123456789.123456789.123456789.12345"
         S IOP=0
         D ^DIWW
         W "^^^^^^^^^^^^^^ FORMATTED BLUE BOX END ^^^^^^^^^^^^",!!
         W !!!,"Save the new BLUE BOX text " R "(Yes/No)? No // ",YN:+$G(DTIME)
         I YN'="","nN"[$E(YN),$D(AMNUBB) K ^DIZ(612418,R1ACIEN,R1ACNODE)
         I YN'="","yY"[$E(YN) D BBSTORE
         Q
         ;
BBL(R1ACBBL) --
          ; build line array
         K R1ACBBL
         N I F I=1:1:9 S R1ACBBL(I)=$G(^DIZ(612418,R1ACIEN,R1ACNODE,I,0))
         Q
         ;
BBSTORE  ; store new format
         W !,"Storing new format for Blue Box",!!
         N I,X,Y
         S X=$P(^DIZ(612418,R1ACIEN,R1ACNODE,0),U,3)
         I X>0 D
         . F I=1:1:X K ^DIZ(612418,R1ACIEN,R1ACNODE,I,0)
         I R1ACTXT>0 D
         . F I=1:1:R1ACTXT S ^DIZ(612418,R1ACIEN,R1ACNODE,I,0)=R1ACTXT(I,0)
         I $D(^DIZ(612418,R1ACIEN,R1ACNODE,0)) D
         . S $P(^DIZ(612418,R1ACIEN,R1ACNODE,0),U,3)=R1ACTXT
         . S $P(^DIZ(612418,R1ACIEN,R1ACNODE,0),U,4)=R1ACTXT
         D HLP^DDSUTL("BLUE BOX text saved...")
         Q
         ;
BBACT(R1ACACT) --
          ; Edit or Reformat Blue Box
         Q:R1ACACT=""
         S R1ACACT=$TR(R1ACACT,"red","RED")
         I R1ACACT="D",$D(^DIZ(612418,D0,1))>1 D
         . S (DX,DY)=23 W $C(27,91)_((DY+1))_$C(59)_((DX+1))_$C(102)
         . W !!!,"Are you sure you want to delete the BLUE BOX text (Yes/No)? No// "
         . N X
         . R X:$G(DTIME)
         . I X'="","yY"[$E(X) K ^DIZ(612418,D0,1)
         . D BBL(.R1ACBBL),HLP^DDSUTL("BLUE BOX text to deleted...")
         . Q
         I R1ACACT="E" D
         . N DIC,DILW,DIWESUB,AMNBB
         . I $D(^DIZ(612418,D0,1)) S R1ACBB=1
         . S DIC="^DIZ(612418,R1ACIEN,R1ACNODE,",DILW=65,DIWESUB="BLUE BOX" D ^DIWE
         . I $D(DDGLZOSF("EON")) X DDGLZOSF("EON")
         . D BLUEBOX,BBL(.R1ACBBL)
         . Q
         I R1ACACT="R",$D(^DIZ(612418,D0,1))=0 D
         . D HLP^DDSUTL("There is no BLUE BOX text to reformat...")
         . Q
         I R1ACACT="R",$D(^DIZ(612418,D0,1))>1 D
         . S (DX,DY)=23 W $C(27,91)_((DY+1))_$C(59)_((DX+1))_$C(102)
         . W !!!,"Are you sure you want to reformat BLUE BOX text (Yes/No)? No //"
         . N X
         . R X:$G(DTIME)
         . I X'="","yY"[$E(X) D BLUEBOX
         . Q
         D PUT^DDSVALF("ACTION",,,"")
         D REFRESH^DDSUTL
         Q
         ;
BBINFO   ;
         W !,"per XEROX - The current dimensions on the blue box are:"
         W !,"            5""  x 1.78"" with 0.125 rounded corners"
         W !,"            Type is 11 pt Franklin Gothic (Book or Demi)"
         W !,"            with 12 pt leaving 65 characters per line,"
         W !,"            9 lines per box",!
         W !,"Please be aware that ONLY the first 9 lines will be used to"
         W !,"format the ""BLUE BOX"" and the remaining lines will be"
         W !,"deleted.",!
         R !,"Press <ENTER> to continue",X:$G(DTIME)
         Q
         ;
CAL1(R1ACCLN) --
          ; clinic address - called via a screenman form
         N Y,Z,R1ACCAD1,INST,DIVI
         S INST=+$P(^SC(+R1ACCLN,0),U,4),DIVI=+$P(^SC(+R1ACCLN,0),U,15),DIVI=$P($G(^DG(40.8,+DIVI,0)),U,2),R1ACCAD1=$S(INST>0:INST,D
          IVI>0:DIVI,1:"")
         S R1ACCAD1=$P($G(^DIC(4,R1ACCAD1,1)),U)
         Q R1ACCAD1
         ;
CAL2(R1ACCLN) --
          ;  - called via a screenman form
         N Z,Y,STANUM,R1ACCAD2
         S Z=+$P(^SC(+R1ACCLN,0),U,4),Y=$P($G(^DIC(4,Z,1)),U,2),STANUM=$P($G(^DIC(4,Z,99)),U)
         S R1ACCAD2=$P($G(^DIC(4,Z,1)),U,3)_", "_$P(^DIC(5,$P($G(^DIC(4,Z,0)),U,2),0),U,2)_"  "_$P($G(^DIC(4,Z,1)),U,4)
         Q R1ACCAD2
         ;
DIVMAIL(R1ACDIV) --
          ;
         I $$GET^DDSVAL("612418.7",R1ACDIV,1)="",$$GET^DDSVAL("612418.7",R1ACDIV,2)="",$$GET^DDSVAL("612418.7",R1ACDIV,3)="",$$GET^D
          DSVAL("612418.7",R1ACDIV,4)="",$$GET^DDSVAL("612418.7",R1ACDIV,5)="" D
         .D PUT^DDSVAL("612418.7",R1ACDIV,1,$P($G(^DIC(4,R1ACDIV,4)),U,1)) ;ADDR L1
         .D PUT^DDSVAL("612418.7",R1ACDIV,2,$P($G(^DIC(4,R1ACDIV,4)),U,2)) ;ADDR L2
         .D PUT^DDSVAL("612418.7",R1ACDIV,3,$P($G(^DIC(4,R1ACDIV,4)),U,3)) ;CITY
         .D PUT^DDSVAL("612418.7",R1ACDIV,4,$P(^DIC(5,$P($G(^DIC(4,R1ACDIV,4)),U,4),0),U,2)) ;STATE
         .D PUT^DDSVAL("612418.7",R1ACDIV,5,$P($G(^DIC(4,R1ACDIV,4)),U,5)) ;ZIP
         Q
