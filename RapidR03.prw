#include "rwmake.ch"
#include "protheus.ch" 
#INCLUDE "REPORT.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RAPIDR03  ºAutor  ³Microsiga           º Data ³  27/02/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ relatorio de movimento dos arquivos r2                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function RapidR03()
	local oReport := nil
	Private cPerg := 'rapid3'
	
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
	local cTitulo := '[RapidR03] - Impressão de Movimentos R2'
    Local aOrdem  :={"Data","Iata","Status","Tipo"}                                                             
 
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

	oReport := TReport():New('RapidR03', cTitulo,cPerg , {|oReport| PrintReport(oReport)},"Este relatorio ira imprimir a relacao de movimentos do R2.")

 
	oSection1 := TRSection():New(oReport,"R2",{"QRY"},aOrdem,.f.,.f.)

 //TRCell():New(oParent,       cName,        cAlias,    cTitle,           cPicture,                         nSize,                 lPixel,          bBlock,                 cAlign,lLineBreak,cHeaderAlign,lCellBreak,nColSpace,lAutoSize,nClrBack,nClrFore,lBold)

	TRCell():new(oSection1, "ZA7_TPARQ"	  	, "QRY", 'TP'	,PesqPict('ZA7',"ZA7_TPARQ")	,TamSX3("ZA7_TPARQ")[1]+1	,,,,,"CENTER" )
	TRCell():new(oSection1, "ZA7_DTARQ"  	, "QRY", 'DT PR' 	,PesqPict('ZA7',"ZA7_DTARQ")	,TamSX3("ZA7_DTARQ")[1]+1	,,,,,"CENTER" )
	TRCell():new(oSection1, "ZA7_DTPR2"  	, "QRY", 'DT R2' 	,PesqPict('ZA7',"ZA7_DTPR2")	,TamSX3("ZA7_DTPR2")[1]+1	,,,,,"CENTER" )
	TRCell():new(oSection1, "ZA7_IATA"	  	, "QRY", 'IATA'		,PesqPict('ZA7',"ZA7_IATA") 	,8							,,,,,"CENTER" )
	TRCell():new(oSection1, "SA1_NOME"      , "QRY", 'CLIENTE'  ,PesqPict('SA1',"A1_NOME")   	,TamSX3("A1_NOME")[1]+1		,,,,,"CENTER" )
   	TRCell():new(oSection1, "ZA7_HIST"      , "QRY", 'PERIODO'  ,PesqPict('ZA7',"ZA7_HIST") 	,TamSX3("ZA7_HIST")[1]+1	,,,,,"CENTER" )
    TRCell():new(oSection1, "ZA7_IDSOLU"    , "QRY", 'COD SOL' 	,PesqPict('ZA7',"ZA7_IDSOLU") 	,TamSX3("ZA7_IDSOLU")[1]+1	,,,,,"CENTER" )
    TRCell():new(oSection1, "ZA7_DSCSOL"    , "QRY", 'SOLUCAO'  ,PesqPict('ZA7',"ZA7_DSCSOL") 	,TamSX3("ZA7_DSCSOL")[1]+1	,,,,,"CENTER" )
    TRCell():new(oSection1, "ZA7_DTPG"      , "QRY", 'DT PAG'	,PesqPict('ZA7',"ZA7_DTPG") 	,TamSX3("ZA7_DTPG")[1]+1	,,,,,"CENTER" )
    TRCell():new(oSection1, "ZA7_VLBRUT"    , "QRY", 'VL BRU '  ,PesqPict('SE1',"E1_VALOR") 	,TamSX3("E1_VALOR")[1]+1	,,,,,"CENTER" )
    TRCell():new(oSection1, "ZA7_VALTXA"    , "QRY", 'VL TX'    ,PesqPict('SE1',"E1_VALOR") 	,TamSX3("E1_VALOR")[1]+1	,,,,,"CENTER" )
    TRCell():new(oSection1, "ZA7_VALLIQ"    , "QRY", 'VL LIQ'  	,PesqPict('SE1',"E1_VALOR") 	,TamSX3("E1_VALOR")[1]+1	,,,,,"CENTER" )
    TRCell():new(oSection1, "ZA7_STACTB"    , "QRY", 'STATUS'   ,PesqPict('ZA7',"ZA7_STACTB") 	,TamSX3("ZA7_STACTB")[1]+1	,,,,,"CENTER" )
    TRCell():new(oSection1, "ZA7_RECONC"    , "QRY", 'RECON.' 	,PesqPict('ZA7',"ZA7_RECONC") 	,TamSX3("ZA7_RECONC")[1]+1	,,,,,"CENTER" ) 
    TRCell():new(oSection1, "ZA7_CHCTB"     , "QRY", 'REG. CTB' ,PesqPict('ZA7',"ZA7_CHCTB") 	,TamSX3("CT2_LOTE")[1]+TamSX3("CT2_SBLOTE");
    [1]+TamSX3("CT2_DOC")[1]+13																								,,,,,"CENTER" )


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
             
