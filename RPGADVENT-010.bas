'-------------------------------------------------------------------------------------
'                    RPG ADVENTURE                    Version 010
'--------------------------------------------------------------------------------------
10 cohort$="<Insert Your Name Here,esq.>"
50 CLS:BR$=CHR$(10):PRINT "Welcome to * RPG ADVENTURE 1 * - Loin Cloth of the Gods."+BR$+"A New, old adventure by Some Dude and "+cohort$+"."+BR$+BR$+"In this game, you will travel to far off imaginary lands and command me with"
55 PRINT "embarrassing two word grunts, all the while upping your stats by fighting"+br$+"monsters and looting pretend valuables so you can make it to the final boss and earn the magical McGuffin for defeating the game."
56 PRINT br$+"This game doesn't have a massive vocabulary. I understand the fun game mechanic of experimenting with words in an adventure game, but it's such a small part of the experience, I didn't think it justifieed the memory or clock cycles."
60 PRINT BR$+"Along the way you will discover a few errprs here and th3re. Be a good sport    and fix them without whining too much. "+cohort$+" and I never said we were experts at this."
61 ?br$+"TIPS:":?"Press the enter key to toggle between your stats and your location."
65 ? "Turn off capslock. Interpreter only understands lower case at the moment."
70 '
75 '
80 '
85 '
90 '
'load data while user is readin
99 ?chr$(15):?@ 1800,chr$(191);" LOADING ";chr$(191);
100 CLEAR 512: DEFINT A-Z: DIM C$(20),L$(20),LV$(20),L(20,6),ls(20,1),OB$(20),OB(20,11),OBSYN$(20),OBSYN(20,5),CSYN$(25),CSYN(25,1),ACT$(15),STAT(25,15),SLOT(11),STATINC(10,11),LOOKTRIG(20):BR$=CHR$(10):STDP=1
110 LO=1:WEIGHT=0:MAXWEIGHT=10:STRENGTH=1:ATTACK=0:XP=0:GOLD=0:HEALTH=10:LUCK=0:MAGIC=0:SPEED=0:SKILL=0: STAMINA=0:CHARISMA=0:KEYS=0 :?@1801,chr$(191);

'DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA 
'--------------------------------------------'locations - NAME, N, E, S, W, Visited?, Dark?----------------------------------
111 DATA "a slippery path", "You are standing at crest of a muddy hill. Behind you, the path steeply slopes  to your certain death in the cold rapids. Eastward you see a small village in   the distance.",0,1,0,0,0,0
112 DATA "Path to the village.", "You are on the long path to the village. The path is faded and overgrown here asif people have been avoiding it.", 0,0,1,1,0,0
113 DATA "Spooky graveyard","You are in a spooky graveyard. It was sunny outside, but now it is overcast and fog curls around the mossy stones and leafless trees.",0,0,0,1,0,0
114 DATA "foisty smelling grave","You are in a dark hole, slimy and foisty smelling.",0,0,0,1,0,1, "location 5","loc 5 verbose",0,0,0,0,0,0
115 DATA "location 6","loc 6 verbose",0,0,0,0,0,0, "location 7","loc 7 verbose",0,0,0,0,0,0, "location 8","loc 8 verbose",0,0,0,0,0,0
116 DATA "location 9","loc 9 verbose",0,0,0,0,0,0, "location 10","Place to be named by lazy co-author",1,0,0,0,0,0, "location 11","loc 11 verbose",0,0,0,0,0,0
117 DATA "location 12","loc 12 verbose",0,0,0,0,0,0, "location 13","loc 13 verbose",0,0,0,0,0,0, "location 14","loc 14 verbose",0,0,0,0,0,0
118 DATA "location 15","loc 15 verbose",0,0,0,0,0,0, "location 16","loc 16 verbose",0,0,0,0,0,0, "location 17","loc 17 verbose",0,0,0,0,0,0
129 FOR X=1 TO 17: READ L$(X): READ LV$(X):FOR Y=1 TO 6: READ L(X,Y): NEXT Y,X:?@1802,chr$(191);
'----------------------------------------------------------------------------------------------------------------------------

'------------------------------------------------  C O M M A N D S ---------------------------------------------------------- 
130 DATA n,e,s,w,go,i,look,get,drop,help,use,stats,equip,unequip,attack,talk,sell,buy,give
135 FOR C=1 TO 19: READ C$(C): NEXT C
140 DATA "skeleton",0,0,2,0,0,0, "skeleton warrior",0,0,0,0,0,0
145 FOR X=1 TO 2:READ NPC$(X):FOR Y=1 TO 6:READ NPC(X,Y):NEXT Y,X:?@1803,chr$(191);
'maybe I can keep these as npc stats. obj 11= npcstatid.
'----------------------------------------------------------------------------------------------------------------------------

