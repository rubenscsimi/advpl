#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ZASA010   ³ Autor ³ RUBENS SIMI           ³ Data ³ 24.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ CALENDARIO IATA                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CalenIata                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T.                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CalenIata                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
user function Ciata()

PRIVATE aRotina := MenuDef()

PRIVATE cCadastro := OemtoAnsi("Calendario Iata")	//"Calendario Contabil"
Private lExibMsg   := .F.   //variavel a ser utilizada no ZASa140


mBrowse( 6, 1,22,75,"ZAS")

SetKey(VK_F12, Nil)

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³CiataCAL ³ Autor ³ Rubens Simi   ³ Data ³ 17.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Exibe na tela o calendario e a getdados                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CiataCal(cAlias,nReg,nOpc)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Alias do Arquivo                                   ³±±
±±³          ³ ExpN1 = Numero do Registro                                 ³±±
±±³          ³ ExpN2 = Numero da opcao selecionada                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
user function CiataCal(cAlias,nReg,nOpc)

Local aSaveArea:= GetArea()
Local cExerc
Local dData
Local nOpca 	:= 0
Local oDlg, oCalend
Local oGet

Local aWizCalen
Local aWizPanCal    
Local aDatas, aTpPer,aDadCalen
Local bFinalWiz
Local lWizard := .F.
Local aArea, aScreen, 	nWStage, nHStage
Local nX
Local oPnlBot, oSay, oButton
Local aColumns, aWindows
Local aAux, aDadosCale, cCodCale, cExerCale, oTreeCal
Local aDadosMoed, oTreeMoed
Local aDadoAmCal, oTreeAmar


Private aTELA[0][0],aGETS[0],aHeader[0]
Private aCols	:= {}
Private nUsado := 0
Private nPosDtIni, nPosDtFim, nPosdtgov, nPosdtNor
Private cCalendZAS

Pergunte("Ciata", .F.)

DbSelectArea("ZAS")
dbSetOrder(1)

If nOpc == 3
	cExerc	:= Str(Year(dDataBase),4)
	cCalendZAS	:= CriaVar("ZAS_CALEND")
Else
	cExerc	:= ZAS->ZAS_EXERC
	cCalendZAS	:= ZAS->ZAS_CALEND
EndIf

CiataAhead()
CiataAcols(nOpc,cExerc,cCalendZAS) 

If  nOpc == 4 .Or. nOpc == 5 //MODO TRADICIONAL
	DEFINE MSDIALOG oDlg TITLE OemToAnsi("Calendario Iata") FROM 9,0 TO 23,80 OF oMainWnd 
	
		@ 005,010 Say OemToAnsi('Codigo') OF oDlg PIXEL
		@ 005,045 MSGET oCalendZAS VAR cCalendZAS When nOpc == 3 Valid NaoVazio(cCalendZAS) .AND. Ct010DgCod(@ccalendZAS,@oCalendZAS)  .and. Ct010Calend(cCalendZAS,nOpc) .And. FreeForUse("ZAS",cCalendZAS) SIZE 020,08 OF oDlg PIXEL
	
		@ 005,100 Say OemToAnsi('Ano') OF oDlg PIXEL
		@ 005,150 MSGET cExerc When nOpc == 3 Valid NaoVazio(cExerc) SIZE 035,08 OF oDlg PIXEL
	
		oCalend:=MsCalend():New(20,0,oDlg)
	
		oCalend:bChange := {||oDlg:Refresh()}
			
		oGet := MSGetDados():New(020,140,86,314,nOpc,"Ct010LinOK","Ct010TudOK","+ZAS_PERIOD",.T.)
	
		DEFINE SBUTTON FROM 090, 260 TYPE 1 ACTION (nOpca:=1,;
		Iif(Ct010TudOk(nOpc),oDlg:End(),nOpca:=0)) ENABLE Of oDlg
		
		DEFINE SBUTTON FROM 090, 290 TYPE 2 ACTION oDlg:End() ENABLE Of oDlg
	
	ACTIVATE MSDIALOG oDlg CENTERED
