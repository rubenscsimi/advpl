#INCLUDE "rwmake.ch"
#include "TOTVS.CH"
#INCLUDE "PROTHEUS.CH"
#Include "COLORS.ch"
#include "MSGRAPHI.CH"
#Include "tbiconn.ch"
#Include "AP5MAIL.CH"
#INCLUDE "DBTREE.CH"
#INCLUDE "msole.ch"




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  		     บAutor  Rubens Simi            บ Data ณ  16/05/13 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿l฿฿฿
*/


User Function contLOG()


Private ldise		:= .f.
PRIVATE aHeader 	:={}
PRIVATE aLog 		:={}
PRIVATE aLog1 		:={}
PRIVATE aLog2 		:={}
PRIVATE oOK  		 := LoadBitmap(GetResources(),'br_verde')
PRIVATE oNO   		:= LoadBitmap(GetResources(),'br_vermelho')

Ajust3SX6()



If ( !AMIIn(34) )		// Acesso somente com licensas full para evitar erro na integracao com CTB
  AVISO('ATENวรO','Esta Rotina nao pode ser utilizada com licensas light' , {'Cancelar'}, 1)
	Return
EndIf    


IF cEmpAnt<>'07' .or. cFilAnt<>'04'
  AVISO('ATENวรO','Esta Rotina so pode ser utilizada na empresa 07 filial 04' , {'Cancelar'}, 1)
     Return()
endif


AaDd(aLog1,{.T.,'          ','                                  ',0,0,'         ',0})
AaDd(aLog,{.T.,'          ','                                  ',0,0,0})
AaDd(aLog2,{.T.,'   ','     ','     ','                      ','                     ',0,0,0,0})


private oPanel1,oTreeAR,odly,oTFolder,oTreeGL,oTreeR2,oMultiGet1,oPanel,oBrowse,oBrowse1,oBrowse2,onumero,oemail,oTBitmap1
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Divide a tela lateralmente e resolve as dimensoes de cada parte     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aSize    := MsAdvSize( .F. )

aObjects := {}

aAdd( aObjects, { 100, 100, .t., .t., .t. } )
aAdd( aObjects, { 140,  66, .F., .T. } )

aInfo    := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj1 := MsObjSize( aInfo, aObjects,  , .T. )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Resolve as dimensoes dos objetos da parte direita da tela           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aObjects := {}
aAdd( aObjects, { 140,  100, .T., .F. } )
aAdd( aObjects, { 100, 100, .T., .T. } )

aSize2 := aClone( aPosObj1[2] )

aInfo    := { aSize2[ 2 ], aSize2[ 1 ], aSize2[ 4 ], aSize2[ 3 ], 3, 3, 0, 0 }
aPosObj2 := MsObjSize( aInfo, aObjects )
//              alt      lar
DEFINE MSDIALOG oDly TITLE "Controle Log" FROM 000, 000  TO aSize[6],aSize[5]  PIXEL


nLin := aPosObj2[2,1]
nCol := aPosObj2[2,2]


oTBitmap1 := TBitmap():New(01,01,100,200,,"SYSTEM\AVIANCA_LOG.BMP",.T.,oDly,;
{||},,.F.,.F.,,,.F.,,.T.,,.F.)
oTBitmap1:lAutoSize := .T.                 
                              //L             C                                                    LARG             ALT
aTFolder := { "Log AR    ","Log Gl   ","Log R2   " }
oFolder := TFolder():New( aPosObj1[2,1], aPosObj1[1,1], aTFolder, , oDly,,,, .T., ,aPosObj2[1,4],aPosObj2[2,3] )
//oFolder:bChange := {||IF(oFolder:nOption=1, DBTreelog('AR'),IF(oFolder:nOption=2,DBTreelog('GL') ,DBTreelog('R2')  ))}



TButton():New( aPosObj2[2,3]-30, aPosObj1[2,1]+ 146, "Sair", oDly,{||oDly:End()};
,60,012,,,.F.,.T.,.F.,,.F.,,,.F. )  

TButton():New( aPosObj2[2,3]-30, aPosObj1[2,1]+ 73, "Alt. Reg", oDly,{||IF (oFolder:nOption=2,u_altCcusto(),ALERT('Opcao disponivel apenas para arquivos Rapdigl'))};
,60,012,,,.F.,.T.,.F.,,.F.,,,.F. )  


TButton():New( aPosObj2[2,3]-30, aPosObj1[2,1]+3, "Processar", oDly,{||U_TPPROC(1,"TIPO DE REPROCESSAMENTOS")};
,60,012,,,.F.,.T.,.F.,,.F.,,,.F. )

TButton():New( aPosObj2[2,3]-14, aPosObj1[2,1]+3, "Relatorios", oDly,{||U_TPPROC(2,"TIPO DE RELATORIOS")};
,60,012,,,.F.,.T.,.F.,,.F.,,,.F. )   


TButton():New( aPosObj2[2,3]-14, aPosObj1[2,1]+73, "Cadastros", oDly,{||U_TPPROC(3,"CADASTROS")};
,60,012,,,.F.,.T.,.F.,,.F.,,,.F. )  

TButton():New( aPosObj2[2,3]-14, aPosObj1[2,1]+146, "Importar Arquivos", oDly,{||U_TPPROC(4,"TIPO DE ARQUIVOS")};
,60,012,,,.F.,.T.,.F.,,.F.,,,.F. )

         

IF LEN(aLog)>0
oBrowse := TCBrowse():New(3  ,aPosObj2[1,4]-aPosObj2[1,2]+5 , aPosObj2[1,2]-20  ,  aPosObj2[2,3]-50,,{'','Conta','descricao','Debito','Credito','RECNO'},{20,50,150,100,100,100},oFolder:adialogs[1],,,,,{||MOSTRALOG('ZA2',aLog[oBrowse:nAt,06])},,,,,,,.F.,,.T.,,.F.,,, )
oBrowse:bLDblClick
oBrowse:SetArray(aLog)
oBrowse:bLine := {||{ If(aLog[oBrowse:nAt,01],oOK,oNO),;
aLog[oBrowse:nAt,02],;
aLog[oBrowse:nAt,03],;
aLog[oBrowse:nAt,04],;
aLog[oBrowse:nAt,05],;
aLog[oBrowse:nAt,06] } }
ENDIF