'OBJECTS - NAME, 1)LOCATION, 2)WEIGHT, 3)STATSID, 4)GOTO, 5)LOOK, 6)USE-swap with, 7)OBJ MUST BE PRESENT,
'8)TRIGGERID, 9)triggeron 1-look, 2-get, 3-drop, 4-help, 5-use, 6-attack. 7-kill 10)EQUIP to slot, 11)OBJECT OR NPC, 12)OBJ MUST NOT BE PRESENT
150 DATA "rusty sword","sword",3,4,8,0,1,0,16,8,5,11,0, "crumpled note","note",-1,0,0,0,2,0,0,0,0,0,0, "pile of rocks","rocks",2,99,0,0,4,0,0,0,0,0,0,"slanty iron gate","gate",0,99,0,3,0,0,0,0,0,0,0,"loin cloth","cloth",-2,0,0,0,3,0,0,0,0,0,0
151 DATA "dirty hole","hole",3,99,0,4,5,0,0,0,0,0,0, "lantern","lamp",0,2,1,0,8,8,0,6,0,0,0, "glowing lantern","lantern",0,4,2,0,6,7,0,6,0,0,0, gold,,4,3,0,0,0,0,0,0,0,0,0, gold,,4,4,0,0,0,0,0,4,0,0,0
152 DATA "leather cuirass","cuirass",10,2,1,0,0,0,0,5,2,0,0,"rusty key","key",0,0,0,0,0,0,13,5,0,0,0, "iron gate","gate",2,99,0,0,7,4,12,2,0,0,0
153 DATA "angry skeleton","skeleton",0,99,3,0,0,0,0,9,7,0,1, "lamp","lantern",1,99,0,0,9,0,0,0,0,0,0,"chain","chain",0,99,0,0,10,0,1,8,5,0,0 '"inanimate bones","bones",,,,,,,,,,,
160 FOR X=1 TO 16: READ OB$(X) : READ OBSYN$(X):FOR Y=1 TO 11:READ OB(X,Y):NEXT Y,X:?@1804,chr$(191);
'----------------------------------------------------------------------------------------------------------------------------

'------------------------------------------------- A C T I O N S - R E S P O N S E S ----------------------------------------
165 DATA "You rub the lantern","You found something.","You hear the squeal of grinding metal as the gate swings open.","You grab the lantern, but it's stuck","You cut the chain with the sword"
170 FOR AC=1 TO 5: READ ACT$(AC):NEXT:?@1805,chr$(191);
'----------------------------------------------------------------------------------------------------------------------------

'----------- T R I G G E R S ------
'------------  1)swap with object, 2)insert object at loc, 3)insert object to inv, 4)trigger death, 5)teleport user,
'------------- 6)delete object, 7)execute another trigger, 8)action message, 9)STAT INCREASE, 10)insert npc at location 
173 DATA 0,12,0,0,0,0,0,2,1,0, 0,0,0,0,0,3,3,2,0,0, 0,4,0,0,0,13,0,0,0,0, 0,0,0,0,0,12,0,0,0,0, 0,14,0,0,0,0,0,0,0,1 ,0,0,0,0,0,0,0,1,0,0, 0,16,0,0,0,0,0,4,0,0, 0,7,0,0,0,15,0,5,0,0
174 FOR X= 1 TO 8: FOR Y=1 TO 10: READ TRIGGER(X,Y):NEXT Y,X:?@1806,chr$(191);
'----------------------------------------------------------------------------------------------------------------------------

'STAT INCREASE -  1)ATTACK, 2)DEFENSE, 3)HEALTH, 4)STRENGTH, 5)SKILL, 6)STAMINA, 7)LUCK, 8)CHARISMA, 9)MAGIC, 10)GOLD, 11) XP
175 DATA 1,2,3,4,5,6,7,8,9,10,11, 0,0,0,0,1,0,0,0,0,0,10
176 FOR X= 1 TO 2: FOR Y=1 TO 11: READ STATINC(X,Y):NEXT Y,X:?@1807,chr$(191);
'----------------------------------------------------------------------------------------------------------------------------

