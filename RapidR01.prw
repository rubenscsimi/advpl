#include "rwmake.ch"
#include "protheus.ch" 
#INCLUDE "REPORT.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RAPIDR01  ºAutor  ³Microsiga           º Data ³  01/28/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function RapidR01()
	local oReport := nil
	Private cPerg := 'rapid1'
	
	AjustaSx1()   

 If (FindFunction( "TRepInUse" ) .And. TRepInUse()) 
	oReport := reportDef()
	oReport:printDialog()  
	else
	alert("Relatorio apenas gerado em R4")
	endif
Return                             




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RAPIDR01  ºAutor  ³Microsiga           º Data ³  01/28/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 
static function reportDef()
	local oReport
	Local oSection1
	Local oSection2
	local cTitulo := '[RapidR01] - Impressão de Movimentos RapidGl'
    Local aOrdem  :={"Data","Conta","Iata","Status","Voado"}                                                             
 
 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	oReport := TReport():New('RapidR01', cTitulo,cPerg , {|oReport| PrintReport(oReport)},"Este relatorio ira imprimir a relacao de movimentos do Rapid.")

 
	oSection1 := TRSection():New(oReport,"Rapid",{"QRY"},aOrdem,.f.,.f.)

 //TRCell():New(oParent,       cName,        cAlias,    cTitle,           cPicture,                         nSize,                 lPixel,          bBlock,                 cAlign,lLineBreak,cHeaderAlign,lCellBreak,nColSpace,lAutoSize,nClrBack,nClrFore,lBold)

	TRCell():new(oSection1, "ZA3_CONTA"	  	, "QRY", 'COD. CONTA'		,PesqPict('CT1',"CT1_CONTA")	,TamSX3("ZA3_CONTA")[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "CT1_DESC01"  	, "QRY", 'DESCRICAO' 		,PesqPict('CT1',"CT1_DESC01")	,TamSX3("CT1_DESC01")[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "ZA3_VALOR"	  	, "QRY", 'VALOR'	 		,PesqPict('SE1',"E1_VALOR") 	,TamSX3("ZA3_VALOR")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "ZA3_STAFIN"    , "QRY", 'FIN'  	,PesqPict('ZA3',"ZA3_STAFIN") 	,TamSX3("ZA3_STAFIN")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
   	TRCell():new(oSection1, "ZA3_STACTB"    , "QRY", 'CTB'  	,PesqPict('ZA3',"ZA3_STACTB") 	,TamSX3("ZA3_STACTB")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
    TRCell():new(oSection1, "ZA3_CHFIN"     , "QRY", 'TITULO FIN'   ,PesqPict('ZA3',"ZA3_CHFIN") 	,TamSX3("E2_PREFIXO")[1]+TamSX3("E2_NUM")[1]+TamSX3("E2_TIPO")[1]+13,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
    TRCell():new(oSection1, "ZA3_CHCTB"     , "QRY", 'REGISTRO CTB'   ,PesqPict('ZA3',"ZA3_CHCTB") 	,TamSX3("CT2_LOTE")[1]+TamSX3("CT2_SBLOTE")[1]+TamSX3("CT2_DOC")[1]+13,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
    TRCell():new(oSection1, "ZA3_DATA"      , "QRY", 'DATA'        ,PesqPict('ZA3',"ZA3_DATA") 	,10,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
    TRCell():new(oSection1, "ZA3_IATA"      , "QRY", 'IATA'        ,PesqPict('SA1',"A1_NOME") 	,50,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
    TRCell():new(oSection1, "ZA3_VOADO"     , "QRY", 'VOADO'        ,PesqPict('ZA3',"ZA3_VOADO") 	,TamSX3("ZA3_VOADO")[1],/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
 

oReport:SetLandScape()
oReport:DisableOrientation()

Return oReport

     
 
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RAPIDR01  ºAutor  ³Microsiga           º Data ³  01/28/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)
Local oSection := oReport:Section(1)
Local ncont       :=0
Local linha       :=0
Local cQuery
Local nOrdem     :=oSection:GetOrder()
             
Dbselectarea("SE1")
Dbselectarea("SE2")
Dbselectarea("CT2")

Pergunte( cPerg , .F. )

//If Select("QRY") > 0
  //	QRY->(dbCloseArea())
//Endif

cQuery := " SELECT * FROM " + RetSqlName("ZA3")
cQuery += " WHERE " 
cQuery += " ZA3_CONTA BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' AND "
cQuery += " ZA3_IATA  BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' AND "

IF MV_PAR07==1
cQuery += " ZA3_DATA  BETWEEN '"+DTOS(MV_PAR05)+"' AND '"+DTOS(MV_PAR06)+"' AND "
ELSE
cQuery += " ZA3_DTPROC  BETWEEN '"+DTOS(MV_PAR05)+"' AND '"+DTOS(MV_PAR06)+"' AND "
ENDIF          

DO CASE

CASE MV_PAR08==1
           
cQuery +=  "ZA3_ACFIN='CR' AND "

CASE MV_PAR08==2

cQuery +=  "ZA3_ACFIN='CP' AND "

CASE MV_PAR08==3

cQuery += "ZA3_ACFIN='' AND "

ENDCASE 


DO CASE

CASE MV_PAR09==1
           
cQuery +=  "ZA3_STATUS='E' AND "

CASE MV_PAR09==2

cQuery +=  " ZA3_STATUS='N' AND "

CASE MV_PAR09==3

cQuery += "ZA3_STATUS='I' AND  "

ENDCASE 


DO CASE

CASE MV_PAR10==1
           
cQuery +=  "ZA3_VOADO='PSJ' AND "

CASE MV_PAR10==2

cQuery +=  "ZA3_VOADO='PFJ' AND "

ENDCASE


cQuery += " D_E_L_E_T_ = ' ' " 

DO CASE
CASE nOrdem=1 .AND. MV_PAR07==1
cQuery += " ORDER BY ZA3_DATA,ZA3_LINHA"
CASE nOrdem=1 .AND. MV_PAR07==2
cQuery += " ORDER BY ZA3_DTPROC,ZA3_LINHA"
CASE nOrdem=2
cQuery += " ORDER BY ZA3_CONTA"
CASE nOrdem=3
cQuery += " ORDER BY ZA3_IATA"
CASE nOrdem=4
cQuery += " ORDER BY ZA3_ACFIN"                     
 
CASE nOrdem=5
cQuery += " ORDER BY ZA3_VOADO"  
ENDCASE


dbuseArea(.T.,"TopConn",TCGenQry(,,cQuery),"QRY",.F.,.F.)
QRY->( dbGoTop() )

 While !oReport:Cancel() .And. !QRY->(Eof()) 
    oSection:Init()
		oSection:Cell("ZA3_CONTA"):SetValue(QRY->ZA3_CONTA)
		oSection:Cell("ZA3_CONTA"):SetAlign("LEFT")

		oSection:Cell("CT1_DESC01"):SetValue(Posicione("CT1",1,xFilial("CT1")+QRY->ZA3_CONTA,"CT1_DESC01"))
		oSection:Cell("CT1_DESC01"):SetAlign("LEFT")

		oSection:Cell("ZA3_VALOR"):SetValue(QRY->ZA3_VALOR)
		oSection:Cell("ZA3_VALOR"):SetAlign("RIGHT")

 		
		oSection:Cell("ZA3_STACTB"):SetValue(QRY->ZA3_STACTB)
		oSection:Cell("ZA3_STACTB"):SetAlign("CENTER")   
	    
	     cAcao:= IF (!EMPTY(QRY->ZA3_ACFIN),'-'+QRY->ZA3_ACFIN,'')
	     
		oSection:Cell("ZA3_STAFIN"):SetValue(QRY->ZA3_STAFIN+ cAcao)
		oSection:Cell("ZA3_STAFIN"):SetAlign("CENTER") 
	
	
		oSection:Cell("ZA3_CHFIN"):SetValue(QRY->ZA3_CHFIN)
		oSection:Cell("ZA3_CHFIN"):SetAlign("LEFT") 
		
	  
		
		
		oSection:Cell("ZA3_CHCTB"):SetValue(QRY->ZA3_CHCTB)
		oSection:Cell("ZA3_CHCTB"):SetAlign("LEFT") 
		  
        oSection:Cell("ZA3_DATA"):SetValue(DTOCY(STOD(QRY->ZA3_DATA)))
		oSection:Cell("ZA3_DATA"):SetAlign("CENTER") 
		    
		   
		    
			cCliForn:=''
		    if !empty(QRY->ZA3_IATA)
		       cCliForn:=ALLTRIM(Posicione("SA1",9,xFilial("SA1")+QRY->ZA3_IATA,"A1_NOME"))
		       IF EMPTY(cCliForn)
		        cCliForn:=ALLTRIM(Posicione("SA2",10,xFilial("SA2")+QRY->ZA3_IATA,"A2_NOME"))
		       ENDIF 

		       IF EMPTY(cCliForn)
		       cCliForn:='Iata nao localizado'
                ELSE
               cCliForn:=ALLTRIM(QRY->ZA3_IATA)+'-'+cCliForn
		       ENDIF
		     endif  
		       
		   
		
	    oSection:Cell("ZA3_IATA"):SetValue(cCliForn)
		oSection:Cell("ZA3_DATA"):SetAlign("CENTER") 
   
	    oSection:Cell("ZA3_VOADO"):SetValue(QRY->ZA3_VOADO)
		oSection:Cell("ZA3_VOADO"):SetAlign("CENTER") 
	
		
				
		oSection:PrintLine()
 
		dbSelectArea("QRY")
		QRY->(dbSkip())
	EndDo
 
	QRY->(dbCloseArea())
Return               




/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³AjustaSx1  ³ Autor ³Rubens Simi       ³ Data ³ 28/01/14     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ajusta SX1            			          				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AjustaSx1()

Local aArea 	:= GetArea()
Local nTamConta := TamSX3("CT1_CONTA")[1]



aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Conta contabil Inicial' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'01','Conta contábil inicial ?','¿Cuenta contable inicial ?','Initial ledger account ?','MV_CH1','C',nTamConta,0,0,'G','','CT1','003','S','mv_par01','','','','','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)


aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Conta contabil Final' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'02','Conta contábil final ?','¿Cuenta contable final ?','Final ledger account ?','MV_CH2','C',nTamConta,0,0,'G','','CT1','003','S','mv_par02','','','','ZZZZZZZZZZZZZZZZZZZZ','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)



aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Cod Iata  Final' )  // fazer consulta padrao!!!!!!!!!!!!!!!!!!!!!!!!!
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'03','Cod Iata  Inicial ?','¿Cuenta contable final ?','Final ledger account ?','MV_CH3','C',7,0,0,'G','','IATA','003','S','mv_par03','','','','','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)



aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Cod Iata Final' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'04','Cod Iata final ?','¿Cuenta contable final ?','Final ledger account ?','MV_CH4','C',7,0,0,'G','','IATA','003','S','mv_par04','','','','ZZZZZZZ','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)

aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Data inicial do movimento' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, 	"05","Data de?"	,"¿De Adquisicion ? "  		,"Acquisition from ? "	,"mv_ch5","D",8,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)




aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Data Final do movimento' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, 	"06","Data até?"	,"¿A Adquisicion ? "   		,"Acquisition To ? "	,"mv_ch6","D",8,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)



aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Considera Data  do movimento ou integracao' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "07","Considera ?","¿Considera ?","Consider ?","mv_ch7","N",1,0,1,"C","","","","","MV_PAR07","Movimento","","","","Integracao","","",""	,"" ,"","","","","","","",aHelpPor,aHelpSpa,aHelpSpa)




aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Considera qual tipo de movimento' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "08","Tipo de Movi ?","","","mv_ch8","N",1,0,1,"C","","","","","MV_PAR08","Receber","","","","Pagar","","","Contabil"	,"" ,"","Todos","","","","","",aHelpPor,aHelpSpa,aHelpEng)

aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Considera qual Situação' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "09","Tipo de Sit ?","","","mv_ch9","N",1,0,1,"C","","","","","MV_PAR09","Inconsistente","","","","Não Integrados","","","Integrados"	,"" ,"","Todos","","","","","",aHelpPor,aHelpSpa,aHelpEng)


aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Tipo de Registros(voados,vendidos,todos)' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "10","Tipo de Reg?","","","mv_cha","N",1,0,1,"C","","","","","MV_PAR10","Voados","","","","Vendidos","","","Todos"	,"" ,"","","","","","","",aHelpPor,aHelpSpa,aHelpEng)


RestArea(aArea)

Return

