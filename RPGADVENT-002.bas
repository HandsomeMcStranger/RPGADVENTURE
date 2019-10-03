'-------------------------------------------------------------------------------------
'                    RPG ADVENTURE                    Version 001
'--------------------------------------------------------------------------------------
10 cohort$="<Insert Your Name Here,esq.>"
50 CLS:BR$=CHR$(10):PRINT "Welcome to * RPG ADVENTURE 1 * - Loin Cloth of the Gods."+BR$+"A New, old adventure by Some Dude and "+cohort$+"."+BR$+BR$+"In this game, you will travel to far off imaginary lands and command me with"
55 PRINT "embarrassing Pidgin English grunts, all the while upping your stats by fighting monsters and looting valuables so you can make it to the final boss and earn themagical McGuffin for defeating the game."
60 PRINT BR$+"Along the way you will discover a few errors here and there. Be a good sport    And fix them without whining too much. We never said we were experts at this."
61 ?br$+"TIPS:":?"Press the enter key to toggle between your stats and your location."
65 ? "Turn off capslock. Interpreter only understands lower case at the moment."
70 '
75 '
80 '
85 '
90 '

'load data while user is readin
100 CLEAR 255: DEFINT A-Z: dim c$(20),l$(20),l(20,20),ob$(20),ob(20,20),obsyn$(20),obsyn(20,20),csyn$(25),csyn(25,1),act$(15),stat(25,25),statinc(25,25),looktrig(20):br$=chr$(10):stdp=1
110 LO=1:weight=0:maxweight=10:strength=1:attack=0:xp=0:gold=0:health=10:luck=0:magic=0:speed=0:skill=0: stamina=0:charisma=0:keys=0

'DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA 
'--------------------------------------------'locations - NAME, N, E, S, W, Visited?, Dark?----------------------------------
111 DATA "a slippery path", "You are standing at crest of a muddy hill. Behind you, the path steeply slopes  to your certain death in the cold rapids. Eastward you see a small village in   the distance.",0,1,0,0,0,0
112 data "Path to the village.", "You are on the long path to the village. The path is faded and overgrown here asif people have been avoiding it.", 0,0,0,1,0,0
113 data "Spooky graveyard","You are in a spooky graveyard. It was sunny outside, but now it is overcast and fog curls around the mossy stones and leafless trees.",0,0,0,1,0,0
114 data "foisty smelling grave","You are in a dark hole, slimy and foisty smelling.",0,0,0,1,0,1
129 FOR X=1 TO 4: read l$(x): read lv$(x):FOR Y=1 TO 6: READ L(X,Y): NEXT Y,X
'----------------------------------------------------------------------------------------------------------------------------

'------------------------------------------------  C O M M A N D S ---------------------------------------------------------- 
130 DATA n,e,s,w,go,i,look,get,drop,help,use,stats,equip,unequip,attack
135 FOR C=1 TO 15: READ C$(C): NEXT C
'----------------------------------------------------------------------------------------------------------------------------

'---------------------------- N P C s    name, 1)location, 2)weight, 3)attack, 4)health, 5)look 6)swap with
140 data "skeleton",0,0,0,0,0,0, "skeleton warrior",0,0,0,0,0,0
145 for x=1 to 2:read npc$(x):for y=1 to 6:read npc(x,y):next y,x
'----------------------------------------------------------------------------------------------------------------------------