IF LEN(aLog1)>0
oBrowse1 := TCBrowse():New(3  ,aPosObj2[1,4]-aPosObj2[1,2]+5 , aPosObj2[1,2]-20  ,  aPosObj2[2,3]-50,,{'','Conta','descricao','Debito','Credito','C. Custo','RECNO'},{20,50,150,100,100,100},oFolder:adialogs[2],,,,,{||MOSTRALOG('ZA3',aLog1[oBrowse1:nAt,07])},,,,,,,.F.,,.T.,,.F.,,, )
oBrowse1:bLDblClick
oBrowse1:SetArray(aLog1)
oBrowse1:bLine := {||{ If(aLog1[oBrowse1:nAt,01],oOK,oNO),;
aLog1[oBrowse1:nAt,02],;
aLog1[oBrowse1:nAt,03],;
aLog1[oBrowse1:nAt,04],;
aLog1[oBrowse1:nAt,05],; 
aLog1[oBrowse1:nAt,06],;
aLog1[oBrowse1:nAt,07] } }
ENDIF
  
  


IF LEN(alog2)>0
oBrowse2 := TCBrowse():New(3  ,aPosObj2[1,4]-aPosObj2[1,2]+5 , aPosObj2[1,2]-20  ,  aPosObj2[2,3]-50,,;
{'','Id','Cod. Iata','Data','Descri็ใo','Historico','Valor Bruto','Valor Taxas','Valor Liquido','RECNO'},{20,50,150,100,100,100},oFolder:adialogs[3];
,,,,,{||MOSTRALOG('ZA7',alog2[oBrowse2:nAt,10])},,,,,,,.F.,,.T.,,.F.,,, )
oBrowse2:bLDblClick
oBrowse2:SetArray(alog2)
oBrowse2:bLine := {||{ If(alog2[oBrowse2:nAt,01],oOK,oNO),;
alog2[oBrowse2:nAt,02],;
alog2[oBrowse2:nAt,03],;
alog2[oBrowse2:nAt,04],;
alog2[oBrowse2:nAt,05],;
alog2[oBrowse2:nAt,06],;
alog2[oBrowse2:nAt,07],;
alog2[oBrowse2:nAt,08],;
alog2[oBrowse2:nAt,09],;
alog2[oBrowse2:nAt,10] } }
ENDIF


//DBTreelog('AR')
  
DBTreelog()

ACTIVATE MSDIALOG odly CENTERED

return()



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  		     บAutor  Rubens Simi            บ Data ณ  16/05/13 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿l฿฿฿
*/




Static Function DBTreelog(cTipo)



//Do Case
	
  //	Case cTipo='AR'
			oTreeAR:=NIL
			oTreeAR := DbTree():New(0,0,aPosObj2[2,3]-50,aPosObj2[1,4]-aPosObj2[1,2],oFolder:adialogs[1],{||cargalog('ZA2',oTreeAR:getcargo())},{||},.T.)
		
		
	
		
			
		cQuery := " SELECT * FROM " + RetSqlName("ZA2")
		cQuery += " WHERE ZA2_STAFIN='E' OR ZA2_STACTB='E'
		cQuery += " AND D_E_L_E_T_ = ' ' "
		cQuery += " ORDER BY ZA2_LOTE,ZA2_DATA "
		
		
		cQuery := ChangeQuery( cQuery )
		dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA2L", .F., .T. )
		
		
		dbSelectArea("ZA2L")
		dbgotop()

		IF !EMPTY(ZA2L->ZA2_LOTE)
			
			oTreeAR:AddTree("Lotes Com Inconsistencia"+space(10),,,,"FOLDER5","FOLDER6","0000000000000000A")
				oTreeAR:BeginUpdate()
			while ZA2L->(!eof() )
				oTreeAR:Treeseek("0000000000000000A")
				oTreeAR:AddTreeItem("Lote: "+ZA2L->ZA2_LOTE ,"WORD",,STR(ZA2L->R_E_C_N_O_))
				ZA2L->( DbSkip() )
			Enddo
			
			
		ELSE
			
			
			
			oTreeAR:AddTree("Nใo ha Lotes Inconsistentes",,,,"BR_VERDE","BR_VERDE","0000000000000000A")
		
		ENDIF
		ZA2L->(DbCloseArea())
    	oTreeAR:EndTree()
		oTreeAR:PTCOLLAPSE()
		oTreeAR:Refresh()
		oTreeAR:EndUpdate()
		oTreeAR:Show()		
		
			oTreeGL:=NIL //Reset()

		oTreegl := DbTree():New(0,0,aPosObj2[2,3]-50,aPosObj2[1,4]-aPosObj2[1,2],oFolder:adialogs[2],{||cargalog('ZA3',oTreeGL:getcargo())},{||},.T.)
		

		cQuery := " SELECT ZA3_IATA,ZA3_DATA,R_E_C_N_O_ FROM " + RetSqlName("ZA3")
		cQuery += " WHERE ZA3_STACTB='E' OR  ZA3_STAFIN='E'
		cQuery += " AND D_E_L_E_T_ = ' ' "
		cQuery += " ORDER BY ZA3_IATA,ZA3_DATA "
		
		
		cQuery := ChangeQuery( cQuery )
		dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA3L", .F., .T. )
		aIatadt:={}
		
		dbSelectArea("ZA3L")
		dbgotop()
		
		
		
		If !EMPTY(ZA3L->ZA3_DATA) 
   		
			
			oTreegl:AddTree("Lotes Com Inconsistencia"+space(10),,,,"FOLDER5","FOLDER6","00000000000000000000000000000000B")
				oTreegl:BeginUpdate()
			while ZA3L->(!eof() )   
			if  aScan(aIatadt, ZA3L->(ZA3_IATA+ZA3_DATA)) == 0
			aAdd(aIatadt, ZA3L->(ZA3_IATA+ZA3_DATA))
	
				oTreegl:Treeseek("00000000000000000000000000000000B")
				oTreegl:AddTreeItem("Iata: "+ALLTRIM(ZA3L->ZA3_IATA)+" Data: "+DTOCY(stod(ZA3L->ZA3_DATA)) ,"WORD",,ALLTRIM(str(ZA3L->R_E_C_N_O_)))
	   
				endif
							ZA3L->( DbSkip() )
	   
			Enddo
			
			
			
		ELSE
			
			
			
			oTreegl:AddTree("Nใo ha Lotes Inconsistentes",,,,"BR_VERDE","BR_VERDE","0000000000000000A")
			
		ENDIF
		ZA3L->(DbCloseArea())
		
		oTreegl:EndTree()
		oTreegl:PTCOLLAPSE()
		oTreegl:Refresh()
		oTreegl:EndUpdate()
		oTreegl:Show()
		
		
