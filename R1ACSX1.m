R1ACSX1  ;VISN21/vhamachillsg - Build transmission script and transmit
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         Q
         ;
BLDFTP   ;build FTP script
         N R1ACFILE,R1ACSTA,R1ACPATH,R1ACDEST,R1ACXFIL,R1ACSTT,TMPPATH
         S R1ACDEST=^TMP("R1ACSX",$J,1,"VIPP","DESTINATION")
         S R1ACPATH=$P($G(^DIZ(612418.5,1,0)),U,2)
         S R1ACSTT=$P($G(^DIZ(612418.5,1,0)),U,9) ; Transmission Type (FTP vs SFTP)
         D:R1ACSTT="S"
         .; Use Secure FTP transmission
         .; build SFTP script
         .S R1ACPATH=$P(R1ACPATH,"]",1)_".PCARD]"
         .S (R1ACFILE,R1ACXFIL)=$P(R1ACDEST,"]",2),R1ACFILE=$P(R1ACFILE,"."),R1ACFILE=R1ACFILE_".SFTP"
         .S TMPPATH=$TR($TR($TR($TR(R1ACPATH,":",""),"[","/"),"]","/"),".","/")
         .D OPEN^%ZISH("R1ACFTP",R1ACPATH,R1ACFILE,"W",512)
         .U IO
         .W "lcd "_TMPPATH,!
         .W "put "_R1ACXFIL,!
         .W "lrm "_R1ACXFIL,! ;4/8/2008 - vhamachillsg
         .W "exit",!
         .Q
         D:R1ACSTT'="S"
         .S R1ACPATH=$P($G(^DIZ(612418.5,1,0)),U,2)
         .S R1ACPATH=$P(R1ACPATH,"]",1)_".INPUT]"
         .S R1ACFILE=$P(R1ACDEST,"]",2),R1ACFILE=$P(R1ACFILE,"."),R1ACFILE=R1ACFILE_".INPUT"
         .D OPEN^%ZISH("R1ACFTP",R1ACPATH,R1ACFILE,"W",512)
         .U IO
         .W "ascii",!
         .W "put "_R1ACDEST,!
         .W "bye",!
         .Q
         D CLOSE^%ZISH("R1ACFTP")
         Q
         ;
REGFTP   ; register the FTP task in the FTP tracking file
         N R1ACFDA,R1ACIEN,X,R1ACDATA,Y,R1ACXMIT,%
         D NOW^%DTC S R1ACXMIT=%
         S R1ACDATA(612418.2,"+1,",.01)=R1ACFILE
         S R1ACDATA(612418.2,"+1,",2)=R1ACXMIT
         D UPDATE^DIE("","R1ACDATA","R1ACIEN","MSG")
         Q
         ; 
FTP      ;
         ; FTP process for transmitting postcards to XEROX PostalSoft server.
         ;  ***(Can manually envoke FTP process by calling the FTP tag)***
         ; Go thru file 612418.2 and check ATX cross reference to see if anything needs to be transmitted.
         ;
         I '$D(^DIZ(612418.2,"ATX")) D  Q
         .I '$D(ZTSK) W !,"Nothing to transmit..",!
         L +^DIZ(612418.2,"ATX","ZZTRANSMITJOB"):3 I '$T W !,"Another transmission process is running.",! Q
         ;L +^DIZ(612418.2,"ATX","ZZTRANSMITJOB"):3 I '$T Q  ; only (1) job should run, lock this non-exists node
         ;
         N R1ACCMD,R1ACFILE,R1ACDFIL,R1ACPATH,R1ACDPTH,R1ACIN,R1ACLOG,R1ACSUBM,R1ACUSR,R1ACPASS,R1ACF1,R1ACF2,R1ACN1,R1ACN2,R1ACSVR,
          R1ACSTT
         S R1ACFILE=""
         S R1ACSTT=$P($G(^DIZ(612418.5,1,0)),U,9) ; Transmission Type (FTP vs SFTP)
         F  S R1ACFILE=$O(^DIZ(612418.2,"ATX",R1ACFILE)) Q:R1ACFILE=""  D
         .L +^DIZ(612418.2,"ATX",R1ACFILE):3 I '$T Q
         .D XMIT0
         .L -^DIZ(612418.2,"ATX",R1ACFILE)
         .Q
         L -^DIZ(612418.2,"ATX","ZZTRANSMITJOB")
         ; there are instances where something could have been placed on the "ATX" xref after the FOR
         ; loop has completed, so submit a task to transmit anything that hit the ATX xref (follow-up)
         ; the task will be scheduled 5min into the future
         N ZTRTN,ZTDESC,ZTIO,ZTDTH
         S ZTRTN="FTP^R1ACSX1",ZTDESC="R1ACS FTP Follow-up transmission",ZTDTH=$$HADD^XLFDT($H,,,5),ZTIO=""
         D ^%ZTLOAD
         Q
         ;