'OBJECTS - NAME, 1)LOCATION, 2)WEIGHT, 3)STATSID, 4)GOTO, 5)LOOK, 6)USE-swap with, 7)OBJ MUST BE PRESENT,
'8)TRIGGERID 8)triggeronget, 9)triggerondrop, 10)triggeronlook, 11)triggeronuse 12)trigger on use from other, 13) equip location
150 DATA "rusty sword","sword",2,4,8,0,1,0,0,, "crumpled note","note",-1,0,0,0,2,0,0,, "pile of rocks","rocks",2,99,0,0,4,0,0,,"slanty iron gate","gate",0,99,0,3,0,0,0,,"loin cloth","cloth",-2,0,0,0,3,0,0,,"dirty hole","hole",3,99,0,4,5,0,0,
155 data "lantern","lamp",1,2,1,0,0,8,0,, "glowing lantern","lantern",0,4,2,0,6,7,1,,gold,,4,3,0,0,0,0,0,, gold,,4,4,0,0,0,0,0,,"leather cuirass","cuirass",0,2,1,0,0,0,0,,"rusty key","key",0,0,0,0,0,0,13,, "iron gate","gate",2,99,0,0,7,4,12,2
160 FOR X=1 TO 13: READ OB$(X) : read obsyn$(x):FOR Y=1 TO 8:READ OB(X,Y):NEXT Y,X
'----------------------------------------------------------------------------------------------------------------------------

'------------------------------------------------- A C T I O N S - R E S P O N S E S ----------------------------------------
165 data "You rub the lantern","You found something.","You hear the squeal of grinding metal as the gate swings open."
170 for ac=1 to 3: read act$(ac):next
'----------------------------------------------------------------------------------------------------------------------------

'---------------------------------- T R I G G E R S - - -  1)swap with object, 2)insert object at loc, 3)insert object to inv,
'------------- 4)trigger death, 5)teleport user, 6)delete object, 7)execute another trigger, 8)action message, 9(STAT INCREASE 
173 DATA ,12,,,,,,2,1, 0,4,0,0,0,13,3,3,2, 0,0,0,0,0,12,0,0,0
174 for x= 1 to 3: for y=1 to 9: read trigger(x,y):next y,x
'----------------------------------------------------------------------------------------------------------------------------

'STAT INCREASE -  1)ATTACK, 2)DEFENSE, 3)HEALTH, 4)STRENGTH, 5)SKILL, 6)STAMINA, 7)LUCK, 8)CHARISMA, 9)MAGIC, 10)GOLD, 11) XP
175 data 1,2,3,4,5,6,7,8,9,10,11, 0,0,0,0,1,0,0,0,0,0,10
176 for x= 1 to 2: for y=1 to 11: read statinc(x,y):next y,x
'----------------------------------------------------------------------------------------------------------------------------

'*** L O O K   R E S P O N S E S *** 
177 DATA "It's seen better days, but will serve you well.",,"It says welcome to RPG Adventure 1",,"You need to visit a tailor",,"There's a loose stone with something hidden beneath",1,"Looks freshly dug",,"it glows with magic",,"It's locked",
180 FOR X=1 TO 7: READ EX$(X): read looktrig(x) : NEXT
'----------------------------------------------------------------------------------------------------------------------------

'*** E R R O R   R E S P O N S E S ***
185 DATA "You can't go that direction.", "It's not here.", "It's too heavy, or You're carrying too much.", "You don't have it.", "You can't use that.", "can't use it with anything here."
190 FOR ER=1 TO 6: READ ER$(ER):NEXT ER
'----------------------------------------------------------------------------------------------------------------------------

'*** S T A T S ***     1)ATTACK, 2)DEFENSE, 3)HEALTH, 4)STRENGTH, 5)SKILL, 6)STAMINA, 7)LUCK, 8)CHARISMA, 9)MAGIC, 10)GOLD, 11)EQUIP SLOT
194 data 0,0,0,0,0,0,0,0,0,0,1, 0,2,1,1,2,0,2,1,1,0,1, 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,
195 DATA 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1
196 FOR X=1 TO 11: FOR Y=1 TO 11:READ stat(X,Y):NEXT Y,X
'DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END
'----------------------------------------------------------------------------------------------------------------------------

'wait for user to finish reading
197 print "<press any key>"
198 i$=inkey$:if i$="" then 198 else cls:goto 9500


'initialize variables for next input
199 CO$="": C0$="": OB$="": csyn=0:ih=0: OB1=0:ob2=0: x=1: :xx=1:LIGHT=0:PRINT@1840,"";
200 INPUT "---What now--->";A$:if a$="" then stdp=-stdp: if stdp<0 then 7200

