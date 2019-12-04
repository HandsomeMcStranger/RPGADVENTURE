'-------------------------------------------------------------------------------------
'                    RPG ADVENTURE                    Version 200
' getting close to end of spitball and restarting with better code
'--------------------------------------------------------------------------------------
10 cohort$="<Insert Your Name Here,esq.>"
50 CLS:BR$=CHR$(10):PRINT "Welcome to * RPG ADVENTURE 1 * - Loin Cloth of the Gods."+BR$+"A New, old adventure by Some Dude and "+cohort$+"."+BR$+BR$+"In this game, you will travel to far off imaginary lands and command me with"
55 PRINT "embarrassing two word grunts, all the while upping your stats by fighting"+br$+"monsters and looting pretend valuables so you can make it to the final boss and earn the magical McGuffin for defeating the game."
56 PRINT br$+"This game doesn't have a massive vocabulary. I understand the fun game mechanic of experimenting with words in an adventure game, but it's such a small part of the experience, I didn't think it justified the memory or clock cycles."
60 PRINT BR$+"Along the way you will discover a few errprs here and th3re. Be a good sport    and fix them without whining too much. "+cohort$+" and I never said we were experts at this."
61 ?br$+"TIPS:":?"Press the enter key to toggle between your stats and your location."
65 ? "Turn off capslock. Interpreter only understands lower case at the moment."
70 '


'load data while user is readin
99 ?chr$(15):?@ 1874,chr$(191);" LOADING ";chr$(191);
100 CLEAR 800: DEFINT A-Z: DIM C$(22),L$(26),LV$(26),L(26,6),l(26),ls(26,1),OB$(29),OB(29,11),OBSYN$(29),OBSYN(29,5),CSYN$(25),CSYN(25,1),ACT$(15),STAT(25,15),SLOT(12),STATINC(10,11),LOOKTRIG(20),EX$(20),cstat(12):BR$=CHR$(10):STDP=1
'101 pb(1)=113:pb(2)=270:pb(3)=273:pb(4)=277:pb(5)=430:pb(6)=433:pb(7)=437:pb(8)=672:pb(9)=675:pb(10)=194:pb(11)=425:pb(12)=450

'C)harSTATS 1=STRENGTH  2=ATTACK  3=DEFENSE  4=SKILL  5=STAMINA  6=LUCK  7=MAGIC  8=CHARISMA  9=HEALTH/HITPOINTS
105 LO=1:WEIGHT=0:MAXWEIGHT=10:STRENGTH=1:ATTACK=0:XP=0:GOLD=0:HEALTH=10:LUCK=0:MAGIC=0:SPEED=0:SKILL=0: STAMINA=0:CHARISMA=0:KEYS=0 :?@1875,chr$(191);

'print @ stat positions
110 for x=0 to 8:p(x+1)=x*80:next





112 OPEN "I", 1, "LOCatS:1"
114 x=1
116 INPUT# 1,L$(X),LV$(X),L(X):
118 while l$(x)<>"*"
120 x=x+1:goto 116
122 wend: close 1:?@1876,chr$(191);
'-----------------------------------------------------------------------------------------------------------------------

'-----------------------------------------------  C O M M A N D S ----------------------------------------------------- 
130 DATA n,e,s,w,go,i,look,get,drop,help,use,stats,equip,unequip,attack,map,talk,sell,buy,give
135 FOR C=1 TO 20: READ C$(C): NEXT C :?@1877,chr$(191);
'-----------------------------------------------------------------------------------------------------------------------



160 OPEN "I", 1, "Objects:1":x=1
161 INPUT# 1, OB$(X),OBsyn$(X) : for y=1 to 11: input# 1, ob(x,y): next
162 while ob$(x)<>"*"
163 x=x+1:goto 161
164 wend:close 1:?@1878,chr$(191);



'------------------------------------------------------------------------------------------------------------------------

'-------------------------------------------- A C T I O N S - R E S P O N S E S ----------------------------------------
165 DATA "You rub the lantern","You found something.","You hear the squeal of grinding metal as the gate swings open.","You grab the lantern, but it's stuck","You cut the chain with the sword"
166 DATA "The Skeleton spins around dramatically, then collapses into a pile of bones."
170 FOR AC=1 TO 6: READ ACT$(AC):NEXT:?@1879,chr$(191);
'-----------------------------------------------------------------------------------------------------------------------

'----------- T R I G G E R S ------
'------------  1)swap with object, 2)insert object at loc, 3)insert object to inv, 4)trigger death, 5)teleport user,
'------------- 6)delete object, 7)execute another trigger, 8)action message, 9)STAT INCREASE, 10)OPEN EXIT @ LOCATION 
173 DATA 0,12,0,0,0,0,0,2,1,0, 0,0,0,0,0,3,3,2,0,0, 0,4,0,0,0,13,0,3,0,0, 0,0,0,0,0,12,0,0,0,0, 0,14,0,0,0,0,0,0,0,0 ,0,0,0,0,0,0,0,1,0,0, 0,16,0,0,0,0,0,4,0,0, 0,17,0,0,0,14,0,6,2,2, 0,7,0,0,0,15,0,5,0,0, 0,18,0,0,0,0,0,2,0,0
174 FOR X= 1 TO 10: FOR Y=1 TO 10: READ TRIGGER(X,Y):NEXT Y,X:?@1880,chr$(191);
'
'------------------------------------------------------------------------------------------------------------------------