'*** L O O K   R E S P O N S E S *** 
177 DATA "It's seen better days, but will serve you well.",,"It says welcome to RPG Adventure 1",,"You need to visit a tailor",,"There's a loose stone with something hidden beneath",1,"Looks freshly dug",,"it glows with magic",,"It's locked",
178 DATA "It looks dull",,"It's attached to a chain",7,"It's attached to a lantern",
180 FOR X=1 TO 10: READ EX$(X): READ LOOKTRIG(X) : NEXT:?@1808,chr$(191);
'----------------------------------------------------------------------------------------------------------------------------

'*** E R R O R   R E S P O N S E S ***
185 DATA "You can't go that direction.", "It's not here.", "It's immovable, too heavy, or you're carrying too much.", "You don't have it.", "You can't use that.", "can't use it with anything here."
190 FOR ER=1 TO 6: READ ER$(ER):NEXT ER:?@1809,chr$(191);
'----------------------------------------------------------------------------------------------------------------------------


'currencies?
'data gold,keys,"health potion",salves,elixirs,xp



'*** S T A T S ***     1)ATTACK, 2)DEFENSE, 3)HEALTH, 4)STRENGTH, 5)SKILL, 6)STAMINA, 7)LUCK, 8)CHARISMA, 9)MAGIC, 10)GOLD, 11)EQUIP SLOT
194 DATA 0,2,0,0,0,0,0,0,0,0,1, 0,2,1,1,2,0,2,1,1,0,1, 4,3,2,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1
195 DATA 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1
196 FOR X=1 TO 11: FOR Y=1 TO 11:READ STAT(X,Y):NEXT Y,X:?@1810,chr$(191);
'DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END
'----------------------------------------------------------------------------------------------------------------------------

'wait for user to finish reading --PRESS ANY d KEY FOR DEBUG MODE.
197 PRINT@1799, "<press any key>"
198 I$=INKEY$:if i$="d" then dbug=1 :?"Debug mode is on." else IF I$="" THEN 198 ELSE CLS:?chr$(14):GOTO 9500



'initialize variables for next input
199 CO$="": C0$="": OB$="": CSYN=0:IH=0: NPCH=0:OB1=0:OB2=0: X=1:OBJORNPC=0 :XX=1:LIGHT=0:PRINT@1840,"";
200 INPUT "---What now--->";A$:IF A$="" THEN STDP=-STDP: IF STDP<0 THEN 7200 ELSE 9500







'interpret words
202 LA=LEN(A$): FOR A=1 TO LA: C0$=MID$(A$,A,1): IF C0$<>" " THEN CO$=CO$+C0$:NEXT
204 OB$=MID$(A$,A+1,LA) : FOR CX=1 TO 19:IF CO$<>C$(CX) THEN NEXT :IF CO$<>C$(CX) THEN PRINT "Huh?":GOTO 9500
206 FOR X=1 TO 16:IF OB$=OB$(X) or OB$=OBSYN$(X) THEN ob1=x:goto 207 else NEXT 
207 if dbug=1 then ?"x=";x:
208 XX=X:IF OB(OB1,1)=LO OR OB(OB1,1)<0 THEN 210 ELSE FOR X=XX+1 TO 16:IF OB$<>OB$(X) AND OB$<>OBSYN$(X) THEN NEXT : OB1=XX ELSE OB1=X :GOTO 208
210 IF OB(OB1,11)=0 THEN OBJORNPC=1 :GOTO 240 ELSE OBJORNPC=2 :GOTO 240
211 PRINT "not obj or npc"
'special conditions
220 'if ob(8,1)<0 or ob(8,1)=lo or l(lo,6)<>1 then light=1


'display commands and object number for debugging
'209 'PRINT "command #:";cx;" Object #: ";OB1;"/";OB2:

'switch to replace landing spot of all commands
240 if dbug=1 then PRINT "command #:";CX;" Object #: ";OB1;"/";OBJORNPC: FOR X=1 TO 11: PRINT OB(OB1,X);". ";:NEXT
241 ON CX GOTO 250,251,252,253,261,271,280,540,651,761,871,951,801,811

' directions
250 IF L(LO,1)<>1 THEN PRINT ER$(1) :GOTO 9500 ELSE L(LO,5)=1:LO=LO-8:GOTO 9499
251 IF L(LO,2)<>1 THEN PRINT ER$(1) :GOTO 9500 ELSE L(LO,5)=1:LO=LO+1:GOTO 9499
252 IF L(LO,3)<>1 THEN PRINT ER$(1) :GOTO 9500 ELSE L(LO,5)=1:LO=LO+8:GOTO 9499
253 IF L(LO,4)<>1 THEN PRINT ER$(1) :GOTO 9500 ELSE L(LO,5)=1:LO=LO-1:GOTO 9499