//	Case cTipo='R2'
		oTreeR2:=NIL
		oTreeR2 := DbTree():New(0,0,aPosObj2[2,3]-50,aPosObj2[1,4]-aPosObj2[1,2],oFolder:adialogs[3],{||cargalog('ZA7',oTreeR2:getcargo())},{||},.T.)
		
		
		
		
		cQuery := " SELECT * FROM " + RetSqlName("ZA7")
		cQuery += " WHERE ZA7_STATUS='E'
		cQuery += " AND D_E_L_E_T_ = ' ' "
		cQuery += " ORDER BY ZA7_TPARQ,ZA7_IATA,ZA7_DTARQ"
		
		
		cQuery := ChangeQuery( cQuery )
		dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA7L", .F., .T. )
		
	
		
		ar21:={}
		ar22:={}
		ar23:={}
		ar24:={}                                                                   
		
		
		
		
		
		dbSelectArea("ZA7L")
		dbgotop()
		
		IF !EMPTY(ZA7L->ZA7_IATA)
			
			while ZA7L->(!eof() )
				
				DO CASE
					CASE ZA7L->ZA7_TPARQ="01" 
						IF aScan(ar21,{|x| AllTrim(x[1])==alltrim(ZA7L->ZA7_IATA)})=0 
							aadd(ar21,{ZA7L->ZA7_IATA})
						ENDIF
					CASE ZA7L->ZA7_TPARQ="02"
						IF aScan(ar22,{|x| AllTrim(x[1])==alltrim(ZA7L->ZA7_IATA)})=0 
						aadd(ar22,{ZA7L->ZA7_IATA})
					    ENDIF
					CASE ZA7L->ZA7_TPARQ="03"
						IF aScan(ar23,{|x| AllTrim(x[1])==alltrim(ZA7L->ZA7_IATA)})=0 
						aadd(ar23,{ZA7L->ZA7_IATA})
					    ENDIF
					CASE ZA7L->ZA7_TPARQ="04"
						IF aScan(ar24,{|x| AllTrim(x[1])==alltrim(ZA7L->ZA7_IATA)})=0 
						aadd(ar24,{ZA7L->ZA7_IATA})
                       ENDIF
				ENDCASE
				
				
				ZA7L->( DbSkip() )
			Enddo
			  
				oTreeR2:AddTree("Lotes Com Inconsistencia"+space(10),,,,"FOLDER5","FOLDER6","0000000000000000C")
		
		oTreeR2:BeginUpdate()
			
			if len(AR21)>0
				oTreeR2:Treeseek("0000000000000000C")
				oTreeR2:AddTree("Hot",,,,"FOLDER5","FOLDER6","0000000000000R201")
				FOR NX:=1 TO LEN(AR21)
					oTreeR2:AddtreeItem("Iata: "+AR21[NX][1],"WORD",,alltrim(AR21[NX][1])+'01')
				NEXT nx
				oTreeR2:EndTree()
			else
				oTreeR2:Treeseek("0000000000000000C")
				oTreeR2:AddTree("Hot",,,,"BR_VERDE","BR_VERDE","0000000000000R201")
				oTreeR2:EndTree()
			endif
			
			
			
			if len(AR22)>0
				oTreeR2:Treeseek("0000000000000000C")
				oTreeR2:AddTree("Provisใo",,,,"FOLDER5","FOLDER6","0000000000000R202")
				FOR NX:=1 TO LEN(AR22)
					oTreeR2:AddtreeItem("Iata: "+AR22[NX][1],"WORD",,alltrim(AR22[NX][1])+'02')
				NEXT nx
				oTreeR2:EndTree()
			else
				oTreeR2:Treeseek("0000000000000000C")
				oTreeR2:AddTree("Provosใo",,,,"BR_VERDE","BR_VERDE","0000000000000R202")
				oTreeR2:EndTree()
			endif
			
			
			if len(AR23)>0
				oTreeR2:Treeseek("0000000000000000C")
				oTreeR2:AddTree("Ajustes",,,,"FOLDER5","FOLDER6","0000000000000R203")
				FOR NX:=1 TO LEN(AR23)
					oTreeR2:AddtreeItem("Iata: "+AR23[NX][1],"WORD",,alltrim(AR23[NX][1])+'03')
				NEXT nx
				oTreeR2:EndTree()
			else
				oTreeR2:Treeseek("0000000000000000C")
				oTreeR2:AddTree("Ajustes",,,,"BR_VERDE","BR_VERDE","0000000000000R203")
				oTreeR2:EndTree()
			endif
			
			
			if len(AR24)>0
				oTreeR2:Treeseek("0000000000000000C")
				oTreeR2:AddTree("Liquida็ใo",,,,"FOLDER5","FOLDER6","0000000000000R204")
				FOR NX:=1 TO LEN(AR24)
					oTreeR2:AddtreeItem("Iata: "+AR24[NX][1],"WORD",,alltrim(AR24[NX][1])+'04')
				NEXT nx
				oTreeR2:EndTree()
			else
				oTreeR2:Treeseek("0000000000000000C")
				oTreeR2:AddTree("Liquida็ใo",,,,"BR_VERDE","BR_VERDE","0000000000000R204")
				oTreeR2:EndTree()
			endif
			
			
		ELSE

			
			oTreeR2:AddTree("Nใo ha Lotes Inconsistentes",,,,"BR_VERDE","BR_VERDE","0000000000000000A")

			
			
		ENDIF
		
		ZA7L->(DbCloseArea())
		oTreeR2:EndTree()
			oTreeR2:Treeseek("0000000000000000C")
			oTreeR2:PTCOLLAPSE()
			oTreeR2:Refresh()
			oTreeR2:EndUpdate()
			oTreeR2:Show()
			
		
//EndCase






static function cargalog(cAlias,rec)


aLog 		:={}
aLog1 		:={}
aLog2 		:={}