'MAKE THIS THE SAME AS CSTATS OR YOU'RE ASKING FOR TROUBLE. 1=STRENGTH 2=ATTACK 3=DEFENSE 4=SKILL 5=STAMINA 6=LUCK 7=MAGIC 8=CHARISMA 9=HEALTH/HITPOINTS 10=MAXWEIGHT
'STAT INCREASE -  1)ATTACK, 2)DEFENSE, 3)HEALTH, 4)STRENGTH, 5)SKILL, 6)STAMINA, 7)LUCK, 8)CHARISMA, 9)MAGIC, 10)GOLD, 11) XP 12)MAXWEIGHT
175 DATA 1,2,3,4,5,6,7,8,9,10,11, 0,0,0,0,1,0,0,0,0,0,10
176 FOR X= 1 TO 2: FOR Y=1 TO 11: READ STATINC(X,Y):NEXT Y,X:?@1881,chr$(191);
'-------------------------------------------------------------------------------------------------------------------------

'*** L O O K   R E S P O N S E S *** 
177 DATA "It's seen better days, but will serve you well.",,"It says welcome to RPG Adventure 1",,"You need to visit a tailor. This thing ain't sitting right.",,"There's a loose stone with something hidden beneath",1,"Looks freshly dug",
178 DATA "it glows with magic",,"It's locked",,"It looks dull",,"It's attached to a chain",7,"It's a standard 5 foot lantern chain",7, "Welp. He had a bad attitude.",10
179 data "Looks like it's from the Yu-Wing period. A little squeaky, probably wants some  oil.",
180 FOR X=1 TO 12: READ EX$(X): READ LOOKTRIG(X) : NEXT:?@1882,chr$(191);
'-------------------------------------------------------------------------------------------------------------------------

'*** E R R O R   R E S P O N S E S ***
185 DATA "You can't go that direction.", "It's not here.", "It's immovable, too heavy, or you're carrying too much.", "You don't have it.", "You can't use that.", "can't use it with anything here."
190 FOR ER=1 TO 6: READ ER$(ER):NEXT ER:?@1883,chr$(191);
'-------------------------------------------------------------------------------------------------------------------------


'currencies?
'data gold,keys,"health potion",salves,elixirs,xp



'weather? time of day?

'*** S T A T S ***
'  1)ATTACK, 2)DEFENSE, 3)HEALTH, 4)STRENGTH, 5)SKILL, 6)STAMINA, 7)LUCK, 8)CHARISMA, 9)MAGIC, 10)GOLD, 11)EQUIP SLOT
194 DATA 2,2,0,0,0,0,0,0,0,0,1, 0,2,1,1,2,0,2,1,1,0,1, 4,4,11,1,1,5,1,1,1,1,1, 9,8,7,6,5,4,3,2,1,2,3, 3,5,6,3,3,2,2,0,0,2,0, 12,8,11,4,5,6,1,1,0,3,0, 1,1,1,1,1,1,1,1,1,1,1, 3,1,1,1,1,1,1,1,1,1,1
195 DATA 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1
196 FOR X=1 TO 11: FOR Y=1 TO 11:READ STAT(X,Y):NEXT Y,X:?@1884,chr$(191);
'DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END DATA END
'----------------------------------------------------------------------------------------------------------------------------

'wait for user to finish reading --PRESS ANY d KEY FOR DEBUG MODE.
197 PRINT@1872, "<press any key>"; :Poke &hb94,6 'lock 6 lines at top (1-7 only 8=0, 9=1, 10=2 etc)
'poke&hb94,6 lock screen top to not scroll -- NOT (POKE &HB94,( PEEK(1) OR 8 ) 
198 I$=INKEY$:if i$="d" then dbug=1 :?"Debug mode is on." else IF I$="" THEN 198 ELSE CLS:?chr$(14):GOTO 9500



'initialize variables for next input
199 CO$="": C0$="": OB$="": CSYN=0:IH=0: NPCH=0:OB1=0:OB2=0: X=1:OBJORNPC=0 :XX=1:LIGHT=0:PRINT@1840,"";
200 INPUT "---What now--->";A$:IF A$="" THEN STDP=-STDP: if stdp<0 then ?"Displaying Stats": goto 7200 ELSE ? "Displaying Scene": goto 9500







'interpret words
202 LA=LEN(A$): FOR A=1 TO LA: C0$=MID$(A$,A,1): IF C0$<>" " THEN CO$=CO$+C0$:NEXT
204 OB$=MID$(A$,A+1,LA) : FOR CX=1 TO 20:IF CO$<>C$(CX) THEN NEXT :IF CO$<>C$(CX) THEN PRINT "Huh?":GOTO 9500
206 FOR X=1 TO 28:IF OB$=OB$(X) or OB$=OBSYN$(X) THEN ob1=x:goto 207 else NEXT 
207 if dbug=1 then ?"x=";x
208 XX=X:IF OB(OB1,1)=LO OR OB(OB1,1)<0 THEN 210 ELSE FOR X=XX+1 TO 28:IF OB$<>OB$(X) AND OB$<>OBSYN$(X) THEN NEXT : OB1=XX ELSE OB1=X :GOTO 208
210 IF OB(OB1,11)=0 THEN OBJORNPC=1 :GOTO 240 ELSE OBJORNPC=2 :GOTO 240
211 PRINT "not obj or npc"
'special conditions
220 'if ob(8,1)<0 or ob(8,1)=lo or l(lo,6)<>1 then light=1