' go through portal object
260 IF OBJORNPC=2 THEN 262
261 IF OB(OB1,1)=LO THEN IF OB(OB1,4)<>0 THEN LO=OB(OB1,4) :GOTO 9499 ELSE PRINT "You can't go there.":GOTO 9500
262 PRINT"Um, it's alive and kicking.":GOTO 9500

' take inventory
270 IF CX<>6 THEN 430
271 PRINT "You are carrying the following...";:FOR X=1 TO 16: :IF OB(X,1)<-1 THEN PRINT "*";
272 IF OB(X,1)<0 THEN PRINT OB$(X);". ";
273 REM FOR X=1 TO 16: IF OB(X,1)<0 THEN PRINT OB$(X); if ob(x,1)<-1 then print "* ";
274 NEXT X:PRINT :GOTO 9500


' look
'280 ' if objornpc=2 then 290 
280 IF OB$<>"" THEN 282
281 IF OB(8,1)<0 OR OB(8,1)=LO OR L(LO,6)<>1 THEN PRINT LV$(LO):GOTO 300 ELSE PRINT "Can't see."+br$:goto 9500
282 IF OB(OB1,1)>-1 AND OB(OB1,1)<>LO THEN PRINT "It's not here.":GOTO 9500
283 IF OB(OB1,6)<>0 THEN PRINT "Try using it for something." ELSE IF OB(OB1,7)<>0 THEN PRINT "Try using it with something."
284 IF EX$(OB(OB1,5))<>"" THEN PRINT EX$(OB(OB1,5)) ELSE PRINT "It looks just like a regular ";ob$(ob1);" to me.":GOTO 9500
285 TRIGGERIT=LOOKTRIG(OB(OB1,5)) : OB(OB1,5)=0: GOTO 6000
286 ' IF OB(OB1,1)<0 OR OB(OB1,1)=LO THEN if ex$(ob(ob1,5))<>"" then PRINT EX$(OB(OB1,5)) :triggerit=looktrig(ob(ob1,5)) : OB(OB1,5)=0: goto 6000 else print "It's not here.":goto 9500 endif print "ballsacks.": goto 9500
290 'if npc(ob1,1)<>lo then print "It's not here.":goto 9500
291 'if npc(ob1,5)>0 then PRINT EX$(OB(OB1,5)) else print "Looks just like a regular ";npc$(ob1);"."
292 GOTO 9500

'Search location.
300 if ls(lo,1)=1 then print "You already searched here.":goto 9500
301 if luck<1 then ?"You can't search for goodies without any luck to spend.":goto 9500
302 found$="":if luck>0 then print "You search the area for goodies.": luck=luck-1:ls(lo,1)=1:search=rnd(10)-luck:if search>0 then print "You find nothing.": goto 9500 

303 search=rnd(10)-luck: if search<0 then found$="You found a chest key."+br$:keys=keys+rnd(3):luck=luck+1
304 search=rnd(10)-luck: if search<0 then found$=found$+"You found a gold coin."+br$:gold=gold+rnd(3):luck=luck+1
305 search=rnd(10)-luck: if search<0 then found$=found$+"You found a strength potion."+br$:strength=strength+rnd(3)
306 search=rnd(10)-luck: if search<0 then found$=found$+"You found a stamina potion"+br$: stamina=stamina+rnd(3)
307 search=rnd(10)-luck: if search<0 then found$=found$+"You found a charisma potion"+br$: charisma=charisma+rnd(3)
308 search=rnd(10)-luck: if search<0 then found$=found$+"You found a luck potion"+br$: luck=luck+rnd(3)

309 if found$<>"" then found$= "You lucky git, you found some loot."+br$+found$:?found$
310 goto 9500


'get
540 IF OBJORNPC=2 THEN 571
541 IF OB(OB1,1)<>LO THEN PRINT ER$(2):GOTO 9500
545 IF OB(OB1,2)+WEIGHT < MAXWEIGHT THEN OB(OB1,1)=-1:WEIGHT=WEIGHT+OB(OB1,2): PRINT "Taken." ELSE PRINT ER$(3) :GOTO 9500
550 IF OB$(OB1)="gold" THEN GOLD=GOLD+OB(OB1,2): OB(OB1,1)=0: OB$(OB1)="":PRINT "Ker-ching!"
560 IF OB$(OB1)="key" THEN KEYS=KEYS+OB(OB1,2):OB(OB1,1)=0: OB$(OB1)="":PRINT "Jingle Jangle!"
569 IF OB(OB1,9)=2 THEN TRIGGERIT=OB(OB1,8) : PRINT "You triggered something.":GOTO 6000
570 GOTO 9500
571 PRINT "I'm not even going to try picking that up.":GOTO 9500