XMIT0    ;
         ; set up transmission
         ; get FTP server, username, password, working directories and build command to execute FTP
         N R1ACUSR,R1ACPASS,R1ACLDIR,R1ACLFIL,R1ACREC,R1ACSFTP,R1ACCFIL,%,POP
         S R1ACUSR=$P($G(^DIZ(612418.5,1,2)),U,3)  Q:R1ACUSR=""
         S R1ACPASS=$P($G(^DIZ(612418.5,1,2)),U,4) Q:R1ACPASS=""  S R1ACPASS=$$DECRYP^XUSRB1(R1ACPASS)
         S (R1ACDPTH,R1ACPATH)=$P($G(^DIZ(612418.5,1,0)),U,2)  Q:R1ACPATH=""  S R1ACPATH=$P(R1ACPATH,"]")_".INPUT]",R1ACDPTH=$P(R1AC
          DPTH,"]")_".PCARD]"
         S R1ACLDIR=$P($G(^DIZ(612418.5,1,2)),U,1)  Q:R1ACLDIR=""   S R1ACLFIL=$P(R1ACFILE,".",1)_".LOG",R1ACLOG=R1ACLDIR_R1ACLFIL
         S R1ACSVR=$P($G(^DIZ(612418.5,1,2)),U,2)  Q:R1ACSVR=""
         ;
         ;S R1ACSFTP=$P(R1ACFILE,".")_".SFTP"
         S R1ACSFTP=$P(R1ACFILE,".")_$S(R1ACSTT="S":".SFTP",1:".INPUT")
         S R1ACDFIL=R1ACDPTH_$P(R1ACFILE,".",1)_".TXT"
         ; build command to execute within host OS (OpenVMS), then execute from Cache
         D 
         .N X
         .; build command procedure to run SFTP script
         .S R1ACCFIL=$P(R1ACFILE,".")_".COM"
         .S X=R1ACDPTH_R1ACCFIL
         .I R1ACSTT="S",'$$STORCHK^R1ACSUTL(X) D  ; don't create 2nd version due to failed transmission
         ..D OPEN^%ZISH("R1ACFTPCOM",R1ACDPTH,R1ACCFIL,"W",512)
         ..U IO
         ..W "$ DEFINE/PROC SYS$LOGIN "_R1ACDPTH,!
         ..W "$ SET DEFAULT "_R1ACDPTH,!
         ..W "$ sftp -""B"" "_R1ACSFTP_" "_R1ACUSR_"@"_R1ACSVR,!
         ..W "$ exit",!
         ..D CLOSE^%ZISH("R1ACFTPCOM")
         .I R1ACSTT'="S" S R1ACIN=R1ACPATH_$P(R1ACFILE,".",1)_".INPUT"
         .S X=$S(R1ACSTT="S":"@"_R1ACDPTH_R1ACCFIL,1:"PIPE FTP "_R1ACSVR_"/USER="_R1ACUSR_"/PASS="""_R1ACPASS_"""/INPUT="_R1ACIN_">"
          _R1ACLOG)
         .; now execute script
         .D ZFEXEC^R1ACSUTL(X)
         .Q
         ; check to determine if transmission was successful
         I R1ACSTT="S" D SFTPCHK
         I R1ACSTT'="S" D FTPCHK
         ;
         ; clean up old card information that may have failed to be transmitted
         ; get pre-scan days and use that as the number of days to go back to
         ; and purge.  These transmissions are most likely too late to be
         ; be mailed.
         S X=$S($P($G(^DIZ(612418.5,1,2)),U,5):$P(^(2),U,5),1:"14"),X="T-"_X
         D ^%DT X ^DD("DD")
         S X=$P($P(Y," ",2),",")_"-"_$E(Y,1,3)_"-"_$P(Y,",",2)
         I +X D
         .N Y,Y1,Y2,Z
         .S Y=$P($G(^DIZ(612418.5,1,0)),U,2)
         .Q:Y=""
         .S Y1=$P(Y,"]",1)_".PCARD]"
         .S Y2=$P(Y,"]",1)_".INPUT]"
         .S Z="DELETE/LOG/NOCONFIRM/BEFORE="_X_" "_Y1_"R1AC*.*;*" D ZFEXEC^R1ACSUTL(Z)
         .S Z="DELETE/LOG/NOCONFIRM/BEFORE="_X_" "_Y2_"R1AC*.*;*" D ZFEXEC^R1ACSUTL(Z)
         .Q
         ; end of clean of phase
         ;
         Q
         ;
         ;
SFTPCHK  ;  check SFTP transmission
         ;S X=R1ACDPTH_$P(R1ACFILE,".",1)_".SENT" ;4/8/2008 - vhamachillsg
         S X=R1ACDPTH_$P(R1ACFILE,".",1)_".TXT" ;4/8/2008 - vhamachillsg
         ;I $$STORCHK^R1ACSUTL(X) S R1ACF1=1 ;4/8/2008 - vhamachillsg
         I '$$STORCHK^R1ACSUTL(X) S R1ACF1=1 ;4/8/2008 - vhamachillsg
         ; update IRMS XEROX POSTCARD PARAMETERS file (612418.5) if successful FTP
         ;  o  record FTP date/time/# of attempts & remove x-ref
         ;  o  delete HFS files that have been transmitted & used as temporary files
         I $G(R1ACF1) D
         .W:'$D(ZTQUEUED) !,"Postcard data transmitted for "_R1ACFILE,!
         .N IEN1,R1ACDATA,CNT,MSG,ZZ
         .Q:$G(R1ACFILE)=""
         .S IEN1=$O(^DIZ(612418.2,"ATX",R1ACFILE,"")) Q:IEN1=""
         .Q:'$D(^DIZ(612418.2,IEN1))
         .S CNT=+$P($G(^DIZ(612418.2,IEN1,0)),U,5)+1
         .K ^DIZ(612418.2,"ATX",R1ACFILE)
         .D NOW^%DTC
         .S R1ACDATA(612418.2,IEN1_",",3)=%
         .S R1ACDATA(612418.2,IEN1_",",4)=+CNT
         .D FILE^DIE(,"R1ACDATA","MSG")
         .I '$D(MSG) D
         ..N R1ACFDEL
         ..K R1ACDFIL
         ..S R1ACFDEL($P(R1ACFILE,".")_".SENT")="",X=$$DEL^%ZISH(R1ACDPTH,$NA(R1ACFDEL)) ; delete postcard FTP script
         ..S R1ACFDEL($P(R1ACFILE,".")_".SFTP")="",X=$$DEL^%ZISH(R1ACDPTH,$NA(R1ACFDEL)) ; delete postcard FTP script
         ..S R1ACFDEL($P(R1ACFILE,".")_".COM")="",X=$$DEL^%ZISH(R1ACDPTH,$NA(R1ACFDEL)) ; delete postcard FTP script
         E  I '$D(ZTQUEUED) W:'$D(ZTQUEUED) !,"Postcard data Transmission Unsuccessful",!
         Q
         ;
FTPCHK   ;
         ; read log file to determine if transmission was successful
         D OPEN^%ZISH("R1ACFTPLOG",R1ACLDIR,R1ACLFIL,"R",512)
         I POP,'$G(ZTQUEUED) D HOME^%ZIS U IO W !!,"Cannot access LOG file for FTP, unknown status of postcard transmission",!! Q
         U IO
         F  R R1ACREC:DTIME Q:$$STATUS^%ZISH  D
         .I R1ACREC[$P(R1ACFILE,".") S R1ACF1=1
         .I R1ACREC["bytes sent in " S R1ACF2=1
         D CLOSE^%ZISH("R1ACFTPLOG")
         K R1ACFDEL S R1ACFDEL(R1ACLFIL)="",X=$$DEL^%ZISH(R1ACLDIR,$NA(R1ACFDEL)) ; delete LOG file
         ;
         ; update R1AC POSTCARD PARAMETERS file (612418.5)to indicate successful FTP
         ;  o  record FTP date/time/# of attempts & remove x-ref
         ;  o  delete HFS files that have been transmitted
         I $G(R1ACF1),$G(R1ACF2) D
         .W:'$D(ZTQUEUED) !,"Postcard data transmitted for "_R1ACFILE,!
         .N IEN1,R1ACDATA,CNT,MSG,ZZ
         .Q:$G(R1ACFILE)=""
         .S IEN1=$O(^DIZ(612418.2,"ATX",R1ACFILE,"")) Q:IEN1=""
         .Q:'$D(^DIZ(612418.2,IEN1))
         .S CNT=+$P($G(^DIZ(612418.2,IEN1,0)),U,5)+1
         .K ^DIZ(612418.2,"ATX",R1ACFILE)
         .D NOW^%DTC
         .S R1ACDATA(612418.2,IEN1_",",3)=%
         .S R1ACDATA(612418.2,IEN1_",",4)=+CNT
         .D FILE^DIE(,"R1ACDATA","MSG")
         .I '$D(MSG) D
         ..N R1ACFDEL
         ..K R1ACDFIL
         ..S R1ACFDEL(R1ACFILE)="",X=$$DEL^%ZISH(R1ACDPTH,$NA(R1ACFDEL)) ; delete postcard TXT file
         ..K R1ACDFIL
         ..S R1ACFDEL($P(R1ACFILE,".")_".INPUT")="",X=$$DEL^%ZISH(R1ACPATH,$NA(R1ACFDEL)) ; delete postcard FTP script
         E  I '$D(ZTQUEUED) W:'$D(ZTQUEUED) !,"Postcard data Transmission Unsuccessful",!
         Q