'switch to replace landing spot of all commands
'201 on cx goto 210,211,212,213,215,320,430,541,651,761,871

'interpret words
202 LA=LEN(A$): FOR A=1 TO LA: C0$=MID$(A$,A,1): IF C0$<>" " THEN CO$=CO$+C0$:NEXT
204 OB$=MID$(A$,A+1,LA) : for cx=1 to 13:if co$<>c$(cx) then next
206 FOR X=1 TO 13:IF OB$<>OB$(X) and ob$<>obsyn$(x) THEN NEXT ELSE OB1=X
207 if ob(ob1,1)=lo or ob(ob1,1)<0 then 208 else FOR X=ob1+1 TO 13:IF OB$<>OB$(X) and ob$<>obsyn$(x) then next else ob1=x
208'


'display commands and object number for debugging
209 'PRINT "command #:";cx;" Object #: ";OB1;"/";OB2:


' directions
210 IF Cx=1 THEN IF L(LO,1)<>1 THEN PRINT ER$(1) ELSE l(lo,5)=1:LO=LO-8
211 IF Cx=2 THEN IF L(LO,2)<>1 THEN PRINT ER$(1) ELSE l(lo,5)=1:LO=LO+1            
212 IF Cx=3 THEN IF L(LO,3)<>1 THEN PRINT ER$(1) ELSE l(lo,5)=1:LO=LO+8
213 IF Cx=4 THEN IF L(LO,4)<>1 THEN PRINT ER$(1) ELSE l(lo,5)=1:LO=LO-1


' go through portal object
214 IF cx<>5 THEN 319
215 IF OB(OB1,1)=LO THEN IF OB(OB1,4)<>0 THEN LO=OB(OB1,4) ELSE PRINT "You can't go there."


' take inventory
319 IF cx<>6 THEN 430
320 PRINT "You are carrying the following...";:FOR X=1 TO 13: :if ob(x,1)<-1 then print "*";
322 IF OB(X,1)<0 THEN PRINT OB$(X);". ";
324 REM FOR X=1 TO 13: IF OB(X,1)<0 THEN PRINT OB$(X); if ob(x,1)<-1 then print "* ";
326 NEXT X:PRINT


' look
430 IF CO$<>C$(7) THEN 540 else if ob1=0 then print lv$(lo):goto 9500
432 IF OB(OB1,1)<0 OR OB(OB1,1)=LO THEN PRINT EX$(OB(OB1,5)) :triggerit=looktrig(ob(ob1,5)) : OB(OB1,5)=0: goto 6000 else print "It's not here.":goto 9500


'get
540 if cx<>8 then 650
541 if ob(ob1,1)<>lo then print er$(2):goto 9500
542 if ob(ob1,2)+weight < maxweight then ob(ob1,1)=-1:weight=weight+ob(ob1,2): Print "Taken." else print er$(3) :goto 9500
543 if ob$(ob1)="gold" then gold=gold+ob(ob1,2): ob(ob1,1)=0: ob$(ob1)="":print "Ker-ching!"
544 if ob$(ob1)="key" then keys=keys+ob(ob1,2):ob(ob1,1)=0: ob$(ob1)="":print "Jingle Jangle!"


'drop
650 if cx<>9 then 760
651 if ob(ob1,1)<>-1 then print er$(2):goto 9500 else ob(ob1,1)=lo:weight=weight-ob(ob1,2): Print "Dropped." else print er$(4)
'152 if ob$(ob1)="gold" then gold=gold-ob(ob1,2): print "Bye bye, money"


'help
760 if cx<>10 then 870
761 print "Use two word sentences like ";c$(6);" ";ob$(2);".";chr$(10);"Some commands to try are: ";:for x=1 to 9: print c$(x);". "; : next:print
762 goto 9500