Dbselectarea("SA1")
Dbselectarea("CT2")

Pergunte( cPerg , .F. )

If Select("QRY") > 0
	QRY->(dbCloseArea())
Endif

cQuery := " SELECT * FROM " + RetSqlName("ZA7")
cQuery += " WHERE " 
cQuery += " ZA7_IATA BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' AND "

IF MV_PAR05==1
cQuery += " ZA7_DTPR2  BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"' AND "
ENDIF

IF MV_PAR05==2
cQuery += " ZA7_DTARQ  BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"' AND "
ENDIF
IF MV_PAR05==3
cQuery += " ZA7_DTPG  BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"' AND "
ENDIF


DO CASE

CASE MV_PAR06==1
           
cQuery +=  "ZA7_TPARQ='02' AND "

CASE MV_PAR06==2

cQuery +=  "ZA7_TPARQ='03' AND "

CASE MV_PAR06==3

cQuery +=  "ZA7_TPARQ='04' AND "


ENDCASE 


DO CASE

CASE MV_PAR07==1
           
cQuery +=  "ZA7_STACTB='E' AND "

CASE MV_PAR07==2

cQuery +=  "ZA7_STACTB='I' AND  "

CASE MV_PAR07==3

cQuery +=  "ZA7_STACTB='' AND  "



ENDCASE 




cQuery += " D_E_L_E_T_ = ' ' " 
                