ENDIF

	If nOpc == 2 //visualizar quando por assistente

		aArea			:= GetArea()
		aScreen 		:= MsAdvSize(.F.)	//GetScreenRes()
		nWStage 		:= (aScreen[3] * 2) //aScreen[1]-65
		nHStage 		:= (aScreen[4] * 2)	//aScreen[2]-215

		DEFINE DIALOG oDlg TITLE cCadastro SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_POPUP)

		//Painel inferior
		oPnlBot := TPanel():New(01,01,,oDlg,,,,,,200,10,.F.,.F.)
		oPnlBot:Align := CONTROL_ALIGN_BOTTOM
		//Clique com o botão direito
       	oSay := TSay():New( 10, 20, MontaBlock("{||'Clique com o botão direito'}"),oPnlBot,, /*oFont*/, .F., .F., .F., .T.,,, 20/*nLarguraSay*/, 10, .F., .F., .F., .F., .F. )  //"Clique com Botao Direito para Visualizar"
		oSay:Align := CONTROL_ALIGN_ALLCLIENT
       	//Botão Sair
       	oButton := TButton():New(0,0,"Sair",oPnlBot,{|| oDlg:End() },30,10,,,,.T.,,"",,,,)		//"Sair"		
		oButton:Align := CONTROL_ALIGN_RIGHT
		
		aColumns := {"Col01","Col02","Col03"}
		aWindows := { 	{	{"Calendario",{||},NIL},;  //"Calendario"
							{"Moeda",{||},NIL} ;  //"Moeda"
						},;
						{;
							{"Moeda x Calendario",{||},NIL};  //"Moeda x Calendario"
						},;
						{;
							{"Cambio",{||},NIL};  //"Cambio"
						};
					}
	
		CiataLayer(oDlg,aColumns,aWindows)

		aDadosCale := {}
		dbSelectArea("ZAS")
		dbSetOrder(1)
		dbSeek(xFilial("ZAS"))
		While ZAS->(!Eof() .And. ZAS_FILIAL == xFilial("ZAS") )
			cCodCale := ZAS->ZAS_CALEND
			cExerCale := ZAS->ZAS_EXERC
			aAux := {}
			While ZAS->(!Eof() .And. ZAS_FILIAL == xFilial("ZAS") .And. ZAS_CALEND == cCodCale )
				aAdd(aAux, { "Periodo :"+ZAS->ZAS_PERIOD+" De: "+DTOC(ZAS->ZAS_DTINI)+" Ate: "+DTOC(ZAS->ZAS_DTFIM),"ZAS"+cCodCale+cExerCale+ZAS->ZAS_PERIOD,{|oTree|TreeVisual(oTree)} } )  //"Periodo "###" de : "###" ate : "
				ZAS->(dbSkip())
			EndDo
			aAdd(aDadosCale, { cCodCale+" - Exercicio : "+cExerCale, "ZAS"+cCodCale, {|oTree|TreeVisual(oTree)}, aClone(aAux) })  //" - Exercicio : "
		EndDo
		oTreeCal := CiataTree(aWindows[1,1,3], aDadosCale)
		
		aDadosMoed := {}
	
		aDadoAmCal := {}
																		
		ACTIVATE DIALOG oDlg CENTERED
		
		RestArea(aArea)
																		
	ElseIf nOpc == 3  //ASSISTENTE SOMENTE PARA INCLUSAO
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Array aWizCalen - Estrutura:                        ³
		//³ Posicao 1 - Titulo                                  ³
		//³         2 - Mensagem Explicativa                    ³
		//³         3 - bNext                                   ³
		//³         4 - bFinish                                 ³
		//³         5 - lPanel                                  ³
		//³         6 - lNoFist                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	    aWizCalen := {}
	    aAdd(aWizCalen, cCadastro)
	    aAdd(aWizCalen, "Este assistente do "+cCadastro+" vai lhe orientar no preenchimento dos dados.")  //"Este assistente do "###" vai lhe orientar no preenchimento dos dados."
	    aAdd(aWizCalen, {||.T.})
	    aAdd(aWizCalen, {||.T.})
	    aAdd(aWizCalen, .T.)
	    aAdd(aWizCalen, .F.)
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Paineis                                             ³
		//³ Array aWizPanel - Estrutura:                        |
		//³ Para cada linha deste array multidimensional        ³
		//³ Posicao 1 - Titulo do painel                        ³
		//³         2 - Mensagem Explicativa                    ³
		//³         3 - bNext                                   ³
		//³         4 - bFinish                                 ³
		//³         5 - lPanel                                  ³
		//³         6 - bBack                                   ³
		//³         7 - bExecute                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aWizPanCal  := {}
		aPanel		:= {}		
		aDatas 		:= { CtoD("01/01/"+Substr(DTOs(dDataBase),3,2)) , CtoD("31/12/"+Substr(DTOs(dDataBase),3,2))}
		aTpPer 		:= {2}  //1=Semanal;2=Quinzenal;3=Mensal;4=Bimestral;5=Semestral;6=Anual;7=Dißrio;8=trimestral
		cCalendZAS 	:= Left(cExerc,1)+Right(cExerc,2)
		aDadCalen 	:= {cCalendZAS,cExerc,.F.,.T.}
		bFinalWiz := {||  If(nOpca == 1, ;
							(	n:=1,;
								lWizard := .T.,;
								cCalendZAS:=aDadCalen[1],;
								cExerc:=aDadCalen[2],;
								lRet := Ct010Calend(cCalendZAS,nOpc).And.Ct010TudOk(nOpc),;
								If(lRet, .T., (nOpca := 0, .F.)) ;
							),;//else
							NIL);
					}

	    aAdd(aWizPanCal, {cCadastro, "Digite o Periodo" , {||CiataWzDt(aDatas)}, {||.T.} , .T., {||.T.}									, {||CiataPer(aPanel[1],aDatas),.T.} })   //"Digite o Periodo"
	    aAdd(aWizPanCal, {cCadastro, "Escolha o Tipo de Periodo" , {||.T.}			   	 , {||.T.} , .T., {||.T.}									, {||CiataTPer(aPanel[2],aTpPer),.T.} })  //"Escolha o Tipo de Periodo"
	    aAdd(aWizPanCal, {cCadastro, "Confira os periodos gerados" , {||.T.}				 , {||.T.} , .T., {||aCols := {},oGet:SetArray(aCols),.T.}	, {||CiataGrd(aPanel[3],@oGet,aDatas,aTpPer),.T.} })  //"Confira os periodos gerados"
	    aAdd(aWizPanCal, {cCadastro, "Preencha e Confirme os Dados" , {||.T.}				 , {||.T.} , .T., {||.T.}									, {||CiataHead(aPanel[4],aDadCalen ),nOpca := 1,.T.} })  //"Preencha e Confirme os Dados"

		ctbWizard(aWizCalen, aWizPanCal, aPanel, /*lCenter*/, bFinalWiz/*bValid*/, /*bInit*/, /*bWhen*/)

	

    EndIf
    