'display commands and object number for debugging
'209 'PRINT "command #:";cx;" Object #: ";OB1;"/";OB2:

'switch to replace landing spot of all commands
240 if dbug=1 then PRINT "command #:";CX;" Object #: ";OB1;"/";OBJORNPC:?"OB ";: FOR X=1 TO 20: PRINT OB(OB1,X);". ";:NEXT :?br$;"trig";:triggerid=ob(ob1,7):for x=1 to 10:?trigger(triggerid,x);".";:next

'               n   e   s   w   go  i look     drop    use    equip   attack     talk
241 ON CX GOTO 250,251,252,253,261,271,280,540,651,761,871,951,801,811,4000,5000,8000
'                                          get     help   stats   uneq      map


' directions
'250 IF l(lo) AND NOT 1 THEN PRINT ER$(1) :GOTO 9500 ELSE LO=LO-8:GOTO 9499
'251 IF l(lo) AND NOT 2 THEN PRINT ER$(1) :GOTO 9500 ELSE LO=LO+1:GOTO 9499
'252 IF l(lo) AND NOT 4 THEN PRINT ER$(1) :GOTO 9500 ELSE LO=LO+8:GOTO 9499
'253 IF l(lo) AND NOT 8 THEN PRINT ER$(1) :GOTO 9500 ELSE LO=LO-1:GOTO 9499


250 IF l(lo) AND 1 THEN gosub 254:LO=LO-8:GOTO 9499 else PRINT ER$(1) :GOTO 9500
251 IF l(lo) AND 2 THEN gosub 254:LO=LO+1:GOTO 9499 else PRINT ER$(1) :GOTO 9500
252 IF l(lo) AND 4 THEN gosub 254:LO=LO+8:GOTO 9499 else PRINT ER$(1) :GOTO 9500
253 IF l(lo) AND 8 THEN gosub 254:LO=LO-1:GOTO 9499 else PRINT ER$(1) :GOTO 9500

254 ?"you shouldn't ever be on line 254":goto 260

'250 IF l(lo) AND NOT 1 THEN PRINT ER$(1) :GOTO 9500 ELSE LO=LO-8:if l(lo-8) and not 32 then l(lo-8)=l(lo-8)+32
'251 IF l(lo) AND NOT 2 THEN PRINT ER$(1) :GOTO 9500 ELSE LO=LO+1:if l(lo+1) and not 32 then l(lo+1)=l(lo+1)+32
'252 IF l(lo) AND NOT 4 THEN PRINT ER$(1) :GOTO 9500 ELSE LO=LO+8:if l(lo+8) and not 32 then l(lo+8)=l(lo+8)+32
'253 IF l(lo) AND NOT 8 THEN PRINT ER$(1) :GOTO 9500 ELSE LO=LO-1:if l(lo-1) and not 32 then l(lo-1)=l(lo-1)+32

'254 goto 9499
'make location visted on exit
254 if l(lo) and 32 then return else l(lo)=l(lo)+32:return 
256
257
258
259





' go through portal object
260 IF OBJORNPC=2 THEN 262
261 IF OB(OB1,1)=LO THEN IF OB(OB1,4)<>0 THEN LO=OB(OB1,4) :GOTO 9499 ELSE PRINT "You can't go there.":GOTO 9500
262 PRINT"Um, it's alive and kicking.":GOTO 9500

' take inventory
270 'IF CX<>6 THEN 430
271 PRINT "You are carrying the following...":FOR X=1 TO 24: :IF OB(X,1)<-1 THEN PRINT "*";
272 IF OB(X,1)<0 THEN PRINT OB$(X);". ";
273 REM FOR X=1 TO 16: IF OB(X,1)<0 THEN PRINT OB$(X); if ob(x,1)<-1 then print "* ";
274 NEXT X:PRINT :GOTO 9500


' look
'280 ' if objornpc=2 then 290 
280 IF l(lo) and 16 then PRINT "Can't see."+br$:goto 9500 else IF OB$="" THEN 300
281 IF OB(8,1)<0 OR OB(8,1)=LO THEN PRINT LV$(LO): gosub 2000 :GOTO 300  
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
301 if cstat(6)<1 then ?"You can't search for goodies without any luck to spend.":goto 9500
302 found$="":if cstat(6)>0 then ?"Searching..":ls(lo,1)=1:search=rnd(10)-cstat(6):cstat(6)=cstat(6)-1:if search>2 then ?"..nothing.":goto 9500 else if search>0 then r=rnd(7)+18:?"You disturbed a "+ob$(r):npc=r:ob(r,1)=LO:npc$=ob$(npc):goto 4000