Do Case
	Case cAlias=='ZA3'
		DBSELECTAREA('ZA3')
		ZA3->(DBGOTO(val(rec)))
		
		
		
		dbselectarea('CT1')
		Dbsetorder(1)
		
		
		cQuery := " SELECT ISNULL(CONVERT(VARCHAR(2047), CONVERT(VARBINARY(2047), ZA3_LOGFIN)),'') AS ZA3_LOGFIN,"
		cQuery += " ISNULL(CONVERT(VARCHAR(2047), CONVERT(VARBINARY(2047), ZA3_LOGCTB)),'') AS ZA3_LOGCTB,
		cQuery += " ZA3_TPLAN,ZA3_CONTA,ZA3_VALOR,R_E_C_N_O_,ZA3_LOTE,ZA3_LINHA,ZA3_CCUSTO,R_E_C_N_O_ AS RECN FROM " + RetSqlName("ZA3")
		cQuery += " WHERE ZA3_IATA='"+ZA3->ZA3_IATA+"' AND ZA3_DATA='"+DTOS(ZA3->ZA3_DATA)+"'"
		cQuery += " AND D_E_L_E_T_ = ' ' "
		cQuery += " ORDER BY ZA3_LOTE,ZA3_LINHA"
		
		
		cQuery := ChangeQuery( cQuery )
		dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA3LC", .F., .T. )
		
		
		
		aLog1:={}
		lRet:=.t.
		N:=0
		nValordb:=0
		nValorcr:=0
		dbSelectArea("ZA3LC")
		dbgotop()
		while ZA3LC->(!eof() )
			lRet:=.t.
			IF EMPTY(ZA3LC->ZA3_LOGFIN)
				IF EMPTY(ZA3LC->ZA3_LOGCTB)
					lRet:=.t.
				else
					lRet:=.f.
				endif
			ELSE
				lRet:=.F.
			ENDIF
			N++
			
			
			IF CT1->(DBSEEK(XFILIAL("CT1") +ZA3LC->ZA3_CONTA))
				cDesc:=alltrim(ct1->CT1_DESC01)
			else
				cDesc:="CONTA NAO CADASTRADA"
				lRet:=.f.
			endif
			
			
			AaDd(aLog1,{lRet,ALLTRIM(ZA3LC->ZA3_CONTA),cDesc,Transform(0, "@E 999,999,999,999.99" ) ,Transform(0, "@E 999,999,999,999.99" ),ALLTRIM(ZA3LC->ZA3_CCUSTO), ZA3LC->RECN})
			
			
			IF ZA3LC->ZA3_TPLAN='1'
				
				aLog1[N][5]:=Transform(ZA3LC->ZA3_VALOR, "@E 999,999,999,999.99" )
				nValorcr+=ZA3LC->ZA3_VALOR
			ELSE
				aLog1[N][4]:=Transform(ZA3LC->ZA3_VALOR, "@E 999,999,999,999.99" )
				nValordb+=ZA3LC->ZA3_VALOR
				
			ENDIF
		
			
			ZA3LC->( DbSkip() )
		Enddo
		ZA3LC->(DbCloseArea())
		
		AaDd(aLog1,{if(nValordb=nValorcr,.t.,.f.),"Total",'',Transform(nValordb, "@E 999,999,999,999.99" ),Transform(nValorcr, "@E 999,999,999,999.99" ),'',0})
		
		
		
		if len(aLog1)=0
		AaDd(aLog1,{.T.,'          ','                                  ',0,0,'        ',0})
		endif
		
		oBrowse1:SetArray(aLog1)
		oBrowse1:bLine := {||{ If(aLog1[oBrowse1:nAt,01],oOK,oNO),;
		aLog1[oBrowse1:nAt,02],;
		aLog1[oBrowse1:nAt,03],;
		aLog1[oBrowse1:nAt,04],;
		aLog1[oBrowse1:nAt,05],;
		aLog1[oBrowse1:nAt,06],;
		alog1[oBrowse1:nAt,07] } }
		oBrowse1:Refresh()


		
		
	Case cAlias=='ZA2'
		
		DBSELECTAREA('ZA2')
		ZA2->(DBGOTO(val(rec)))
		
		dbSelectArea('SA2')
		DBSETORDER(9)
		
		dbSelectArea('SA1')
		DBSETORDER(9)
		
		dbSelectArea('SED')
		DBSETORDER(4)
		nValorcr:=0
		nValordb:=0
		N:=1
		
		IF CT1->(DBSEEK(XFILIAL("CT1") +ZA2->ZA2_CONTA))
			cDesc:=alltrim(ct1->CT1_DESC01)
			lRet:=.t.
		else
			cDesc:="CONTA NAO CADASTRADA"
			lRet:=.f.
		endif
		
		AaDd(aLOG,{lRet,ALLTRIM(ZA2->ZA2_CONTA),cDesc,Transform(0, "@E 999,999,999,999.99" ) ,Transform(0, "@E 999,999,999,999.99" ), val(rec)})
		
		nValor:=If (ZA2->ZA2_VALOR>0,ZA2->ZA2_VALOR,ZA2->ZA2_VALOR*-1)
		IF ZA2->ZA2_TPLAN='1'
			
			aLOG[N][5]:=Transform(nValor, "@E 999,999,999,999.99" )
			nValorcr+=nValor
		ELSE
			aLOG[N][4]:=Transform(nValor, "@E 999,999,999,999.99" )
			nValordb+=nValor
			
		ENDIF
		
		
		
		
		//carrega informacoes do rateio
		
		cQuery := " SELECT * FROM " + RetSqlName("ZA4")
		cQuery += " WHERE ZA4_LOTE='"+ZA2->ZA2_LOTE+"' AND ZA4_IATA='"+ ZA2->ZA2_IATA+"'"
		cQuery += " AND   D_E_L_E_T_ = ' ' "
		cQuery += " ORDER BY ZA4_LINHA"
		
		
		cQuery := ChangeQuery( cQuery )
		dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA4T", .F., .T. )
		
		
		dbSelectArea("ZA4T")
		dbgotop()
		while ZA4T->(!eof() )
			nValor:=If (ZA4T->ZA4_VALOR>0, ZA4T->ZA4_VALOR ,ZA4T->ZA4_VALOR*-1)
			
			N++
			
			IF CT1->(DBSEEK(XFILIAL("CT1") +ZA4T->ZA4_CONTA))
				cDesc:=alltrim(ct1->CT1_DESC01)
				lRet:=.t.
			else
				cDesc:="CONTA NAO CADASTRADA"
				lRet:=.f.
			endif
			
			AaDd(aLOG,{lRet,ALLTRIM(ZA4T->ZA4_CONTA),cDesc,Transform(0, "@E 999,999,999,999.99" ) ,Transform(0, "@E 999,999,999,999.99" ), val(rec)})
			
			
			IF ZA4T->ZA4_TPLAN='1'
				
				aLOG[N][5]:=Transform(nValor, "@E 999,999,999,999.99" )
				nValorcr+=nValor
			ELSE
				aLOG[N][4]:=Transform(nValor, "@E 999,999,999,999.99" )
				nValordb+=nValor
				
			ENDIF
			
			ZA4T->( DbSkip() )
		Enddo
		ZA4T->(DbCloseArea())
		
		AaDd(aLOG,{if(nValordb=nValorcr,.t.,.f.),"Total",'',Transform(nValordb, "@E 999,999,999,999.99" ),Transform(nValorcr, "@E 999,999,999,999.99" ),0})


		if len(aLog)=0
			AaDd(aLog,{.T.,'          ','                                  ',0,0,0})
		ENDIF

		oBrowse:SetArray(aLog)
		oBrowse:bLine := {||{ If(aLog[oBrowse:nAt,01],oOK,oNO),;
		aLog[oBrowse:nAt,02],;
		aLog[oBrowse:nAt,03],;
		aLog[oBrowse:nAt,04],;
		aLog[oBrowse:nAt,05],;
		alog[oBrowse:nAt,06] } }
		oBrowse:Refresh() 
				



		
	Case cAlias=='ZA7'
		

			
	    cQuery := "	SELECT * FROM " + RetSqlName("ZA7")+" WHERE RTRIM(ZA7_IATA)+ZA7_TPARQ='"+rec+"'"
     	cQuery += " AND ZA7_RECONC<>'S' ORDER BY ZA7_DTPR2 "
		
		cQuery := ChangeQuery( cQuery )
		dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA7L3", .F., .T. )
		
		
		dbSelectArea("ZA7L3")
		dbgotop()
		

			while ZA7L3->(!eof() )  
			
			if ZA7L3->ZA7_STATUS='I'
			lRet:=.t.
			else
			lRet:=.f.
			endif
			
		AaDd(aLOG2,{lRet,ZA7L3->ZA7_ID,alltrim(ZA7L3->ZA7_IATA),DTOCY(stod(ZA7L3->ZA7_DTPR2)),alltrim(ZA7L3->ZA7_DSCSOL),alltrim(ZA7L3->ZA7_HIST),Transform(ZA7L3->ZA7_VLBRUT, "@E 999,999,999,999.99" ),;
		Transform(ZA7L3->ZA7_VALTXA, "@E 999,999,999,999.99" ),Transform(ZA7L3->ZA7_VALLIQ, "@E 999,999,999,999.99" ),ZA7L3->R_E_C_N_O_ })


				ZA7L3->( DbSkip() )
			Enddo
		ZA7L3->(DbCloseArea())		
		
		
		
		if len(aLog2)=0
		AaDd(aLog2,{.T.,'   ','     ','     ','                      ','                     ',0,0,0,0})
		endif  
		
		oBrowse2:SetArray(aLog2)		
		oBrowse2:bLine := {||{ If(aLog2[oBrowse2:nAt,01],oOK,oNO),;
		aLog2[oBrowse2:nAt,02],;
		aLog2[oBrowse2:nAt,03],;
		aLog2[oBrowse2:nAt,04],;
		aLog2[oBrowse2:nAt,05],;
		aLog2[oBrowse2:nAt,06],;
		aLog2[oBrowse2:nAt,07],;
		aLog2[oBrowse2:nAt,08],;
		aLog2[oBrowse2:nAt,09],;
		alog2[oBrowse2:nAt,10] } }
		oBrowse2:Refresh()
		

		
		