DO CASE
CASE nOrdem=1 .AND. MV_PAR05==1
cQuery += " ORDER BY ZA7_DTARQ,ZA7_LINHA"
CASE nOrdem=1 .AND. MV_PAR05==2
cQuery += " ORDER BY ZA7_DTPR2,ZA7_LINHA"
CASE nOrdem=1 .AND. MV_PAR05==3
cQuery += " ORDER BY ZA7_DTPG,ZA7_LINHA"
CASE nOrdem=2
cQuery += " ORDER BY ZA7_IATA"
CASE nOrdem=3
cQuery += " ORDER BY ZA7_IATA,ZA7_STACTB"
CASE nOrdem=4
cQuery += " ORDER BY ZA7_TPARQ,ZA7_IATA,ZA7_STACTB"
ENDCASE
dbuseArea(.T.,"TopConn",TCGenQry(,,cQuery),"QRY",.F.,.F.)
QRY->( dbGoTop() )

 While !oReport:Cancel() .And. !QRY->(Eof()) 
    oSection:Init()                                       
    
        DO CASE
          
          CASE QRY->ZA7_TPARQ=='01'
          cTparq:='HO'
          CASE QRY->ZA7_TPARQ=='02'
          cTparq:='PR'
          CASE QRY->ZA7_TPARQ=='03'
          cTparq:='AJ'
          CASE QRY->ZA7_TPARQ=='04'    
          cTparq:='LQ'              
        ENDCASE
		
		oSection:Cell("ZA7_TPARQ"):SetValue(cTparq)                              
		oSection:Cell("ZA7_TPARQ"):SetAlign("LEFT")
  
       
       
        oSection:Cell("ZA7_DTARQ"):SetValue(DTOCY(STOD(QRY->ZA7_DTARQ)))
		oSection:Cell("ZA7_DTARQ"):SetAlign("CENTER") 
           
       
       
        oSection:Cell("ZA7_DTPR2"):SetValue(DTOCY(STOD(QRY->ZA7_DTPR2)))
		oSection:Cell("ZA7_DTPR2"):SetAlign("CENTER") 

		oSection:Cell("ZA7_IATA"):SetValue(QRY->ZA7_IATA)
		oSection:Cell("ZA7_IATA"):SetAlign("CENTER")
  
        cNome:=''                                                                                              
        cNome:=Posicione("SA1",9,xFilial("SA1")+QRY->ZA7_IATA,"A1_NOME")
   
     	oSection:Cell("SA1_NOME"):SetValue(if(empty(cNome),'Iata nao cadastrado',cNome))
		oSection:Cell("SA1_NOME"):SetAlign("RIGHT")

	  
	    oSection:Cell("ZA7_HIST"):SetValue(QRY->ZA7_HIST)
		oSection:Cell("ZA7_HIST"):SetAlign("CENTER")   
	   
	    oSection:Cell("ZA7_IDSOLU"):SetValue(QRY->ZA7_IDSOLU)
		oSection:Cell("ZA7_IDSOLU"):SetAlign("CENTER")   
	  
		oSection:Cell("ZA7_DSCSOL"):SetValue(QRY->ZA7_DSCSOL)
		oSection:Cell("ZA7_DSCSOL"):SetAlign("CENTER")   

 
        oSection:Cell("ZA7_DTPG"):SetValue(IF(EMPTY(QRY->ZA7_DTPG),'-',DTOCY(STOD(QRY->ZA7_DTPG))))
		oSection:Cell("ZA7_DTPG"):SetAlign("CENTER") 

        oSection:Cell("ZA7_VLBRUT"):SetValue(QRY->ZA7_VLBRUT)
		oSection:Cell("ZA7_VLBRUT"):SetAlign("CENTER") 

        oSection:Cell("ZA7_VALTXA"):SetValue(QRY->ZA7_VALTXA)
		oSection:Cell("ZA7_VALTXA"):SetAlign("CENTER") 

        oSection:Cell("ZA7_VALLIQ"):SetValue(QRY->ZA7_VALLIQ)
		oSection:Cell("ZA7_VALLIQ"):SetAlign("CENTER") 
 
        oSection:Cell("ZA7_STACTB"):SetValue(QRY->ZA7_STACTB)
		oSection:Cell("ZA7_STACTB"):SetAlign("CENTER") 
   
        oSection:Cell("ZA7_RECONC"):SetValue(QRY->ZA7_RECONC)
		oSection:Cell("ZA7_RECONC"):SetAlign("CENTER") 
		
		
		oSection:Cell("ZA7_CHCTB"):SetValue(QRY->ZA7_CHCTB)
		oSection:Cell("ZA7_CHCTB"):SetAlign("LEFT") 
   	 	  
				
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
Local nTamIata := TamSX3("ZA7_IATA")[1]

aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Cod Iata  Inicial' )  // fazer consulta padrao!!!!!!!!!!!!!!!!!!!!!!!!!
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'01','Cod Iata  Inicial ?','¿Cuenta contable final ?','Final ledger account ?','MV_CH1','C',nTamIata,0,0,'G','','IATA','','S','mv_par01','','','','','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)



aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Cod Iata Final' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'02','Cod Iata final ?','¿Cuenta contable final ?','Final ledger account ?','MV_CH2','C',nTamIata,0,0,'G','','IATA','','S','mv_par02','','','','ZZZZZZZ','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)


aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Data inicial do movimento' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, 	"03","Data de?"	,"¿De Adquisicion ? "  		,"Acquisition from ? "	,"mv_ch3","D",8,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)




aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Data Final do movimento' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, 	"04","Data até?"	,"¿A Adquisicion ? "   		,"Acquisition To ? "	,"mv_ch4","D",8,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)



aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Considera Data  do movimento, integracao ou Baixa' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "05","Considera ?","¿Considera ?","Consider ?","mv_ch5","N",1,0,1,"C","","","","","MV_PAR05","Movimento","","","","Integracao","","",""	,"Baixa" ,"","","","","","","",aHelpPor,aHelpSpa,aHelpSpa)




aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Considera qual tipo de Arquivo' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "06","Tipo de Arquivo ?","","","mv_ch6","N",1,0,1,"C","","","","","MV_PAR06","Provisao","","","","Ajustes","","","Liquidacao"	,"" ,"","Todos","","","","","",aHelpPor,aHelpSpa,aHelpEng)

aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Considera qual Situação' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "07","Tipo de Sit ?","","","mv_ch7","N",1,0,1,"C","","","","","MV_PAR07","Inconsistente","","","","Integrados","","","Não Integrados"	,"" ,"","Todos","","","","","",aHelpPor,aHelpSpa,aHelpEng)


RestArea(aArea)

Return

