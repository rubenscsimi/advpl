#INCLUDE "rwmake.ch"
#include "TOTVS.CH"
#INCLUDE "PROTHEUS.CH"
#Include "COLORS.ch"
#include "MSGRAPHI.CH"
#Include "tbiconn.ch"
#Include "AP5MAIL.CH"
#INCLUDE "DBTREE.CH"
#INCLUDE "msole.ch"
#DEFINE F_BLOCK 1024 //Define o bloco de Bytes a serem lidos
#DEFINE INTERACTIONS 100000

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณOpenFtp     บAutor  ณMicrosiga           บ Data ณ  11/28/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ fun็ao utilizada para dos arquivos no FTP                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
user Function abreftp(cOrig,cDest,cTipo,cEst,Lbarra)        	

Local aFiles := {} 
Local nX


if Lbarra
	aFiles := Directory(cOrig)
else
	aFiles := Directory(cOrig+"\*."+cEst)
endif

IF LEN(aFiles)>0 .and. Lbarra
	IF FILE(cDest+'\'+aFiles[1][1])
		Alert("arquivo jแ Processado!, Operacao cancelada!")
		aFiles:={}
		AADD(aFiles,{,,,,.f.}) 
		return(aFiles)
	endif
endif

 

For nX := 1 to len(aFiles  ) 
  if Lbarra
   CpyT2S( cOrig, cDest, .F. )   
   FERASE(cOrig)

   ELSE
   CpyT2S( cOrig+'\'+aFiles[nx][1], cDest, .F. )   
   FERASE(cOrig+'\'+aFiles[nx][1])
   ENDIF
   
Next nX


IF LEN(aFiles)=0
	AADD(aFiles,{,,,,.f.}) 
u_ConsoleLog('arquivo '+cTipo+' Nใo localizado para importa็ใo','Favor Verificar parametros de origem ou ser o arquivo foi enviado por FTP!')
	
ELSE
	FOR NX:=1 TO Len(aFiles)
		aFiles[nx][5]:=.t.
	next
ENDIF
 
	
		
	
Return (aFiles)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณlerArq     Autor  ณMicrosiga           บ Data ณ  11/28/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ faz a leitura do arquivo tx e retorna as informacoes      บฑฑ
ฑฑบ          ณ em um array                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

	
user function lerArq(_caminho,cDelimit)

local cBuffer    	:= SPACE(F_BLOCK)
Local nHOrigem 		:= 0
Local nBytesLidos	:= 0
local nBytesFalta	:= 0
local nTamArquivo	:= 0
Local nBytesLer		:= 0
local aReturn		:={}


if !FILE(_caminho)  //valida a existencia do arquivo
	return({})
endif

 
FT_FUSE(_caminho)
FT_FGOTOP()
While !FT_FEOF()
 
//Tratamento para linhas com tamanho superior a 1020 Bytes
	If ( Len(FT_FREADLN()) < 1023 )
	cLinha	:= FT_FREADLN()                                       	
Else
	cLinha	:= ""
	While .T.
		/*Verifica se encontrou o final da linha.*/
		If ( Len(FT_FREADLN()) < 1023 )
			cLinha += FT_FREADLN()
			Exit
		Else
			cLinha += FT_FREADLN()
			FT_FSKIP()
		EndIf
	EndDo
EndIf
 

		AADD(aReturn,SEPARA(cLinha,cDelimit,.T.))
	
 
	FT_FSKIP()
EndDo


Return(aReturn)    



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณConsoleLogบAutor  ณRubens Simi           บ Data ณ  12/17/13 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function ConsoleLog(cTipo,aMsg)

local cArqTxt := "\SYSTEM\LogRapid\Log_"+StrTran(dtoc(dDatabase),"/")+'_'+StrTran(time(),":")+".TXT"
local nHdl := 0

IF !EXISTDIR("\SYSTEM\LogRapid")
	Makedir("\SYSTEM\LogRapid")
endif

//Verifica se o arquivo existe

if !file(cArqTxt)
	nHdl := fCreate(cArqTxt) 
	else
	
	
endif


	if nHdl == -1
		Return
	Endif
	
	if nHdl <> -1
		cLin := "" + CRLF
		cLin += "----------------------------Log Eventos "+ dtoc(date()) + " as " + time() + "-------------------------------" + CRLF
		cLin += " Tipo: " + cTipo + CRLF
		if fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			Return(.F.)
		endif
		
		If !fClose(nHdl)
			RETURN()
		EndIf
		
		
		// Abre o arquivo de Origem
		nHdl := fOpen(cArqTxt,1)
		// Testa a abertura do Arquivo
		If nHdl == -1
			Return .F.
		Endif
		If ctipo="LOG DE INCONSISTENCIA DO R2"
			
			for nx:=1 to len(aMsg)
				cLin:=''
				cLin+='ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ'+ CRLF
				cLin+=''+ CRLF
				cLin+='Tipo de Arquivo        :'+aMsg[nx][7]+ CRLF 
				cLin+='Tipo de Inconsistencia :'+if (aMsg[nx][1]=='D',"Valor com diferen็a ","Registro nao Localizado ")+ CRLF
				cLin+='Codigo Iata 			 :'+aMsg[nx][2]+ CRLF
				cLin+='Data 					 :'+aMsg[nx][3]+ CRLF
				cLin+='Valor R2				 :'+Transform(aMsg[nx][4], "@E 999,999.99")+ CRLF
				cLin+='Valor Rapid			 :'+Transform(aMsg[nx][5], "@E 999,999.99")+ CRLF
				cLin+='Obs. 					 :'+aMsg[nx][6]+CRLF
				cLin+=''+ CRLF
				cLin+='ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ'+ CRLF
				cLin+=''+ CRLF
				
				fSeek(nHdl,0,2)
				//Grava no arquivo texto
				if fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
					Return(.F.)
				endif
				
			
						
			next nx
		else
			
			for nx:=1 to len(aMsg)
				cLin:=''
				cLin += " Msg: " + aMsg[nx][1] + CRLF
				
				fSeek(nHdl,0,2)
				//Grava no arquivo texto
				if fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
					Return(.F.)
				endif
				
				
			next nx
		endif
		
		cLin:=''
		cLin += "----------------------------Finalizado "+ dtoc(date()) + " as " + time() + "--------------------------------" + CRLF
		cLin += "" + CRLF
		
		fSeek(nHdl,0,2)
		//Grava no arquivo texto
		if fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			Return(.F.)
		endif
		
		
		
		
		
		
		
		//Fecha o arquivo texto
		
		If !fClose(nHdl)
			RETURN()
		EndIf
		
ENDIF		
		u_enviamail(cArqTxt)

Return()  




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  enviamail  บAutor  ณRUBENS SIMI         บ Data ณ  16/12/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  ENVIO DE EMAIL COM ARQUIVO DE LOG       				  บฑฑ
ฑฑบ          ณ                                     						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
user Function enviamail(cArqTxt )






Local oMail , oMessage , nErro
Local lRet := .T.
local cPara:= 'rubens.c.simi@gmail.com'
Local cSMTPServer	:= 'smtp.qsdobrasil.com'//GetMV("MV_RELSERV",,"smtp.servername.com.br")
Local cSMTPUser		:= 'rubens.simi@qsdobrasil.com'//GetMV("MV_RELAUSR",,"minhaconta@servername.com.br")
Local cSMTPPass		:= 'rubens123'//GetMV("MV_RELAPSW",,"minhasenha")
Local cMailFrom		:= 'rubens.simi@qsdobrasil.com'//GetMV("MV_RELFROM",,"minhaconta@servername.com.br")
Local nPort	   		:= 587//GetMV("MV_GCPPORT",,587)
Local lUseAuth		:= .t.

local cMsg := "<hr>Erro na Integracao Rapid/R2 Vide arquivo Anexo<hr>"
local cCopia := ""

	MsgRun('Conectando com SMTP  '," ",{||oMail := TMailManager():New()})   
//conout('Conectando com SMTP ['+cSMTPServer+'] ')




MsgRun('Inicializando SMTP',"",{|| oMail:Init( '', cSMTPServer , cSMTPUser, cSMTPPass, 0, nPort  )})


MsgRun('Setando Time-Out',"",{||oMail:SetSmtpTimeOut( 30 )})


MsgRun('Conectando com servidor...',"",{||nErro := oMail:SmtpConnect()})


MsgRun('Status de Retorno = '+str(nErro,6),"",{||})


If lUseAuth
   MsgRun("Autenticando Usuario ["+cSMTPUser+"] senha ********* ","",{||nErro := oMail:SmtpAuth(cSMTPUser ,cSMTPPass)})
	
   MsgRun("Status de Retorno = '+str(nErro,6)","",{||})
	If nErro <> 0
		// Recupera erro ...
		cMAilError := oMail:GetErrorString(nErro)
		DEFAULT cMailError := '***UNKNOW***'
		Conout("Erro de Autenticacao "+str(nErro,4)+' ('+cMAilError+')')
		lRet := .F.
	Endif
Endif

if nErro <> 0
	
	// Recupera erro
	cMAilError := oMail:GetErrorString(nErro)
	DEFAULT cMailError := '***UNKNOW***'
	conout(cMAilError)
	
	Conout("Erro de Conexใo SMTP "+str(nErro,4))
	
	conout('Desconectando do SMTP')
	oMail:SMTPDisconnect()
	
	lRet := .F.
	
Endif

If lRet
	conout('Compondo mensagem em mem๓ria')
	oMessage := TMailMessage():New()
	oMessage:Clear()
	oMessage:cFrom	:= cMailFrom
	oMessage:cTo	:= cPara
	If !Empty(cCopia)
		oMessage:cCc	:= cCopia
	Endif
	oMessage:cSubject	:= cMsg
	oMessage:cBody		:= cMsg
	oMessage:AttachFile( cArqTxt ) 
	
	conout('Enviando Mensagem para ['+cPara+'] ')
	nErro := oMessage:Send( oMail )
	
	if nErro <> 0
		xError := oMail:GetErrorString(nErro)
		Conout("Erro de Envio SMTP "+str(nErro,4)+" ("+xError+")")
		lRet := .F.
	Endif
	
	conout('Desconectando do SMTP')
	oMail:SMTPDisconnect()
Endif 




Return(lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIMP()      บAutor  ณRUBENS SIMI         บ Data ณ  12/19/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ IMPORTACAO DO COD IATA PARA O SA1                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/



user function imp(cAlias)
 

aRquivo:=u_lerArq("\system\cadastro.csv",';')

dbselectarea(cAlias)
dbsetorder(1)

	nHdl := fCreate("\system\logrubens.txt")
	fClose(nHdl)
		       NY:=0  
		       NB:=0
for nx:=1 to len(aRquivo)
                                               
       	if dbseek(xfilial(cAlias)+aRquivo[nx][1]+aRquivo[nx][2])
         		RECLOCK(cAlias,.f.)
         		if cAlias=="SA2"
				 (cAlias)->A2_IATA:=alltrim(aRquivo[nx][3])
			    ELSE
			    (cAlias)->A1_IATA:=alltrim(aRquivo[nx][3])
			    
			    ENDIF
				MSUNLOCK()
				NY++
      	ELSE

			    nHdl:=	fOpen("\system\logrubens.txt",1)
				fSeek(nHdl,0,2)
				cLin := " Tipo: "+aRquivo[nx][1]+" - "+aRquivo[nx][2] + CRLF
				
				//Grava no arquivo texto
			    fWrite(nHdl,cLin,Len(cLin)) != Len(cLin) 
			    fClose(nHdl)
			    NB++
    	endif

next nx

ALERT("OK "+STR(NY)+" ER "+STR(NB))  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณcalciss    บAutor  ณrubens simi         บ Data ณ  04/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ calcular iss sobre o valor da comissao                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function   calcIss(cIata,nBaseIss)

Local lRndVlIss  := SuperGetMv("MV_RNDISS",.F.,.F.)
Local nVlMinIss  := SuperGetMv("MV_VRETISS",.F., 0)
Local nValorIss  :=0    
Local nPercIss   :=0 


  
 dbSelectArea("SA1")
 dbsetorder(9)
 IF  Dbseek(xfilial('SA1')+ cIata) 
                    // Obtem a aliquota de ISS da tabela FIM - Multiplos Vinculos de ISS
					DbSelectArea( "ZAA" )
					ZAA->( DbSetOrder( 1 ) )
					If ZAA->( DbSeek( xFilial( "ZAA" ) + SA1->A1_CODMUN ) )
						nPercIss := ZAA->ZAA_ALQISS
					EndIf
			

			
			If lRndVlIss
				nValorIss := Round(((nBaseIss) * nPercIss / 100),2)
			Else
				nValorIss := NoRound(((nBaseIss) * nPercIss / 100),2)
			EndIf  
ENDIF

			return(nValorIss)


 


 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAVIANCAXFUNบAutor  ณMicrosiga           บ Data ณ  05/05/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


user Function barra(cFunction,cArquivo)

PRIVATE oDlb         := Nil
PRIVATE nMeter       := 0
PRIVATE  oSay         := Nil
PRIVATE  oMeter       := Nil




Define Dialog oDlb Title "Processamento "+cArquivo From 0,0 To 75,400 Pixel

@05,05 Say oSay Prompt "Processamento "  Of oDlb Pixel Colors CLR_RED,CLR_WHITE Size 185,20

oMeter := TMeter():New(15,05,{|u|if(Pcount()>0,nMeter:=u,nMeter)},100,oDlb,175,20,,.T.)

Activate Dialog oDlb Centered On Init (&cFunction,oDlb:end())


Return





user function progresso(cIata,cdata,nVezes,nTotReg)

Local nCount              := nVezes


oSay:SetText("Processando Iata:"+alltrim(cIata)+" Data:"+cdata+" Processados: "+alltrim(str(nVezes))+' De: '+alltrim(str(nTotReg)))

		
		oMeter:Set(nCount)
		
		oDlB:CommitControls()   // Para atualizar a tela e o usuแrio receber o feedback


Return


USER Function VALORGL(cIatavld,cDatavld,cCcontaCart) 
       
local nValor:=0





cQuery := " SELECT ZA3_IATA,  "
cQuery += " (SELECT SUM(ZA3_VALOR)  FROM " + RetSqlName("ZA3")
cQuery += " WHERE ZA3_IATA='"+cIatavld+"' 
cQuery += " AND ZA3_DATA='"+cDatavld+" ' "
cQuery += " AND ZA3_FILIAL='"+xfilial('ZA3')+"'
cQuery += " AND ZA3_CONTA='"+cCcontaCart+"' "
cQuery += " AND ZA3_TPLAN='1' AND D_E_L_E_T_ = ' ') AS VALOR1, "

cQuery += " (SELECT SUM(ZA3_VALOR)  FROM " + RetSqlName("ZA3")
cQuery += " WHERE ZA3_IATA='"+cIatavld+"' 
cQuery += " AND ZA3_DATA='"+cDatavld+" ' "
cQuery += " AND ZA3_FILIAL='"+xfilial('ZA3')+"'
cQuery += " AND ZA3_CONTA='"+cCcontaCart+"' "
cQuery += " AND ZA3_TPLAN='2' AND D_E_L_E_T_ = ' ') AS VALOR2 "

cQuery += " FROM " + RetSqlName("ZA3")
cQuery += " WHERE ZA3_IATA='"+cIatavld+"' 
cQuery += " AND ZA3_DATA='"+cDatavld+" ' "
cQuery += " AND ZA3_FILIAL='"+xfilial('ZA3')+"'
cQuery += " AND ZA3_CONTA='"+cCcontaCart+"' GROUP BY ZA3_IATA"




cQuery := ChangeQuery( cQuery )
dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA3V", .F., .T. )
 
dbSelectArea("ZA3V")
dbgotop()  
            
              
		nValor:= ZA3V->VALOR1-ZA3V->VALOR2
		
ZA3V->(DbCloseArea())		    

         if nValor<0
             nValor:=nValor*-1
         endif
               
Return(nValor) 