EndCase

RETURN()

STATIC function MOSTRALOG(cALIAS,nRec)

Local cMask   :=''
Local cTexto  :=''
Local cFile   :=''



Dbselectarea(cALIAS)
dBGOTO(nRec)


	cTexto:=(cALIAS)->&(cALIAS+'_LOGCTB')
  	cTexto+=(cALIAS)->&(cALIAS+'_LOGFIN')
  

DEFINE FONT oFont NAME "Mono AS" SIZE 5,12   //6,15
DEFINE MSDIALOG oDlX TITLE "log de Resgistros" From 3,0 to 340,417 PIXEL //"Atualizacao concluida."
@ 5,5 GET oMemo  VAR cTexto MEMO SIZE 200,145 OF oDlX PIXEL
oMemo:bRClicked := {||AllwaysTrue()}
oMemo:oFont:=oFont

DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlX:End() ENABLE OF oDlX PIXEL //Apaga
DEFINE SBUTTON  FROM 153,145 TYPE 13 ACTION (cFile:=cGetFile(cMask,""),If(cFile="",.t.,MemoWrite(cFile,cTexto))) ENABLE OF oDlX PIXEL //Salva e Apaga //"Salvar Como..."


ACTIVATE MSDIALOG oDlX CENTER 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณProgram   ณproduto   ณ Autor ณ RUBENS SIMI           ณ Data ณ 11.07.00 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ TELA DE TIPO DE PROCESSAMENTO                              ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ Nenhum                                                     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Generico                                                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nenhum                                                     ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
user Function TPPROC(nTipo,cDescri)

Local oDlg
Local oRadio
Local nRadio
Local nOpca := 1


DEFINE MSDIALOG oDlg FROM  94,1 TO 320,293 TITLE cDescri PIXEL

@ 05,17 Say "escolha uma Op็ใo"  SIZE 150,7 OF oDlg PIXEL

@ 17,07 TO 92, 140 OF oDlg  PIXEL

