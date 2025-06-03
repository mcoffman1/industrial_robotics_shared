MODULE inst_module
    Task PERS wobjdata box:=[FALSE,TRUE,"",[[400,0,100],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];
    Task PERS wobjdata Circle:=[FALSE,TRUE,"",[[250,0,100],[1,0,0,0]],[[10,0,0],[1,0,0,0]]];
    
    CONST robtarget circ_10:=[[0,0,0],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget circ_20:=[[50,50,0],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget circ_30:=[[100,0,0],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget circ_40:=[[50,-50,0],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    CONST robtarget Target_10:=[[0,0,0],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    ! Data specific to each object
    LOCAL PERS pose my_pose:=[[0,0,0],[1,0,0,0]];
    VAR num nRX1;
    VAR num nRY1;
    VAR num nRZ1;
    VAR string my_str;
    
    VAR num circ_offs;
    
    
    PROC inst_main()
        offs_circles;
    ENDPROC
    
    
    PROC inst_offs_ex()
        !my_pose.rot:=OrientZYX(0,0,0);
        my_pose.trans.x:=-100;
        nRX1:=EulerZYX(\X,my_pose.rot);
        nRY1:=EulerZYX(\Y,my_pose.rot);
        nRZ1:=EulerZYX(\Z,my_pose.rot);
        
        TPErase;
        TPWrite "Object / Coordinates";
        TPWrite "  1  : X="+ValToStr(my_pose.trans.x)+" Y="+ValToStr(my_pose.trans.y)+" RZ="+ValToStr(nRZ1);
        
        box.oframe:=my_pose;
        MoveJ Target_10,v150,z0,cone\WObj:=box;
        
        !Move to a point 100mm in the x and 90 around the z
        my_pose.rot:=OrientZYX(90,0,0);
        my_pose.trans.x:=100;
        nRZ1:=EulerZYX(\Z,my_pose.rot);
        
        TPErase;
        TPWrite "Object / Coordinates";
        TPWrite "  1  : X="+ValToStr(my_pose.trans.x)+" Y="+ValToStr(my_pose.trans.y)+" RZ="+ValToStr(nRZ1);
        
        box.oframe:=my_pose;
        MoveJ Target_10,v150,z0,cone\WObj:=box;
        
        ! RESET and move to original point
        my_pose.rot:=OrientZYX(0,0,0);
        my_pose.trans:=[0,0,0];
        box.oframe:=my_pose;
        MoveJ Target_10,v150,z0,cone\WObj:=box;
    ENDPROC
    
    PROC draw_circle()
        MoveC circ_20,circ_30, v200, z0, cone\WObj:=Circle;
        MoveC circ_40,circ_10, v200, z0, cone\WObj:=Circle;
        
    ENDPROC
    
    PROC offs_circles()
        
        MoveJ Offs(circ_10, 0, 0, 50),v200,z100,cone\WObj:=Circle;
        MoveL circ_10,v200,z100,cone\WObj:=Circle;
        
        FOR i FROM 1 TO 10 DO
        	circ_offs:=i*10;
            Circle.oframe.trans.x:=circ_offs;
            draw_circle;
        ENDFOR
        Circle.oframe.trans.x:=0;
        MoveJ Offs(circ_10, 0, 0, 50),v200,z100,cone\WObj:=Circle;
    ENDPROC
ENDMODULE