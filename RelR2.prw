#include "rwmake.ch"
#include "protheus.ch" 
#INCLUDE "REPORT.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRAPIDR01  บAutor  ณMicrosiga           บ Data ณ  01/28/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function RelR2()
	local oReport := nil
	Private cPerg := 'RelR2'
	
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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRAPIDR01  บAutor  ณMicrosiga           บ Data ณ  01/28/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
static function reportDef()
	local oReport
	Local oSection1
	Local oSection2
	local cTitulo := '[RelR2] - Impressใo de Movimentos de Provisใo '
    Local aOrdem  :={"Data","Iata"}                                                             
 
 //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao do componente de impressao                                      ณ
//ณ                                                                        ณ
//ณTReport():New                                                           ณ
//ณExpC1 : Nome do relatorio                                               ณ
//ณExpC2 : Titulo                                                          ณ
//ณExpC3 : Pergunte                                                        ณ
//ณExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ณ
//ณExpC5 : Descricao                                                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	oReport := TReport():New('RelR2', cTitulo,cPerg , {|oReport| PrintReport(oReport)},"Este relatorio ira imprimir a relacao de movimentos de Provisao.")

 
	oSection1 := TRSection():New(oReport,"RelR2",{"QRY"},aOrdem,.f.,.f.)

 //TRCell():New(oParent,       cName,        cAlias,    cTitle,           cPicture,                         nSize,                 lPixel,          bBlock,                 cAlign,lLineBreak,cHeaderAlign,lCellBreak,nColSpace,lAutoSize,nClrBack,nClrFore,lBold)


    TRCell():new(oSection1, "ZA7_ID"        , "QRY", 'ID-IATA'      ,PesqPict('ZA7',"ZA7_ID") 	    ,TamSX3("ZA7_ID")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
    TRCell():new(oSection1, "A1_NOME"       , "QRY", 'NOME'         ,PesqPict('SA1',"A1_NOME") 	    ,50,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
    TRCell():new(oSection1, "ZA7_DTPR2"     , "QRY", 'DATA'         ,PesqPict('ZA3',"ZA3_DATA") 	,13,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "ZA3_VALOR"	  	, "QRY", 'RAPID'	    ,PesqPict('SE1',"E1_VALOR") 	,TamSX3("ZA3_VALOR")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "VAL_PROVISAO" 	, "QRY", 'PROVISAO'	    ,PesqPict('SE1',"E1_VALOR") 	,TamSX3("ZA3_VALOR")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "VAL_AJUSTE"	, "QRY", 'AJUSTE'	    ,PesqPict('SE1',"E1_VALOR") 	,TamSX3("ZA3_VALOR")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "DIF_VALOR"	    , "QRY", 'DIFERENวA'    ,PesqPict('SE1',"E1_VALOR") 	,TamSX3("ZA3_VALOR")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
    TRCell():new(oSection1, "ZA7_CHCTB"     , "QRY", 'REGISTRO CTB' ,PesqPict('ZA7',"ZA7_CHCTB")    ,TamSX3("CT2_LOTE")[1]+TamSX3("CT2_SBLOTE")[1]+TamSX3("CT2_DOC")[1]+13,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
 

oReport:SetLandScape()
oReport:DisableOrientation()

Return oReport

     
 
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRAPIDR01  บAutor  ณMicrosiga           บ Data ณ  01/28/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrintReport(oReport)
Local oSection := oReport:Section(1)
Local ncont       :=0
Local linha       :=0
Local cQuery
Local nOrdem     :=oSection:GetOrder() 
Local cCcontaCart		:=alltrim(getmv("MV_CCARTAO"))
             
Dbselectarea("CT2")

Pergunte( cPerg , .F. )

//If Select("QRY") > 0
  //	QRY->(dbCloseArea())
//Endif

cQuery := " SELECT * FROM " + RetSqlName("ZA7")
cQuery += " WHERE ZA7_TPARQ IN ("+MV_PAR06+") AND " 
cQuery += " ZA7_DTPR2 BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"' AND "
cQuery += " ZA7_IATA  BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' AND "


DO CASE

CASE MV_PAR05==1
           
cQuery +=  "ZA7_RECONC='S' AND "

CASE MV_PAR05==2

cQuery +=  "ZA7_RECONC='D' AND "

CASE MV_PAR05==3

cQuery += "ZA7_RECONC='N' AND  "

ENDCASE 


cQuery += " D_E_L_E_T_ = ' ' " 

cQuery += " ORDER BY ZA7_IATA,ZA7_DTPR2,ZA7_RECONC"


dbuseArea(.T.,"TopConn",TCGenQry(,,cQuery),"QRY",.F.,.F.)
QRY->( dbGoTop() )

 While !oReport:Cancel() .And. !QRY->(Eof()) 
    oSection:Init()


        oSection:Cell("ZA7_ID"):SetValue(ALLTRIM(QRY->ZA7_ID))
		oSection:Cell("ZA7_ID"):SetAlign("CENTER") 
        
        oSection:Cell("A1_NOME"):SetValue(Posicione("SA1",9,xFilial("SA1")+QRY->ZA7_IATA,"A1_NOME"))
		oSection:Cell("A1_NOME"):SetAlign("LEFT") 
        
        oSection:Cell("ZA7_DTPR2"):SetValue(DTOCY(STOD(QRY->ZA7_DTPR2)))
		oSection:Cell("ZA7_DTPR2"):SetAlign("CENTER")                
		
    	oSection:Cell("ZA3_VALOR"):SetValue(U_VALORGL(QRY->ZA7_IATA,QRY->ZA7_DTPR2,cCcontaCart) )
		oSection:Cell("ZA3_VALOR"):SetAlign("CENTER") 
        
		oSection:Cell("VAL_PROVISAO"):SetValue(QRY->ZA7_VLBRUT)
		oSection:Cell("VAL_PROVISAO"):SetAlign("CENTER") 
		
		oSection:Cell("VAL_AJUSTE"):SetValue(nValaju:=VlAju(QRY->ZA7_IATA,QRY->ZA7_DTPR2)   )
		oSection:Cell("VAL_AJUSTE"):SetAlign("CENTER") 
        
       	oSection:Cell("DIF_VALOR"):SetValue(QRY->ZA7_DIFGL)
		oSection:Cell("DIF_VALOR"):SetAlign("CENTER") 
        
   		
		oSection:Cell("ZA7_CHCTB"):SetValue(QRY->ZA7_CHCTB)
		oSection:Cell("ZA7_CHCTB"):SetAlign("LEFT") 
						
		oSection:PrintLine()
 
		dbSelectArea("QRY")
		QRY->(dbSkip())
	EndDo
 
	QRY->(dbCloseArea())
Return               

               
        
Static Function VlAju(cIatavld,cDatavld) 
       
local nValor:=0

cQuery := " SELECT SUM(ZA7_VLBRUT) AS VALOR FROM " + RetSqlName("ZA7")
cQuery += " WHERE ZA7_IATA='"+cIatavld+"' 
cQuery += " AND ZA7_DTPR2='"+cDatavld+" ' "
cQuery += " AND ZA7_FILIAL='"+xfilial('ZA7')+"'
cQuery += " AND ZA7_TPARQ='03' "

cQuery := ChangeQuery( cQuery )
dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA7V", .F., .T. )
 
dbSelectArea("ZA7V")
dbgotop()  
            
                                        
		nValor:= ZA7V->VALOR
		
ZA7V->(DbCloseArea())		    

Return(nValor)


/*/
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณAjustaSx1  ณ Autor ณRubens Simi       ณ Data ณ 28/01/14     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณAjusta SX1            			          				  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function AjustaSx1()

Local aArea 	:= GetArea()
Local nTamConta := TamSX3("CT1_CONTA")[1]


aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Cod Iata  Final' )  // fazer consulta padrao!!!!!!!!!!!!!!!!!!!!!!!!!
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'01','Cod Iata  Inicial ?','ฟCuenta contable final ?','Final ledger account ?','MV_CH1','C',7,0,0,'G','','IATA','003','S','mv_par03','','','','','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)



aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Cod Iata Final' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'02','Cod Iata final ?','ฟCuenta contable final ?','Final ledger account ?','MV_CH2','C',7,0,0,'G','','IATA','003','S','mv_par02','','','','ZZZZZZZ','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)

aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Data inicial do movimento' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, 	"03","Data de?"	,"ฟDe Adquisicion ? "  		,"Acquisition from ? "	,"mv_ch3","D",8,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)




aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Data Final do movimento' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, 	"04","Data at้?"	,"ฟA Adquisicion ? "   		,"Acquisition To ? "	,"mv_ch4","D",8,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)


aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Considera qual Situa็ใo' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "05","Tipo de Sit ?","","","mv_ch5","N",1,0,1,"C","","","","","MV_PAR05","Integrados","","","","Com Diferencas","","","Inconsistente","" ,"","Todos","","","","","",aHelpPor,aHelpSpa,aHelpEng)
 


aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Considera qual Tipo de arquivo 01-Hot,02-Provisao EXEMPLO :01,02' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'06','Qual tipo de Arq.?','','','MV_CH6','C',5,0,0,'G','','','','S','mv_par06','','','','01,02','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)


RestArea(aArea)

Return

