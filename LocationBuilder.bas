' FOR DEMONSTRATION ONLY. NOT INTEGRATED INTO MAIN PROGRAM YET.
'
' New way of handling data to move it to disk, free up more available memory by removing it
' from program memory and storing it in a cache outside of available memory.
' instead of storing exits as separate variables, they all can be merged into one and
' extrapolated through AND logic.


' first part stores all data to disk
' 800 onwards reads back that test data



'add up total 1=N, 2=E, 4=S, 8=W, 16=No Light
10 DATA "a slippery path", "You are standing at crest of a muddy hill. Behind you, the path steeply slopes  to your certain death in the cold rapids. Eastward you see a small village in   the distance.",2
20 DATA "Path to the village.", "You are on the long path to the village. The path is faded and overgrown here asif people have been avoiding it.", 12
30 DATA "Spooky graveyard","You are in a spooky graveyard. It was sunny outside, but now it is overcast and fog curls around the mossy stones and leafless trees.",8
40 DATA "foisty smelling grave","You are in a dark hole, slimy and foisty smelling.",24
50 DATA "Broken wall","You are at the broken stone wall separating the path from the bog at the bottom of the embankment",4
60 DATA "location 6","loc 6 verbose",0
64 DATA "location 7","loc 7 verbose",0
66 DATA "location 8","loc 8 verbose",0
70 DATA "location 9","loc 9 verbose",0
74 DATA "location 10","Place to be named by lazy co-author",1
80 data "Thicket","You are in a thicket. The sharp branches make the exit east impassable, yet somenice person has dug a small tunnel through",8
90 DATA "forking path","You are at a fork in the path. Eastwards, the road to the village remerges. A small path to a windmill lies to the south.",6
94 DATA "old village road","You are on the cobbled road to the village",15
100 DATA "location 14","loc 14 verbose",0
110 DATA "location 15","loc 15 verbose",0
120 DATA "location 16","loc 16 verbose",0
130 DATA "location 17","loc 17 verbose",0
140 DATA "location 18","loc 18 verbose",0
150 DATA "location 19","loc 19 verbose",0
160 DATA "Windmill","Windmill verbose",1
170 DATA "location 21","loc 21 verbose",0
180 DATA "location 22","loc 22 verbose",0
190 DATA "location 23","loc 23 verbose",0
200 DATA "location 24","loc 24 verbose",0

'insert new locations before here before null data terminator
550 DATA "*","*",0


589 DIM L$(40),LV$(40),L(40)
600 OPEN "O", 1,"LOCatS:1"
605 X=1
610 READ L$(X),LV$(X),L(X)
615 WRITE#1, L$(X),LV$(X),L(X)
620 WHILE L$(X)<>"*"
' OPEN "O" = OUTPUT, 1 = BUFFER #1, "LOCatS:1" = FILENAME:DRIVE

630 X=X+1:goto 610
640 'INPUT "Enter exits from room -add up total 1=N, 2=E, 4=S, 8=W, 16=No Light";DIRECTIONS
650 'WRITE#1,DIRECTIONS
660 WEND
670 CLOSE
680 ?"Data written to disk."
690 END



'second part of program. run 800 from prompt
800 DIM L$(40),LV$(40),L(40):
' OPEN "I" = INPUT, 1 = BUFFER #1, "LOCatS:1" = FILENAME:DRIVE
810 OPEN "I", 1, "LOCatS:1"
820 x=1
830 INPUT# 1,L$(X),LV$(X),L(X)
840 PRINT L$(X),LV$(X),L(X)
850 DIRECTIONS=L(X)
860 IF DIRECTIONS AND 1 THEN PRINT "N. ";
870 IF DIRECTIONS AND 2 THEN PRINT "E. ";
880 IF DIRECTIONS AND 4 THEN PRINT "S. ";
890 IF DIRECTIONS AND 8 THEN PRINT "W. ";
900 IF DIRECTIONS AND 16 THEN PRINT "No Light.";
910 ?:
912 while l$(x)<>"*"
914 x=x+1:goto 830
915 wend
920 CLOSE 1
930 END