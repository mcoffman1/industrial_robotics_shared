---

MODULE MainModule
    VAR string requestQueue{20};   ! FIFO queue for up to 20 requests
    VAR num head := 1;
    VAR num tail := 1;

    PROC main()
        WHILE TRUE DO
            ! Perform normal production routine here
            ! (Insert your existing logic)
            TPWrite "Main routine running...";

            ! Check if a request is waiting
            IF head <> tail THEN
                VAR string req;
                req := requestQueue[head];
                head := head + 1;
                IF head > Dim(requestQueue,1) THEN
                    head := 1;
                ENDIF;

                ! Execute the requested routine
                TPWrite "Executing request: "\req;

                IF req = "RED" THEN
                    RedRoutine;
                    SetDO DO1, 0;   ! Turn off RED light
                ELSEIF req = "GREEN" THEN
                    GreenRoutine;
                    SetDO DO2, 0;   ! Turn off GREEN light
                ELSEIF req = "BLUE" THEN
                    BlueRoutine;
                    SetDO DO3, 0;   ! Turn off BLUE light
                ELSEIF req = "YELLOW" THEN
                    YellowRoutine;
                    SetDO DO4, 0;   ! Turn off YELLOW light
                ENDIF;
            ENDIF;

            WaitTime 0.1;
        ENDWHILE
    ENDPROC
ENDMODULE

---

MODULE BG_Module
    TASK PERS string requestQueue{20};   ! Shared queue
    TASK PERS num head := 1;
    TASK PERS num tail := 1;

    PROC main()
        WHILE TRUE DO
            ! Check RED button
            IF DI1 = 1 THEN
                Enqueue("RED");
                SetDO DO1, 1;
                WaitUntil DI1=0;   ! Wait for release
            ENDIF;

            ! Check GREEN button
            IF DI2 = 1 THEN
                Enqueue("GREEN");
                SetDO DO2, 1;
                WaitUntil DI2=0;
            ENDIF;

            ! Check BLUE button
            IF DI3 = 1 THEN
                Enqueue("BLUE");
                SetDO DO3, 1;
                WaitUntil DI3=0;
            ENDIF;

            ! Check YELLOW button
            IF DI4 = 1 THEN
                Enqueue("YELLOW");
                SetDO DO4, 1;
                WaitUntil DI4=0;
            ENDIF;

            WaitTime 0.05;
        ENDWHILE
    ENDPROC

    PROC Enqueue(req STRING)
        requestQueue[tail] := req;
        tail := tail + 1;
        IF tail > Dim(requestQueue,1) THEN
            tail := 1;
        ENDIF;
    ENDPROC
ENDMODULE

---