'drop
650 IF OBJORNPC=2 THEN 660
651 IF OB(OB1,1)<>-1 THEN PRINT ER$(4):GOTO 9500 ELSE OB(OB1,1)=LO:WEIGHT=WEIGHT-OB(OB1,2): PRINT "Dropped." :GOTO 9500
'152 if ob$(ob1)="gold" then gold=gold-ob(ob1,2): print "Bye bye, money"
660 IF NPC(OB1,1)>-1 THEN PRINT "You're not carrying a ";NPC$(OB1):GOTO 9500
661 PRINT "Looks just like a regular ";NPC$(OB1);"." :GOTO 9500

'help
760 IF CX<>10 THEN 870
761 PRINT "Use two word sentences like:- ";C$(rnd(11)+4);" ";OBSYN$(rnd(16));".";CHR$(10);"Some commands to try are: ";:FOR X=1 TO 15: PRINT C$(X);". "; : NEXT:PRINT
762 GOTO 9500

'equip
800 IF CX<>13 THEN 870
801 IF OB(OB1,1)=-1 THEN SLOT=OB(OB1,10): FOR X=1 TO 10: IF OB(X,10)=SLOT AND OB(X,1)=-2 THEN OB(X,10)=-1:GOTO 9500 ELSE NEXT : OB(OB1,1)=-2:  PRINT "Equipped.": WEIGHT=WEIGHT-OB(OB1,2)
802 GOTO 9500
'unequip
810 IF CX<>14 THEN 870
811 IF OB(OB1,1)=-2 THEN OB(OB1,1)=-1 :  WEIGHT=WEIGHT+OB(OB1,2): PRINT "Removed."
812 GOTO 9500
'------------------------------------------------------------------------------------------------------------------------------------
'COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE
870 IF OBJORNPC=2 THEN 890
871 IF OB(OB1,1)<>LO AND OB(OB1,1)>-1 THEN PRINT OB$(OB1);" is not here": GOTO 9500
874 IF OB(OB(OB1,7),1)=LO THEN TRIGGERIT=OB(OB(OB,7),8):if dbug=1 then  PRINT "object to use with is present."
875 IF OB(OB1,7)<>0 THEN IF OB(OB(OB1,7),1)<>LO AND OB(OB(OB1,7),1)>-1 THEN PRINT ER$(6):GOTO 9500 ELSE TRIGGERIT=OB(OB(OB1,7),8):GOTO 6000
882 'if ob(ob1,7)=0 then 873 else if ob(ob(ob1,7),1)<>lo and ob(ob(ob1,7),1)>0 then print er$(6):goto 995 else triggerit=ob(ob(ob1,7),8):goto 6000
883 IF OB(OB1,1)>-1 AND OB(OB1,1)<>LO THEN PRINT ER$(2):GOTO 9500
884 IF OB(OB1,6)=0 THEN PRINT ER$(5):GOTO 9500
885 IF OB(OB1,6)<0 THEN PRINT ER$(5):GOTO 9500 ELSE OB2= OB(OB1,6): SWAP OB(OB1,1), OB(OB2,1): ACTMESS=TRIGGER(OB(OB1,8),8):  PRINT ACT$(ACTMESS);". ";EX$(OB(OB2,5))': ?ob2:?act$(1)
889 GOTO 9500
890 PRINT "use NPC goes here.":GOTO 9500

'------------------------------------------------------------------------------------------------------------------------------------

