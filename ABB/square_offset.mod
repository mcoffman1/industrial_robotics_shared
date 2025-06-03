MODULE INST_Module
    !***********************************************************
    !   Defining Tool and Work Object
    !***********************************************************
    TASK PERS tooldata INST_tool:=[TRUE,[[0,0,100],[1,0,0,0]],[1,[0,0,1],[1,0,0,0],0,0,0]];
    TASK PERS wobjdata INST_workobject:=[FALSE,TRUE,"",[[350,0,100],[1,0,0,0]],[[50,20,0],[1,0,0,0]]];
    
    !***********************************************************
    !   Defining ABS Joint Targets
    !***********************************************************
    CONST jointtarget Home:=[[0,0,0,0,90,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    
    !***********************************************************
    !   Defining Robot Targets
    !***********************************************************
    CONST robtarget INST_p10:=[[-100,0,0],[0,0,1,0],[0,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget INST_p20:=[[-100,100,0],[0,0,1,0],[0,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget INST_p30:=[[100,100,0],[0,0,1,0],[0,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget INST_p40:=[[150,0,0],[0,0,1,0],[0,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget INST_p50:=[[100,-100,0],[0,0,1,0],[0,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget INST_p60:=[[-100,-100,0],[0,0,1,0],[0,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    
    !***********************************************************
    !   Defining Variables
    !***********************************************************
    
    LOCAL PERS pose my_pose:=[[50,20,0],[1,0,0,0]];
    VAR num RZ;
    VAR string my_string;
    
    !! Main Routine to call and test subroutines
    PROC INST_main()
        MoveAbsJ Home\NoEOffs, v200, z0, INST_tool;
        wo_offset_pro;
    ENDPROC
    
    !! Point based programming 
    PROC reg_pro()
        MoveJ INST_p10, v200, z0, INST_tool\WObj:=INST_workobject;
        MoveL INST_p20, v200, z0, INST_tool\WObj:=INST_workobject;
        MoveL INST_p30, v200, z0, INST_tool\WObj:=INST_workobject;
        MoveC INST_p40, INST_p50, v200, z10, INST_tool\WObj:=INST_workobject;
        MoveL INST_p60, v200, z0, INST_tool\WObj:=INST_workobject;
        MoveL INST_p10, v200, z0, INST_tool\WObj:=INST_workobject;
    ENDPROC
    
    !! Offset points
    PROC offset_pro()
        MoveJ INST_p60, v200, z0, INST_tool\WObj:=INST_workobject;
        MoveL Offs(INST_p60,200,0,0), v200, z0, INST_tool\WObj:=INST_workobject;
        MoveL Offs(INST_p60,200,200,0), v200, z0, INST_tool\WObj:=INST_workobject;
        MoveL Offs(INST_p60,0,200,0), v200, z0, INST_tool\WObj:=INST_workobject;
        MoveL INST_p60, v200, z0, INST_tool\WObj:=INST_workobject;
    ENDPROC
    
    !! display results of pose changes
    PROC display_results()
        RX:=EulerZYX(\X,my_pose.rot);
        RY:=EulerZYX(\Y,my_pose.rot);
        RZ:=EulerZYX(\Z,my_pose.rot);
        TPErase;
        TPWrite "Object Coordinates";
        TPWrite "   X="+ValToStr(my_pose.trans.x)+" | Y="+ValToStr(my_pose.trans.y)+" | Z="+ValToStr(my_pose.trans.z)+" | RX="+ValToStr(RX)+" | RY="+ValToStr(RY)+" | RZ="+ValToStr(RZ);
    ENDPROC
    
    !! move change pose and move workobject
    PROC wo_offset_pro()
        my_pose:=[[0,0,0],[1,0,0,0]];
        !display_results;
        INST_workobject.oframe:=my_pose;
        offset_pro;
        
        !my_pose.trans.x:=20;
        my_pose.trans:=[50,20,0];
        my_pose.rot:=OrientZYX(30,0,0);
        
        !INST_workobject.oframe.trans.x:=100
        display_results;
        INST_workobject.oframe:=my_pose;
        offset_pro;
    ENDPROC
    
ENDMODULE