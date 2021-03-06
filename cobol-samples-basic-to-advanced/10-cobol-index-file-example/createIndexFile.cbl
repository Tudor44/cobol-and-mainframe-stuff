       IDENTIFICATION DIVISION.
       PROGRAM-ID. CREATE-INDEX-FILE.
       AUTHOR. GAETANO.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
       SELECT IN-FILE ASSIGN TO "/Users/gaetanodorsi/file.txt"
           ORGANISATION IS LINE SEQUENTIAL.
       SELECT OUT-FILE ASSIGN TO "/Users/gaetanodorsi/file1.txt"
           ORGANISATION IS INDEXED
           ACCESS IS SEQUENTIAL
           RECORD KEY IS ACCT-NO-OUT
           FILE STATUS IS WS-STATUS.
       DATA DIVISION.
       FILE SECTION.
       FD IN-FILE
           RECORD CONTAINS 6 CHARACTERS.
           01 IN-REC.
               02 ACCT-NO-IN               PIC 9(2).
               02 AMT-DUE-IN               PIC 9(4).
       FD OUT-FILE.
           01 OUT-REC.
               02 ACCT-NO-OUT               PIC 9(2).
               02 AMT-DUE-OUT              PIC 9(4).
       WORKING-STORAGE SECTION.
       01 ARE-THERE-MORE-RECORDS          PIC XXX VALUE "YES".
           88 NO-MORE-RECORDS                     VALUE "NO".
       01 WS-STATUS                       PIC XX.
       PROCEDURE DIVISION.
       100-MAIN-RTN.
           OPEN INPUT IN-FILE
                OUTPUT OUT-FILE
            PERFORM UNTIL NO-MORE-RECORDS
              READ IN-FILE
                  AT END
                      MOVE "NO" TO ARE-THERE-MORE-RECORDS
                  NOT AT END
                      PERFORM 200-CREATE-RTN
               END-READ
             END-PERFORM
             CLOSE IN-FILE
                  OUT-FILE
             STOP RUN.

       200-CREATE-RTN.
           MOVE IN-REC TO OUT-REC
           DISPLAY OUT-REC
           WRITE OUT-REC
               INVALID KEY PERFORM 400-ERROR-RTN
           END-WRITE.

        400-ERROR-RTN.
            IF WS-STATUS = 22
                   DISPLAY " YOU HAVE A DUPLICATE RECORD"" "  WS-STATUS
            ELSE
             IF WS-STATUS = 21
                 DISPLAY  " OUT OF SEQUEMCE ERROR"  "  "  WS-STATUS
            ELSE
                 DISPLAY " WRITTING ERROR"
           END-IF.
