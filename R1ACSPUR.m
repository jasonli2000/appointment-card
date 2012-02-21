R1ACSPUR ;VISN21/vhamachillsg - Purge POST CARD Tracking file
         ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
         ; Purge R1AC POSTCARD TRACKING file of old entries.
         ; This option should be scheduled to run once a week.
         ; R1/KJP 3/23/11 - Changed wording from previous filenames to new filenames.
         Q
PURGE    ; Need to run thru (2) files and remove obsolete entries
         N X,R1ACPDTE,Y
         S X=$P($G(^DIZ(612418.5,1,2)),U,9) I +X=0 S X="120" ; check parameter file for retention
         S X="T-"_X
         D ^%DT S R1ACPDTE=Y X ^DD("DD")
         W !,"Purging data from R1AC POSTCARD TRACKING FILE (612418.3)",!?5,"- prior to "_Y,!  ;R1/KJP 3/23/11 CHANGED WORDING
         K X,DIK,DA S X="",DIK="^DIZ(612418.3,"
         F  S X=$O(^DIZ(612418.3,X)) Q:X=""  I +X,+X<R1ACPDTE D
         .W ^DIZ(612418.3,+X,0),! S DA=+X N X D ^DIK
         K DIK,DA
         S X="",DIK="^DIZ(612418.2,"
         W !,"Purging data from R1AC POSTCARD FTP FILE (612418.2)",!?5,"- prior to "_Y,!  ;R1/KJP 3/23/11 CHANGED WORDING
         F  S X=$O(^DIZ(612418.2,X)) Q:X=""  I $D(^(X,0)),+X D
         .Q:+$P(^DIZ(612418.2,X,0),U,3)>R1ACPDTE
         .W $P(^DIZ(612418.2,X,0),U,2),! S DA=+X N X D ^DIK
         Q
