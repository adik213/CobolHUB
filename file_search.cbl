       IDENTIFICATION DIVISION.
       PROGRAM-ID. FILE-SEARCH.
       ENVIRONMENT DIVISION.
         INPUT-OUTPUT SECTION.
           FILE-CONTROL.
            SELECT INFILE ASSIGN TO 'D:\Adrian\Projekty\Cobol\input.dtx'
            ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
         FILE SECTION.
           FD INFILE.
             01 CLIENTDATA.
               05 PERSON.
                 10 PERSONID PIC 9(5).
                 10 FIRSTNAME PIC X(20).
                 10 LASTNAME PIC X(20).

       WORKING-STORAGE SECTION.
       01 WS-CLIENTDATA.
          05 WS-PERSON.
            10 WS-PERSONID PIC 9(5).
            10 WS-FIRSTNAME PIC X(20).
            10 WS-LASTNAME PIC X(20).
       01 WS-EOF PIC A(1).
       01 WS-SEARCH-QUERY PIC X(20).
       01 WS-SEARCH-QUERY-2 PIC X(20).
      *-----------------------
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.
            DISPLAY "Type search query:".
            ACCEPT WS-SEARCH-QUERY.
      *REMOVE NEW LINE*
            INSPECT WS-SEARCH-QUERY
              REPLACING ALL X'0A' BY SPACE
              REPLACING ALL X'0D' BY SPACE.
      ***
            DISPLAY "Loading file...".
            SET WS-EOF TO 'N'.
            OPEN INPUT INFILE.
            PERFORM UNTIL WS-EOF = 'Y'
              READ INFILE INTO WS-PERSON
               AT END MOVE 'Y' TO WS-EOF
              NOT AT END
               IF WS-SEARCH-QUERY = WS-FIRSTNAME OR WS-LASTNAME
                 DISPLAY "Found with ID:",WS-PERSONID
               END-IF
              END-READ
            END-PERFORM.

            CLOSE INFILE.
            STOP RUN.
       END PROGRAM FILE-SEARCH.
