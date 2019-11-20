' FOR DEMONSTRATION ONLY. NOT INTEGRATED INTO MAIN PROGRAM YET.
'
' New way of handling data to move it to disk, free up more available memory by removing it
' from program memory and storing it in a cache outside of available memory.
' instead of storing exits as separate variables, they all can be merged into one and
' extrapolated through AND logic.


' first part stores all data to disk
' 200 onwards reads back that test data

10 DATA "a slippery path", "You are standing at crest of a muddy hill. Behind you, the path steeply slopes  to your certain death in the cold rapids. Eastward you see a small village in   the distance.",2
20 DATA "Path to the village.", "You are on the long path to the village. The path is faded and overgrown here asif people have been avoiding it.",12
30 DATA "Spooky graveyard","You are in a spooky graveyard. It was sunny outside, but now it is overcast and fog curls around the mossy stones and leafless trees.",8
40 DATA "foisty smelling grave","You are in a dark hole, slimy and foisty smelling.",24, "location 5","loc 5 verbose",0
50 DATA "location 6","loc 6 verbose",0,"location 7","loc 7 verbose",0,"location 8","loc 8 verbose",0
60 DATA "location 9","loc 9 verbose",0, "location 10","Place to be named by lazy co-author",1,"location 11","loc 11 verbose",0
70 DATA "location 12","loc 12 verbose",0,"location 13","loc 13 verbose",0,"location 14","loc 14 verbose",0
80 DATA "location 15","loc 15 verbose",0, "location 16","loc 16 verbose",0,"location 17","loc 17 verbose",0
89 DIM L$(20),LV$(20),L(20)
90 FOR X=1 TO 17: READ L$(X): READ LV$(X): READ L(X): NEXT X
' OPEN "O" = OUTPUT, 1 = BUFFER #1, "LOCatS:1" = FILENAME:DRIVE
100 OPEN "O", 1,"LOCatS:1"
110 FOR X = 1 TO 17

130 WRITE#1, L$(X),LV$(X),L(X)
140 'INPUT "Enter exits from room -add up total 1=N, 2=E, 4=S, 8=W, 16=No Light";DIRECTIONS
150 'WRITE#1,DIRECTIONS
160 NEXT
170 CLOSE
180 ?"Data written to disk."
190 END



'second part of program. run 200 from prompt
200 DIM L$(20),LV$(20),L(20):
' OPEN "I" = INPUT, 1 = BUFFER #1, "LOCatS:1" = FILENAME:DRIVE
210 OPEN "I", 1, "LOCatS:1"
220 FOR X = 1 TO 17
230 INPUT# 1,L$(X),LV$(X),L(X)
240 PRINT L$(X),LV$(X),L(X)
250 DIRECTIONS=L(X)
260 IF DIRECTIONS AND 1 THEN PRINT "N. ";
270 IF DIRECTIONS AND 2 THEN PRINT "E. ";
280 IF DIRECTIONS AND 4 THEN PRINT "S. ";
290 IF DIRECTIONS AND 8 THEN PRINT "W. ";
300 IF DIRECTIONS AND 16 THEN PRINT "No Light.";
310 ?: NEXT
320 CLOSE 1
330 END