303 search=rnd(10)-cstat(6): if search<0 then ra=rnd(7)-rnd(4):if ra>0 then ra$=str$(ra):found$="You found "+ra$+"x chest keys."+br$:keys=keys+ra:cstat(6)=cstat(6)+1
304 search=rnd(10)-cstat(6): if search<0 then ra=rnd(7)-rnd(4):if ra>0 then ra$=str$(ra):found$=found$+"You found "+ra$+"x gold coins."+br$:gold=gold+ra:cstat(6)=cstat(6)+1
305 search=rnd(10)-cstat(6): if search<0 then ra=rnd(7)-rnd(4):if ra>0 then ra$=str$(ra):found$=found$+"You found "+ra$+"x strength potions."+br$:cstat(1)=cstat(1)+ra
306 search=rnd(10)-cstat(6): if search<0 then ra=rnd(7)-rnd(4):if ra>0 then ra$=str$(ra):found$=found$+"You found "+ra$+"x stamina potions"+br$: cstat(5)=cstat(5)+ra
307 search=rnd(10)-cstat(6): if search<0 then ra=rnd(7)-rnd(4):if ra>0 then ra$=str$(ra):found$=found$+"You found "+ra$+"x charisma potions"+br$: cstat(8)=cstat(8)+ra
308 search=rnd(10)-cstat(6): if search<0 then ra=rnd(7)-rnd(4):if ra>0 then ra$=str$(ra):found$=found$+"You found "+ra$+"x luck potions"+br$: cstat(6)=cstat(6)+ra 

309 if found$<>"" then found$= "You lucky git, you found some loot."+br$+found$:?found$ else ? "But there was nothing here."
310 goto 9500


'get
540 IF OBJORNPC=2 THEN 571
541 IF OB(OB1,1)<>LO THEN PRINT ER$(2):GOTO 9500
545 IF OB(OB1,2)+WEIGHT < MAXWEIGHT THEN OB(OB1,1)=-1:WEIGHT=WEIGHT+OB(OB1,2): PRINT "Taken." ELSE PRINT ER$(3) :GOTO 569
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
760 'IF CX<>10 THEN 870
761 PRINT "Use two word sentences like:- ";C$(rnd(11)+4);" ";OBSYN$(rnd(16));".";CHR$(10);"Some commands to try are: ";:FOR X=1 TO 15: PRINT C$(X);". "; : NEXT:PRINT
762 GOTO 9500





'equip 

'800 'IF CX<>13 THEN 870
'801 IF OB(OB1,1)<>-1 then ?"You don't have it.":goto 9500 
'802 SLOT=OB(OB1,10): FOR X=1 TO 12: IF OB(X,10)=SLOT AND OB(X,1)=-2 THEN OB(X,10)=-1:?"Unequipped ";ob$(x) :WEIGHT=WEIGHT+OB(x,2):GOTO 804
'803 NEXT 
'804 OB(OB1,1)=-2:  PRINT "Equipped ";ob$(ob1): WEIGHT=WEIGHT-OB(OB1,2):slot(slot)=stat(ob(ob1,3),1):
'HOW AM I GOING TO WORK THIS? SO MANY STATS, ONLY ONE DISPLAY



800 'IF CX<>13 THEN 870
801 IF OB(OB1,1)<>-1 then ?"You don't have it.":goto 9500 
802 if ob(ob1,10)=0  then ?"Can't equip that.":goto 9500
803 SLOT=OB(OB1,10): FOR X=1 TO 12: IF OB(X,10)=SLOT AND OB(X,1)=-2 THEN OB(X,10)=-1:?"Unequipped ";ob$(x) :WEIGHT=WEIGHT+OB(x,2):for x=1 to 9:cstat(x)=cstat(x)-stat(ob(ob1,3),x):next:GOTO 805
804 NEXT 
805 OB(OB1,1)=-2:  PRINT "Equipped ";ob$(ob1): WEIGHT=WEIGHT-OB(OB1,2):slot(slot)=stat(ob(ob1,3),1):for x=1 to 9:cstat(x)=cstat(x)+stat(ob(ob1,3),x):next
'HOW AM I GOING TO WORK THIS? SO MANY STATS, ONLY ONE DISPLAY




808 GOTO 9500

'unequip
810 'IF CX<>14 THEN 870
811 IF OB(OB1,1)=-2 THEN OB(OB1,1)=-1 :  WEIGHT=WEIGHT+OB(OB1,2):slot(ob(ob1,10))=0: PRINT "Removed." : for x=1 to 9:cstat(x)=cstat(x)-stat(ob(ob1,3),x): IF cstat(x)<0 then cstat(x)=0
812 next : GOTO 9500


'------------------------------------------------------------------------------------------------------------------------
'COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE COMMAND USE
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



'------------------------------------------------------------------------------------------------------------------------

'stats on object
'STATS 1)STRENGTH, 2)ATTACK, 3)DEFENSE,  4)SKILL, 5)STAMINA, 6)LUCK, 7)MAGIC, 8)CHARISMA, 9)HEALTH
951 'if objornpc=2 then 953
952 IF OB(OB1,1) >0 AND OB(OB1,1)<>LO THEN PRINT ER$(2) : GOTO 9500 ELSE PRINT "Stats on "; OB$(OB1) :STATOB=OB(OB1,3):if dbug=1 then ?statob

 'if npc(ob1,1) <>lo then print er$(2) : goto 9500 else print "Stats on "; npc$(ob1) :statob=npc(ob1,3):goto 954
