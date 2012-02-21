R1ACSUTL ;VISN21/vhamachillsg - XEROX POSTCARD application utilities
         ;;2.5;Region One Appointment Card;;March 23, 2011;Build 9
         ;  This routine will check to see if XEROX POSTCARD parameters are set and if
         ;  the current system has network connectivity and can access the assigned
         ;  storage area on the Windows 2003 PostalSoft server.
         ;  (This routine uses $ZF to run DCL command procedures built by this application
         ;   (VA Kernel cannot perform this))
         Q
         ;
STORCHK(X) --
          ; ZFunction
         ;** This function tests for the existance of a directory/file.  
         ;   Vaule of 'X' is either a DIRECTORY or FILE specification.
         ;
         Q:X="" 0
         N R1ACPATH,R1ACMORE,R1ACMASK,Y,R1ACTST
         ;
         ; filename specified in 'X'
         I $P(X,"]",2)'="" D  Q R1ACTST
         .S R1ACPATH=$P(X,"]")_"]"
         .S R1ACMASK($P(X,"]",2)_";*")=""
         .D FILECHK
         .Q
         ;
         ; no filename specified, need to parse PATH and extract directory
         S R1ACPATH=$P(X,"[")
         S Y=$P(X,"[",2),Y=$TR(Y,"]","")
         F  Q:Y'["."  S:Y["." R1ACMORE=$G(R1ACMORE)_$P(Y,".") S Y=$P(Y,".",2)
         I $G(R1ACMORE)'="" S R1ACPATH=R1ACPATH_"["_R1ACMORE_"]",R1ACMASK(Y_".DIR;*")=""
         E  S R1ACMASK(Y_".DIR;*")=""
         D FILECHK
         Q R1ACTST
         ;
FILECHK  ; Check for existance of file
         N RESULTS
         S R1ACTST=0
         S R1ACTST=$$LIST^%ZISH(R1ACPATH,"R1ACMASK","RESULTS")
         I R1ACTST=0 S R1ACTST=$$LIST^%ZISH(R1ACPATH_"[000000]","R1ACMASK","RESULTS") ; second try based upon VMS logical
         Q
         ;
ZFEXEC(X) ; ZFunction - execute a command procedural script in OS
         ; Value of 'X' should be a command that can be executed within the underlying OS
         S X=$ZF(-1,X)
         Q