DO CASE
	
	CASE nTipo==1
		@ 25,10 Radio 	oRadio VAR nRadio;
		ITEMS 	"GL",;
		"AR",;
		"R2",;
		"DU",;
		"TODOS";
		SIZE 110,10 OF oDlg PIXEL
		
	CASE nTipo==2
		
		@ 25,10 Radio 	oRadio VAR nRadio;
		ITEMS 	"Relatorio RapidGL",;
		"Relatorio RapidAR",;
		"Relatorio R2",;
		'Relatorio De Provis๕es',;
		'Mapa de Integra็ใo';
		SIZE 110,10 OF oDlg PIXEL
		
		
	CASE nTipo==3
		
		@ 20,10 Radio 	oRadio VAR nRadio;
		ITEMS 	"Cliente",;
		"Fornecedor",;
		"Natureza",;
		"Plano de Contas",;
	    "A็ใo X Conta",;
		"Calendario Iata",;
		"Tabela De ISS";
		SIZE 110,10 OF oDlg PIXEL
		
	 

	CASE nTipo==4
		@ 25,10 Radio 	oRadio VAR nRadio;
		ITEMS 	"GL",;
		"AR",;
		"R2";
		SIZE 110,10 OF oDlg PIXEL
		
			
	END CASE
	
	
	
	
	DEFINE SBUTTON FROM 92,085 TYPE 1 ENABLE OF oDlg ACTION (nOpca := 1, oDlg:End())
	DEFINE SBUTTON FROM 92,115 TYPE 2 ENABLE OF oDlg ACTION (nOpca := 0, oDlg:End())
	
	ACTIVATE MSDIALOG oDlg CENTERED ON INIT (nOpca := 0, .T.)	// Zero nOpca caso
	//	para saida com ESC
	
 IF nOpca==1	
	DO CASE
		
		CASE nTipo==1
			if  nRadio==1
			   //	MsAguarde({||u_barra(),U_ProcGl()},"Aguarde...","Processando GL...",.F.)
                u_barra('U_ProcGl(oMeter)','RapidGl')
			elseif  nRadio == 2
			   //	MsAguarde({|| U_ProcAr()},"Aguarde...","Processando AR...",.F.)
                u_barra('U_ProcAr(oMeter)','RapidAr')
			elseif  nRadio == 3
				//MsAguarde({|| U_ProcR2()},"Aguarde...","Processando R2...",.F.)
	            u_barra('U_ProcR2(oMeter)','R2 Tech') 
	       	elseif  nRadio == 4
				//MsAguarde({|| U_ProcR2()},"Aguarde...","Processando R2...",.F.)
	            u_LerDu()   
	       	elseif	nRadio ==5
    		     u_barra('U_ProcGl(oMeter)','RapidGl')
    			 u_barra('U_ProcAr(oMeter)','RapidAr')
    			 u_barra('U_ProcR2(oMeter)','R2 Tech')	
    		endif
		      	if nRadio<>4
		      	MsAguarde({||DBTreelog()},"Aguarde...","Atualizando log...",.F.)
			    endif
		CASE nTipo==2
			if  nRadio==1
				U_RapidR01()
			elseif  nRadio == 2
				U_RapidR02()
		    elseif nRadio == 3
		    U_RapidR03()
		    elseif nRadio == 4
		    	u_RelR2()  		    
		    else

		    	u_Rapido4()
			endif
			
		CASE nTipo==3
			if  nRadio==1
				MATA030()    //CLIENTE
			elseif  nRadio == 2
				MATA020()    //FORNECEDOR
			elseif  nRadio == 3
				FINA010()    //NATUREZA
			elseif  nRadio == 4
				CTBA020()   //PLANO DE CONTAS
			elseif  nRadio == 5
			    u_za5070()   //contas x acao
			elseif  nRadio == 6				
				u_Ciata()    // calendario Iata
			elseif  nRadio == 7
			    u_ZAA070()				
		
			ENDIF
			
			
				CASE nTipo==4
			if  nRadio==1
			   //	MsAguarde({||u_barra(),U_ProcGl()},"Aguarde...","Processando GL...",.F.)
                u_barra('U_LERGL(oMeter)','Arq RapidGl')
			elseif  nRadio == 2
			   //	MsAguarde({|| U_ProcAr()},"Aguarde...","Processando AR...",.F.)
                u_barra('U_LERAR(oMeter)','Arq RapidAr')
			elseif  nRadio == 3
				//MsAguarde({|| U_ProcR2()},"Aguarde...","Processando R2...",.F.)
	            u_barra('U_LERR2(oMeter)','Arq R2')
			ENDIF
			
			
		END CASE
		
		ENDIF
		Return()
		

                 
STATIC  Function Ajust3SX6()



Local aArea    := GetArea()
Local aAreaSX6 := SX6->(GetArea())


SX6->(dbSetOrder(1))
If !SX6->(MsSeek(xFilial("SX6")+"MV_ORIGAR"))
	RecLock("SX6",.T.)
	SX6->X6_FIL		 	:= xFilial("SX6")
	SX6->X6_VAR		 	:= "MV_ORIGAR"
	SX6->X6_TIPO	 	:= "C"
	SX6->X6_DESCRIC 	:= "Endereco origem "
	SX6->X6_DESC1 	 	:= "do arquivo RapidAR"
	SX6->X6_DESC2 	 	:= ""
	SX6->X6_DSCSPA  	:= ""
	SX6->X6_DSCSPA1		:= ""
	SX6->X6_DSCSPA2		:= ""
	SX6->X6_DSCENG 		:=""
	SX6->X6_DSCENG1		:= ""
	SX6->X6_DSCENG2		:= ""
	SX6->X6_CONTEUD 	:= " "
	SX6->X6_CONTSPA 	:= "' '"
	SX6->X6_CONTENG 	:= "' '"
	SX6->X6_PROPRI	 	:= "S"
	SX6->X6_PYME	 	:= "N"
	MsUnlock()
Endif

If !SX6->(MsSeek(xFilial("SX6")+"MV_DESTAR"))
	RecLock("SX6",.T.)
	SX6->X6_FIL		 	:= xFilial("SX6")
	SX6->X6_VAR		 	:= "MV_DESTAR"
	SX6->X6_TIPO	 	:= "C"
	SX6->X6_DESCRIC 	:= "Endereco Destino"
	SX6->X6_DESC1 	 	:= "do arquivo RapidAR"
	SX6->X6_DESC2 	 	:= ""
	SX6->X6_DSCSPA  	:= ""
	SX6->X6_DSCSPA1		:= ""
	SX6->X6_DSCSPA2		:= ""
	SX6->X6_DSCENG 		:=""
	SX6->X6_DSCENG1		:= ""
	SX6->X6_DSCENG2		:= ""
	SX6->X6_CONTEUD 	:= " "
	SX6->X6_CONTSPA 	:= "' '"
	SX6->X6_CONTENG 	:= "' '"
	SX6->X6_PROPRI	 	:= "S"
	SX6->X6_PYME	 	:= "N"
	MsUnlock()
