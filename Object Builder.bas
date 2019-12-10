' FOR DEMONSTRATION ONLY. NOT INTEGRATED INTO MAIN PROGRAM YET.
'
' New way of handling data to move it to disk, free up more available memory by removing it
' from program memory and storing it in a cache outside of available memory.
' instead of storing exits as separate variables, they all can be merged into one and
' extrapolated through AND logic.


' first part stores all data to disk
' 800 onwards reads back that test data


'OBJECTS - NAMEs, 
' 1)LOCATION, 2)WEIGHT, 3)STATSID, 4)GOTO, 5)LOOK, 6)USE-swap with, 7)OBJ MUST BE PRESENT,
' 8)TRIGGERID, 9)triggeron 1-look, 2-get, 3-drop, 4-help, 5-use, 6-attack. 7-kill
' 10)EQUIP to slot, 11)OBJECT OR NPC   0=object, 1=hostileNPC 2=FriendlyNPC   --not yet-- 12)OBJ MUST NOT BE PRESENT

100 DATA "rusty sword","sword",3,4,8,0,1,0,16,9,5,11,0
101 data "crumpled note","note",-1,0,0,0,2,0,0,0,0,0,0
110 DATA "pile of rocks","rocks",2,99,0,0,4,0,0,0,0,0,0,"open iron gate","gate",0,99,0,3,0,0,0,0,0,0,0
115 DATA "loin cloth","cloth",-2,0,4,0,3,0,0,0,0,6,0
120 DATA "dirty hole","hole",3,99,0,4,5,0,0,0,0,0,0, "lantern","lamp",0,2,1,0,8,8,0,6,0,0,0
130 DATA "glowing lantern","lantern",0,4,2,0,6,7,0,6,0,0,0, gold,,4,3,0,0,0,0,0,0,0,0,0, gold,,4,4,0,0,0,0,0,4,0,0,0
140 DATA "leather cuirass","cuirass",10,2,1,0,0,0,0,5,2,3,0,"rusty key","key",0,1,0,0,0,0,13,3,0,0,0
150 DATA "iron gate","gate",2,99,0,0,7,4,12,3,0,0,0
160 DATA "angry skeleton","skeleton",0,99,3,0,0,0,0,8,7,0,1, "lamp","lantern",1,99,0,0,9,0,0,7,2,0,0
170 DATA "chain","chain",0,99,0,0,10,0,1,9,5,0,0 ,"inanimate bones","bones",,3,,,11,,,,,,
175 DATA "dynastic shoulder pad","pad",0,1,4,0,12,0,0,0,0,4,0
180 data "squealing rat","rat",0,99,5,0,0,0,0,0,0,0,1, "angry badger","badger",0,99,6,0,0,0,0,0,0,0,1
200 data "randy ferret","ferret",0,99,6,0,0,0,0,0,0,0,1, "rattlesnake","snake",0,99,6,0,0,0,0,0,0,0,1
210 data "wraith","wraith",0,99,6,0,0,0,0,0,0,0,1, "goblin","goblin",0,99,6,0,0,0,0,0,0,0,1
220 data "randy ferret","ferret",0,99,6,0,0,0,0,0,0,0,1, "rattlesnake","snake",0,99,6,0,0,0,0,0,0,0,1
240 data "fire ants","ants",0,99,6,0,0,0,0,0,0,0,1, "romany tinker","tinker",5,99,0,0,0,0,0,0,0,0,2
'item 29&30
241 data "tunnel","tunnel",11,99,0,12,0,0,0,0,0,0,0,  "tunnel","tunnel",12,99,0,11,0,0,0,0,0,0,0
242 data "iron gate","gate",3,99,0,0,0,32,33,11,0,0,0, "open iron gate","gate",0,99,0,9,0,31,33,11,0,0,0
243 data "crypt key","key",0,1,0,0,0,0,31,11,0,0,0

'insert new locations before here before null data terminator
550 DATA "*","*",0,0,0,0,0,0,0,0,0,0,0,0


' FOR X=1 TO 28: READ OB$(X) : READ OBSYN$(X):FOR Y=1 TO 11:READ OB(X,Y):NEXT Y,X:?@1878,chr$(191);
589 DIM OB$(40),OBsyn$(40),v(40)
600 OPEN "O", 1,"Objects:1"
605 X=1
610 READ OB$(X),OBsyn$(X) : ?  OB$(X),OBsyn$(X);: for x2=1 to 11: read v(x2): ? v(x2);:next


615 WRITE#1, OB$(X),OBsyn$(X):for x2=1 to 11: write#1, v(x2):next

620 WHILE OB$(X)<>"*"
' OPEN "O" = OUTPUT, 1 = BUFFER #1, "LOCatS:1" = FILENAME:DRIVE

630 X=X+1:?:goto 610
660 WEND
670 CLOSE
680 ?:?"Object Data written to disk."
690 END



'second part of program. run 800 from prompt
800 DIM OB$(40),OBsyn$(40),v(40)
' OPEN "I" = INPUT, 1 = BUFFER #1, "LOCatS:1" = FILENAME:DRIVE
810 OPEN "I", 1, "Objects:1"
820 x=1
830 INPUT# 1, OB$(X),OBsyn$(X) : ?  OB$(X),OBsyn$(X);: for x2=1 to 11: input# 1, v(x2): ? v(x2);:next

912 WHILE OB$(X)<>"*"
914 x=x+1:?:goto 830
915 wend
920 CLOSE 1
930 END