'------------------------------------------------------------------------------------------------------------------------------------
'COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE
        870 if cx<>11 then 995
        871 if ob(ob1,1)<>lo and ob(ob1,1)>-1 then 995
        874 if ob(ob(ob1,7),1)=lo then triggerit=ob(ob(ob,7),8)
        875 if ob(ob1,7)<>0 then if ob(ob(ob1,7),1)<>lo and ob(ob(ob1,7),1)>-1 then print er$(2):goto 995 else triggerit=ob(ob(ob1,7),8):goto 6000
        882 'if ob(ob1,7)=0 then 873 else if ob(ob(ob1,7),1)<>lo and ob(ob(ob1,7),1)>0 then print er$(6):goto 995 else triggerit=ob(ob(ob1,7),8):goto 6000
        883 if ob(ob1,1)>-1 and ob(ob1,1)<>lo then print er$(2):goto 995
        884 if ob(ob1,6)<0 and ob(obsyn,6) <0 then print er$(5):goto 995
        885  ob2= ob(ob1,6): swap ob(ob1,1), ob(ob2,1): PRINT act$(ob(ob2,7));". ";EX$(ob(ob2,5))
'------------------------------------------------------------------------------------------------------------------------------------

'stats on object
'STATS 1)ATTACK, 2)DEFENSE, 3)HEALTH, 4)STRENGTH, 5)SKILL, 6)STAMINA, 7)LUCK, 8)CHARISMA, 9)MAGIC, 10)GOLD
995 if cx<>12 then 9500
996 if ob(ob1,1) >0 and ob(ob1,1)<>lo then print er$(2) : goto 9500 else print "Stats on "; ob$(ob1) :statob=ob(ob1,3)
997 print "Attack: ";stat(statob,1);"  /   Defense: ";stat(statob,2);"  /   Health:";stat(statob,3);"  /   Strength:";stat(statob,4);"   /  Skill:";stat(statob,5)
998 print "Stamina:";stat(statob,6);"  /   Charisma:";stat(statob,8);"  /   Luck:  ";stat(statob,7); "  /   Magic:   ";stat(statob,9);"   /  Gold: ";stat(statob,10)
999 goto 9500

'death
1000

'fight
4000


'map
5000 

'EXECUTE TRIGGERS
'---------------------------------- T R I G G E R S - - -  1)swap with object, 2)insert object at loc, 3)insert object to inv,
'------------- 4)trigger death, 5)teleport user, 6)delete object, 7)execute another trigger, 8)action message, 9(STAT INCREASE 
'0,4,0,0,0,13,0,3,2
6000 '
6010 if trigger(triggerit,1)>0 then swap ob(ob1,1) , ob(triggerit,1)
6020 if trigger(triggerit,2)>0 then ob(trigger(triggerit,2),1)=lo:
6030 if trigger(triggerit,3)>0 then ob(trigger(triggerit,3),1)=-1
6040 if trigger(triggerit,4)>0 then 1000
6050 if trigger(triggerit,5)>0 then lo =  trigger(triggerit,5)
6060 if trigger(triggerit,6)>0 then ob(trigger(triggerit,6),1)=0
6070 if trigger(triggerit,7)>0 then goto trigger(triggerit,7)
6080 if trigger(triggerit,8)>0 then PRINT act$ (trigger(triggerit,8));". "
6090 if trigger(triggerit,9)>0 then PRINT "Your stats have increased. ":gosub 7300
6070 if trigger(triggerit,7)>0 then ob1=trigger(triggerit,7):goto 871 
6100 goto 9500





' STATS PAGE
7200 PRINT@0,STRING$(240,32):PRINT @240,STRING$(80,32):print@0,
7201 print "Carry Weight: ",weight: print "Max Weight: ",maxweight:print"Strength: ",strength
7202 print "Experience: ",xp:print "Gold: ",gold:print "Health: ",health :print "keys: ",keys
7203 print "Attack:",attack: print "Defense: ",defense: print "Skill: ",skill;
7204 print "   Stamina: ";stamina; "   Luck:";luck; "   Charisma: ";charisma;"   Magic: ";magic