Endif

If !SX6->(MsSeek(xFilial("SX6")+"MV_ORIGGL"))
	RecLock("SX6",.T.)
	SX6->X6_FIL		 	:= xFilial("SX6")
	SX6->X6_VAR		 	:= "MV_ORIGGL"
	SX6->X6_TIPO	 	:= "C"
	SX6->X6_DESCRIC 	:= "Endereco origem "
	SX6->X6_DESC1 	 	:= "do arquivo RapidGL"
	SX6->X6_DESC2 	 	:= ""
	SX6->X6_DSCSPA  	:= ""
	SX6->X6_DSCSPA1		:= ""
	SX6->X6_DSCSPA2		:= ""
	SX6->X6_DSCENG 		:=""
	SX6->X6_DSCENG1		:= ""
	SX6->X6_DSCENG2		:= ""
	SX6->X6_CONTEUD 	:= " "
	SX6->X6_CONTSPA 	:= "' '"
	SX6->X6_CONTENG 	:= "' '"
	SX6->X6_PROPRI	 	:= "S"
	SX6->X6_PYME	 	:= "N"
	MsUnlock()
Endif

If !SX6->(MsSeek(xFilial("SX6")+"MV_DESTGL"))
	RecLock("SX6",.T.)
	SX6->X6_FIL		 	:= xFilial("SX6")
	SX6->X6_VAR		 	:= "MV_DESTGL"
	SX6->X6_TIPO	 	:= "C"
	SX6->X6_DESCRIC 	:= "Endereco Destino"
	SX6->X6_DESC1 	 	:= "do arquivo RapidGl"
	SX6->X6_DESC2 	 	:= ""
	SX6->X6_DSCSPA  	:= ""
	SX6->X6_DSCSPA1		:= ""
	SX6->X6_DSCSPA2		:= ""
	SX6->X6_DSCENG 		:=""
	SX6->X6_DSCENG1		:= ""
	SX6->X6_DSCENG2		:= ""
	SX6->X6_CONTEUD 	:= " "
	SX6->X6_CONTSPA 	:= "' '"
	SX6->X6_CONTENG 	:= "' '"
	SX6->X6_PROPRI	 	:= "S"
	SX6->X6_PYME	 	:= "N"
	MsUnlock()
Endif

                                           

If !SX6->(MsSeek(xFilial("SX6")+"MV_ORIGR2"))
	RecLock("SX6",.T.)
	SX6->X6_FIL		 	:= xFilial("SX6")
	SX6->X6_VAR		 	:= "MV_ORIGR2"
	SX6->X6_TIPO	 	:= "C"
	SX6->X6_DESCRIC 	:= "Endereco origem "
	SX6->X6_DESC1 	 	:= "do arquivo RapidrE"
	SX6->X6_DESC2 	 	:= ""
	SX6->X6_DSCSPA  	:= ""
	SX6->X6_DSCSPA1		:= ""
	SX6->X6_DSCSPA2		:= ""
	SX6->X6_DSCENG 		:=""
	SX6->X6_DSCENG1		:= ""
	SX6->X6_DSCENG2		:= ""
	SX6->X6_CONTEUD 	:= " "
	SX6->X6_CONTSPA 	:= "' '"
	SX6->X6_CONTENG 	:= "' '"
	SX6->X6_PROPRI	 	:= "S"
	SX6->X6_PYME	 	:= "N"
	MsUnlock()
Endif

If !SX6->(MsSeek(xFilial("SX6")+"MV_DESTR2"))
	RecLock("SX6",.T.)
	SX6->X6_FIL		 	:= xFilial("SX6")
	SX6->X6_VAR		 	:= "MV_DESTR2"
	SX6->X6_TIPO	 	:= "C"
	SX6->X6_DESCRIC 	:= "Endereco Destino"
	SX6->X6_DESC1 	 	:= "do arquivo RapidR2"
	SX6->X6_DESC2 	 	:= ""
	SX6->X6_DSCSPA  	:= ""
	SX6->X6_DSCSPA1		:= ""
	SX6->X6_DSCSPA2		:= ""
	SX6->X6_DSCENG 		:=""
	SX6->X6_DSCENG1		:= ""
	SX6->X6_DSCENG2		:= ""
	SX6->X6_CONTEUD 	:= " "
	SX6->X6_CONTSPA 	:= "' '"
	SX6->X6_CONTENG 	:= "' '"
	SX6->X6_PROPRI	 	:= "S"
	SX6->X6_PYME	 	:= "N"
	MsUnlock()
Endif


If !SX6->(MsSeek(xFilial("SX6")+"MV_CCARTAO"))
	RecLock("SX6",.T.)
	SX6->X6_FIL		 	:= xFilial("SX6")
	SX6->X6_VAR		 	:= "MV_CCARTAO"
	SX6->X6_TIPO	 	:= "C"
	SX6->X6_DESCRIC 	:= "Informar conta contabil de carta"
	SX6->X6_DESC1 	 	:= "Utilizado na importacao R2"
	SX6->X6_DESC2 	 	:= ""
	SX6->X6_DSCSPA  	:= ""
	SX6->X6_DSCSPA1		:= ""
	SX6->X6_DSCSPA2		:= ""
	SX6->X6_DSCENG 		:=""
	SX6->X6_DSCENG1		:= ""
	SX6->X6_DSCENG2		:= ""
	SX6->X6_CONTEUD 	:= " "
	SX6->X6_CONTSPA 	:= "' '"
	SX6->X6_CONTENG 	:= "' '"
	SX6->X6_PROPRI	 	:= "S"
	SX6->X6_PYME	 	:= "N"
	MsUnlock()
Endif
  






/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  		     บAutor  Rubens Simi            บ Data ณ  16/05/13 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿l฿฿฿
*/

user Function altCcusto()