954 PRINT "Attack: ";STAT(STATOB,2);"  /   Defense: ";STAT(STATOB,3);"  /   Health:";STAT(STATOB,9);"  /   Strength:";STAT(STATOB,1);"   /  Skill:";STAT(STATOB,4)
955 PRINT "Stamina:";STAT(STATOB,5);"  /   Charisma:";STAT(STATOB,8);"  /   Luck:  ";STAT(STATOB,6); "  /   Magic:   ";STAT(STATOB,7);
996 if ob(ob1,11)=0 then ? "   /  Value:"; else ? "   /  Gold: ";
997 ? STAT(STATOB,10)
999 GOTO 9500

'death
1000'

'display exits
2000 PRINT CHR$(10);"Some obvious directions are: ";:if l(lo) AND 1 then ? "North. ";
2001 if l(lo) AND 2 then ? "East. ";
2002 if l(lo) AND 4 then ? "South. ";
2003 if l(lo) AND 8 then ? "West.";
2004 return

'fight
4000 print "You are now locked in battle and your fate is in the hands of the gods. They'll roll the dice with your stats. If you are skilled or lucky enough, you may come out victorious at the other end of this."+br$+"<press any key when ready>"

'*** S T A T S ***
'STATS   1)STRENGTH, 2)ATTACK, 3)DEFENSE,  4)SKILL, 5)STAMINA, 6)LUCK, 7)MAGIC, 8)CHARISMA, 9)HEALTH
4001 i$=inkey$:if i$="" then 4001 else round=1
4002 npcatt=stat(ob(npc,3),1):npcdef=stat(ob(npc,3),2):npchlth=stat(ob(npc,3),3):npcstr=stat(ob(npc,3),4):npcskl=stat(ob(npc,3),5):npcstam=stat(ob(npc,3),6):npcluck=stat(ob(npc,3),7)
4003 ?"NPC ATTACK:";npcatt; " NPC DEFNSE:";npcdef; " NPC HEALTH:";npchlth;" NPC STRENGTH:";npcstr;"NPC SKILL:";npcskl
4004 ?"NPC STAMINA:";npcstam;"NPC luck:";npcstr

4010 turn=rnd(2):if turn=2 then ?"You get the jump on the ";npc$: goto 4050 else goto 4012
4011 if inkey$="" then 4011
4012 ? "Round:";round 
4013 luckycrit=rnd(12/(npcluck+1)):if luckycrit<>1 then luckycrit=0 else luckycrit=rnd(npcluck)
4014 hit=rnd(npcstr/2)+1*rnd(npcskl/2)+1*(npcstam+luckycrit)+1:connect=hit-cstat(3)
4015 if npcstam<1 then print "The "+npc$+" has tuckered himself out. He can't raise a limb to attack.":goto 4050
4016 ?"The "+npc$+" lashes out with strength ";hit: if rnd(npcluck+2)>rnd(luck+2) then ? "And it hits you for ";connect else print " .. but you duck and he misses.":connect=0
4020 npcstam=npcstam-1:npcluck=npcluck-1:cstat(9)=cstat(9)-connect:cstat(3)=cstat(3)-connect
4021 for x=1 to 9: if cstat(x)<0 then cstat(x)=0
4022 next:if npcstam<0 then npchlth=npchlth-1:npcstam=0
4023 if npcluck<0 then npcluck=0

' do I need to keep resetting cstats to 0 or is there a better way.
4025 if cstat(9)<1 then ? "You hear The gods rumble as consciousness slips: Thou broughtest pisse to a shytefight.":end

4050 luckycrit=rnd(12/(cstat(6)+1)):if luckycrit<>1 then luckycrit=0 else luckycrit=rnd(cstat(6))
4051 hit=rnd(cstat(1)/2)+1*rnd(cstat(4)/2)+1*(cstat(5)+luckycrit)+1:if hit<1 then hit=1
4052 connect=hit-npcdef: if connect<1 then connect=1

' insert gosub animation routine between lashing out and connecting
4053 ?"You lash out with strength ";hit: if rnd(cstat(6)+2)>rnd(npcluck+2) or npcstam<1 then ? "And hit the "+npc$+" for ";connect else print ".. but the "+npc$+" dodges.": connect=0
4054 cstat(5)=cstat(5)-1:cstat(6)=cstat(6)-1:npchlth=npchlth-connect:npcdef=npcdef-connect
4055 '
4056 if npchlth<1 then ? "You killed the "+npc$+". Now all their loot is yours" else round=round+1:goto 4011

'4056 '?npc;ob1;ob(npc,8);trigger(ob(npc,8),1):?ob(ob1,8):?"why no work?";
'303 or 4058? Can't do both.
'4057 TRIGGER ON DEATH GOES HERE - exchange NPC for OB at location. OB has loot to search for
'4057 if ob(npc,9)=7 then triggerit=(ob(npc,8)):?triggerit;"death trigger works";trigger(triggerit,10);br$:goto 6000
4057 if ob(npc,9)=7 then triggerit=(ob(npc,8)):goto 6000
4058 ?"You take a breath and rest for a moment, then search the "+npc$: ob(npc,1)=0:npch=0:cstat(6)=cstat(6)+3:xp=xp+npcatt+stat(ob(npc,3),11):gold=gold+stat(ob(npc,3),10) :goto 303