7205 print @30, string$(3,32)+chr$(176)+chr$(188)+chr$(176);
7206 print @112,chr$(170)+string$(3,32)+chr$(149);
7207 print @190,string$(3,176)+chr$(187)+chr$(128)+chr$(183)+string$(3,176);
7208 print @269,chr$(170)+string$(2,32)+chr$(175)+string$(3,32)+chr$(159)+string$(2,32)+chr$(149);
7209 print @350,chr$(171)+chr$(151)+chr$(162)+string$(3,191)+chr$(129)+chr$(171)+chr$(151);
7210 print @432,chr$(170)+string$(3,32)+chr$(149);
7211 print @510,chr$(130)+chr$(129)+chr$(130)+chr$(191)+chr$(131)+chr$(191)+chr$(129)+chr$(130)+chr$(129);
7212 print @592,chr$(176)+chr$(191)+chr$(32)+chr$(191)+chr$(176);
7213 print @671,chr$(170)+string$(5,32)+chr$(149);
7214 print @752,string$(2,131)+chr$(32)+string$(2,131);

7220 print @113,"000";:print@270,"00";:print@273,"000";:?@277,"00";
7221 print @430,"00";:?@433,"000";:?@437,"00";
7222 print @672,"00";:?@675,"00";
7299 goto 199


'110 maxweight=10:strength=1:attack=0:xp=0:gold=0:health=10:luck=0:magic=0:speed=0:skill=0: stamina=0:charisma=0:keys=0
'INCREASE STATS -  1)ATTACK, 2)DEFENSE, 3)HEALTH, 4)STRENGTH, 5)SKILL, 6)STAMINA, 7)LUCK, 8)CHARISMA, 9)MAGIC, 10)GOLD, 11) XP
7300 statstoinc=trigger(triggerit,9)
7310 if statinc(statstoinc,1)<>0 then attack=attack+statinc(statstoinc,1)
7320 if statinc(statstoinc,2)<>0 then defense=defense+statinc(statstoinc,2)
7330 if statinc(statstoinc,3)<>0 then health=health+statinc(statstoinc,3)
7340 if statinc(statstoinc,4)<>0 then strength=strength+statinc(statstoinc,4)
7350 if statinc(statstoinc,5)<>0 then skill=skill+statinc(statstoinc,5)
7360 if statinc(statstoinc,6)<>0 then stamina=stamina+statinc(statstoinc,6)
7370 if statinc(statstoinc,7)<>0 then luck=luck+statinc(statstoinc,7)
7380 if statinc(statstoinc,8)<>0 then charisma=charisma+statinc(statstoinc,8)
7390 if statinc(statstoinc,9)<>0 then magic=magic+statinc(statstoinc,9)
7400 if statinc(statstoinc,10)<>0 then gold=gold+statinc(statstoinc,10)
7410 if statinc(statstoinc,11)<>0 then xp=xp+statinc(statstoinc,11)
'7500 return


' MAPS PAGE
8000 rem map stuff goes here


' update new screen goes here
'light source present?
9500 if ob(8,1)<0 or ob(8,1)=lo then light=1                                                                  
9501 PRINT@0,STRING$(240,32):PRINT @240,STRING$(80,32):if l(lo,6)=1 and light=0 then print @0,"It's too dark to see.":goto 9520
9502 if l(lo,5)=1 then PRINT@0,"Location: "; L$(LO) else print@0, lv$(lo)
9503 PRINT@240, "Items here: ";
9504 FOR X=1 TO 13: IF OB(X,1)=LO THEN PRINT OB$(X);". ";:ih=1:
9505 NEXT : if ih=0 then PRINT "none": 
9506 PRINT chr$(10);"Some obvious directions: ";:if l(lo,1)=1 THEN PRINT "North.";
9507 IF L(LO,2)=1 THEN PRINT "East.";
9508 IF L(LO,3)=1 THEN PRINT "South.";
9509 IF L(LO,4)=1 THEN PRINT "West.";
9520 print: PRINT"<";STRING$(78,45);">"
9599 GOTO 199

------------------------------------------------