'stats on object
'STATS 1)ATTACK, 2)DEFENSE, 3)HEALTH, 4)STRENGTH, 5)SKILL, 6)STAMINA, 7)LUCK, 8)CHARISMA, 9)MAGIC, 10)GOLD
951 'if objornpc=2 then 953
952 IF OB(OB1,1) >0 AND OB(OB1,1)<>LO THEN PRINT ER$(2) : GOTO 9500 ELSE PRINT "Stats on "; OB$(OB1) :STATOB=OB(OB1,3):GOTO 954
953 'if npc(ob1,1) <>lo then print er$(2) : goto 9500 else print "Stats on "; npc$(ob1) :statob=npc(ob1,3):goto 954
954 PRINT "Attack: ";STAT(STATOB,1);"  /   Defense: ";STAT(STATOB,2);"  /   Health:";STAT(STATOB,3);"  /   Strength:";STAT(STATOB,4);"   /  Skill:";STAT(STATOB,5)
955 PRINT "Stamina:";STAT(STATOB,6);"  /   Charisma:";STAT(STATOB,8);"  /   Luck:  ";STAT(STATOB,7); "  /   Magic:   ";STAT(STATOB,9);"   /  Gold: ";STAT(STATOB,10)
999 GOTO 9500

'death
1000'

'fight
4000 print "You are now locked in battle and your fate is in the hands of the gods. They will roll the dice with your stats. If you are skilled or lucky enough, you may come out victorious at the other end of this."+br$+"<press any key when ready>"

'*** S T A T S ***     1)ATTACK, 2)DEFENSE, 3)HEALTH, 4)STRENGTH, 5)SKILL, 6)STAMINA, 7)LUCK, 8)CHARISMA, 9)MAGIC, 10)GOLD, 11)EQUIP SLOT

4001 i$=inkey$:if i$="" then 4001  
4002 npcatt=stats(ob(npc,3),1):npcdef=stats(ob(npc,3),2):npchlth=stats(ob(npc,3),3):npcstr=stats(ob(npc,3),4):npcskl=stats(ob(npc,3),5):npcstam=stats(ob(npc,5),6):npcluck=stats(ob(npc,3),7)
4010 turn=rnd(2):if turn=2 then 4050
4011 luckycrit=rnd(npcluck):if luckycrit<>3 then luckycrit=0 :hit=rnd(npcstr)*rnd(npcskl)+(npcstam+luckycrit)+1:connect=hit-Defense
4012 if npcstam<0 then print "The "+npc$+" has tuckered himself out. He can't raise an arm to attack.":goto4050
4013 ?"The "+npc$+" lashes out with strength ";hit: if rnd(npcluck)>rnd(luck) then ? "And it hits you for ";connect else print " .. but you duck and he misses.":connect=0
4020 npcstam=npcstam-1:npcluck=npcluck-1:health=health-connect:if npcluck<0 then npcluck=0

4025 if health<1 then ? "You are dead.":end

4050 luckycrit=rnd(luck):if luckycrit<>3 then luckycrit=0 :hit=rnd(strength)*rnd(skill)+(stamina+luckycrit)+1:connect=hit-npcdef

4051 ?"You lash out with strength ";hit: if rnd(luck)>rnd(npcluck) then ? "And hit the "+npc$+" for ";connect else print ".. but the "+npc$+" dodges.": connect=0
4052 stamina=stamina-1:luck=luck-1:npchlth=npchlth-connect:if luck<0 then luck=0
4053 if npchlth<1 then ? "You killed the "+npc$+". Now all their loot is yours" else goto 4011

4054 ?"You take a breath and rest for a moment, then search the "+npc$: ob(npc,1)=0:npch=0:luck=luck+3:xp=xp+npcatt:goto 303
'4055 TRIGGER ON DEATH GOES HERE - exchange NPC for OB at location. OB has loot to search for


'map
5000 '

'EXECUTE TRIGGERS
'----------- T R I G G E R S ------
'------------  1)swap with object, 2)insert object at loc, 3)insert object to inv, 4)trigger death, 5)teleport user,
'------------- 6)delete object, 7)execute another trigger, 8)action message, 9)STAT INCREASE, 10)insert npc at location

'OBJECTS - NAME, 1)LOCATION, 2)WEIGHT, 3)STATSID, 4)GOTO, 5)LOOK, 6)USE-swap with, 7)OBJ MUST BE PRESENT,
'8)TRIGGERID  9)triggeron 1-look, 2-get, 3-drop, 4-help, 5-use, 6-attack. 10)EQUIP to slot