'map  - x = 8x8 map every multiple of 8 increases y - print @ = 80x22 
5000 cls:?@0,chr$(15);"Ye olde worlde map"
5001 for y=1 to 3:for x=1 to 8
5002 PA=(x*10)+(y*400)-320:xloc=x+(y-1)*8


5099 if xloc=lo then or l(xloc) AND 32 then 5101 else 5116 :'NOT VISITED - RETURN

5101 ?@PA-8,chr$(151)+chr$(131)+chr$(131)+chr$(131)+chr$(171);:?@PA+72,chr$(149);
5105 if xloc = lo then ?@pa+74,"X"; 
5110 print@pa+76, chr$(170);:print@PA+152,chr$(181)+chr$(176)+chr$(176)+chr$(176)+chr$(186);


5110 'if l(x+y,6)=1 then something :'DARK BLOCK

5112 if l(xloc) AND 4 then ? @ PA+70,chr$(131)+chr$(131); :'WEST  EXIT OPEN
5113 if l(xloc) And 4 then ? @ PA+234,chr$(191); :'SOUTH EXIT OPEN
5114 if l(xloc) AND 2 then ? @ PA+77,chr$(131)+chr$(131);chr$(131); :'EAST  EXIT OPEN
5115 if l(xloc) AND 1 then ? @ PA-86,chr$(191); :'NORTH EXIT OPEN
5116 next x,y:?@1760, "<Press any key to continue>";
5199 i$=inkey$:if i$="" then 5199 else ?chr$(14):goto 9500

'EXECUTE TRIGGERS
'----------- T R I G G E R S ------
'------------  1)swap with object, 2)insert object at loc, 3)insert object to inv, 4)trigger death, 5)teleport user,
'------------- 6)delete object, 7)execute another trigger, 8)action message, 9)STAT INCREASE, 10)open exit at location

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

'UGH! WHY CAN'T I GET MY HEAD AROUND IT. IT SEEMS GOOD TO ME. UPDATE: For some reason the return was missing from gosub on the previous line. Fixed it.
6092 IF TRIGGER(TRIGGERIT,10)>0 THEN ?"A new path is available.":l(lo)=l(lo)+trigger(triggerit,10)

6093 IF TRIGGER(TRIGGERIT,7)>0 THEN TRIGGERIT=TRIGGER(TRIGGERIT,7):GOTO 6000
6100 GOTO 9500





' STATS PAGE
7200 GOSUB 9600



'7201 PRINT@0,"Weight: ";:?@10,WEIGHT;: PRINT @80,"Max WT: ";:?@90,MAXWEIGHT:PRINT"Health: ";:?@170,HEALTH
'7202 PRINT "Strength:";:?@250,STRENGTH:PRINT "Attack:";:?@330,ATTACK: PRINT "Defense: ";:?@410,DEFENSE: PRINT "Skill: ";:?@490,SKILL
'7203 PRINT "Stamina: ";:?@570,STAMINA: 
'7204 ?@625,XP;:?@630,":Experin";:?@545,CHARISMA;:?@550,":Charsma";:?@465,MAGIC;:?@470,":Magic";
'7205 ?@385,LUCK;:?@390,":Luck";:?@305,ELIXIRS;:?@310,":Elixirs";:?@225,SALVES;:?@230,":Salves";
'7206 ?@145,KEYS;:?@150,":Keys";:?@65,GOLD;:?@70,":Gold";

' If I define these as a mapped location, I can zip in and out, changing them on the screen
7201 PRINT@P(1),"Strength:";:?@P(1)+10,cstat(1):PRINT @p(2),"Attack:";:?@p(2)+10,cstat(2):PRINT@p(3),"Defense:";:?@p(3)+10,cstat(3):PRINT @p(4),"Skill:";:?@p(4)+10,cstat(4)
7202 PRINT@p(5),"Stamina:";:?@p(5)+10,cstat(5):PRINT@p(6),"Luck:";:?@p(6)+10,cstat(6):PRINT@p(7),"Magic:";:?@p(7)+10,cstat(7)
'hmm what's with cstat(8) not displaying on this line, but value is right if I break and print it?
7203 PRINT@p(8),"Charisma:";:?@p(8)+10,cstat(8)
'hmm listing looked fine on 7202, but now it works on a separate line.

7204 ?@p(2)-16,WEIGHT;:?@p(2)-11,":Weight";:?@p(3)-16,MAXWEIGHT;:?@p(3)-11,":Max Weight";:?@p(4)-16,cstat(9);:?@p(4)-11,":Health";:?@p(5)-16,GOLD;:?@p(5)-11,":Gold";
7205 ?@p(6)-16,KEYS;:?@p(6)-11,":Keys";:?@p(7)-16,SALVES;:?@p(7)-11,":Salves";:?@p(8)-16,ELIXIRS;:?@p(8)-11,":Elixirs";:?@p(8)+64,cstat(11);:?@p(8)+69,":Experience";
7207
7208
7209 



