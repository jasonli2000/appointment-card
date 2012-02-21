R1ACSPAR ;VISN21/vhamachillsg - Check XEROX POSTCARD setup (parameters)
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ;  This routine will check to see if XEROX POSTCARD parameters are set and if
         ;  the current system has network connectivity and can access the assigned
         ;  storage area on the Windows 2003 PostalSoft server.
         ;R1/KJP 3/23/11 - Changed wording from IRMS XEROX POSTCARD PARAMETERS to R1AC POSTCARD PARAMETERS file"
         ;R1/SGH 3/23/11 - Added code to display OS username when testing SFTP
         ;
         Q
         ;
CHKPAR   ; check setup
         N X,Y,Z1,Z2,Z3,Z4,Z5,POP,R1ACFILE,R1ACPATH,R1ACRTN,R1ACARAY,R1ACSTAT,R1ACZFP,R1ACDATA
         I '$D(^DIZ(612418.5,1,0)) D
         . W !!,"R1AC POSTCARD PARAMETERS file (#612418.5)is empty, please populate",!  ;R1/KJP 3/23/11 CHANGED WORDING
         E  W !!,"R1AC POSTCARD PARAMETERS file (#612418.5) populated,",!?2,"proceeding with additional checks...",!  ;R1/KJP 3/23/1
          1 CHANGED WORDING
         S Z1=$P($G(^DIZ(612418.5,1,0)),U,2)
         I Z1="" D
         . I Z1="" W ?5,"o VMS POSTCARD directory not entered into R1AC POSTCARD PARAMETERS file."  ;R1/KJP 3/23/11 CHANGED WORDING
         E  D
         . W ?5,"o VMS POSTCARD directory:"
         . ; check directory
         . W !?10,"'"_Z1_"'...",$S($$STORCHK^R1ACSUTL(Z1)=1:"(exists)",1:"(non-exists)")
         . ; check sub directory
         . W !?10,"'"_Z1_"PCARD.DIR'...",$S($$STORCHK^R1ACSUTL($P(Z1,"]")_".PCARD]")=1:"(exists)",1:"(non-exists)")
         . W !?10,"'"_Z1_"INPUT.DIR'...",$S($$STORCHK^R1ACSUTL($P(Z1,"]")_".INPUT]")=1:"(exists)",1:"(non-exists)")
         W !
         ;K R1ACARAY,R1ACRTN
         S Z1=$P($G(^DIZ(612418.5,1,2)),U,1)
         I Z1="" D
         . I Z1="" W ?5,"o VMS POSTCARD LOG FILE directory not entered into R1AC POSTCARD PARAMETERS file.",!  ;R1/KJP 3/23/11 CHANG
          ED WORDING
         E  D
         . W ?5,"o VMS POSTCARD LOG FILE directory:"
         . W !?10,"'"_Z1_"'..."
         . N R1ACPATH,R1ACFDEL
         . S R1ACPATH=Z1
         . N Z1,POP
         . D OPEN^%ZISH("R1ACLOG",R1ACPATH,"R1AC_"_$J_"_LOGFILE.TST","W",512)
         . W $S(POP=0:"(exists)",1:"(non-exists)") Q:POP
         . D CLOSE^%ZISH("R1ACLOG")
         . S R1ACFDEL("R1AC_"_$J_"_LOGFILE.TST")="",X=$$DEL^%ZISH(R1ACPATH,$NA(R1ACFDEL))
         ;
         W !?5,"o XEROX POSTCARD SERVER SETTINGS:"
         S R1ACDATA=$G(^DIZ(612418.5,1,2))
         S Z1=$P(R1ACDATA,U,2)
         I Z1="" D
         . I Z1="" W !?10,"POSTALSOFT SERVER for FTP not entered.",!
         E  S Z3=Z1 W !?10,"POSTALSOFT SERVER for FTP is '"_Z3_"'",!
         S Z4=$P(R1ACDATA,U,3)
         I Z4="" D
         . I Z4="" W ?10,"FTP USERNAME not present.",!
         E  W ?10,"FTP USERNAME present.",!
          S Z5=$P(R1ACDATA,U,4)
         I Z5="" D
         . I Z5="" W ?10,"FTP PASSWORD not present.",!
         E  W ?10,"FTP PASSWORD present.",!
         I (Z3'=""),(Z4'=""),(Z5'="") D
         . K DIR,DIOUT S DIR(0)="YOA",DIR("A")="See if server is on the network? ",DIR("B")="No" D ^DIR Q:$D(DIOUT)
         . I Y=1 W ! D ZFEXEC^R1ACSUTL("$TCPIP PING "_Z3) W !,"*** If server failed the PING, then skip next tests ***"
         . W !,""
         . W !,"            F T P   t e s t"
         . K DIR,DIOUT S DIR(0)="YOA",DIR("A")="Test FTP access? ",DIR("B")="No" D ^DIR Q:$D(DIOUT)
         . I Y=1 D
         .. N IO,R1ACFILE,R1ACPATH,R1ACFDEL,R1ACLFIL,R1ACREC,R1ACSTAT,R1ACPASS
         .. S R1ACPATH=$$DEFDIR^%ZISH,R1ACFILE="R1AC_"_$J_".TMP",R1ACLFIL="R1AC_"_$J_"FTPTST.LOG"
         .. S R1ACPASS=$$DECRYP^XUSRB1(Z5)
         .. W !,"Building/Executing "_R1ACPATH_R1ACFILE
         .. D OPEN^%ZISH("R1ACFTP",R1ACPATH,R1ACFILE,"W",512)
         .. U IO
         .. W "$SET NOON",!
         .. W "$SET NOVER",!
         .. W "$ DEFINE/USER SYS$OUTPUT "_R1ACPATH_R1ACLFIL,!
         .. W "$FTP "_Z3_"/USER="_Z4_"/PASS="""_R1ACPASS_"""",!
         .. W "EXIT",!
         .. W "$SET NOVER",!
         .. W "$EXIT",!
         .. D CLOSE^%ZISH("R1ACFTP")
         .. D ZFEXEC^R1ACSUTL("$@"_R1ACPATH_R1ACFILE)
         .. S R1ACFDEL(R1ACFILE)="",X=$$DEL^%ZISH(R1ACPATH,$NA(R1ACFDEL))
         .. ; read log file
         .. D OPEN^%ZISH("R1ACFTPLOG",R1ACPATH,R1ACLFIL,"R",512)
         .. I POP D HOME^%ZIS U IO W !!,"Cannot access LOG file for FTP, unknown status of FTP test",!! Q
         .. U IO
         .. S R1ACSTAT=0
         .. F  R R1ACREC:DTIME Q:$$STATUS^%ZISH  D
         ... I R1ACREC["230 User" S R1ACSTAT=1
         .. D CLOSE^%ZISH("R1ACFTPLOG")
         .. I R1ACSTAT W !?3,"User "_Z4_" successfully logged into PostalSoft server",!
         .. E  W !?3,"User "_Z4_" could not log into PostalSoft server",!
         .. K R1ACFDEL S R1ACFDEL(R1ACLFIL)="",X=$$DEL^%ZISH(R1ACPATH,$NA(R1ACFDEL)) ; delete LOG file
         .. Q
         . W @IOF,"        S e c u r e   F T P   t e s t"
         . W !,"This test will attempt to connect to the remote server via"
         . W !,"SFTP.  You should receive the following message:"
         . W !,"          ***  Authentication successful  ***"
         . W !,""
         . ;W !,"Upon receiving the message above, press the <enter> key to exit"
         . ;W !,"the SFTP test."
         . W !,""
         . W !,"If you receive a password prompt, or any additional prompts, or"
         . W !,"messages, then Automated Secure FTP setup is not correct."
         . W !,"Please contact the RRC IT support staff for assistance."
         . W !,""
         . W !,"**Note**"
         . W !,"This test should be executed using the VistA production account:"
         . W !,"     scdVISTA or VISTA  (scd used in Regional data centers)"
         . W !,""
         . W !,""
         . K DIR,DIOUT S DIR(0)="YOA",DIR("A")="Test Secure FTP access? ",DIR("B")="No" D ^DIR Q:$D(DIOUT)
         . I Y=1 D
         .. N IO,R1ACFILE,R1ACPATH,R1ACFDEL,R1ACLFIL,R1ACREC,R1ACSTAT,R1ACPASS,R1ACSFTP
         .. S R1ACPATH=$$DEFDIR^%ZISH,R1ACFILE="R1AC_TEST_SFTP_"_$J_".COM",R1ACSFTP="R1AC_TEST_SFTP_"_$J_".SFTP"
         .. W !,"OS account being used: "_$USERNAME ; if need to troubleshoot sftp connectivity - 3/23/2011
         .. W !,"Building/Executing "_R1ACPATH_R1ACFILE
         .. D OPEN^%ZISH("R1ACFTP",R1ACPATH,R1ACFILE,"W",512)
         .. U IO
         .. W "$ set noon",!
         .. W "$ set default "_R1ACPATH,!
         .. W "$ convert/fdl=SYS$SYSTEM:TCPIP$CONVERT.FDL "_R1ACSFTP_" "_R1ACSFTP,!
         .. W "$sftp -""B"" "_R1ACSFTP_" "_Z4_"@"_Z3,!
         .. W "$ if $STATUS .eqs. ""%X0764D01B""",!
         .. W "$   then",!
         .. W "$      write sys$output """"",!
         .. W "$      write sys$output ""SFTP is properly configured for this application""",!
         .. W "$      write sys$output ""     ***  Authentication successful  ***""",!
         .. W "$      write sys$output """"",!
         .. W "$ else",!
         .. W "$        write sys$output """"",!
         .. W "$        write sys$output """"",!
         .. W "$        write sys$output ""SFTP is NOT properly configured for this application""",!
         .. W "$        write sys$output ""   ***  Authentication unsuccessful  ***""",!
         .. W "$        write sys$output """"",!
         .. W "$ endif",!
         .. W "$ exit",!
         .. D CLOSE^%ZISH("R1ACFTP")
         .. D OPEN^%ZISH("R1ACFTP",R1ACPATH,R1ACSFTP,"W",512)
         .. U IO
         .. W "ls",!
         .. D CLOSE^%ZISH("R1ACFTP")
         .. D ZFEXEC^R1ACSUTL("$@"_R1ACPATH_R1ACFILE)
         .. S R1ACFDEL(R1ACFILE)="",X=$$DEL^%ZISH(R1ACPATH,$NA(R1ACFDEL))
         .. S R1ACFDEL(R1ACSFTP)="",X=$$DEL^%ZISH(R1ACPATH,$NA(R1ACFDEL))
         .. Q
         . Q
         K DIR
         Q
