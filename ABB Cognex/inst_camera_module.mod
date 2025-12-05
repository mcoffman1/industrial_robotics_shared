MODULE inst_camera_module
    
    TASK PERS wobjdata ImageFrame:=[FALSE,TRUE,"",[[426.37,-38.3193,6.46511],[0.00393309,-0.00200576,0.0122759,0.999915]],[[4.133,0.379,0],[0.317147,0,0,-0.948376]]];
    TASK PERS tooldata tCalib:=[TRUE,[[134.349,-42.9566,98.4936],[0.722231,-0.0094212,0.691528,0.0090207]],[1,[0,0,10],[1,0,0,0],0,0,0]];

    !**********************************************************
    ! Common strings
    CONST string strJobVision:="YOUR_JOB.job";
    PERS string strIP_Camera1:="YOUR.CAMERA.IP.ADDRESS";
    
    CONST string strNULL:="";
    VAR num nResponse;
    VAR bool bStatus;
    VAR num nActiveCam:=1;
    VAR string strFileName;
    PERS num nErrStatus:=0;

    ! Number of active camera


    ! Data specific to each vision object / Données spécifique à chaque objet vision
    LOCAL PERS pose tVisionTranfObj1:=[[4.133,0.379,0],[0.317147,0,0,-0.948376]];
    LOCAL PERS num nVisionScoreObj1:=100.882;
    !
    ! Robot-vision calibration data 
    LOCAL CONST num nMAX_CALPOS:=10;

    ! MY TARGET
    CONST robtarget PokePostion:=[[-11.14,26.75,5.59],[0.00258144,0.367251,0.930039,0.0121127],[0,0,-1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];




    LOCAL PROC DisplayResults()
        VAR num nRZ1;
        nRZ1:=EulerZYX(\Z,tVisionTranfObj1.rot);
        TPErase;
        TPWrite "Object / Coordinates";
        TPWrite "  1  : X="+ValToStr(tVisionTranfObj1.trans.x)+" Y="+ValToStr(tVisionTranfObj1.trans.y)+" RZ="+ValToStr(nRZ1);
        TPWrite "       Score="+ValToStr(nVisionScoreObj1);
    ENDPROC

    PROC TestProduction()
        !VAR pose Obj1:=[[80.377,-0.196,0],[0.642808,0,0,0.766028]];
        !VAR num nVisionScoreObj1:=100.882;
        VAR string strData;
        TPErase;
        nActiveCam:=1;
        !
        ! Initializing the camera persistant data / Initialisation des données persistantes de la caméra
        CX_SetupCamera nActiveCam,strIP_Camera1,23,"admin","",-600,600,-600,600,-360,360,50\Timeout:=2;

        !
        ! Initializing communication / Initialisation de la communication
        IF NOT CX_InitComm(nActiveCam,nErrStatus) THEN
            CX_ShowErrStatus nErrStatus;
            RETURN ;
        ENDIF
        !
        ! Checking the "Online" mode status / Vérification de l'état du mode "Online"
        IF CX_GetOnline(nActiveCam,nErrStatus) THEN
            TPErase;
            TPWrite "The vision is already on line";
        ELSE
            ! Requesting the "Online" mode / Demande de passage en mode "Online"
            IF CX_SetOnline(nActiveCam,\On,nErrStatus) THEN
                TPWrite "The vision has been set to on line mode";
            ELSE
                CX_ShowErrStatus nErrStatus;
                RETURN ;
            ENDIF
        ENDIF
        !
        ! Reading the vision program name / Lecture du nom du programme vision
        IF CX_GetFile(nActiveCam,strFileName,nErrStatus) THEN
            TPErase;
            TPWrite "Name of vision program: "+strFileName;
        ELSE
            ! Case execution memory of camera is empty / Cas mémoire exécution caméra vide
            ! Loading demo program from flash memory / Chargement programme de démo de la mémoire flash
            IF strFileName=strNULL THEN
                ! Setting camera offline / Passage caméra hors ligne
                bStatus:=CX_SetOnline(nActiveCam,\Off,nErrStatus);
                ! Loading "job" file / Chargement fichier "job"
                IF NOT CX_LoadFile(nActiveCam,strJobVision,nErrStatus) THEN
                    CX_ShowErrStatus nErrStatus;
                    RETURN ;
                ENDIF
                ! Setting camera on line / Passage caméra en ligne
                bStatus:=CX_SetOnline(nActiveCam,\On,nErrStatus);
            ELSE
                CX_ShowErrStatus nErrStatus;
                RETURN ;
            ENDIF
        ENDIF


        IF CX_TriggImage(nActiveCam,nErrStatus) THEN
            
            !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            !
            !       HOW TO GET DATA FROM THE CELLS OF THE SPREADSHEET
            !
            !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            
            IF NOT CX_GetVisionData(nActiveCam,"C",26,\Read4Cells,tVisionTranfObj1,nVisionScoreObj1,nErrStatus) THEN
                CX_ShowErrStatus nErrStatus;
                RETURN ;
            ENDIF

            IF NOT CX_GetValue(nActiveCam,"B",44,strData,nErrStatus) THEN
                CX_ShowErrStatus nErrStatus;
                RETURN ;
            ENDIF
            
            !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



        ELSE
            ! Error during image acquisition / Erreur d'acquisition de l'image
            CX_ShowErrStatus nErrStatus;
            RETURN ;
        ENDIF
        !
        ! Displaying object coordinates / Affichage des coordonnées d'objets
        ! DisplayResults;
        !    ENDWHILE


    ENDPROC

    PROC MOVE_ARM(num Zoffset)
        MoveAbsJ [[0,0,0,0,-5,0],[9E9,9E9,9E9,9E9,9E9,9E9]]\NoEOffs,v300,z50,tool0\WObj:=wobj0;
        !This aligns the coordiate system with the frame on the object in Insight
        ImageFrame.oframe:=tVisionTranfObj1;

        MoveL offs(PokePostion,0,0,Zoffset),v200,z50,tCalib\WObj:=ImageFrame;
        MoveL PokePostion,v20,fine,tCalib\WObj:=ImageFrame;
        MoveL offs(PokePostion,0,0,Zoffset),v200,z50,tCalib\WObj:=ImageFrame;
        
        MoveAbsJ [[0,0,0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]]\NoEOffs,v200,z50,tool0\WObj:=wobj0;
        !add rotation
    ENDPROC

    
ENDMODULE