7210 PRINT @30, STRING$(3,32)+CHR$(176)+CHR$(188)+CHR$(176);
7211 PRINT @112,CHR$(170)+STRING$(3,32)+CHR$(149);
7212 PRINT @190,STRING$(3,176)+CHR$(187)+CHR$(128)+CHR$(183)+STRING$(3,176);
7213 PRINT @269,CHR$(170)+STRING$(2,32)+CHR$(175)+STRING$(3,32)+CHR$(159)+STRING$(2,32)+CHR$(149);
7214 PRINT @350,CHR$(171)+CHR$(151)+CHR$(162)+STRING$(3,191)+CHR$(129)+CHR$(171)+CHR$(151);
7215 PRINT @432,CHR$(170)+STRING$(3,32)+CHR$(149);
7216 PRINT @510,CHR$(130)+CHR$(129)+CHR$(130)+CHR$(191)+CHR$(131)+CHR$(191)+CHR$(129)+CHR$(130)+CHR$(129);
7217 PRINT @592,CHR$(176)+CHR$(191)+CHR$(32)+CHR$(191)+CHR$(176);
7218 PRINT @671,CHR$(170)+STRING$(5,32)+CHR$(149);
7219 PRINT @752,STRING$(2,131)+CHR$(32)+STRING$(2,131);

7220 if slot(11)>0 then PRINT @105,chr$(181);:?@185,chr$(191);:?@265,chr$(191);:?@345,chr$(191);:?@424,chr$(131);chr$(191);chr$(131);:?@505,chr$(131);

'populate equipment stats
'801 IF OB(OB1,1)=-1 THEN SLOT=OB(OB1,10): FOR X=1 TO 10: IF OB(X,10)=SLOT AND OB(X,1)=-2 THEN OB(X,10)=-1:GOTO 9500 ELSE NEXT : OB(OB1,1)=-2:  'PRINT "Equipped.": WEIGHT=WEIGHT-OB(OB1,2): slot(x)=stat(ob(ob1,3),1):
'802 GOTO 9500

7240 ' for x=1 to 12 : stat(x)= FORGET THIS. CALCULATE IT AT TIME OF EQUIP/UNEQUIP
'NEED TO TRACK DOWN WHY THIS ISN'T POPULATING
7251 STATTY$=STR$(SLOT(1)):GOSUB 9700:STAT1$=STATTY$: STATTY$=STR$(SLOT(2)):GOSUB 9710:STAT2$=STATTY$: STATTY$=STR$(SLOT(3)):GOSUB 9700: STAT3$=STATTY$: STATTY$=STR$(SLOT(4)):GOSUB 9710:STAT4$=STATTY$
7252 STATTY$=STR$(SLOT(5)):GOSUB 9710:STAT5$=STATTY$: STATTY$=STR$(SLOT(6)):GOSUB 9700:STAT6$=STATTY$: STATTY$=STR$(SLOT(7)):GOSUB 9710: STAT7$=STATTY$: STATTY$=STR$(SLOT(8)):GOSUB 9710:STAT8$=STATTY$: STATTY$=STR$(SLOT(9)):GOSUB 9710:STAT9$=STATTY$
7253 STATTY$=STR$(SLOT(10)):STAT10$=RIGHT$(STATTY$,LEN(STATTY$)-1)
7254 statty$=str$(slot(11)):stat11$=RIGHT$(STATTY$,LEN(STATTY$)-1):
     'statty$=str$(slot(12)):stat12$=RIGHT$(STATTY$,LEN(STATTY$)-1)

7278 PRINT @113,STAT1$;:PRINT@270,STAT2$;:PRINT@273,STAT3$;:PRINT@277,STAT4$;
7279 PRINT @430,STAT5$;:PRINT@433,STAT6$;:PRINT@437,STAT7$;
7280 PRINT @672,STAT8$;:PRINT@675,STAT9$;:PRINT@194,STAT10$;

7282 if slot(11)>0 then print @425,stat11$;
7283 FOR X=1 TO 28: IF OB(X,1)=LO AND OB(X,11)>0 THEN NPCH=ob(x,11):npc$=ob$(x):npc=x else npch=0
7284 NEXT
7299 GOTO 199


'110 maxweight=10:strength=1:attack=0:xp=0:gold=0:health=10:luck=0:magic=0:speed=0:skill=0: stamina=0:charisma=0:keys=0
'INCREASE STATS -  1)ATTACK, 2)DEFENSE, 3)HEALTH, 4)STRENGTH, 5)SKILL, 6)STAMINA, 7)LUCK, 8)CHARISMA, 9)MAGIC, 10)GOLD, 11) XP

7300 STATSTOINC=TRIGGER(TRIGGERIT,9)
7301 for x=1 to 11: cstat(x)=cstat(x)+STATINC(STATSTOINC,x)
7302 next
7303 if xp>level*10 then level=level+1

7500 return


' TALK TO NPC PAGE
8000 REM BUY / SELL / TRADE goes here