If nOpca == 1  
	BEGIN TRANSACTION
		CiataGrava(nOpc,cExerc,cCalendZAS)
	END TRANSACTION
	
EndIf


RestArea(aSaveArea)

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CiataAhea³ Autor ³ Rubens Simi   ³ Data ³ 17.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gera matriz Aheader - para montagem posterior da acols     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³CiataAhea()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum		                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
static function CiataAhead()

Local aSaveArea := GetArea()

dbSelectArea("Sx3")
dbSetOrder(1)

dbseek("ZAS")
While !EOF() .And. (x3_arquivo == "ZAS")
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And.;
		Trim(X3_CAMPO) != "ZAS_EXERC" .And. Trim(X3_CAMPO) != "ZAS_CALEND" .And. Trim(X3_CAMPO) != "ZAS_DESCD"
		nUsado++
		AADD(aHeader,{ TRIM(X3Titulo()), x3_campo, x3_picture,;
					 x3_tamanho, x3_decimal, x3_valid,;
					 x3_usado, x3_tipo, x3_arquivo } )
	EndIf
	DbSkip()
EndDO

RestArea(aSaveArea)

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CiataAcol³ Autor ³ Rubens Simi   ³ Data ³ 17.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gera matriz ACOLS para preenchimento das cotacoes          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³CiataAcol(nOpc,cExerc,cCalendZAS)  	                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum		                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 = Opcao escolhida do menu (Inclusao / Alteracao..)   ³±±
±±³          ³ ExpC1 = Exercicio Contabil -> Ano                          ³±±
±±³          ³ ExpC2 = Calendario Contabil escolhido                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
static function CiataAcols(nOpc,cExerc,cCalendZAS,cFilCal)

Local nCont := 1
Local cFilZAS	:= ""
Local aSaveArea := GetArea() 
Default cFilCal := xFilial("ZAS")

cFilZAS := xFilial("ZAS",cFilCal)  
nPosDtIni	:= Ascan(aHeader,{|x|Alltrim(x[2]) = "ZAS_DTINI"})
nPosDtFim	:= Ascan(aHeader,{|x|Alltrim(x[2]) = "ZAS_DTFIM"})
nPosDtgov	:= Ascan(aHeader,{|x|Alltrim(x[2]) = "ZAS_DTGOV"})
nPosDtnor	:= Ascan(aHeader,{|x|Alltrim(x[2]) = "ZAS_DTNOR"})
//nPosStatus	:= Ascan(aHeader,{|x|Alltrim(x[2]) = "ZAS_STATUS"})

aCols := {}

dbSelectArea("ZAS")
dbSetOrder(1)
If (nOpc == 2 .Or. nOpc == 4 .Or. nOpc == 5)  // Visualiza / Altera / Exclui
	dbSeek(cFilZAS+cCalendZAS+cExerc)
	While !Eof() .And. cFilZAS == ZAS->ZAS_FILIAL .And.;
			ZAS->ZAS_EXERC == cExerc .And. ZAS->ZAS_CALEND == cCalendZAS

		AADD(aCols,Array(nUsado+1))     
	 
		aCols[nCont][1]			:= ZAS->ZAS_PERIODO
		aCols[nCont][nPosDtIni]	:= ZAS->ZAS_DTINI
		aCols[nCont][nPosDtFim]	:= ZAS->ZAS_DTFIM
		aCols[nCont][nPosDtgov]	:= ZAS->ZAS_DTGOVE
		aCols[nCont][nPosDtnor]	:= ZAS->ZAS_DTNORM
//		aCols[nCont][nPosStatus]:= ZAS->ZAS_STATUS
		aCols[nCont][nUsado+1]	:= .F.

		nCont++	
		dbSkip()

	EndDo	
