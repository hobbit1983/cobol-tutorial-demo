      *-----------------------                                          00001000
       IDENTIFICATION DIVISION.                                         00002000
      *-----------------------                                          00003000
       PROGRAM-ID.    CBL0001                                           00004000
       AUTHOR.        Otto B. Fun.                                      00005000
      *--------------------                                             00006000
       ENVIRONMENT DIVISION.                                            00007000
      *--------------------                                             00008000
       INPUT-OUTPUT SECTION.                                            00009000
       FILE-CONTROL.                                                    00020000
           SELECT PRINT-LINE ASSIGN TO PRTLINE.                         00030000
           SELECT ACCT-REC   ASSIGN TO ACCTREC                          00040000
                  ORGANIZATION IS SEQUENTIAL.                           00041000
      *-------------                                                    00042000
       DATA DIVISION.                                                   00043000
      *-------------                                                    00044000
       FILE SECTION.                                                    00045000
       FD  PRINT-LINE RECORDING MODE F.                                 00046000
       01  PRINT-REC.                                                   00047000
           05  ACCT-NO-O      PIC X(8).                                 00048000
           05  ACCT-LIMIT-O   PIC $$,$$$,$$9.99.                        00049000
           05  ACCT-BALANCE-O PIC $$,$$$,$$9.99.                        00050000
           05  LAST-NAME-O    PIC X(20).                                00060000
           05  FIRST-NAME-O   PIC X(15).                                00070000
           05  COMMENTS-O     PIC X(50).                                00080000
      *                                                                 00090000
       FD  ACCT-REC RECORDING MODE F.                                   00100000
       01  ACCT-FIELDS.                                                 00101000
           05  ACCT-NO        PIC X(8).                                 00102000
           05  ACCT-LIMIT     PIC S9(7)V99 COMP-3.                      00103000
           05  ACCT-BALANCE   PIC S9(7)V99 COMP-3.                      00104000
           05  LAST-NAME      PIC X(20).                                00105000
           05  FIRST-NAME     PIC X(15).                                00106000
           05  STREET-ADDR    PIC X(25).                                00107000
           05  CITY-COUNTY    PIC X(20).                                00108000
           05  USA-STATE      PIC X(15).                                00108100
           05  RESERVED       PIC X(7).                                 00108200
           05  COMMENTS       PIC X(50).                                00108300
      *                                                                 00108400
       WORKING-STORAGE SECTION.                                         00108500
       01 FLAGS.                                                        00108600
         05 LASTREC           PIC X VALUE SPACE.                        00108700
      *------------------                                               00108800
       PROCEDURE DIVISION.                                              00108900
      *------------------                                               00109000
       OPEN-FILES.                                                      00110000
           OPEN INPUT  ACCT-REC.                                        00120000
           OPEN OUTPUT PRINT-LINE.                                      00121000
      *                                                                 00122000
       READ-NEXT-RECORD.                                                00123000
           PERFORM READ-RECORD                                          00124000
           PERFORM UNTIL LASTREC = 'Y'                                  00125000
           PERFORM WRITE-RECORD                                         00126000
           PERFORM READ-RECORD                                          00127000
           END-PERFORM.                                                 00128000
      *                                                                 00129000
       CLOSE-STOP.                                                      00130000
           CLOSE ACCT-REC.                                              00140000
           CLOSE PRINT-LINE.                                            00150000
           STOP RUN.                                                    00160000
      *                                                                 00170000
       READ-RECORD.                                                     00180000
           READ ACCT-REC                                                00190000
           AT END MOVE 'Y' TO LASTREC                                   00200000
           END-READ.                                                    00210000
      *                                                                 00220000
       WRITE-RECORD.                                                    00230000
           MOVE ACCT-NO      TO  ACCT-NO-O.                             00240000
           MOVE ACCT-LIMIT   TO  ACCT-LIMIT-O.                          00241000
           MOVE ACCT-BALANCE TO  ACCT-BALANCE-O.                        00242000
           MOVE LAST-NAME    TO  LAST-NAME-O.                           00243000
           MOVE FIRST-NAME   TO  FIRST-NAME-O.                          00244000
           MOVE COMMENTS     TO  COMMENTS-O.  
           WRITE PRINT-REC.                                             00246000
      *                                                                 00247000
