#INCLUDE "rwmake.ch"
#include "TOTVS.CH"
#INCLUDE "PROTHEUS.CH"
#Include "COLORS.ch"
#include "MSGRAPHI.CH"
#Include "tbiconn.ch"
#Include "AP5MAIL.CH"
#INCLUDE "DBTREE.CH"
#INCLUDE "msole.ch"




user Function LerDu()

PRIVATE oDlb        := Nil
PRIVATE nMeter      := 0
PRIVATE oSay        := Nil
PRIVATE oMeter      := Nil
private aMsg		:={}
private teste

///comentario



Define Dialog oDlb Title "Processamento " From 0,0 To 75,400 Pixel

@05,05 Say oSay Prompt "Processamento "  Of oDlb Pixel Colors CLR_RED,CLR_WHITE Size 185,20

oMeter := TMeter():New(15,05,{|u|if(Pcount()>0,nMeter:=u,nMeter)},100,oDlb,175,20,,.T.)

Activate Dialog oDlb Centered On Init (u_lerse1(oMeter),oDlb:end())


Return


user function lerse1(oMeter)

local cTpArq		:= "Delimitado (*.CSV)|*.CSV|"
local cOrig			:=cGetFile(cTpArq, , 0, "SERVIDOR\", .T., GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE)
local nErrado  :=0
Local nCerto   :=0
Local aArray   :={}

Local cMask   :=''
Local cTexto  :=''
Local cFile   :=''
Local cTexto2 :=''
Local cTexto1 :=''
Local dDataold :=dDatabase
private lMsErroAuto := .F.

aCarga:=u_lerArq(cOrig,';')



nTotReg:=len(aCarga)
oMeter:SetTotal(nTotReg)




for nx:=1 to len(aCarga)
	u_pro1(nx,nTotReg)
	
	//E1_FILIAL+  E1_CLIENTE+   E1_LOJA+      E1_PREFIXO+   E1_NUM+   E1_PARCELA      +E1_TIPO
	cChave:=aCarga[NX][1]+aCarga[NX][2]+aCarga[NX][3]+aCarga[NX][4]
	
	IF ALLTRIM(aCarga[NX][6])=='R'
		DBSELECTAREA('SE1')
		DBSETORDER(2)
		IF DBSEEK(XFILIAL('SE1')+cChave) .and. SE1->E1_VALOR==SE1->E1_SALDO .AND. ALLTRIM(SE1->E1_ORIGEM)=='RAPID'
		    nRecno:=se1->(recno())
			
			nValor:=val(aCarga[NX][5])
			
			nValold:=SE1->E1_VALOR
			
			dDatabase:=SE2->E2_EMISSAO
			
			aArrayIn := { { "E1_PREFIXO"  , SE1->E1_PREFIXO   , NIL },;
			{ "E1_NUM"      ,  SE1->E1_NUM		, NIL },;
			{ "E1_TIPO"     , SE1->E1_TIPO      , NIL },;
			{ "E1_NATUREZ"  , SE1->E1_NATUREZ  	, NIL },;
			{ "E1_CLIENTE"  , SE1->E1_CLIENTE   , NIL },;
			{ "E1_LOJA"     , SE1->E1_LOJA      , NIL },;
			{ "E1_EMISSAO"  , SE1->E1_EMISSAO   , NIL },;
			{ "E1_VENCTO"   , SE1->E1_VENCTO	, NIL },;
			{ "E1_VENCREA"  , SE1->E1_VENCREA	, NIL },;
			{ "E1_HIST"     , SE1->E1_HIST		, NIL },;
			{ "E1_IDCNAB"   , SE1->E1_IDCNAB	, NIL },;
			{ "E1_ORIGEM"   , SE1->E1_ORIGEM	, NIL },;
			{ "E1_VALOR"    , nValor      	 	, NIL } }
			
			
		  	    RECLOCK("SE1",.F.)
				SE1->(dbDelete())
				MSUNLOCK()

			
			
			MsExecAuto( { |x,y| FINA040(x,y)} , aArrayIn, 3)
			
			If 	!lMsErroAuto
				RECLOCK("SE1",.F.)
				E1_LA:="S" 
				MSUNLOCK()

			cTexto1+=aCarga[NX][1]+aCarga[NX][2]+aCarga[NX][3]+aCarga[NX][4]+' - Alterado de :'+TRANSFORM(nValold, "@E 999,999.99")+'  Para:'+TRANSFORM(nValor, "@E 999,999.99");
			 + CRLF	

			else 
			cquery := " update "+RetSqlName("SE1")+" SET  D_E_L_E_T_=' '  "
			cquery += " WHERE R_E_C_N_O_ ='"+alltrim(STR(nRecno))+"' "
			TCSQLEXEC(cQuery)
			
				FLAGTEMP( )
			endif
			
			
			lMsErroAuto := .F.
			
			
			nCerto++
			
		else
			nErrado++
			cTexto2+=aCarga[NX][1]+aCarga[NX][2]+aCarga[NX][3]+aCarga[NX][4]+' - Nao encontrado' + CRLF
		endif
		
		
		
	ELSE
		DBSELECTAREA('SE2')
		DBSETORDER(6)
		IF DBSEEK(XFILIAL('SE2')+cChave) .and. SE2->E2_VALOR==SE2->E2_SALDO .AND. ALLTRIM(SE2->E2_ORIGEM)=='RAPID'
			nRecno:=se2->(recno())
			

			nValor:=val(aCarga[NX][5])
			
			nValold:=SE2->E2_VALOR
			dDatabase:=SE2->E2_EMISSAO
			
			aArrayIn := { { "E2_PREFIXO"  , SE2->E2_PREFIXO   , NIL },;
			{ "E2_NUM"      , SE2->E2_NUM		, NIL },;
			{ "E2_TIPO"     , SE2->E2_TIPO      , NIL },;
			{ "E2_VENCTO"   , SE2->E2_VENCTO	, NIL },;
			{ "E2_NATUREZ"  , SE2->E2_NATUREZ   , NIL },;
			{ "E2_FORNECE"  , SE2->E2_FORNECE   , NIL },;
			{ "E2_LOJA"     , SE2->E2_LOJA      , NIL },;
			{ "E2_EMISSAO"  , SE2->E2_EMISSAO	, NIL },;
			{ "E2_HIST"     , SE2->E2_HIST	    , NIL },;
			{ "E2_ORIGEM"   , SE2->E2_ORIGEM	, NIL },;
			{ "E2_VENCREA"  , SE2->E2_VENCREA 	, NIL },;
			{ "E2_VALOR"    , nValor      		, NIL } }
			
			
			
			
		  	    RECLOCK("SE2",.F.)
				SE2->(dbDelete())
				MSUNLOCK()
			
			MsExecAuto( { |x,y,z| FINA050(x,y,z)}, aArrayIn,, 3)
			
			If 	!lMsErroAuto
				RECLOCK("SE2",.F.)
				E2_LA:="S"                                                                             
				
				MSUNLOCK()
				
				
			cTexto1+=aCarga[NX][1]+aCarga[NX][2]+aCarga[NX][3]+aCarga[NX][4]+' - Alterado de :'+TRANSFORM(nValold, "@E 999,999.99")+'  Para:'+TRANSFORM(nValor, "@E 999,999.99");
			 + CRLF	
			else         
			cquery := " update "+RetSqlName("SE2")+" SET  D_E_L_E_T_=' '  "
			cquery += " WHERE R_E_C_N_O_ ='"+alltrim(STR(nRecno))+"' "
			TCSQLEXEC(cQuery)
			
				FLAGTEMP( )
			endif
			
			
			lMsErroAuto := .F.
			
			nCerto++
			
		else
			nErrado++
			cTexto2+=aCarga[NX][1]+aCarga[NX][2]+aCarga[NX][3]+aCarga[NX][4]+' - Nao encontrado' + CRLF
		endif
		
		
		
		
	ENDIF
	
	
NEXT NX
dDatabase :=dDataold


cTexto+=" Total de Encontrados ->"+ALLTRIM(str(nCerto))+"  Total de Nโo encontrados->"+ALLTRIM(str(nErrado))+ CRLF
cTexto+='###############################################################################'+ CRLF
cTexto+=cTexto1
cTexto+='###############################################################################'+ CRLF
cTexto+=cTexto2

DEFINE FONT oFont NAME "Mono AS" SIZE 5,12   //6,15
DEFINE MSDIALOG oDlX TITLE "log de Resgistros" From 3,0 to 340,417 PIXEL //"Atualizacao concluida."
@ 5,5 GET oMemo  VAR cTexto MEMO SIZE 200,145 OF oDlX PIXEL
oMemo:bRClicked := {||AllwaysTrue()}
oMemo:oFont:=oFont

DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlX:End() ENABLE OF oDlX PIXEL //Apaga
DEFINE SBUTTON  FROM 153,145 TYPE 13 ACTION (cFile:=cGetFile(cMask,""),If(cFile="",.t.,MemoWrite(cFile,cTexto))) ENABLE OF oDlX PIXEL //Salva e Apaga //"Salvar Como..."


ACTIVATE MSDIALOG oDlX CENTER

return()


user function pro1(nVezes,nTotReg)

Local nCount              := nVezes


oSay:SetText(" Processados: "+alltrim(str(nVezes))+' De: '+alltrim(str(nTotReg)))


oMeter:Set(nCount)

oDlB:CommitControls()   // Para atualizar a tela e o usuแrio receber o feedback


Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFLAGTEMP   บAutor  ณRubens Simi       บ Data ณ  09/01/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ rotina para flag dos logs gerados pelos exacauto            ฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FLAGTEMP( )


Local cErroTemp	:=''
Local cCrLf   := Chr(13) + Chr(10)
Local cMsg :=''

IF !EXISTDIR("\SYSTEM\logMsexec")
	Makedir("\SYSTEM\logMsexec")
endif




cArqLOG 	:= StrTran(DTOC(dDataBase),"/","")+"_"+StrTran(Time(),":","")+".log"
cErroTemp	:=Mostraerro("\SYSTEM\logMsexec", cArqLOG)


cMsg+='ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ'+ cCrLf
cMsg+=''+ cCrLf
cMsg+=cErroTemp
cMsg+=''+ cCrLf
cMsg+='ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ'+ cCrLf
cMsg+=''+ cCrLf

aadd( aMsg,{cMsg}  )

Return()