ElseIf nOpc == 3				// Inclusao
	AADD(aCols,Array(nUsado+1))     
	dbSelectArea("Sx3")
	dbSetOrder(1)
	dbSeek("ZAS")
	nUsado:=0
	While !EOF() .And. (x3_arquivo == "ZAS")
		IF X3USO(x3_usado) .and. cNivel >= x3_nivel
			If Trim(X3_CAMPO) != "ZAS_EXERC" .And. Trim(X3_CAMPO) != "ZAS_CALEND" .And. Trim(X3_CAMPO) != "ZAS_DESCD"
				nUsado++
				IF x3_tipo == "C"
					IF ExistIni(X3_CAMPO)
						aCOLS[1][nUsado]:=InitPad(SX3->X3_RELACAO)
					ELSE
						aCOLS[1][nUsado]:=SPACE(x3_tamanho)
					EndIF
				ELSEIF x3_tipo == "N"
					aCOLS[1][nUsado] := 0
				ELSEIF x3_tipo == "D"
					aCOLS[1][nUsado] := CTOD("  /  /  ")
				ELSEIF x3_tipo == "M"
					aCOLS[1][nUsado] := ""
				ELSE
					aCOLS[1][nUsado] := .F.
				ENDIF
				If x3_context == "V"
						aCols[1][nUsado] := CriaVar(allTrim(x3_campo))
				Endif	
			ENDIF
		EndIf	
		dbSkip()
	EndDo
	aCols[1][nUsado+1]	:= .F.
	aCols[1][1]		:= "01"
EndIf

RestArea(aSaveArea)
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CiataGrav³ Autor ³ Rubens Simi   ³ Data ³ 17.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava as datas do calendario contabil                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³CiataGrava(nOpc,cExerc,cCalendZAS)  	                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum		                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³	ExpN1 = Opcao escolhida do menu (Inclusao / Alteracao..)  ³±±
±±³          ³	ExpC1 = Exercicio Contabil -> Ano                         ³±±
±±³          ³  ExpC2 = Calendario Contabil escolhido                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

static function CiataGrava(nOpc,cExerc,cCalendZAS)

Local aSaveArea := GetArea()
Local nCont
Local lExclui   := .T.
Local lPergCTE	:= .T.
Local lDelCTE	:= .F.
Local cStatusAnt:= ""

If nOpc == 3 .Or. nOpc == 4			// Inclusao / Alteracao
	dbSelectArea("ZAS")
	dbSetOrder(1)
	For nCont := 1 To Len(aCols)
		If aCols[nCont][nUsado+1] == .F.
			If !dbSeek(xFilial()+cCalendZAS+cExerc+aCols[nCont][1])
				RecLock("ZAS",.T.)
				Replace ZAS_FILIAL	With xFilial()
				Replace ZAS_CALEND 	With cCalendZAS
				Replace ZAS_EXERC		With cExerc
				Replace ZAS_PERIODO	With aCols[nCont][1]
			Else
				RecLock("ZAS",.F.)
			EndIf
			//Guarda o status anterior do resgistro do calendário
//			cStatusAnt := ZAS_STATUS
			
			Replace ZAS_DTINI		With aCols[nCont][nPosDtIni]
			Replace ZAS_DTFIM		With aCols[nCont][nPosDtFim]
			Replace ZAS_DTGOVE	With aCols[nCont][nPosDtGOV]
			Replace ZAS_DTNORM	With aCols[nCont][nPosDtNOR]
//			Replace ZAS_STATUS	With aCols[nCont][nPosStatus]
			MsUnlock()
		
		
		Else
			If lExclui
					RecLock("ZAS",.F.,.T.)
					dbDelete()
					MsUnlock()
				EndIf
				lExclui := .T.
			
		EndIf
	Next nCont
ElseIf nOpc == 5				// Exclusao
				dbSelectArea("ZAS")
				dbSeek(xFilial()+cCalendZAS+cExerc)
				ZAS->(DbEval( { || RecLock("ZAS",.F.,.T.),;
				dbDelete()            ,;
				MsUnlock() },,;
				{ || xFilial() == ZAS->ZAS_FILIAL .And.;
				cCalendZAS == ZAS->ZAS_CALEND   .AND.;
				cExerc == ZAS->ZAS_EXERC }))
		
EndIf