' select ability to implement

   ' HMM won't get keyboard peek on model 4
   ' 8500 dim pb(12),ab(12):pb(1)=113:pb(2)=270:pb(3)=273:pb(4)=277:pb(5)=430:pb(6)=433:pb(7)=437:pb(8)=672:pb(9)=675:pb(10)=194:pb(11)=425:pb(12)=450:for x=1to12:ab(x)=rnd(99):next

   ' 8501 FOR X=1 TO 9:P(X)=X*80:NEXT
   ' 8502 'FOR X=1 TO 8 : GET ABILITY(X) :PRINT@P(X)+15,ABILITY(X);:NEXT
   ' 8504 PRINT@P(Y)+15,"   ";
   ' 8505 I=PEEK(14400):PRINT@0,I;
   ' 8506 IF I AND 8 THEN Y=Y-1 :IF Y<0 THEN Y=9
   ' 8507 IF I AND 16 THEN Y=Y+1: IF Y>9 THEN Y=1
   ' 8508 if i and 128 then 8502
   ' 8508 if i and 32 then x=x-1:if x<1 then x=12
   ' 8509 if i and 64 then x=x+1:if x>12 then x=1
   ' 8510 ?@p(y),ab(Y);:PRINT@P(Y)+15,"<--";:?@pb(x),ab(y);:?@pb(x),"  ";:?@pb(x),ab(y);
   ' 8520 GOTO 8504


'ALT VERSION
8500 dim pb(12),ab(12):pb(1)=113:pb(2)=270:pb(3)=273:pb(4)=277:pb(5)=430:pb(6)=433:pb(7)=437:pb(8)=672:pb(9)=675:pb(10)=194:pb(11)=425:pb(12)=450:for x=1to12:ab(x)=rnd(99):next

8501 FOR X=1 TO 9:P(X)=X*80:NEXT
8502 'FOR X=1 TO 8 : GET ABILITY(X) :PRINT@P(X)+15,ABILITY(X);:NEXT
8504 PRINT@P(Y)+15,"   ";
8505 I$=inkey$:if i$="" then 8505 else i=asc(i$)
8506 IF I=91 THEN Y=Y-1 :IF Y<0 THEN Y=9
8507 IF I=10 THEN Y=Y+1: IF Y>9 THEN Y=1
8508 if i=32 then 8502
8508 if i=8 then x=x-1:if x<1 then x=12
8509 if i=9 then x=x+1:if x>12 then x=1
8510 ?@p(y),ab(Y);:PRINT@P(Y)+15,"<--";:?@pb(x),ab(y);:?@pb(x),"  ";:?@pb(x),ab(y);

8520 GOTO 8504







'  to make top of screen static ->  POKE &HB94,( PEEK(1) OR 8 )
' update new screen goes here
'light source present?
9499 PRINT "okay."; ' eventually change this to returnmessage$ so I can rearrage the order of the messages. 
9500 IF STDP<0 THEN ?:goto 7200 
9501 IF OB(8,1)<0 OR OB(8,1)=LO THEN LIGHT=1
9502 GOSUB 9600:IF L(LO) AND 16 then if LIGHT=0 THEN print @400,chr$(30):poke &hb94,3: PRINT @0,"It's too dark to see.":GOTO 9550 else poke &hb94,7
9520 IF L(LO) AND 16 THEN PRINT@0,"Location: "; L$(LO) ELSE PRINT@0, LV$(LO)
9530 PRINT@240, "Items here: ";
9531 FOR X=1 TO 28: IF OB(X,1)=LO THEN PRINT OB$(X);". ";:IH=1:IF OB(X,11)>0 THEN NPCH=ob(x,11):npc$=ob$(x):npc=x else npch=0
9532 NEXT ': for x=1 to 2: if npc(x,1)=LO then print npc$(x);". ";:ih=1
9533 IF IH=0 THEN PRINT "none" ;
9539 gosub 2000 ' list exits.
9540 'PRINT CHR$(10);"Some obvious directions: ";:IF L(LO,1)=1 THEN PRINT "North.";
9541 'IF L(LO,2)=1 THEN PRINT "East.";
9542 'IF L(LO,3)=1 THEN PRINT "South.";
9543 'IF L(LO,4)=1 THEN PRINT "West.";
9550 ?:PRINT"<";STRING$(78,45);">";


'npc attack?
9559 PRINT@1840,"":if luck<0 then luck=0
9560 IF NPCH=1 THEN ATTACKCHANCE=RND(3+LUCK): IF ATTACKCHANCE=1 THEN PRINT "You are attacked":GOTO 4000 else print "You were in danger of being attacked, but your luck held out for this turn."


9599 GOTO 199

'clear screen 
9600 PRINT@0,CHR$(30):PRINT @80,CHR$(30):PRINT@160,CHR$(30):PRINT@240,CHR$(30):  RETURN

'remove superflous spaces at front of each number
9700 STATTY$=RIGHT$(STATTY$,LEN(STATTY$)-1)
9701 IF LEN(STATTY$)<3 THEN STATTY$="0"+STATTY$:GOTO 9701
9702 RETURN

9710 STATTY$=RIGHT$(STATTY$,LEN(STATTY$)-1)
9711 IF LEN(STATTY$)<2 THEN STATTY$="0"+STATTY$
9712 RETURN