Local cCadastro := "inclusao de movimento"  
local nOpc:=4  
local cNumpv  :=ZA3->ZA3_IATA 
local cData  :=DTOCY(ZA3->ZA3_DATA )
Local nOpcA:=0   
Private oFont:= TFont():New('Courier New',,-11,.T.)
private oGetszm,oDlCust,onumpv
Private aRotina := {}   
PRIVATE aHeader:={}
PRIVATE aCOLS:={}
    


AADD( aRotina, {"Pesquisar" ,"AxPesqui" ,0,1})
AADD( aRotina, {"Visualizar" ,'U_Mod3Mnt',0,2})
AADD( aRotina, {"Incluir" ,'U_Mod3Inc',0,3})
AADD( aRotina, {"Alterar" ,'U_Mod3Mnt',0,4})
AADD( aRotina, {"Excluir" ,'U_Mod3Mnt',0,5})

MontAhdSz3()
MontAcols()

 cEval:="nOpcA:=1,oDlg:end()"
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณSalva o aCols   de Entrada e Desabilita o Paint da Primeira GetDados    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//	oGetD:oBrowse:lDisablePaint := .T.

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณMonta a GetDados                                                        ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DEFINE MSDIALOG oDlCust TITLE cCadastro From 10,0 to 300,1000 PIXEL
 	@ 10,05 	SAY "Movimento  do dia :"+cData PIXEL Font oFont OF oDlCust
 	@ 10,150 	SAY "Iata:" PIXEL Font oFont OF oDlCust
	@ 10,200 	MSGET onumpv  VAR cNumpv SIZE 061, 010 OF oDlCust  PIXEL
    oGetszm := MSGetDados():New(035,001,125,500,4,," "," ",.f.,,,,len(acols))
 
	
	TButton():New( 130, 05, "Gravar Atera็๕es", oDlCust,{||nOpcA:=1,oDlCust:end()};
	,60,010,,,.F.,.T.,.F.,,.F.,,,.F. ) 
                 
	
	TButton():New( 130, 205, "Sair", oDlCust,{||oDlCust:end() };
	,60,010,,,.F.,.T.,.F.,,.F.,,,.F. )
	
 	ACTIVATE MSDIALOG oDlCust CENTERED  
 	
 	if nOpcA=1 
 	      U_gravaZA3() 
 	      cargalog('ZA3',oTreeGL:getcargo())
 	      
 	endif 

Return ()

                                                                                                  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  		     บAutor  Rubens Simi            บ Data ณ  16/05/13 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿l฿฿฿
*/


Static Function MontAhdSZ3()

Local aArea := GetArea() 


dbSelectArea("SX3")
dbSetOrder(1)
dbSeek("ZA3")                                                                          //ZA3_FILIAL+ZA3_ARQUIV+ZA3_IATA+ZA3_DATA+ZA3_LINHA                                                                                                               
While !EOF() .And. X3_ARQUIVO == "ZA3"
	If X3Uso(X3_USADO) .And. cNivel >= X3_NIVEL .and. alltrim(X3_CAMPO)$'ZA3_CONTA/ZA3_CCUSTO/ZA3_VALOR/ZA3_ARQUIV/ZA3_IATA/ZA3_DATA/ZA3_LINHA'
		AADD( aHeader, { Trim( X3Titulo() ),;
		X3_CAMPO,;
		X3_PICTURE,;
		X3_TAMANHO,;
		X3_DECIMAL,;
		X3_VALID,;
		X3_USADO,;
		X3_TIPO,;
		X3_ARQUIVO,;
		X3_CONTEXT})
	Endif
	dbSkip()
End
RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  		     บAutor  Rubens Simi            บ Data ณ  16/05/13 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿l฿฿฿
*/


Static Function MontAcols( )
Local aArea := GetArea()
Local cChave := ""
Local cAlias := "ZA3"
Local nI := 0
Local nOpc := 4
Local aStru     	:= ZA3->(DbStruct())  

					
		DBSELECTAREA('ZA3')
		ZA3->(DBGOTO(val(oTreeGL:getcargo())))
	
	
	cChave := ZA3->(ZA3_ARQUIV+ZA3_IATA+DTOS(ZA3_DATA))
	
	
		cQuery := " SELECT * FROM " + RetSqlName("ZA3")
		cQuery += " WHERE ZA3_ARQUIV='"+ZA3->ZA3_ARQUIV+"' AND ZA3_IATA='"+ZA3_IATA+"'
		cQuery += " AND ZA3_DATA='"+DTOS(ZA3->ZA3_DATA) +"'  AND D_E_L_E_T_ = ' ' "
		cQuery += " ORDER BY ZA3_LINHA "
		
		
		cQuery := ChangeQuery( cQuery )
		dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA3C", .F., .T. )
		aIatadt:={}
		 

For ni := 1 to Len(aStru)
	If aStru[ni,2] != 'C'
		TCSetField("ZA3C", aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
	EndIf
Next

		
		
		
		dbSelectArea("ZA3C")
		dbgotop()
		
	while ZA3C->(!eof() )
		
		
		AADD( aCOLS, Array( Len( aHeader ) + 1 ) )
		For nI := 1 To Len( aHeader )
			If aHeader[nI,10] == "V"
				aCOLS[Len(aCOLS),nI] := CriaVar(aHeader[nI,2],.T.)
			Else
				aCOLS[Len(aCOLS),nI] :=	FieldGet(FieldPos(aHeader[nI,2]))
			Endif
		Next nI                        
		aCOLS[Len(aCOLS),Len(aHeader)+1] := .F.
		 ZA3C->( DbSkip() )
		Enddo
		ZA3C->(DbCloseArea())
		
	
Restarea( aArea )
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  		     บAutor  Rubens Simi            บ Data ณ  16/05/13 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿l฿฿฿
*/


USER function gravaZA3()

	// Grava os itens
	For nX := 1 To Len( aCOLS ) //'ZA3_CONTA,ZA3_CCUSTO,ZA3_VALOR,ZA3_ARQUIV,ZA3_IATA,ZA3_DATA,ZA3_LINHA'

            cquery :="  update "+RetSqlName("ZA3")+" SET  ZA3_CCUSTO='"+aCOLS[NX][7]+"' "
			cquery += "  WHERE ZA3_ARQUIV='"+aCOLS[NX][5]+"' AND ZA3_LINHA='"+STR(aCOLS[NX][4])+"'
			TCSQLEXEC(cQuery)
	    


	Next nX  