RestArea(aSaveArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CT010Calen³ Autor ³ Rubens Simi   ³ Data ³ 17.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Validacao do cadastro do calendario contabil               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Ct010Calen(nOpc,cExerc,cCalendZAS)  	                 	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T. / .F.		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Calendario Contabil Escolhido                      ³±±
±±³          ³ ExpN1 = Opcao do Menu escolhida (Inclusao / Alteraca..)    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
static Function Ct010Calend(cCalendZAS,nOpc)

Local lRet 		:= .T.
Local aSaveArea := GetArea() 

If nOpc == 3		// Inclusao
	dbSelectAREA("ZAS")
	dbSetOrder(1)
	If dbSeek(xFilial()+cCalendZAS)
		Help(" ",1,"JAEXISCALE")
		lRet := .F.
	EndIf
ElseIf nOpc == 4	// Alteracao
	dbSelectAREA("ZAS")
	dbSetOrder(1)
	If !dbSeek(xFilial()+cCalendZAS)
		Help(" ",1,"NOEXISCALE")
		lRet := .F.
	EndIf	
EndIf

RestArea(aSaveArea)

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CT010LinOK³ Autor ³ Rubens Simi   ³ Data ³ 17.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida a linha da getdados                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Ct010LinOk()												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T./.F.  		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
static Function Ct010LinOK()

Local lRet := .T.

If !aCols[n][nUsado+1]
	If Empty(aCols[n][nPosDtIni]) .Or. Empty(aCols[n][nPosDtFim])
		Help(" ",1,"C010EMPTY")
		lRet := .F.
	EndIf	
EndIf		

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CT010TudOK³ Autor ³ Rubens Simi   ³ Data ³ 17.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida a getdados completa                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Ct010TudOk()			                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T./.F.  		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
static Function Ct010TudOK(nOpc)

Local aSaveArea:= GetAREA()
Local lRet		:=	.T.
Local nCont
Local nLenCols	:= Len(aCols)
Local dLastData
Local lCT010TOK := ExistBlock( "CT010TOK" )

For nCont := 1 To nLenCols
	If !Ct010LinOK()
		lRet := .F.
		Exit
	EndIf
Next nCont

//// VALIDACAO DE INTERVALO COM LINHAS DELETADAS
For nCont := 1 to nLenCols
	If !aCols[nCont][nUsado+1]
		If nCont > 1 .and. ValType(dLastData) == "D"
			If aCols[nCont][nPosDtIni] <> dLastData+1
				Help(" ",1,"CT010DIAS")
				lRet := .F.
				Exit
			Endif
		Endif
		dLastData := aCols[nCont][nPosDtFim]
	EndIF
Next


RestArea(aSaveArea)

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Ct010Datas ³ Autor ³ Pilar S Albaladejo   ³ Data ³ 17/07/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica se data inicial eh maior que data final           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Ct010Datas()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T. / .F.		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³    		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
static Function Ct010Datas()

Local aSaveArea	:= GetArea()
Local lRet		:= .T.
Local dDataFim	:= &(ReadVar())

If aCols[n][nPosDtIni] > dDataFim
	Help(" ",1,"CT010DATAS")
	lRet := .F.
EndIf

RestArea(aSaveArea)

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Ct010DtIni ³ Autor ³ Pilar S Albaladejo   ³ Data ³ 17/07/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica se data final do periodo anterior eh menor do que ³±±
±±³          ³ a data inicial do periodo seguinte.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Ct010DtIni()		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T. / .F.		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³    		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
static Function Ct010DtIni()

Local lRet 		:= .T.
Local aSaveArea := GetArea()
Local dDataIni	:= &(ReadVar())
Local nAntCols  := n-1

If VALTYPE(n) != "N" .OR. n == 1
	lRet := .T.
Else
	If aCols[nAntCols][nPosDtFim] > dDataIni .or. aCols[nAntCols][nPosDtFim]-dDataIni = 0
		Help(" ",1,"CT010DTINI")
		lRet := .F.
	EndIf
	If lRet	
	If (dDataIni - aCols[nAntCols][nPosDtFim]) > 1
			Help(" ",1,"CT010DIAS")
			lRet := .F.
		EndIf
	EndIf
EndIf			

RestArea(aSaveArea)
Return lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Ct010DgCod ³ Autor ³ Lucimara Soares      ³ Data ³ 10/12/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Força o código do calendário a possuir três dígitos.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Ct010DgCod() 	                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T. / .F.		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³    		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

static Function Ct010DgCod(cCalendZAS,oCalendZAS)

cCalendZAS := STRZERO(Val(cCalendZAS),3)

oCalendZAS:Refresh()

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MenuDef   ³ Autor ³ Paulo Carnelossi      ³ Data ³07/03/07  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Utilizacao de menu Funcional                               ³±±     
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Array com opcoes da rotina.                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Parametros do array a Rotina:                               ³±±
±±³          ³1. Nome a aparecer no cabecalho                             ³±±
±±³          ³2. Nome da Rotina associada                                 ³±±
±±³          ³3. Reservado                                                ³±±
±±³          ³4. Tipo de Transa‡„o a ser efetuada:                        ³±±
±±³          ³		1 - Pesquisa e Posiciona em um Banco de Dados         ³±±
±±³          ³    2 - Simplesmente Mostra os Campos                       ³±±
±±³          ³    3 - Inclui registros no Bancos de Dados                 ³±±
±±³          ³    4 - Altera o registro corrente                          ³±±
±±³          ³    5 - Remove o registro corrente do Banco de Dados        ³±±
±±³          ³5. Nivel de acesso                                          ³±±
±±³          ³6. Habilita Menu Funcional                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MenuDef()

Local aRotina 	:= {	{ OemToAnsi("Pesquisar"),"AxPesqui", 0 , 1,,.F.},;	 //"Pesquisar"
						{ OemToAnsi("Visualizar"),"u_CiataCal", 0 , 2},;  //"Visualizar"
						{ OemToAnsi("Incluir"),"u_CiataCal", 0 , 3},;  //"Incluir"
						{ OemToAnsi("Alterar"),"u_CiataCal", 0 , 4},;  //"Alterar"
						{ OemToAnsi("Excluir"),"u_CiataCal", 0 , 5} }  //"Excluir"




Return(aRotina)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CiataWzDt   ºAutor  ³William Pires    º Data ³  15/08/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica se a data inicial e maior que a data final no     º±±
±±º          ³ assistente para inclusao de calendario contabil            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bloco bNext da funcao ZASWizard (ZASXFUNA)                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CiataWzDt(aDatas)

Local lRet := .T.

Default aDatas := {}

If Len(aDatas) > 1

	If Empty(aDatas[1]) .OR. Empty(aDatas[2])
		Help(" ",1,"C010EMPTY")
		lRet := .F.
	Else
		If aDatas[1] > aDatas[2]
			Help(" ",1,"CT010DATAS")
			lRet := .F.
		EndIf
	EndIf
	
EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CiataPer   ºAutor  ³Microsiga         º Data ³  30/07/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela para digitação do periodos inicial / final no         º±±
±±º          ³ assistente para inclusao de calendario contabil            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CiataPer(oDlg, aDatas)
Local aParam := {	{ 1 ,"Data inicial", aDatas[1] ,"@D" 	 ,""  ,"" ,".T." ,65 ,.T. }, ; //"Data inicial"
					{ 1 ,"Data final", aDatas[2] ,"@D" 	 ,""  ,"" ,".T." ,65 ,.T. } } //"Data final"

Default aDatas := {dDataBase, dDataBase+90 }

ParamBox(aParam ,"Periodo", aDatas,,,.F.,120,3, oDlg)    //"Periodo"

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CiataTPer  ºAutor  ³Microsiga         º Data ³  30/07/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela para selecionar tipo do periodos no assistente para   º±±
±±º          ³ inclusao de calendario contabil                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CiataTPer(oDlg, aTpPer)
Local aOpcoes := { "1=Semanal",;  //"1=Semanal"
				    "2=Decendial",;
					"3=Quinzenal",;  //"2=Quinzenal"
					"4=Mensal",;  //"3=Mensal"
					"5=Bimestral",;  //"4=Bimestral"
					"6=Semestral",;  //"5=Semestral"
					"7=Anual",;  //"6=Anual"
					"8=Diario",;  //"7=Diario"
					"9=trimestral";   //"8=trimestral"
				}
Local aParametros  := { {3,"Selecione Tipo de Periodo",aTpPer[1],aOpcoes,160,,.F.} }  //"Selecione Tipo de Periodo"
Default aTpPer 		:= {3}  

ParamBox(aParametros ,"Tipo de Periodo", aTpPer,,,.F.,120,aTpPer[1], oDlg)   //"Tipo de Periodo"

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CiataGrd   ºAutor  ³Microsiga         º Data ³  30/07/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela para apresentacao dos periodos no assistente para     º±±
±±º          ³ inclusao de calendario contabil                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CiataGrd(oDlg, o_GetD, aDatas, aTpPer)
Local aPerAux  := {}
Local aPeriodo := {}
Local nCont
Local nInicio := 1  

	aPeriodo := u_RetPer(aDatas[1], aDatas[2], Str(aTpPer[1],1,0), .F., aPerAux)
	nPosDtIni	:= Ascan(aHeader,{|x|Alltrim(x[2]) = "ZAS_DTINI"})
	nPosDtFim	:= Ascan(aHeader,{|x|Alltrim(x[2]) = "ZAS_DTFIM"})
	nPosDtgov	:= Ascan(aHeader,{|x|Alltrim(x[2]) = "ZAS_DTGOVE"})
	nPosDtnor	:= Ascan(aHeader,{|x|Alltrim(x[2]) = "ZAS_DTNORM"})

	If Len(aCols) == 1
		aCols[1, 2] := STOD(aPerAux[1,1])
		aCols[1, 3] := STOD(aPerAux[1,2])
		nInicio := 2
	Else
		aCols := {}
	EndIf
	For nCont := nInicio TO Len(aPerAux)
		AADD(aCols,Array(nUsado+1))     
		aCols[nCont][1]				:= If( nCont<100,StrZero(nCont, Len(ZAS->ZAS_PERIODO)), Soma1(aCols[nCont-1,1]) )
		aCols[nCont][nPosDtIni]		:= STOD(aPerAux[nCont,1])
		aCols[nCont][nPosDtFim]		:= STOD(aPerAux[nCont,2])
        aCols[nCont][nPosDtgov]		:= STOD("  /  /    ")
        aCols[nCont][nPosDtnor]		:= STOD("  /  /    ")
		aCols[nCont][nUsado+1]		:= .F.
	Next
	If ValType(o_GetD)!="O"
		o_GetD := MSGetDados():New(0,0,154,70,4,"Ct010LinOK","Ct010TudOK","+ZAS_PERIOD",,,,,9999,,,,,oDlg)
		o_GetD:oBrowse:Align := CONTROL_ALIGN_TOP
	Else
		o_GetD:SetArray(aCols)
		o_GetD:oBrowse:Refresh()
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CiataHead  ºAutor  ³Microsiga         º Data ³  30/07/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela para finalizacao do assistente para inclusao de       º±±
±±º          ³ calendario contabil                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CiataHead(oDlg, aDadCalen)
Local aParam := {	{ 1 ," Codigo Calendario"		, aDadCalen[1] 	,"@!" 	 ,""  ,"" ,".T." ,65 ,.T. }, ; 
					{ 1 ,"Ano"	 	, aDadCalen[2]	,"@!" 	 ,""  ,"" ,".T." ,65 ,.T. } }  
				   //	{4,"",aDadCalen[4]	,"Amarrar Calendario com Moedas"		,165,.F.,.F.} }  

ParamBox(aParam ,"Periodo", aDadCalen,,,.F.,120,3, oDlg)  //"Periodo"

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CiataTree  ºAutor  ³Microsiga         º Data ³  30/07/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta Tree na dialog informada com os dados fornecidos     º±±
±±º          ³ calendario contabil                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CiataTree(oDlg, aDados)
Local oTree
Local oPanel

oPanel := TScrollBox():New( oDlg, 005, 005, oDlg:nClientHeight,oDlg:nClientWidth,.T.,.T.,.T.)
oPanel:Align := CONTROL_ALIGN_ALLCLIENT

//------------------------------------------------------------------------------------------//
//CRIACAO DA ARVORE
//------------------------------------------------------------------------------------------//
oTree:= Xtree():New(005,005,oPanel:nClientHeight,oPanel:nClientWidth,oPanel)

CiataNode(oTree, aDados)

Return(oTree)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CiataNode  ºAutor  ³Microsiga         º Data ³  30/07/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta nodes na Tree da dialog informada com os dados       º±±
±±º          ³ fornecidos calendario contabil                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CiataNode(oTree, aDados, lEndTree)
Local nX

Default lEndTree := .T.

For nX := 1 TO Len(aDados)

	oTree:AddTree	( aDados[nX,1],; //descricao do node //
						"IndicatorCheckBox", ; //bitmap fechado
						"IndicatorCheckBoxOver",; //bitmap aberto
						aDados[nX,2], ;  //cargo (id)
						,;//bAction - bloco de codigo para exibir
						aDados[nX,3] ; 
					)
					
	If Len(aDados[nX]) > 3
		CiataNode(oTree, aDados[nX,4])
	EndIf
	
	If lEndTree
		oTree:EndTree()
	EndIf
	
Next	

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CiataLayer ºAutor  ³Microsiga         º Data ³  30/07/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta layer para exibicao dos dados                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CiataLayer(oDlg,aColumns,aWindows)
Local oFWLayer, oWin
Local nX, nY


// Cria instancia do fwlayer
oFWLayer := FWLayer():New()

// Inicializa componente passa a Dialog criada, 
// o segundo parametro é para criação de um botao de fechar utilizado para Dlg sem cabeçalho
oFWLayer:init( oDlg, .T. )

For nX := 1 To Len(aColumns)
	// Adiciona coluna passando nome, porcentagem da largura, e se ela é redimensionada ou não
	oFWLayer:addCollumn( "Col"+StrZero(nX,1), 1/Len(aColumns)*100, .T. )

	For nY:=1 TO Len(aWindows[nX])
		// Cria windows passando, nome da coluna onde sera criada, nome da window
		// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,
		// se é redimensionada em caso de minimizar outras janelas e a ação no click do split
		oFWLayer:addWindow( "Col"+StrZero(nX,1), "Win"+StrZero(nX,1)+StrZero(nY,1), aWindows[nX,nY,1], 100/Len(aWindows[nX]) , .F., .T., aWindows[nX,nY,2],,)
		oWin := oFWLayer:getWinPanel('Col'+StrZero(nX,1),'Win'+StrZero(nX,1)+StrZero(nY,1))
      	aWindows[nX,nY,3] := oWin
	Next

Next

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TreeVisual  ºAutor  ³Microsiga         º Data ³  30/07/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ axvisual para exibicao dos cadastros                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TreeVisual(oTree,cAlias,cSeek,lSeek)
Local aArea := GetArea()
Local oDlg

Default lSeek := .T.

DEFINE MSDIALOG oDlg TITLE OemToAnsi("Calendario Contabil") FROM 9,0 TO 23,80 OF oMainWnd //"Calendario Contabil"

If lSeek
	If oTree == NIL
		cAlias := If(cAlias == NIL, Alias(), cAlias)
		cSeek := If(cSeek == NIL, "", cSeek)
	Else
		cAlias := If(cAlias == NIL, Left(oTree:GetCargo(),3), cAlias)
		cSeek := If(cSeek == NIL, Substr(oTree:GetCargo(),4), cSeek)
	EndIf
	dbSelectArea(cAlias)
	If dbSeek(xFilial()+cSeek)
		axVisual(Alias(),Recno(),2,,,,,,.F./*lMaximized*/,,.T.,oDlg,,,,,)
	EndIf
Else
	axVisual(Alias(),Recno(),2,,,,,,.F./*lMaximized*/,,.T.,oDlg,,,,,)
EndIf

ACTIVATE MSDIALOG oDlg CENTERED

RestArea(aArea)

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PcoRetPer ºAutor  ³Microsiga           º Data ³  11/30/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que retorna array contendo os periodos a serem or-  º±±
±±º          ³ çados na planilha orçamentaria, baseado no campo AK1_TPPERIº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PCOA100                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
user Function RetPer(dIniPer, dFimPer, cTipoPer, lAcumul, aPerAux)
Local aRetPer   := {}
Local dIni
Local dx
Local nx
Local bWhile


If cTipoPer == "8"
	bWhile := {|| dx <= dFimPer }
Else
	bWhile := {|| dx < dFimPer }
EndIf

Do Case
	Case cTipoPer == "1"  //SEMANAL
		dIni := dIniPer
		If DOW(dIniPer)<>1
			dIni -= DOW(dIniPer)-1
		EndIf   
			Case cTipoPer == "2"  //Decendial
		If DAY(dIniPer) <= 10
			dIni := FirstDay(dIniPer)
		Else
			dIni := CTOD("12/"+Str(Month(dIniPer),2,0)+"/"+Str(Year(dIniPer),4,0))
		EndIf
		
	Case cTipoPer == "3"  //QUIZENAL
		If DAY(dIniPer) <= 15
			dIni := FirstDay(dIniPer)
		Else
			dIni := CTOD("16/"+Str(Month(dIniPer),2,0)+"/"+Str(Year(dIniPer),4,0))
		EndIf
	Case cTipoPer == "5"		//BIMESTRAL
		dIni := CTOD("01/"+Str((Round(MONTH(dIniPer)/2,0)*2)-1,2,0)+"/"+Str(Year(dIniPer),4,0))
	Case cTipoPer == "6"   //SEMESTRAL
		dIni := CTOD("01/"+IIf(MONTH(dIniPer)<=6,'01','07')+"/"+Str(Year(dIniPer),4,0))
	Case cTipoPer == "7"   //ANUAL
		dIni := CTOD("01/01/"+Str(Year(dIniPer),4,0))
	Case cTipoPer == "8"   //PERIODO (DT INICIAL A DT FINAL)
		dIni := dIniPer		
	Case cTipoPer == "9"   //TRIMESTRAL
		dIni := CTOD("01/"+StrZero(MONTH(dIniPer),2,0)+"/"+StrZero(YEAR(dIniPer),4,0))
	OtherWise
		dIni := CTOD("01/"+StrZero(MONTH(dIniPer),2,0)+"/"+StrZero(YEAR(dIniPer),4,0))
EndCase

dx := dIni

While Eval(bWhile)
	aAdd(aRetPer,Padr(DTOC(dx),10))
	aAdd(aPerAux,{ DTOS(dx), NIL })
	Do Case
		Case cTipoPer == "1"
			dx += 7
		Case cTipoPer == "2"
			If DAY(dx) == 01
				dx        := CTOD("11/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
			Else
			    if MONTH(dx+11)>MONTH(dx)
				 	dx:=CTOD(alltrim(str(Last_Day( dx )))+"/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
				 	dx+=1
				else
					dx += 10
			    endif
			EndIf
	
	
	
	
		Case cTipoPer == "3"
			If DAY(dx) == 01
				dx        := CTOD("15/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
			Else
				dx += 35
				dx        := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
			EndIf
		Case cTipoPer == "4"
			dx += 35      
			dx        := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
		Case cTipoPer == "5"
			dx += 62
			dx        := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
		Case cTipoPer == "6"
			dx += 185
			dx        := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
		Case cTipoPer == "7"
			dx += 370
			dx        := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
		Case cTipoPer == "8"
			dx += 1
		Case cTipoPer == "9"
			dx += 93
			dx        := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
	EndCase
    aRetPer[Len(aRetPer)] += " - "+Padr(DTOC(dx-1),10)
	aPerAux[Len(aRetPer), 2] := DTOS(dx-1)
End

If lAcumul
	dIniPer := Subs(aRetPer[1], 1, 8)
	For nx := 1 to Len(aRetPer)
		aRetPer[nx] := dIniPer + Subs(aRetPer[nx], 9)
		aPerAux[nx] := { aPerAux[1, 1], aPerAux[nx, 2]}
	Next
EndIf

Return aRetPer