6000 '
6010 IF TRIGGER(TRIGGERIT,1)>0 THEN SWAP OB(OB1,1) , OB(TRIGGERIT,1)
6020 IF TRIGGER(TRIGGERIT,2)>0 THEN OB(TRIGGER(TRIGGERIT,2),1)=LO: if dbug=1 then PRINT"An item appears here."
6030 IF TRIGGER(TRIGGERIT,3)>0 THEN OB(TRIGGER(TRIGGERIT,3),1)=-1 :if dbug=1 then PRINT"You got something."
6040 IF TRIGGER(TRIGGERIT,4)>0 THEN 1000
6050 IF TRIGGER(TRIGGERIT,5)>0 THEN LO =  TRIGGER(TRIGGERIT,5) :if dbug=1 then print "You moved somewhere."
6060 IF TRIGGER(TRIGGERIT,6)>0 THEN OB(TRIGGER(TRIGGERIT,6),1)=0 :if dbug=1 then ?"Something went away."
6070 '
6080 IF TRIGGER(TRIGGERIT,8)>0 THEN PRINT ACT$ (TRIGGER(TRIGGERIT,8));". "
6081 'print trigger(triggerit,8)
6090 IF TRIGGER(TRIGGERIT,9)>0 THEN PRINT "Your stats have increased. ":GOSUB 7300
6091 'if trigger(triggerit,7)>0 then ob1=trigger(triggerit,7):goto 871 
6093 IF TRIGGER(TRIGGERIT,7)>0 THEN TRIGGERIT=TRIGGER(TRIGGERIT,7):GOTO 6000
6100 GOTO 9500





' STATS PAGE
7200 GOSUB 9600:PRINT@0,
7201 PRINT "Carry Weight: ",WEIGHT: PRINT "Max Weight: ",MAXWEIGHT:PRINT"Strength: ",STRENGTH
7202 PRINT "Experience: ",XP:PRINT "Gold: ",GOLD:PRINT "Health: ",HEALTH :PRINT "keys: ",KEYS
7203 PRINT "Attack:",ATTACK: PRINT "Defense: ",DEFENSE: PRINT "Skill: ",SKILL;
7204 PRINT "   Stamina: ";STAMINA; "   Luck:";LUCK; "   Charisma: ";CHARISMA;"   Magic: ";MAGIC
7205 PRINT @30, STRING$(3,32)+CHR$(176)+CHR$(188)+CHR$(176);
7206 PRINT @112,CHR$(170)+STRING$(3,32)+CHR$(149);
7207 PRINT @190,STRING$(3,176)+CHR$(187)+CHR$(128)+CHR$(183)+STRING$(3,176);
7208 PRINT @269,CHR$(170)+STRING$(2,32)+CHR$(175)+STRING$(3,32)+CHR$(159)+STRING$(2,32)+CHR$(149);
7209 PRINT @350,CHR$(171)+CHR$(151)+CHR$(162)+STRING$(3,191)+CHR$(129)+CHR$(171)+CHR$(151);
7210 PRINT @432,CHR$(170)+STRING$(3,32)+CHR$(149);
7211 PRINT @510,CHR$(130)+CHR$(129)+CHR$(130)+CHR$(191)+CHR$(131)+CHR$(191)+CHR$(129)+CHR$(130)+CHR$(129);
7212 PRINT @592,CHR$(176)+CHR$(191)+CHR$(32)+CHR$(191)+CHR$(176);
7213 PRINT @671,CHR$(170)+STRING$(5,32)+CHR$(149);
7214 PRINT @752,STRING$(2,131)+CHR$(32)+STRING$(2,131);
7215 STATTY$=STR$(STAT1):GOSUB 9700:STAT1$=STATTY$: STATTY$=STR$(STAT2):GOSUB 9710:STAT2$=STATTY$: STATTY$=STR$(STAT3):GOSUB 9700:STAT3$=STATTY$: STATTY$=STR$(STAT4):GOSUB 9710:STAT4$=STATTY$
7216 STATTY$=STR$(STAT5):GOSUB 9710:STAT5$=STATTY$: STATTY$=STR$(STAT6):GOSUB 9700:STAT6$=STATTY$: STATTY$=STR$(STAT7):GOSUB 9710:STAT7$=STATTY$: STATTY$=STR$(STAT8):GOSUB 9710:STAT8$=STATTY$: STATTY$=STR$(STAT9):GOSUB 9710:STAT9$=STATTY$
7217 STATTY$=STR$(STAT10):STAT10$=RIGHT$(STATTY$,LEN(STATTY$)-1)
7220 PRINT @113,STAT1$;:PRINT@270,STAT2$;:PRINT@273,STAT3$;:PRINT@277,STAT4$;
7221 PRINT @430,STAT5$;:PRINT@433,STAT6$;:PRINT@437,STAT7$;
7222 PRINT @672,STAT8$;:PRINT@675,STAT9$;:PRINT@194,STAT10$;
7299 GOTO 199


