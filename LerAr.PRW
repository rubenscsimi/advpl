#Include 'Protheus.ch'
#INCLUDE "TBICONN.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LerAr()   ºAutor  ³Microsiga           º Data ³  12/17/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ rotina para leitura e gravacao do arquivo RapidAr          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LerAr(oMeter)

Local aArquivo  :={}
Local cOrig		:=getmv("MV_ORIGAR")
Local cDest		:=getmv("MV_DESTAR")
Local nLinha    :=0
Local cItem     :="001"
Local Lbarra    :=.f.


if valtype(oMeter)=='O'
cTpArq		:= "Delimitado (*ARD.DAT)|*ARD.DAT|"
 
cOrig:=cGetFile(cTpArq, , 0, "SERVIDOR\", .T., GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE)
Lbarra:=.t.
endif

IF !EMPTY(cOrig)

aArquivo:=u_abreftp(cOrig,cDest,'AR','DAT',Lbarra)

If aArquivo[1][5]
	aCarga:=u_lerArq(cDest+'\'+aArquivo[1][1],',')
	
if len(aCarga)=0
u_ConsoleLog('Erro na Leitura do arquivo AR',{'Não foi possivel fazer a leitura do Arquivo '+cDest+'\'+aArquivo[1][1]})
endif
                   
   
   
if lBarra
nTotReg:=len(aCarga) 
oMeter:SetTotal(nTotReg)
endif

   

	for nx:=1 to len(aCarga)
	     
	

		
		If aCarga[nx][1]=="H"
			nLinha++
			
		cConta:=aCarga[nx][11]
		
		nCr:=At ( 'CR', cConta ) 
		
		if nCr>0     
		cConta:=SUBSTR(cConta,1,nCr-1)
		endif     
		      cData:=STOD(SUBSTR(aCarga[nx][7],7,4)+SUBSTR(aCarga[nx][7],1,2)+SUBSTR(aCarga[nx][7],4,2))        
		
			if lBarra 
nTotReg:=len(aCarga) 
oMeter:SetTotal(nTotReg)
   			  u_progresso(aCarga[nx][5],DTOCY(cData),nx,nTotReg)
			ENDIF    
			
			RECLOCK("ZA2",.T.)
			ZA2_LOTE  	:=aCarga[nx][3]
			ZA2_IATA    :=aCarga[nx][5]
			ZA2_DATA  	:=cData
			ZA2_DTPROC  :=ddatabase
			ZA2_VALOR 	:=VAL(aCarga[nx][10])
			ZA2_STATUS	:="N"
			ZA2_ARQUIV	:=aArquivo[1][1]
			ZA2_LINHA 	:=nLinha
			ZA2_CONTA 	:=cConta
			ZA2_TPLAN 	:=If (VAL(aCarga[nx][10])>0,'1','2')  
			ZA2_HIST    :=aCarga[nx][27]
			MSUNLOCK()
		Else
	
	
		cConta:=SUBSTR(aCarga[nx][9],11,LEN(aCarga[nx][9]))
		
		nCr:=At ( 'CR', cConta ) 
		
		if nCr>0     
		cConta:=SUBSTR(cConta,1,nCr-1)
		endif                     
		
	
			nLinha++
			RECLOCK("ZA4",.T.)
			ZA4_ITEM	:=cItem
			ZA4_LOTE    :=aCarga[nx][3]
			ZA4_IATA    :=aCarga[nx][5]
			ZA4_NATURE	:=SUBSTR(aCarga[nx][9],11,LEN(aCarga[nx][9]))
			ZA4_VALOR 	:=val(aCarga[nx][7])
			ZA4_LINHA 	:=nLinha
			ZA4_CONTA   := cConta
			ZA4_TPLAN   :=If (VAL(aCarga[nx][7])>0,'2','1')
			MSUNLOCK()
			
			If NX+1<=LEN(aCarga)
				If	aCarga[nx][3]==aCarga[nx+1][3]
					cItem:= strzero((val(cItem)+1),3)
				Else
					cItem     :="001"
				EndIf
			EndIf
			
		EndIf
		
		
	NEXT NX
EndIf
ENDIF
//U_PROCAR()
  
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LerAr()   ºAutor  ³Microsiga           º Data ³  12/17/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ rotina para leitura e gravacao do arquivo RapidAr          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ProcAr(oMeter)

Local aCarga    	:={}
Local aAreaZA2T 	:={}
Local aStru     	:= ZA2->(DbStruct())  
Local cIata   		:=''  
Local nl     		:=1
Local aParamAuto 	:= {} 
Local aItens		:={} 
Local lBarra        :=.f.
Private lMsErroAuto := .F.
Private aLogOk    	:={} 
Private dDatadoc  	:=STOD('20010101')  
Private dOldDdatabase  	:=dDatabase
Private nRecnoOld  	:=0
Private aMsg        :={}
Private dDatavencCli	:= stod("  /  /    ")
Private dDatavencGov	:= stod("  /  /    ")



If ( !AMIIn(34) )		// Acesso somente com licensas full para evitar erro na integracao com CTB
  AVISO('ATENÇÃO','Esta Rotina nao pode ser utilizada com licensas light' , {'Cancelar'}, 1)
	Return
EndIf    

aAdd( aParamAuto, {"MV_PAR01", 2} ) //Pergunta 01 - Mostra Lanc.Contab ? 1 = Sim   ; 2 = Não
aAdd( aParamAuto, {"MV_PAR03", 2} ) //Pergunta 02 - Contabiliza on line ? 1 = Sim   ; 2 = Não


cQuery := " SELECT * FROM " + RetSqlName("ZA2")
cQuery += " WHERE ZA2_STATUS<>'I'
cQuery += " AND D_E_L_E_T_ = ' ' "
cQuery += " ORDER BY ZA2_DATA,ZA2_LINHA"


cQuery := ChangeQuery( cQuery )
dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA2T", .F., .T. )


For ni := 1 to Len(aStru)
	If aStru[ni,2] != 'C'
		TCSetField("ZA2T", aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
	EndIf
Next

dbSelectArea('SA2')
DBSETORDER(9)

dbSelectArea('SA1')
DBSETORDER(9)

dbSelectArea('SED')
DBSETORDER(4) 

if valtype(oMeter)=='O' 
lBarra:=.t. 
nTotReg := Contar("ZA2T","!Eof()")
oMeter:SetTotal(nTotReg)
endif

dbSelectArea("ZA2T")
dbgotop()            
	 cLoteza2:=ZA2T->ZA2_LOTE 
np:=0
while ZA2T->(!eof() )
if lBarra 
np++
u_progresso(ZA2T->ZA2_IATA,DTOCY(ZA2T->ZA2_DATA),np,nTotReg)
ENDIF                       
 

	    If NL=1
	    dDatadoc:=ZA2T->ZA2_DATA
	    EndIf      


If SUBSTR(ZA2T->ZA2_CONTA,1,1)=='3'
	If   CT1->(DBSEEK(XFILIAL('CT1')+ZA2T->ZA2_CONTA)) .and. !empty(CT1->CT1_CCRAP) 
		cCusto:= CT1->CT1_CCRAP
	Else
		cCusto:='Centro de custo nao cadastrado para conta:'+alltrim(ZA2T->ZA2_CONTA)
	EndIf
EndIf 
         SED->(DBSETORDER(5))
      If SED->(DBSEEK(XFILIAL("SED") +ZA2T->ZA2_CONTA))
			cNaturH:= SED->ED_CODIGO
	  Else
			cNaturH:="CONTA "+ZA2T->ZA2_CONTA+" NAO VINCULADA AO CADASTRO DE NATUREZA "
	  EndIf
	    
   
    NL++
    		aAdd(aItens,{   {'CT2_FILIAL' ,xfilial("CT2")   						    	, NIL},;
						{'CT2_LINHA'  ,STRZERO(NL,3)   									, NIL},;
						{'CT2_MOEDLC' ,'01'   											, NIL},;
						{'CT2_DC'     ,ZA2T->ZA2_TPLAN                  		 		, NIL},;
						{'CT2_DEBITO' ,If(ZA2T->ZA2_TPLAN=='1',ZA2T->ZA2_CONTA,'') 		, NIL},;
						{'CT2_CREDIT' ,If(ZA2T->ZA2_TPLAN=='2',ZA2T->ZA2_CONTA,'') 	  	, NIL},;
						{'CT2_VALOR'  ,If (ZA2T->ZA2_VALOR>0,ZA2T->ZA2_VALOR,ZA2T->ZA2_VALOR*-1)  							  	, NIL},;
						{'CT2_ORIGEM' ,'ARH|'+ALLTRIM(ZA2T->ZA2_IATA)+'|'+ALLTRIM(DTOS(ZA2T->ZA2_DATA));
						              +'|'+ALLTRIM(STR(ZA2T->ZA2_LINHA))									  	, NIL},;
						{'CT2_HP'     ,''   											, NIL},;
				        {'CT2_CCD'    ,	If (SUBSTR(ZA2T->ZA2_CONTA,1,1)=='3';
				                      .AND. ZA2T->ZA2_TPLAN=='1',cCusto,'')	, NIL},;
						{'CT2_CCC'    ,	If (SUBSTR(ZA2T->ZA2_CONTA,1,1)=='3';
				                      .AND. ZA2T->ZA2_TPLAN=='2',cCusto,'')	, NIL},;
						{'CT2_HIST'   ,ALLTRIM(ZA2T->ZA2_HIST)							, NIL} } )
    
         nRecnoOld:= ZA2T->R_E_C_N_O_
		 aAreaZA2T     := GetArea('ZA2T') // protecao pra nao entrar em loop    
			
			
				   
				    
				cQuery := " SELECT * FROM " + RetSqlName("ZA4")
				cQuery += " WHERE ZA4_LOTE='"+ZA2T->ZA2_LOTE+"' AND ZA4_IATA='"+ ZA2T->ZA2_IATA+"'"
				cQuery += " AND   D_E_L_E_T_ = ' ' "
				cQuery += " ORDER BY ZA4_LINHA"
				
				
				cQuery := ChangeQuery( cQuery )
				dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA4T", .F., .T. )      "
			

				dbSelectArea("ZA4T")
					dbgotop()
						while ZA4T->(!eof() )
					   	nValor:=If (ZA4T->ZA4_VALOR>0, ZA4T->ZA4_VALOR ,ZA4T->ZA4_VALOR*-1)
					 	                                          
						nl++
							aAdd(aItens,{   {'CT2_FILIAL' ,xfilial("CT2")   						    	, NIL},;
						{'CT2_LINHA'  ,STRZERO(NL,3)   									, NIL},;
						{'CT2_MOEDLC' ,'01'   											, NIL},;
						{'CT2_DC'     ,ZA4T->ZA4_TPLAN                  		 		, NIL},;
						{'CT2_DEBITO' ,If(ZA4T->ZA4_TPLAN=='1',ZA4T->ZA4_CONTA,'') 		, NIL},;
						{'CT2_CREDIT' ,If(ZA4T->ZA4_TPLAN=='2',ZA4T->ZA4_CONTA,'') 	  	, NIL},;
						{'CT2_VALOR'  ,nValor           							  	, NIL},;
						{'CT2_ORIGEM' ,'ARD|'+ALLTRIM(ZA2T->ZA2_IATA)+'|'+ALLTRIM(DTOS(ZA2T->ZA2_DATA));
						              +'|'+ALLTRIM(STR(ZA2T->ZA2_LINHA)), NIL},;
						{'CT2_HP'     ,''   											, NIL},;
				        {'CT2_CCD'    ,	If (SUBSTR(ZA4T->ZA4_CONTA,1,1)=='3';
				                      .AND. ZA4T->ZA4_TPLAN=='1',ZA4T->ZA4_CCUSTO,'')	, NIL},;
						{'CT2_CCC'    ,	If (SUBSTR(ZA4T->ZA4_CONTA,1,1)=='3';
				                      .AND. ZA4T->ZA4_TPLAN=='2',ZA4T->ZA4_CCUSTO,'')	, NIL},;
						{'CT2_HIST'   ,ALLTRIM(ZA2T->ZA2_HIST)							, NIL} } )
					
						ZA4T->( DbSkip() )   
					Enddo
				ZA4T->(DbCloseArea())
					
		
	
			RestArea(aAreaZA2T)
	                    nValor:=ZA2T->ZA2_VALOR 
	                    cIata:=ZA2T->ZA2_iATA       
		 

						ZA2T->( DbSkip() )   

 
If  ZA2T->ZA2_LOTE <> cLoteza2 
			 Ddatabase:=dDatadoc  
           


  procvenc(dDatadoc)

             BeginTran()
		

			If nValor<0     
			
			
				U_MYFINA050('AR','CON',cNaturH,cIata,dDatadoc,dDatavencCli,(nValor*-1),cLoteza2,alltrim(cIata)+alltrim(dtos(dDatadoc)),'')
				
	             Else			
	
				U_MYFINA040('AR','CON',cNaturH,cIata,dDatadoc,dDatavencCli,nValor,cLoteza2,alltrim(cIata)+alltrim(dtos(dDatadoc)),'','')

			
			EndIf
				

  
  			U_MYCTBA102(aItens,NL,'AR',cIata,'RAPIDA',,cLoteza2)


    If aScan(aLogOk,{|x| AllTrim(x[3])=="E"})>0


			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³desfaz toda a integracao do lote em caso de erro em alguma parte
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/

              DisarmTransaction()   
                                  
           
   

	

            /*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³Limpa inconsistencias antes de gravar as novas
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/

           
            FOR NX:=1 TO LEN(aLogOk)

	       
		    cquery :="  update "+RetSqlName("ZA2")+" SET  ZA2_LOGFIN='',ZA2_LOGCTB='' "
			cquery += "  WHERE D_E_L_E_T_ = ' ' AND R_E_C_N_O_="+alltrim(aLogOk[NX][5])
			TCSQLEXEC(cQuery)
	    
	        NEXT NX

   

	

            /*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³grava inconsistencias 
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/


            FOR NX:=1 TO LEN(aLogOk)
            
           
		If  aLogOk[NX][1]='FIN'
		   
		    cquery :="  update "+RetSqlName("ZA2")+" SET  ZA2_ACFIN='"+alltrim(aLogOk[NX][2])+"'," 
			cquery += "  ZA2_STAFIN='E', ZA2_STATUS='E', ZA2_LOGFIN='"+alltrim(aLogOk[NX][4])+"'"
			cquery += "  WHERE D_E_L_E_T_ = ' ' AND R_E_C_N_O_="+alltrim(aLogOk[NX][5])
			TCSQLEXEC(cQuery)
		Else
            cquery := " update "+RetSqlName("ZA2")+" SET ZA2_STATUS='E',  ZA2_STACTB='E', ZA2_LOGCTB='"+alltrim(aLogOk[NX][4])+" ' "
			cquery += " WHERE D_E_L_E_T_ = ' ' AND R_E_C_N_O_="+alltrim(aLogOk[NX][5]) 
			TCSQLEXEC(cQuery)
            
        EndIf
            NEXT NX
         	
         
            
   Else
              
            /*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³flaga registros sem inconsistencias
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/
            
            cquery := " update "+RetSqlName("ZA2")+" SET  ZA2_STATUS='I',ZA2_STACTB='I',ZA2_STAFIN='I',ZA2_LOGCTB='',ZA2_LOGFIN=''
			cquery += " WHERE D_E_L_E_T_ = ' '  AND ZA2_LOTE='"+cLoteza2+"' AND ZA2_DATA='"+DTOS(dDatadoc)+"'
			TCSQLEXEC(cQuery)
   EndIf
               
             
             
             /*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³termina controle de trancaçoes libera todos 
			// libera todos os registros e inicia o proximo controle de transacao
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/
              
              EndTran() 
		      MsUnLockAll() 
		      


     dDatadoc:=ZA2T->ZA2_DATA 
	 cIata :=ZA2T->ZA2_IATA 
	 cLoteza2:=ZA2T->ZA2_LOTE 
	 
	 
    nValor		:=0
	aLogOk		:={}
	aItens		:={}
	lMsErroAuto :=.F.
    NL          :=1

EndIf  
 


					Enddo
ZA2T->(DbCloseArea())
EndTran() 
MsUnLockAll()  

  Ddatabase:=dOldDdatabase
    
IF len(aMsg)>0
u_ConsoleLog("LOG DE INCONSISTENCIA DO RAPIDAR",aMsg)
aMsg:={}
ENDIF


Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LerGl()   ºAutor  ³Rubens Simi           º Data ³  07/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ rotina para leitura e gravacao do arquivo RapidgL          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LerGl(oMeter)


Local aCargagL  :={}
Local cOrig     :=getmv("MV_ORIGGL")
Local cDest     :=getmv("MV_DESTGL")
Local aAreaZA3T :={}
local lBarra    :=.f.




if valtype(oMeter)=='O' 
lBarra:=.t.
cTpArq		:= "Delimitado (*GLD.DAT)|*GLD.DAT|"
cOrig:=cGetFile(cTpArq, , 0, "SERVIDOR\", .T., GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE)
endif

IF !EMPTY(cOrig)

aArquivo:=u_abreftp(cOrig,cDest,'GL','DAT',lBarra)


If aArquivo[1][5] 
     cArquiv:=aArquivo[1][1]
	aCargaGl:=u_lerArq(cDest+'\'+cArquiv,',')
	               
	if len(aCargaGl)=0
       u_ConsoleLog('Erro na Leitura do arquivo GL',{'Não foi possivel fazer a leitura do Arquivo '+cDest+'\'+aArquivo[1][1]})
    endif
       
if lBarra
nTotReg:=len(aCargaGl) 
oMeter:SetTotal(nTotReg)
endif



	
	
	for nx:=1 to len(aCargaGl)
	
	if lBarra 
	u_progresso(aCargaGl[nx][26],aCargaGl[nx][4],nx,nTotReg)
	ENDIF  
	
	
		//CONVERCAO DA DATA DD-MM-AAAA PARA AAAAMMDD
		_DDATA:=STRTRAN(aCargaGl[nx][4],'-')
		_DDATA:=STOD(SUBSTR(_DDATA,5,8)+SUBSTR(_DDATA,1,2)+SUBSTR(_DDATA,3,2))
		
		cConta:=SUBSTR(aCargaGl[nx][11],11,LEN(aCargaGl[nx][11]))
	    
		nCr:=At ( 'CR', cConta ) 
		
		if nCr>0     
		cConta:=SUBSTR(cConta,1,nCr-1)
		endif                                       	
		
		RECLOCK("ZA3",.T.)
		ZA3_FILIAL    :=XFILIAL("ZA3")
		ZA3_LOTE      :=aCargaGl[nx][22]
		ZA3_VALOR     :=If(!empty(aCargaGl[nx][10]),VAL(aCargaGl[nx][10]),VAL(aCargaGl[nx][9]))
		ZA3_TPLAN     :=If(!empty(aCargaGl[nx][10]),'2','1')
		ZA3_LINHA     :=NX
		ZA3_HIST      :=aCargaGl[nx][5]
		ZA3_CONTA     :=cConta
		ZA3_CCUSTO    :=SUBSTR(aCargaGl[nx][11],3,8)
		ZA3_STATUS    :="N"
		ZA3_STACTB    :="N"
		ZA3_STAFIN    :="N"
		ZA3_DATA      :=_DDATA
		ZA3_IATA      :=aCargaGl[nx][26]
		ZA3_DTPROC    :=ddatabase
		ZA3_VOADO     :=aCargaGl[nx][21]   
		ZA3_ARQUIV    :=cArquiv
		MSUNLOCK()
		
		
		
		
		
	NEXT NX
EndIf
                
ENDIF

//U_ProcGl()

 Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ProcGl()   ºAutor  ³Rubens Simi        º Data ³  07/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Processamento dos registros da tabela za3 e integracao     º±±
±±º          ³ com o protheus                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ProcGl(oMeter)

Local aItens 	 		:= {}
Local NL         		:= 0
Local aCab      		:={}
Local aStru     		:= ZA3->(DbStruct())
Local cOpc      		:=''
Local aAreaZA3T 		:={} 
local aGeraFin          :={}
local lBarra			:=.f.
Private lMsErroAuto 	:= .F.
Private aLogOk      	:={} 
Private nRecnoOld   	:=0
Private dOldDdatabase  	:=dDatabase
Private dDatavencCli	:= stod("  /  /    ")
Private dDatavencGov	:= stod("  /  /    ")
Private aMsg        :={}


If ( !AMIIn(34) )		// Acesso somente com licensas full para evitar erro na integracao com CTB
  AVISO('ATENÇÃO','Esta Rotina nao pode ser utilizada com licensas light' , {'Cancelar'}, 1)
	Return
EndIf    



cQuery := " SELECT * FROM " + RetSqlName("ZA3")
cQuery += " WHERE ZA3_STATUS<>'I'
cQuery += " AND D_E_L_E_T_ = ' ' "
cQuery += " ORDER BY ZA3_IATA,ZA3_DATA"


cQuery := ChangeQuery( cQuery )
dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA3T", .F., .T. )


For ni := 1 to Len(aStru)
	If aStru[ni,2] != 'C'
		TCSetField("ZA3T", aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
	EndIf
Next


dbSelectArea("ZA5")
dbsetorder(1)       


DbSelectArea("ZA3")

dbSelectArea("CT1")
dbsetorder(1)

if valtype(oMeter)=='O' 
lBarra:=.t. 
nTotReg := Contar("ZA3T","!Eof()")
oMeter:SetTotal(nTotReg)
endif
dbSelectArea("ZA3T")
dbgotop()          


np:=0
cIata:=ZA3T->ZA3_IATA
dDatadoc:=ZA3T->ZA3_DATA
			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³BeginTran() controle de transacao para garantir integridade do banco
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/

BeginTran()
while ZA3T->(!eof() ) 
if lBarra 
np++
u_progresso(cIata,DTOCY(dDatadoc),np,nTotReg)
ENDIF                       
 
    NL++
	cOpc:=''
	cChave:=ZA3T->ZA3_CONTA+ZA3T->ZA3_TPLAN+ZA3T->ZA3_VOADO
      
 
  
/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³devinicao da açao a ser realizada definida na za5
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
*/
	   ZA5->(dbsetorder(1) )
	If ZA5->(DBSEEK(XFILIAL('ZA5')+cChave))
		cOpc:=ZA5->ZA5_TPREG
       
       IF  ZA5->ZA5_CALISS='1'
       
       	aAreaZA3T := GetArea("ZA3T")    

        nValiss:= U_CalcIss(ZA3T->ZA3_IATA,ZA3T->ZA3_VALOR)
       
        ZA3->(Dbgoto(ZA3T->R_E_C_N_O_))
       
        RECLOCK("ZA3",.F.)
		ZA3_VLISS     :=nValiss
		MSUNLOCK()                                                                                                   
	   
	   RestArea(aAreaZA3T)	
	   
	   ENDIF  
			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³Soma valores  a Receber 1 = cliente 2 = governo ou subtrai se contas a pagar
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/	 
		nPos:=aScan(aGeraFin,{|x|x[1]==ZA5->ZA5_TPCLI+ZA5->ZA5_CONTA})	
     IF  nPos>0
		 
			   aGeraFin[npos][2]:= if (cOpc=='1',aGeraFin[npos][2]-ZA3T->ZA3_VALOR,aGeraFin[npos][2]+ZA3T->ZA3_VALOR)
			nPos:=0
	  else
	       
	  aadd( aGeraFin,{ZA5->ZA5_TPCLI+ZA5->ZA5_CONTA,if (cOpc=='1',ZA3T->ZA3_VALOR*-1,ZA3T->ZA3_VALOR),ZA5->ZA5_TPCLI,ZA5->ZA5_CONTA,ZA3T->ZA3_VLISS})
	  
	  endif		
			
	EndIf	

	    If NL=1
	    dDatadoc:=ZA3T->ZA3_DATA
	    EndIf                       
	    
	    /*
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		// item do lancamento contabil
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		*/ 
If SUBSTR(ZA3T->ZA3_CONTA,1,1)=='3' 
    Do Case

    Case ALLTRIM(ZA3T->ZA3_CCUSTO)<>'RE000001' .AND. !EMPTY(ZA3T->ZA3_CCUSTO)
	    cCusto:=ZA3T->ZA3_CCUSTO
	Case   CT1->(DBSEEK(XFILIAL('CT1')+ZA3T->ZA3_CONTA)) .and. !empty(CT1->CT1_CCRAP )
		cCusto:= CT1->CT1_CCRAP
	Otherwise
		cCusto:='Centro de custo nao cadastrado para conta:'+alltrim(ZA3T->ZA3_CONTA)
	EndCase
EndIf 

                      
		aAdd(aItens,{   {'CT2_FILIAL' ,xfilial("CT2")   						    	, NIL},;
						{'CT2_LINHA'  ,STRZERO(NL,3)   									, NIL},;
						{'CT2_MOEDLC' ,'01'   											, NIL},;
						{'CT2_DC'     ,ZA3T->ZA3_TPLAN                  		 		, NIL},;
						{'CT2_DEBITO' ,If(ZA3T->ZA3_TPLAN=='1',ZA3T->ZA3_CONTA,'') 		, NIL},;
						{'CT2_CREDIT' ,If(ZA3T->ZA3_TPLAN=='2',ZA3T->ZA3_CONTA,'') 	  	, NIL},;
						{'CT2_VALOR'  ,ZA3T->ZA3_VALOR  							  	, NIL},;
						{'CT2_ORIGEM' ,'GL|'+ALLTRIM(ZA3T->ZA3_IATA)+'|'+ALLTRIM(DTOS(ZA3T->ZA3_DATA));
						              +'|'+ALLTRIM(STR(ZA3T->ZA3_LINHA)), NIL},;
						{'CT2_HP'     ,''   											, NIL},;
				        {'CT2_CCD'    ,	If (SUBSTR(ZA3T->ZA3_CONTA,1,1)=='3';
				                      .AND. ZA3T->ZA3_TPLAN=='1',cCusto,'')	, NIL},;
						{'CT2_CCC'    ,	If (SUBSTR(ZA3T->ZA3_CONTA,1,1)=='3';
				                      .AND. ZA3T->ZA3_TPLAN=='2',cCusto,'')	, NIL},;
						{'CT2_HIST'   ,ALLTRIM(ZA3T->ZA3_HIST)							, NIL} } )
						nRecnoOld:=ZA3T->R_E_C_N_O_
				   
   	ZA3T->( DbSkip() )
	
If cIata<>ZA3T->ZA3_IATA .or.  dDatadoc<>ZA3T->ZA3_DATA   
	    	aAreaZA3T := GetArea("ZA3T")    
		   /*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³altera a data base do sistema
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/	
         
	          Ddatabase:=dDatadoc  
	          
	          
	
		/*
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³integra contas a receber
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		*/
	          	   /*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³Localiza a data de Vencimento
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/	

		procvenc(dDatadoc)  

		nValorISS:=0

		nPos:=aScan(aGeraFin,{|x|x[5]>0})
		
		IF npos>0
		     nValorISS:=aGeraFin[nPos][5]
		endif	
		
		
	   ZA5->(dbsetorder(2))
for nx:=1 to len(aGeraFin)
    
	
			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			// Define qual data de vencimento utilizar
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/


if  aGeraFin[NX][2]>0   //cliente
	   cIdCnab:=''          
	
	
	if  ZA5->(DBSEEK(XFILIAL('ZA5')+aGeraFin[NX][4]+'2'))
		IF ZA5->ZA5_TPCLI='1'

			IF ZA5->ZA5_GERCNB='1'
			cIdCnab:=ALLTRIM(cIata)+ALLTRIM(DTOS(ddatabase))
            ENDIF

			ddataVenc:=if ( ZA5->ZA5_NDIAS>0,DaySum( ddatabase ,ZA5->ZA5_NDIAS ),dDatavencCli)
			
		else     
		
			IF ZA5->ZA5_GERCNB='1'
			cIdCnab:=ALLTRIM(cIata)+ALLTRIM(DTOS(ddatabase))+'G'
			ENDIF
		
			ddataVenc:=dDatavencGov
			
		Endif
		
		/*
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³integra contas a receber
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		*/
		
		IF ZA5->ZA5_OPEISS<>'3'
		   IF ZA5->ZA5_OPEISS='1'
		   aGeraFin[NX][2]:=aGeraFin[NX][2]+nValorISS
		   ELSE
		   aGeraFin[NX][2]:=aGeraFin[NX][2]-nValorISS
		   ENDIF
		   
	   ENDIF
		
		
		U_MYFINA040('GL', ZA5->ZA5_PREFIX, ZA5->ZA5_NATUR,cIata,ddatabase,ddataVenc,aGeraFin[NX][2],;
		'',ALLTRIM(cIata)+ALLTRIM(DTOS(ddatabase)),cIdCnab,ALLTRIM(aGeraFin[NX][4]))
	else
		
		FLAGTEMP('FIN','CR','GL','Situaçao nao configurada para a conta'+alltrim(aGeraFin[NX][4])+' para gerar contas a receber')
	endif
endif	
	
	
	if aGeraFin[NX][2]<0
		
		
		if   ZA5->(DBSEEK(XFILIAL('ZA5')+aGeraFin[NX][4]+'1'))
			
			IF ZA5->ZA5_TPCLI='1'
				ddataVenc:=if ( ZA5->ZA5_NDIAS>0,DaySum( ddatabase , ZA5->ZA5_NDIAS ),dDatavencCli)
				
			else
				
				ddataVenc:=dDatavencGov
				
			Endif
			
			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³integra contas a pagar
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/
			
			
			U_MYFINA050('GL',ZA5->ZA5_PREFIX, ZA5->ZA5_NATUR,cIata,ddatabase,ddataVenc,aGeraFin[NX][2]*-1,;
			'',ALLTRIM(cIata)+ALLTRIM(DTOS(ddatabase)),ALLTRIM(aGeraFin[NX][4]))
		else
			
			
			FLAGTEMP('FIN','CP','GL','Situaçao nao configurada para a conta'+alltrim(aGeraFin[NX][4])+' para gerar contas a Pagar')
		endif
endif	
next nx

    
   
      
			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³integra contabilidade ao mudar dar lote     
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/


			U_MYCTBA102(aItens,NL,'GL',cIata,'RAPIDG' )

        	  
   	If aScan(aLogOk,{|x| AllTrim(x[3])=="E"})>0


			/*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³desfaz toda a integracao do lote em caso de erro em alguma parte
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/

              DisarmTransaction()   

        
         /*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³Limpa Logs antes de grava inconsistencias novas
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/  
			
           
				cquery := " update "+RetSqlName("ZA3")+" 
				cquery += "	SET  ZA3_LOGFIN='', ZA3_LOGCTB=''
				cquery += " WHERE D_E_L_E_T_ = ' ' AND ZA3_IATA='"+cIata+"' AND ZA3_DATA='"+DTOS(dDatadoc)+"'
	            
	            TCSQLEXEC(cQuery)
	           
	           
	            /*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³grava inconsistencias  novas
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/  
			
	            
            FOR NX:=1 TO LEN(aLogOk)
            
        	cquery := " update "+RetSqlName("ZA3")+" 
	   		If  aLogOk[NX][1]='FIN'	
	   		cquery += "	SET  ZA3_STATUS='E', ZA3_STAFIN='E', ZA3_LOGFIN='"+alltrim(aLogOk[NX][4])+" ' "
        	Else                                   
        	cquery += "SET  ZA3_STATUS='E',ZA3_STACTB='E', ZA3_LOGCTB='"+alltrim(aLogOk[NX][4])+" '
	   		EndIf
			cquery += " WHERE D_E_L_E_T_ = ' ' AND ZA3_IATA='"+cIata+"' AND ZA3_DATA='"+DTOS(dDatadoc)+"'
	    	TCSQLEXEC(cQuery)
  
	     NEXT NX
                  
            


   Else
              
            /*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³flaga registros sem inconsistencias
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/
            
            cquery := " update "+RetSqlName("ZA3")+" SET  ZA3_STATUS='I',ZA3_STAFIN='I',ZA3_STACTB='I',ZA3_LOGFIN='',ZA3_LOGCTB=''
			cquery += " WHERE D_E_L_E_T_ = ' '  AND  ZA3_IATA='"+cIata+"' AND ZA3_DATA='"+DTOS(dDatadoc)+"'
			TCSQLEXEC(cQuery)
   EndIf 
   
			   /*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³Limpa Variaveis para proximo Ciclo
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/	
                RestArea(aAreaZA3T)		      

            	aLogOk		:=	{}		
       			NL			:=	1
				aItens		:=	{} 
				dDatadoc	:=ZA3T->ZA3_DATA 
			    cIata		:=ZA3T->ZA3_IATA
	            aGeraFin    :={}
		  
			   /*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³termina controle de trancaçoes libera todos 
			//³libera todos os registros e inicia o proximo
			//³controle de transacao
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/	
			  EndTran() 
		      MsUnLockAll() 
		      BeginTran()

EndIf               
Enddo
ZA3T->(DbCloseArea())

			   /*
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³Retorna a data base do sistema para data correta
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			*/	 
			
             Ddatabase:=dOldDdatabase
            
IF len(AMsg)>0
u_ConsoleLog("LOG DE INCONSISTENCIA DO RAPIDGL",aMsg)
aMsg:={}
ENDIF

  EndTran() 
MsUnLockAll() 

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MYCTBA102   ºAutor  ³Rubens Simi       º Data ³  09/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ rotina para inclusao de registros na contabilidade		  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MYCTBA102(aItens,NL,cArq,cIata,cLoteCtb,aRec,cLoteza2) 
           




Local cDocumento :=''
Local cRecno:=''
PRIVATE lMsErroAuto:=.F.


ProxDoc(dDatadoc,cLoteCtb,'001',@cDocumento,0)




aCab := {   {'DDATALANC'	,dDatadoc 	,NIL},;
			{'CLOTE' 		,cLoteCtb 	,NIL},;
			{'CSUBLOTE' 	,'001'		,NIL},;
			{'CDOC' 		,cDocumento ,NIL},;
			{'CPADRAO' 		,'' 		,NIL},;
			{'NTOTINF' 		,0 			,NIL},;
			{'NTOTINFLOT' 	,0 			,NIL} }
			


/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³Protecao para impedir erro "USEDCOD" na CTF
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
*/
Dbselectarea("CTF")
Dbsetorder(1)
If Dbseek(xfilial("CTF")+DTOS(dDatadoc)+cLoteCtb+'001'+cDocumento)
	If !CTF->(RLOCK())
		CTF->(MSUNLOCK())
	EndIf
EndIf
CTF->( Dbclosearea() )
Dbselectarea("CT2")
Dbsetorder(1)




MSExecAuto( {|X,Y,Z| CTBA102(X,Y,Z)} ,aCab ,aItens, 3)
                                                

DBCOMMITALL()
MsUnLockAll()




If 	!lMsErroAuto  
	
	/*
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³flega apenas o estatus dos registros da contabilidade
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ     
	*/
    
cRecno:='LT:'+cLoteCtb+"/SBL:001/DOC:"+cDocumento 

	


	
	Do Case
	Case cArq=='GL'
		cquery := " update "+RetSqlName("ZA3")+" SET  ZA3_STACTB='I',ZA3_CHCTB='"+cRecno+"',ZA3_LOGCTB='' "
		cquery += " WHERE D_E_L_E_T_ = ' ' AND ZA3_IATA='"+cIata+"' AND ZA3_DATA='"+DTOS(dDatadoc)+"'
		TCSQLEXEC(cQuery)
	                        
	
	Case cArq=='AR'
	
		cquery := " update "+RetSqlName("ZA2")+" SET  ZA2_STACTB='I',ZA2_CHCTB='"+cRecno+"',ZA2_LOGCTB='' "
		cquery += " WHERE D_E_L_E_T_ = ' ' AND ZA2_LOTE='"+cLoteza2+"' AND ZA2_IATA='"+cIata+"' AND  ZA2_DATA='"+DTOS(dDatadoc)+"'
		TCSQLEXEC(cQuery)
		
	Case cArq=='R2'	
		    
		for nRec:=1 to len(aRec)
	                ZA7->(Dbgoto(aRec[nrec][1]))
					RECLOCK("ZA7",.F.)
					ZA7_CHCTB:=cRecno
					ZA7_STATUS:='I' 
					ZA7_STACTB:='I' 
					ZA7_STAFIN:='I' 
					MSUNLOCK()
		next   nRec            

	EndCase
	
	
	
	/*
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³Protecao para impedir erro "EXISTCHAV" na CTF
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	*/
	
	Dbselectarea("CTF")
	Dbsetorder(1)
	If Dbseek(xfilial("CTF")+DTOS(dDatadoc)+cLoteCtb+'001'+cDocumento)
		RECLOCK("CTF",.F.)
		if valtype(NL)='N'
		CTF_LINHA:=STRZERO(NL,3)
		else
		CTF_LINHA:=NL
		endif
		MSUNLOCK()
	EndIf
	
	
Else

	FLAGTEMP('CTB','',cArq,'')
EndIf



lMsErroAuto :=.F.

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MYFINA050   ºAutor  ³Rubens Simi       º Data ³  09/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ rotina para inclusao do contas a pagar vindo do rapidgl     ±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MYFINA050(cArq,cPrefixo,cNatur,cIata,dEmiss,dVencrea,nValor,cLote,cHist,cCont)

Local aArray 		:= {}
Local aParamAuto	:= {}


/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³parametros para impedir contabilizacao on line
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
*/
aAdd( aParamAuto, {"MV_PAR01", 2} ) //Pergunta 01 - Mostra Lanc.Contab ? 1 = Sim   ; 2 = Não
aAdd( aParamAuto, {"MV_PAR03", 2} ) //Pergunta 02 - Contabiliza on line ? 1 = Sim   ; 2 = Não


/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³verIfica quantidade de dias para data de vencimento do titulo
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
*/
Dbselectarea("SA2")
Dbsetorder(10)
If Dbseek(XFILIAL("SA2") +cIata)
	cFor:=SA2->A2_COD
	cLoja:=SA2->A2_LOJA
Else
	cFor:='CODIGO IATA NAO CADASTRADO:'+cIata
	cLoja:='01'
EndIf

IF !EMPTY(dVencrea)

		aArray := { { "E2_PREFIXO"  , cPrefixo             			, NIL },;
					{ "E2_NUM"      , GETSXENUM('SE2',"E2_NUM",,1)	, NIL },;
					{ "E2_TIPO"     , "FT "              			, NIL },;
					{ "E2_VENCTO"   , dVencrea						, NIL },;
					{ "E2_NATUREZ"  , cNatur     					, NIL },;
					{ "E2_FORNECE"  , cFor            				, NIL },;
					{ "E2_LOJA"     , cLoja           				, NIL },;
					{ "E2_EMISSAO"  , dEmiss						, NIL },; 
					{ "E2_HIST"     , cHist+'-'+cCont	            , NIL },;
					{ "E2_ORIGEM"   , 'RAPID'					    , NIL },;
					{ "E2_VENCREA"  , DataValida(dVencrea, .t.) 	, NIL },;
					{ "E2_VALOR"    , nValor      					, NIL } }
					
		
		MsExecAuto( { |x,y,z| FINA050(x,y,z)}, aArray,, 3,aParamAuto)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão
		
		
		
		
		If 	!lMsErroAuto 
			    ConfirmSX8()
			RECLOCK("SE2",.F.)
			E2_LA:="S"
			MSUNLOCK()
			
				cChave:='PRE:'+SE2->E2_PREFIXO+'/NUM:'+SE2->E2_NUM+'/TP:'+SE2->E2_TIPO
			
			If cArq=='GL'
				
				
			
				
			
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
				// flega como correto o flag da integracao com
				// o financeiro e grava chave se2 para vinculo
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
				
				
				cquery := " update "+RetSqlName("ZA3")+" SET  ZA3_ACFIN='CP' ,ZA3_STAFIN='I',ZA3_CHFIN='"+cChave+"',ZA3_LOGFIN='' "
				cquery += " WHERE D_E_L_E_T_ = ' ' AND ZA3_CONTA='"+cCont+"' AND ZA3_IATA='"+cIata+"' AND  ZA3_DATA='"+DTOS(dEmiss)+"'
				TCSQLEXEC(cQuery)
				
			Else
				
				cquery := " update "+RetSqlName("ZA2")+" SET  ZA2_ACFIN='CP' ,ZA2_STAFIN='I',ZA2_CHFIN='"+cChave+"',ZA2_LOGFIN='' "
				cquery += " WHERE D_E_L_E_T_ = ' ' AND ZA2_IATA='"+cIata+"' AND ZA2_LOTE='"+cLote+"' AND  ZA2_DATA='"+DTOS(dEmiss)+"'
				TCSQLEXEC(cQuery)
				
				
			EndIf
		 ELSE	
			FLAGTEMP('FIN','CP',cArq,'')
		    ROLLBACKSXE()	
		EndIf
ELSE
			FLAGTEMP('FIN','CP',cArq,'CALENDARIO IATA NAO CADASTRADO')
ENDIF					

lMsErroAuto :=.F.



Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MYFINA040   ºAutor  ³Rubens Simi       º Data ³  09/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ rotina para inclusao do contas a receber vindo do rapidgl   ±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MYFINA040(cArq,cPrefixo,cNatur,cIata,dEmiss,dVencrea,nValor,cLote,cHist,cIdCnab,cCont)

Local aArray 		:= {}
Local aParamAuto	:= {}  

DEFAULT cIdCnab 	:=''


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
// parametros para nao contabilizar on line
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


aAdd( aParamAuto, {"MV_PAR01", 2} ) //Pergunta 01 - Mostra Lanc.Contab ? 1 = Sim   ; 2 = Não
aAdd( aParamAuto, {"MV_PAR03", 2} ) //Pergunta 02 - Contabiliza on line ? 1 = Sim   ; 2 = Não

pergunte("FIN040",.F.)  
MV_PAR01:=2
MV_PAR03:=2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
// busca dias a ser somado para data de vencimento
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


Dbselectarea("SA1")
Dbsetorder(9)
If Dbseek(XFILIAL("SA1") +cIata)
	cCli:=SA1->A1_COD
	cLoja:=SA1->A1_LOJA
Else
	cCli:='CODIGO IATA NAO CADASTRADO:'+cIata
	cLoja:='01'
EndIf


IF !EMPTY(dVencrea)
	
	
	aArray := { { "E1_PREFIXO"  , cPrefixo          		, NIL },;
	{ "E1_NUM"      ,  GETSXENUM('SE1',"E1_NUM",,1)		, NIL },;
	{ "E1_TIPO"     , "FT "              	 	, NIL },;
	{ "E1_NATUREZ"  , cNatur  		 			, NIL },;
	{ "E1_CLIENTE"  , cCli       	 			, NIL },;
	{ "E1_LOJA"     , cLoja       	 			, NIL },;
	{ "E1_EMISSAO"  , dEmiss    	 			, NIL },;
	{ "E1_VENCTO"   , dVencrea				 	, NIL },;
	{ "E1_VENCREA"  , DataValida(dVencrea, .t.)	, NIL },;
	{ "E1_HIST"     , cHist+'-'+cCont			, NIL },;
	{ "E1_IDCNAB"   , cIdCnab					, NIL },;
	{ "E1_ORIGEM"   , 'RAPID'					, NIL },;
	{ "E1_VALOR"    , nValor      	 			, NIL } }
	
	MsExecAuto( { |x,y| FINA040(x,y)} , aArray, 3,aParamAuto)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão
	
	
	
	
	
	If 	!lMsErroAuto
		ConfirmSX8()
		RECLOCK("SE1",.F.)
		E1_LA:="S"
		
		MSUNLOCK()
		cChave:='PRE:'+SE1->E1_PREFIXO+'/NUM:'+SE1->E1_NUM+'/TP:'+SE1->E1_TIPO


		
		
		If cArq=='GL'
			
			cquery := " update "+RetSqlName("ZA3")+" SET  ZA3_ACFIN='CR' ,ZA3_STAFIN='I',ZA3_CHFIN='"+cChave+"',ZA3_LOGFIN='' "
			cquery += " WHERE D_E_L_E_T_ = ' ' AND ZA3_IATA='"+cIata+"' AND  ZA3_DATA='"+DTOS(dEmiss)+"' AND ZA3_CONTA='"+cCont+"' 
			TCSQLEXEC(cQuery)
		Else
			
			cquery := " update "+RetSqlName("ZA2")+" SET  ZA2_ACFIN='CR' ,ZA2_STAFIN='I',ZA2_CHFIN='"+cChave+"',ZA2_LOGFIN='' "
			cquery += " WHERE D_E_L_E_T_ = ' ' AND ZA2_IATA='"+cIata+"' AND ZA2_LOTE='"+cLote+"' AND  ZA2_DATA='"+DTOS(dEmiss)+"'
			TCSQLEXEC(cQuery)
			
		EndIf
	Else
		
		FLAGTEMP('FIN','CR',cArq,'')
		ROLLBACKSXE()
	ENDIF
ELSE
	FLAGTEMP('FIN','CP',cArq,'CALENDARIO IATA NAO CADASTRADO')
ENDIF



lMsErroAuto :=.F.

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FLAGTEMP   ºAutor  ³Rubens Simi       º Data ³  09/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ rotina para flag dos logs gerados pelos exacauto            ±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FLAGTEMP(cOrig,cOp,cArq,erroZa5)


Local cErroTemp	:=''
Local cCrLf   := Chr(13) + Chr(10) 
Local cMsg :=''

IF !EXISTDIR("\SYSTEM\logMsexec")
    Makedir("\SYSTEM\logMsexec")
endif



if   empty(erroZa5)
cArqLOG 	:= StrTran(DTOC(dDataBase),"/","")+"_"+StrTran(Time(),":","")+".log"
cErroTemp	:=Mostraerro("\SYSTEM\logMsexec", cArqLOG)
else 
cErroTemp:=erroZa5
endif


cMsg+='±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±'+ cCrLf
cMsg+=''+ cCrLf
cMsg+=cErroTemp
cMsg+=''+ cCrLf
cMsg+='±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±'+ cCrLf
cMsg+=''+ cCrLf

aadd( aMsg,{cMsg}  )     



aadd( aLogOk,{cOrig,cOp , 'E', cErroTemp,ALLTRIM(STR(nRecnoOld)) })



Return()   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  procvenc   ºAutor  ³Rubens Simi       º Data ³  09/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Localiza a data de vencimento dos titulos pagar e receber   ±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function   procvenc(dDatadoc)
           

 dDatavencCli 		:= stod("  /  /    ")
 dDatavencGov 		:= stod("  /  /    ")

 Dbselectarea("ZAS")
 Dbsetorder(6)

 ZAS->(DBSEEK(XFILIAL("ZAS")+dtos(FirstDay(dDatadoc))))

		While !ZAS->(EOF())
          
             If ZAS->ZAS_DTINI<=dDatadoc .AND. ZAS->ZAS_DTFIM>=dDatadoc
                   dDatavencCli:=ZAS->ZAS_DTNORM
                   dDatavencGov:=ZAS->ZAS_DTGOVE
              EXIT
              EndIf
        
   	      ZAS->( DbSkip() )
        End    
        
Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  LerHotR2()   ºAutor  ³Rubens Simi       º Data ³  07/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina para leitura e gravacao do arquivo HotR2           º±±
±±º          ³ e comparacao com valores do Rapid                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LerR2(oMeter)


Local aCargaHT  :={}
Local cOrig     :=getmv("MV_ORIGR2")
Local cDest     :=getmv("MV_DESTR2")
Local aAreaZA3T :={}
Local aArquivo  :={}
Local nArq      :=1
Local Lbarra    :=.f.


if valtype(oMeter)=='O'
cTpArq		:= "Delimitado (microsiga*.*)|microsiga*.*|"
 
cOrig:=cGetFile(cTpArq, , 0, "SERVIDOR\", .T., GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE)
Lbarra:=.t.
endif

aArquivo:=u_abreftp(cOrig,cDest,'R2','*',Lbarra)


IF !EMPTY(cOrig)


for nY:=1 to len(aArquivo)
	
	If aArquivo[nY][5]
		
		aCargaR2:=u_lerArq(cDest+'\'+aArquivo[nY][1],';')
		
		if len(aCargaR2)=0
			u_ConsoleLog('Erro na Leitura do arquivo R2',{'Não foi possivel fazer a leitura do Arquivo '+cDest+'\'+aArquivo[ny][1]})
		endif
		
		           
		
				
			if lBarra
			nTotReg:=len(aCargaR2) 
			oMeter:SetTotal(nTotReg)
			endif
					
		
		for nx:=1 to len(aCargaR2)
			
			if lBarra 
				u_progresso(aCargaR2[NX][3],DTOCY(STOD(aCargaR2[NX][5])),nx,nTotReg)
			ENDIF  
	     
			
			RECLOCK("ZA7",.T.)
			
			ZA7_FILIAL   :=XFILIAL("ZA7")
			ZA7_TPARQ    :=aCargaR2[NX][1]
			ZA7_DTARQ	 :=dDatabase
			ZA7_ID		 :=aCargaR2[NX][3]
			ZA7_IATA	 :=aCargaR2[NX][4]
			ZA7_DTPR2	 :=stod(aCargaR2[NX][5])
			ZA7_HIST	 :=aCargaR2[NX][6]
			ZA7_LINHA    :=nx
			ZA7_ARQUI    :=aArquivo[nY][1]
			ZA7_STATUS   :='N'
			ZA7_STACTB   :='N'
			ZA7_STAFIN   :='N'
			DO Case
				
				Case aCargaR2[NX][1]=='04'
					
					ZA7_DTPG	 :=stod(aCargaR2[NX][7])
					ZA7_DSCSOL	 :=aCargaR2[NX][8]
					ZA7_IDSOLU	 :=substr(alltrim(aCargaR2[NX][8]),1,6)
					ZA7_VALLIQ 	 :=IF (val(aCargaR2[NX][9])<0,val(aCargaR2[NX][9])*-1,val(aCargaR2[NX][9]))
					ZA7_VALTXA 	 :=IF (val(aCargaR2[NX][10])<0,val(aCargaR2[NX][10])*-1,val(aCargaR2[NX][10]))
					
				Case aCargaR2[NX][1]=='03'
					
					ZA7_IDSOLU	 :='AJU'+aCargaR2[NX][7]
					ZA7_DSCSOL	 :=aCargaR2[NX][8]
					ZA7_VLBRUT	 :=val(aCargaR2[NX][9])
					
				Case aCargaR2[NX][1]=='02'
					
					ZA7_VLBRUT	 :=val(aCargaR2[NX][7])
					ZA7_VALLIQ	 :=val(aCargaR2[NX][8])
					ZA7_VALTXA	 :=val(aCargaR2[NX][9])
					
				Case aCargaR2[NX][1]=='01'
					
					ZA7_VLBRUT	 :=val(aCargaR2[NX][7])
					
			ENDCase
			MSUNLOCK()
		NEXT NX
	EndIf
	
next ny
                
ENDIF

//u_ProcR2
   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  u_ProcR2()   ºAutor  ³Rubens Simi       º Data ³  07/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina para processamento dos arqivos R2                  º±±
±±º          ³ Hot/adquirente/baixas/inconsistencias                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ProcR2(oMeter)

Local cQuery    		:=''
Local aStru     		:= ZA7->(DbStruct())
Local cCcontaCart		:=getmv("MV_CCARTAO")
Local nl				:=0
Local cTipoArqOld       :='02'
Local aItens            :={}
Local aRec              :={} 
Local lbarra			:=.f. 
local Lfirst02			:=.f.
local Lfirst03			:=.f.
local Lfirst04			:=.f.
Local aGeraBanco        :={}
Private dDatadoc        :=Stod('  /  /    ')
private aLogOk          :={}
Private nRecnoOld  	    :=0
Private lMsErroAuto     :=.f.
Private aMsg            :={}
Private aLogHot         :={}


If ( !AMIIn(34,06) )		// Acesso somente com licensas full para evitar erro na integracao com CTB
	AVISO('ATENÇÃO','Esta Rotina nao pode ser utilizada com licensas light' , {'Cancelar'}, 1)
	Return
EndIf

                        Dbselectarea('SA6')
                        DBSETORDER(4)

cQuery := " SELECT * FROM " + RetSqlName("ZA7")
cQuery += " WHERE ZA7_STATUS<>'I'
cQuery += " AND D_E_L_E_T_ = ' ' "
cQuery += " ORDER BY ZA7_TPARQ,ZA7_DTPG"


cQuery := ChangeQuery( cQuery )
dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA7T", .F., .T. )


For ni := 1 to Len(aStru)
	If aStru[ni,2] != 'C'
		TCSetField("ZA7T", aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
	EndIf
Next



if valtype(oMeter)=='O' 
lBarra:=.t. 
nTotReg := Contar("ZA7T","!Eof()")
oMeter:SetTotal(nTotReg)
endif

Dbselectarea('ZA7')
Dbsetorder(1)

Dbselectarea('SZM')
Dbsetorder(1)

dbSelectArea("ZA7T")
dbgotop()
 NP:=0
while ZA7T->(!eof() )		            
If lBarra 
np++
u_progresso(ZA7T->ZA7_IATA,DTOCY(ZA7T->ZA7_DTPR2),np,nTotReg)
ENDIF      
		   
		   
Do Case
		
		
		Case ZA7T->ZA7_TPARQ=='01'  
				 nrecno:=ZA7T->R_E_C_N_O_   
		
				 aAreaZA7T     := GetArea('ZA7T')
		            nValorGlLiq:=U_VALORGL(ZA7T->ZA7_IATA,DTOS(ZA7T->ZA7_DTPR2),cCcontaCart)
		
		cQuery := " SELECT COUNT(*) as TOTAL FROM " + RetSqlName("ZA3")
		cQuery += " WHERE ZA3_IATA='"+ZA7T->ZA7_IATA+"' 
		cQuery += " AND ZA3_DATA='"+DTOS(ZA7T->ZA7_DTPR2)+" ' "
		cQuery += " AND ZA3_CONTA='"+cCcontaCart+" ' "
		
		cQuery := ChangeQuery( cQuery )
		dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA3V", .F., .F. )
		 
		dbSelectArea("ZA3V")
		dbgotop()
		Do Case
			Case ZA7T->ZA7_VLBRUT=nValorGlLiq .AND. ZA3V->TOTAL>0
				ZA7->(Dbgoto(nrecno))
				RECLOCK("ZA7",.F.)
				ZA7_RECONC:=cReconc:='S'
				ZA7_STATUS:='I'
				ZA7_DIFGL :=0
				ZA7_VLGL  :=nValorGlLiq
				MSUNLOCK()
			Case nValorGlLiq<>0 .AND. ZA3V->TOTAL>0
				ZA7->(Dbgoto(nrecno))
				RECLOCK("ZA7",.F.)
				ZA7_RECONC:='D'
				ZA7_STATUS:='E'
				ZA7_LOGCTB:='Registro localizado porem com diferença Valor Rapid: '+Transform(nValorGlLiq,"@E 999,999.99")+' Valor R2: '+Transform(ZA7T->ZA7_VLBRUT,"@E 999,999.99")
				ZA7_DIFGL :=IF (nValorGlLiq-ZA7T->ZA7_VLBRUT<0, (nValorGlLiq-ZA7T->ZA7_VLBRUT)*(-1),nValorGlLiq-ZA7T->ZA7_VLBRUT)
				ZA7_VLGL  :=nValorGlLiq
				MSUNLOCK()
				aadd( aLogHot,{ZA7->ZA7_RECONC,ZA7T->ZA7_IATA ,DTocy(ZA7T->ZA7_DTARQ),ZA7T->ZA7_VLBRUT,nValorGlLiq,'','Hot'})
			Case nValorGlLiq=0	.AND. ZA3V->TOTAL=0
				ZA7->(Dbgoto(nrecno))
				RECLOCK("ZA7",.F.)
				ZA7_RECONC:='N'
				ZA7_STATUS:='E'
				ZA7_LOGCTB:='Registro não localizado '
				ZA7_DIFGL :=ZA7T->ZA7_VLBRUT
				ZA7_VLGL  :=0
				MSUNLOCK()
				aadd( aLogHot,{ZA7->ZA7_RECONC,ZA7T->ZA7_IATA ,DTocy(ZA7T->ZA7_DTARQ),ZA7T->ZA7_VLBRUT,0,'','Hot'})
				
		EndCase
		
		ZA3V->(DbCloseArea())
		RestArea(aAreaZA7T)
		
Case ZA7T->ZA7_TPARQ=='02'
	  cTipoArqOld   :=ZA7T->ZA7_TPARQ
	  cLote 		:='R2ADQ ' 
	  dDatadoc		:=ZA7T->ZA7_DTPR2
	  cIataid		:=ZA7T->ZA7_ID
	  cTipo  		:=ZA7T->ZA7_TPARQ

	  if !Lfirst02
	    Lfirst02:=.t.
	    nl:='0' 
	  endif
	         
	
	
	////////////////////////////
	// Verifica o menor valor entre 
	// provisao r2 e provisao gl e grava valores de divergencia na za7
	////////////////////////////  
	
	
	     nValor:=ValidProv(cCcontaCart)
	 
		
	   if	nValor>0                 
		
			for nr:=1 to  2
			                                               
		              cLanPad:= if(nr=2,'000422','000433')
		               
					
				If SZM->(Dbseek(xfilial('SZM')+cLanPad))
					cCdebito  := SZM->ZM_CC_D      
					cCcredito := SZM->ZM_CC_C   
					cCustod   := SZM->ZM_CUSTO_D    
					cCustoc   := SZM->ZM_CUSTO_C
				Else
					cCdebito  :='lancamento '+cLanPad+' não Localizado na tabela SZM' 
					cCcredito :=''
					cCustod   :=''
					cCustoc   :=''
				EndIf
			            if nr=2 
			            nValor :=ZA7T->ZA7_VALTXA
			         	ENDIF
	
	    			    IF nValor>0                       
	    			     nl:=PADL(alltrim(SOMA1(nl,3)),3,'0') 
								aAdd(aItens,{   {'CT2_FILIAL' ,xfilial("CT2")  , NIL},;
							{'CT2_LINHA'  ,nl  				   , NIL},;
							{'CT2_MOEDLC' ,'01'   						   , NIL},;
							{'CT2_DC'     ,'3'                  		   , NIL},;
							{'CT2_DEBITO' , cCdebito					   , NIL},;
							{'CT2_CREDIT' , cCcredito	  				   , NIL},;
							{'CT2_VALOR'  ,nValor   					   , NIL},;
							{'CT2_ORIGEM' ,'R202|'+ALLTRIM(ZA7T->ZA7_IATA)+'|'+ALLTRIM(DTOS(ZA7T->ZA7_DTPR2));
							              +'|'+ALLTRIM(STR(ZA7T->ZA7_LINHA))							   , NIL},;                             
							{'CT2_HP'     ,''   						   , NIL},;
					        {'CT2_CCD'    ,	cCustod						   , NIL},;
							{'CT2_CCC'    ,	cCustoc						   , NIL},;
							{'CT2_HIST'   ,ALLTRIM(ZA7T->ZA7_HIST)		   , NIL} } )
	                    ENDIF
	                    NEXT nR
	               aadd( aRec,{ZA7T->R_E_C_N_O_})      			
	               
	  endif
	
Case   ZA7T->ZA7_TPARQ=='04'
     
	  if !Lfirst04
	    Lfirst04:=.t.
	    nl:='0' 
	  endif




	  cTipoArqOld:=ZA7T->ZA7_TPARQ
	  cLote :='R2BXA '
	  dDatadoc:=ZA7T->ZA7_DTPG       
	  cIataid:=ZA7T->ZA7_ID
	  nValor:=0
	                                         
		FOR NR:=1 TO 2 
	
		            	nValor:=0
	            		if nr=1 .and. ZA7T->ZA7_VALLIQ<>0
			            nValor :=if (ZA7T->ZA7_VALLIQ<0,ZA7T->ZA7_VALLIQ*-1,ZA7T->ZA7_VALLIQ)+ZA7T->ZA7_VALTXA
			           elseif nr=2 .and. ZA7T->ZA7_VALTXA<>0
				        nValor :=ZA7T->ZA7_VALTXA
				      	ENDIF
	
			    IF nValor>0
	          nl:=PADL(alltrim(SOMA1(nl,3)),3,'0') 
	        If SZM->(Dbseek(xfilial('SZM')+IF (NR=1,ZA7T->ZA7_IDSOLU,'000330')))
					cCdebito  := if (NR=1,cBancoD:=SZM->ZM_CC_D,SZM->ZM_CC_D)      
					cCcredito := if (NR=1,SZM->ZM_CC_C,cBancoD)
					cCustod   := SZM->ZM_CUSTO_D    
					cCustoc   := SZM->ZM_CUSTO_C 
				     if nr=1  
				     
				     
				     DO CASE
				     CASE SA6->(DBSEEK(XFILIAL("SA6")+cCdebito))  
	                
	                nPos:=aScan(aGeraBanco,{|x|x[1]==ALLTRIM(cCdebito)+dtos(dDatadoc)+SZM->ZM_BANDEIR}) 
						
							
				     IF  nPos>0
						       aGeraBanco[npos][6]:=aGeraBanco[npos][6]+','+alltrim(STR(ZA7T->R_E_C_N_O_))
							   aGeraBanco[npos][2]:= aGeraBanco[npos][2]+if (ZA7T->ZA7_VALLIQ<0,ZA7T->ZA7_VALLIQ*-1,ZA7T->ZA7_VALLIQ)
							   nPos:=0
					  else
					       
					  aadd( aGeraBanco,{ALLTRIM(cCdebito)+dtos(dDatadoc)+SZM->ZM_BANDEIR, nValor,cCdebito,dDatadoc,cCustod,alltrim(STR(ZA7T->R_E_C_N_O_))})
					  
					  endif		
					
	                   	
	                    
	                 CASE SA6->(DBSEEK(XFILIAL("SA6")+cCcredito))  
						
						nPos:=aScan(aGeraBanco,{|x|x[1]==ALLTRIM(cCcredito)+dtos(dDatadoc)+SZM->ZM_BANDEIR}) 
						
							
				     IF  nPos>0
						       aGeraBanco[npos][6]:=aGeraBanco[npos][6]+','+alltrim(STR(ZA7T->R_E_C_N_O_))
							   aGeraBanco[npos][2]:= aGeraBanco[npos][2]-if (ZA7T->ZA7_VALLIQ<0,ZA7T->ZA7_VALLIQ*-1,ZA7T->ZA7_VALLIQ)
							   nPos:=0
					  else
					       
					  aadd( aGeraBanco,{ALLTRIM(cCcredito)+dtos(dDatadoc)+SZM->ZM_BANDEIR, nValor*-1,cCcredito,dDatadoc,cCustod,alltrim(STR(ZA7T->R_E_C_N_O_))})
					  
					  endif		
						
					ENDCASE	
					
				   	endif  
				Else
					cCdebito  :='lancamento '+ZA7T->ZA7_IDSOLU+'não cadastrado na Tabela SZM para Historico '+ZA7T->ZA7_DSCSOL
					cCcredito :=''
					cCustod   :=''
					cCustoc   :=''
				EndIf

				
	        
							aAdd(aItens,{   {'CT2_FILIAL' ,xfilial("CT2")  , NIL},;
							{'CT2_LINHA'  , nl  				   , NIL},;
							{'CT2_MOEDLC' ,'01'   						   , NIL},;
							{'CT2_DC'     ,'3'                  		   , NIL},;
							{'CT2_DEBITO' , cCdebito					   , NIL},;
							{'CT2_CREDIT' , cCcredito	  				   , NIL},;
							{'CT2_VALOR'  ,nValor  			   , NIL},;
							{'CT2_ORIGEM' ,'R204|'+ALLTRIM(ZA7T->ZA7_IATA)+'|'+ALLTRIM(DTOS(ZA7T->ZA7_DTPR2));
							              +'|'+ALLTRIM(STR(ZA7T->ZA7_LINHA))							   , NIL},;
							{'CT2_HP'     ,''   						   , NIL},;
					        {'CT2_CCD'    ,	cCustod						   , NIL},;
							{'CT2_CCC'    ,	cCustoc						   , NIL},;
							{'CT2_HIST'   ,ALLTRIM(ZA7T->ZA7_HIST)+'-'+ALLTRIM(ZA7T->ZA7_DSCSOL), NIL} } )
	               aadd( aRec,{ZA7T->R_E_C_N_O_})      			
	           ENDIF
	           NEXT NR             
	                        
Case ZA7T->ZA7_TPARQ=='03'
	            
   	  if !Lfirst03
	    Lfirst03:=.t.
	    nl:='0' 
	  endif
    
	            
	                                 
	  cTipoArqOld:=ZA7T->ZA7_TPARQ
	  cLote :='R2AJU '
	  dDatadoc:=ZA7T->ZA7_DTPR2
	  cIataid:=ZA7T->ZA7_ID 
	  nValor :=0                               
	  cLanpad :=STRZERO(VAL(ZA7T->ZA7_IDSOLU),6)
			
	          If  SZM->(Dbseek(xfilial('SZM')+ cLanpad))
					cCdebito  := SZM->ZM_CC_D      
					cCcredito := SZM->ZM_CC_C   
					cCustod   := SZM->ZM_CUSTO_D    
					cCustoc   := SZM->ZM_CUSTO_C
				Else
					cCdebito  :='lancamento '+cLanpad+'não cadastrado na Tabela SZM para Historico '+ZA7T->ZA7_DSCSOL
					cCcredito :='' 
					cCustod   :=''
					cCustoc   :=''
				EndIf
			                       
		     
			         		
	              nl:=PADL(alltrim(SOMA1(nl,3)),3,'0')               
			
	                        aAdd(aItens,{  {'CT2_FILIAL' ,xfilial("CT2")  , NIL},;
							{'CT2_LINHA'  ,nl  				   , NIL},;
							{'CT2_MOEDLC' ,'01'   						   , NIL},;
							{'CT2_DC'     ,'3'                  		   , NIL},;
							{'CT2_DEBITO' , cCdebito					   , NIL},;
							{'CT2_CREDIT' , cCcredito	  				   , NIL},;
							{'CT2_VALOR'  ,ZA7T->ZA7_VALLIQ			  			   , NIL},;
							{'CT2_ORIGEM' ,'R204|'+ALLTRIM(ZA7T->ZA7_IATA)+'|'+ALLTRIM(DTOS(ZA7T->ZA7_DTPR2));
							              +'|'+ALLTRIM(STR(ZA7T->ZA7_LINHA))							   , NIL},;
							{'CT2_HP'     ,''   						   , NIL},;
					        {'CT2_CCD'    ,	cCustod						   , NIL},;
							{'CT2_CCC'    ,	cCustoc						   , NIL},;
							{'CT2_HIST'   ,ALLTRIM(ZA7T->ZA7_HIST)+'-'+ALLTRIM(ZA7T->ZA7_DSCSOL)+'-'+IF (NR>1,' - TAXAS',' - VL LIQUIDO')		   , NIL} } )
	               aadd( aRec,{ZA7T->R_E_C_N_O_})      						
	                 nRecnoOld:= ZA7T->R_E_C_N_O_
	        	EndCase				
	      
	      ZA7T->( DbSkip() )   	
	      
	      	    
	      	
	       	  if  len(aItens)>0 .AND. (dDatadoc<>IF(cTipoArqOld='04',ZA7T->ZA7_DTPG,ZA7T->ZA7_DTPR2)  .OR. cTipoArqOld<>ZA7T->ZA7_TPARQ) // .or. dDatadoc<>ZA7T->ZA7_DTPR2) .And.
	                    aAreaZA7T     := GetArea('ZA7T')
	                    BeginTran()
		
	      			    IF LEN(aGeraBanco)>0
	      			     
	      			     //U_myfina100(aGeraBanco)
	      			    
	      			    ENDIF
	      				
	      				U_MYCTBA102(aItens,NL,'R2','',cLote,aRec)
						        
					If aScan(aLogOk,{|x| AllTrim(x[3])=="E"})>0
		                
		                 DisarmTransaction()  
		                
	                    for nx:=1 to len(aRec)
		                     
		                    ZA7->(Dbgoto(aRec[NX][1]))
							RECLOCK("ZA7",.F.)
							ZA7_CHCTB:='' 
							ZA7_CHFIN:='' 
							ZA7_STATUS:='E'  
							 IF alltrim(aLogOk[1][1])=='CTB'
								ZA7_STACTB:='E' 
								ZA7_LOGCTB:=alltrim(aLogOk[1][4])
							 ELSE
								ZA7_STAFIN:='E' 
								ZA7_LOGFIN:=alltrim(aLogOk[1][4])
							 ENDIF					
							MSUNLOCK()
					     	
				     	next nx
						aLogOk:={}	
					
	
					endif
				 RestArea(aAreaZA7T)		
				 EndTran() 
				 aGeraBanco:={}
			     aRec:={}
				 dDatadoc:=ZA7T->ZA7_DTPR2
				 aItens:={}    
	     		 cIataid:=ZA7T->ZA7_ID
				 nl:='0'   
				 MsUnLockAll() 
			     
			  EndIf
			    
			           
								
Enddo

ZA7T->(DbCloseArea())
MsUnLockAll() 



IF  len(aLogHot)>0
	u_ConsoleLog("LOG DE INCONSISTENCIA DO R2",aloghot)
endif
 

Return()          


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ValidProv     ºAutor  ³Microsiga           º Data ³  04/29/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


Static Function ValidProv(cCcontaCart)

Local   cAjuste		  := ''      
Local   lRet          := .F.
Local   nrecno        := ZA7T->R_E_C_N_O_   
Local   nValor        := 0
Local   aAreaZA7T     := GetArea('ZA7T')
Local   cIatavld      :=ZA7T->ZA7_IATA
Local   cDatavld      := DTOS(ZA7T->ZA7_DTPR2)
Local   nValorvld     :=ZA7T->ZA7_VLBRUT

nValorGlLiq:=U_VALORGL(cIatavld,cDatavld,cCcontaCart)
 
dbSelectArea("ZA3V")
dbgotop()  
                   		
		  Do Case
           Case nValorvld=nValorGlLiq 
               ZA7->(Dbgoto(nrecno))   
				RECLOCK("ZA7",.F.)
				ZA7_RECONC:='S'
				ZA7_LOGCTB:=''
				ZA7_DIFGL :=0
				ZA7_VLGL  :=nValorGlLiq
				MSUNLOCK()
           
           Case nValorGlLiq<>0 
	            ZA7->(Dbgoto(nrecno))   
				RECLOCK("ZA7",.F.)
				ZA7_RECONC:='D'
				ZA7_LOGCTB:='Registro com Diferenças em relacao ao RapidGL : '+Transform(nValorGlLiq,"@E 999,999.99")+' Valor R2: '+Transform(ZA7T->ZA7_VLBRUT,"@E 999,999.99")+' '+cAjuste
				ZA7_DIFGL :=max(nValorGlLiq,nValorvld)- min(nValorGlLiq,nValorvld)
				ZA7_VLGL  :=nValorGlLiq
				MSUNLOCK()
//		        aadd( aLogHot,{ZA7->ZA7_RECONC,cIatavld ,cDatavld,nValorvld,nValorGlLiq,cAjuste,'Provisão'})

        Case nValorGlLiq=0   
	            ZA7->(Dbgoto(nrecno))   
				RECLOCK("ZA7",.F.)
				ZA7_RECONC:='N'
				ZA7_STATUS:='E'
				ZA7_LOGCTB:='Registro nao localizado nos Registros do RapidGL, '+cAjuste
				ZA7_DIFGL :=nValorvld
				ZA7_VLGL  :=0
				MSUNLOCK()
			    aadd( aLogHot,{ZA7->ZA7_RECONC,cIatavld ,cDatavld,nValorvld,0,cAjuste,'Provisão'})
  EndCase   
 nValorvld:=min(nValorGlLiq,nValorvld)
ZA3V->(DbCloseArea())		    
RestArea(aAreaZA7T) 

  
    
     Return(nValorvld) 
     
     
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  myfina100     ºAutor  ³Microsiga           º Data ³  04/29/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

     
     user function  myfina100 (aGeraBanco)
            
     Local   aFina100      := {}
     Local   ddataold      := ddatabase
     Private LMSERROAUTO   := .F.
                              


FOR NX:=1 TO LEN(aGeraBanco)
             ddatabase:=aGeraBanco[NX][4]  
             LMSERROAUTO   := .F.
             AFINA100:={}
                                 
					  //aadd( aGeraBanco,{cCdebito+dtos(dDatadoc)+SZM->ZM_BAND, nValor,cCdebito,dDatadoc,cCustod})
					                             
     // garante que nao contabiliza on Line
     SX1->(DBSEEK(PADR('AFI100',LEN(SX1->X1_GRUPO))+'04'))
       IF SX1->X1_PRESEL<>2
        RECLOCK('SX1',.F.)
        X1_PRESEL:=2
        MSUNLOCK()
       ENDIF
                                 
     
	 DbSelectArea('SA6')
	 DbSetOrder(4)
     DBSEEK(XFILIAL('SA6')+aGeraBanco[NX][3]  )
       cBanco	:=ALLTRIM(SA6->A6_COD)
       cAgencia :=SA6->A6_AGENCIA
       cConta	:=SA6->A6_NUMCON 
    

	 SA6->(DbSetOrder(1))
     SA6->(DBSEEK(XFILIAL('SA6')+cBanco+cAgencia+cConta))
    
    
     AFINA100 := {           {"E5_DATA"        ,ddatabase          			,NIL},;
                             {"E5_MOEDA"       ,"M1"              			,NIL},;
                             {"E5_VALOR"       ,IF(aGeraBanco[NX][2]>0,aGeraBanco[NX][2],aGeraBanco[NX][2]*-1)           ,NIL},;
                             {"E5_NATUREZ"     ,'121000'          			,NIL},;
                             {"E5_BANCO"       ,ALLTRIM(SA6->A6_COD)       	,NIL},;
                             {"E5_AGENCIA"     ,SA6->A6_AGENCIA   			,NIL},;
                             {"E5_CONTA"       ,SA6->A6_NUMCON    			,NIL},;
                             {"E5_DOCUMEN"     ,aGeraBanco[NX][1]           ,NIL},; 
                             {"E5_BASE"        ,'BAS0902'              		,NIL},;
                             {"E5_CUSTO"       ,aGeraBanco[NX][5]           ,NIL},;
                             {"E5_BENEF"       ," "               			,NIL},; 
                             {"E5_ORIGEM"       ,"RAPID"               		,NIL},;
                             {"E5_HISTOR"      ,aGeraBanco[NX][1]		  	,NIL}}
                             
                                 
						  IF aGeraBanco[NX][2]>0
						      nOpc1:=4
						  ELSE
							  nOpc1:=3
						  ENDIF                
                        
                        
                             MSEXECAUTO({|X,Y,Z| FINA100(X,Y,Z)},0,AFINA100,nOpc1)
                             
                             IF !LMSERROAUTO
                            
					        RECLOCK('SE5',.F.)
					        E5_LA:='S'
					        MSUNLOCK()
					
                             cquery := " update "+RetSqlName("ZA7")+" SET  ZA7_STAFIN='I',ZA7_CHFIN='"+aGeraBanco[NX][1]+"',ZA7_LOGFIN='' "
					         cquery += " WHERE D_E_L_E_T_ = ' ' AND R_E_C_N_O_ IN ("+aGeraBanco[NX][6]+") AND  ZA7_DTPG='"+DTOS(ddatabase)+"'  

			                 TCSQLEXEC(cQuery)
                                              
                              else
                              	FLAGTEMP('FIN','MV','R2','')  
                              endif 
                              
                               
                      
    NEXT NX
ddatabase:= ddataold  
DbSelectArea('SA6')
	 DbSetOrder(4)                  
   
   
   RETURN()  
   
   
                                 