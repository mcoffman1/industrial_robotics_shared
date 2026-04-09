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