'110 maxweight=10:strength=1:attack=0:xp=0:gold=0:health=10:luck=0:magic=0:speed=0:skill=0: stamina=0:charisma=0:keys=0
'INCREASE STATS -  1)ATTACK, 2)DEFENSE, 3)HEALTH, 4)STRENGTH, 5)SKILL, 6)STAMINA, 7)LUCK, 8)CHARISMA, 9)MAGIC, 10)GOLD, 11) XP
7300 STATSTOINC=TRIGGER(TRIGGERIT,9)
7310 IF STATINC(STATSTOINC,1)<>0 THEN ATTACK=ATTACK+STATINC(STATSTOINC,1)
7320 IF STATINC(STATSTOINC,2)<>0 THEN DEFENSE=DEFENSE+STATINC(STATSTOINC,2)
7330 IF STATINC(STATSTOINC,3)<>0 THEN HEALTH=HEALTH+STATINC(STATSTOINC,3)
7340 IF STATINC(STATSTOINC,4)<>0 THEN STRENGTH=STRENGTH+STATINC(STATSTOINC,4)
7350 IF STATINC(STATSTOINC,5)<>0 THEN SKILL=SKILL+STATINC(STATSTOINC,5)
7360 IF STATINC(STATSTOINC,6)<>0 THEN STAMINA=STAMINA+STATINC(STATSTOINC,6)
7370 IF STATINC(STATSTOINC,7)<>0 THEN LUCK=LUCK+STATINC(STATSTOINC,7)
7380 IF STATINC(STATSTOINC,8)<>0 THEN CHARISMA=CHARISMA+STATINC(STATSTOINC,8)
7390 IF STATINC(STATSTOINC,9)<>0 THEN MAGIC=MAGIC+STATINC(STATSTOINC,9)
7400 IF STATINC(STATSTOINC,10)<>0 THEN GOLD=GOLD+STATINC(STATSTOINC,10)
7410 IF STATINC(STATSTOINC,11)<>0 THEN XP=XP+STATINC(STATSTOINC,11)
'7500 return


' MAPS PAGE
8000 REM map stuff goes here


' update new screen goes here
'light source present?
9499 PRINT "okay." ' eventually change this to returnmessage$ so I can rearrage the order of the messages. 
9500 IF OB(8,1)<0 OR OB(8,1)=LO THEN LIGHT=1                                                                  
9501 GOSUB 9600:IF L(LO,6)=1 AND LIGHT=0 THEN PRINT @0,"It's too dark to see.":GOTO 9550
9520 IF L(LO,5)=1 THEN PRINT@0,"Location: "; L$(LO) ELSE PRINT@0, LV$(LO)
9530 PRINT@240, "Items here: ";
9531 FOR X=1 TO 16: IF OB(X,1)=LO THEN PRINT OB$(X);". ";:IH=1:IF OB(X,11)>0 THEN NPCH=1:npc$=ob$(x):npc=x
9532 NEXT ': for x=1 to 2: if npc(x,1)=LO then print npc$(x);". ";:ih=1
9533 IF IH=0 THEN PRINT "none": 
9540 PRINT CHR$(10);"Some obvious directions: ";:IF L(LO,1)=1 THEN PRINT "North.";
9541 IF L(LO,2)=1 THEN PRINT "East.";
9542 IF L(LO,3)=1 THEN PRINT "South.";
9543 IF L(LO,4)=1 THEN PRINT "West.";
9550 PRINT: PRINT"<";STRING$(78,45);">"


'npc attack?
9559 PRINT@1700,"";:if luck<0 then luck=0
9560 IF NPCH=1 THEN ATTACKCHANCE=RND(3+LUCK): IF ATTACKCHANCE=1 THEN PRINT "You are attacked":GOTO 4000 else print "You were in danger of being attacked, but your luck held out for this turn.";


9599 GOTO 199

9600 PRINT@0,CHR$(30):PRINT @80,CHR$(30):PRINT@160,CHR$(30):PRINT@240,CHR$(30):RETURN
9700 STATTY$=RIGHT$(STATTY$,LEN(STATTY$)-1)
9701 IF LEN(STATTY$)<3 THEN STATTY$="0"+STATTY$:GOTO 9701
9702 RETURN

9710 STATTY$=RIGHT$(STATTY$,LEN(STATTY$)-1)
9711 IF LEN(STATTY$)<2 THEN STATTY$="0"+STATTY$
9712 RETURN
