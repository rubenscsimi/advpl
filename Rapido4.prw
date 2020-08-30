#include "rwmake.ch"
#include "protheus.ch" 
#INCLUDE "REPORT.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RAPIDR04  ºAutor  ³Microsiga           º Data ³  01/28/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Rapido4()
	local oReport := nil
	Private cPerg := 'Rapido4'
	
	AjustaSx1()   

 
	oReport := reportDef()
	oReport:printDialog()  




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
	local cTitulo := '[Rapido4] - Mapa de integração '
    Local aOrdem  :={"Data","Iata"}                                                             
 
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

	oReport := TReport():New('Rapido4', cTitulo,cPerg , {|oReport| PrintReport(oReport)},"Este relatorio ira imprimir o mapa de integração.")

 
	oSection1 := TRSection():New(oReport,"Rapido4",{"QRY"},aOrdem,.f.,.f.)

 //TRCell():New(oParent,       cName,        cAlias,    cTitle,           cPicture,                         nSize,                 lPixel,          bBlock,                 cAlign,lLineBreak,cHeaderAlign,lCellBreak,nColSpace,lAutoSize,nClrBack,nClrFore,lBold)


    TRCell():new(oSection1, "ZA7_ID"        , "QRY", 'ID-IATA'      	,PesqPict('ZA7',"ZA7_ID") 	    ,TamSX3("ZA7_ID")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
    TRCell():new(oSection1, "A1_NOME"       , "QRY", 'NOME'         	,PesqPict('SA1',"A1_NOME") 	    ,50,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
    TRCell():new(oSection1, "ZA7_DTPR2"     , "QRY", 'DATA'         	,PesqPict('ZA3',"ZA3_DATA") 	,13,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "ZA3_VALOR"	  	, "QRY", 'RAPID'	    	,PesqPict('SE1',"E1_VALOR") 	,TamSX3("ZA3_VALOR")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "ZA7_VALOR01"  	, "QRY", 'HOT'	        	,PesqPict('SE1',"E1_VALOR") 	,TamSX3("ZA3_VALOR")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "DIF_GLXHOT"	, "QRY", 'RAPID X HOT'  	,PesqPict('SE1',"E1_VALOR") 	,TamSX3("ZA3_VALOR")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "VAL_PROVISAO" 	, "QRY", 'PROVISAO'	    	,PesqPict('SE1',"E1_VALOR") 	,TamSX3("ZA3_VALOR")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "VAL_AJUSTE"	, "QRY", 'AJUSTE'	        ,PesqPict('SE1',"E1_VALOR") 	,TamSX3("ZA3_VALOR")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
	TRCell():new(oSection1, "DIF_GLXPROV"	, "QRY", 'RAPID X PROV' 	,PesqPict('SE1',"E1_VALOR") 	,TamSX3("ZA3_VALOR")[1]+3,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
   
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
Local oSection      := oReport:Section(1)
Local ncont         :=0
Local linha         :=0
Local cQuery        :=''
Local nOrdem        :=oSection:GetOrder() 
Local cCcontaCart	:=alltrim(getmv("MV_CCARTAO"))
             

Pergunte( cPerg , .F. )

//If Select("QRY") > 0
  //	QRY->(dbCloseArea())
//Endif

cQuery := " SELECT ZA3_IATA,ZA3_DATA FROM " + RetSqlName("ZA3")
cQuery += " WHERE ZA3_DATA BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"' AND "
cQuery += " ZA3_IATA  BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' AND ZA3_CONTA='"+cCcontaCart+"' 
cQuery += " AND D_E_L_E_T_ = ' ' GROUP BY ZA3_IATA,ZA3_DATA " 
cQuery += " ORDER BY ZA3_IATA,ZA3_DATA"


dbuseArea(.T.,"TopConn",TCGenQry(,,cQuery),"QRY",.F.,.F.)
QRY->( dbGoTop() )

 While !oReport:Cancel() .And. !QRY->(Eof()) 
    oSection:Init()   

    
        oSection:Cell("ZA7_ID"):SetValue(ALLTRIM(QRY->ZA3_IATA)+ALLTRIM(QRY->ZA3_DATA))
		oSection:Cell("ZA7_ID"):SetAlign("CENTER") 
        
        oSection:Cell("A1_NOME"):SetValue(Posicione("SA1",9,xFilial("SA1")+QRY->ZA3_IATA,"A1_NOME"))
		oSection:Cell("A1_NOME"):SetAlign("LEFT") 
        
        oSection:Cell("ZA7_DTPR2"):SetValue(DTOCY(STOD(QRY->ZA3_DATA)))
		oSection:Cell("ZA7_DTPR2"):SetAlign("CENTER")                
	 
		cIata :=  ALLTRIM(QRY->ZA3_IATA)
	    dData :=  ALLTRIM(QRY->ZA3_DATA)
	    
       	aAreaZA3T := GetArea("ZA3T")    
	                         
	
    	oSection:Cell("ZA3_VALOR"):SetValue(nVlgl:=U_VALORGL(cIata,dData,cCcontaCart))
		oSection:Cell("ZA3_VALOR"):SetAlign("CENTER")  
		
		oSection:Cell("ZA7_VALOR01"):SetValue(nVlr201:=VALORR2(cIata,dData,'01'))
		oSection:Cell("ZA7_VALOR01"):SetAlign("CENTER") 
       
       	oSection:Cell("DIF_GLXHOT"):SetValue(nVlgl-nVlr201)
		oSection:Cell("DIF_GLXHOT"):SetAlign("CENTER") 
        
		oSection:Cell("VAL_PROVISAO"):SetValue(nVlr202:=VALORR2(cIata,dData,'02'))
		oSection:Cell("VAL_PROVISAO"):SetAlign("CENTER") 
		
		oSection:Cell("VAL_AJUSTE"):SetValue(nVlr203:=VALORR2(cIata,dData,'03'))
		oSection:Cell("VAL_AJUSTE"):SetAlign("CENTER")  
		
       RestArea(aAreaZA3T)	

		oSection:Cell("DIF_GLXPROV"):SetValue(nVlgl-(nVlr202+nVlr203))
		oSection:Cell("DIF_GLXPROV"):SetAlign("CENTER")  
				
        				
		oSection:PrintLine()
 
		dbSelectArea("QRY")
		QRY->(dbSkip())
	EndDo
 
	QRY->(dbCloseArea())
Return               


        
Static Function VALORR2(cIatavld,cDatavld,ctipo) 
       
local nValor:=0

cQuery := " SELECT SUM(ZA7_VLBRUT) AS VALOR FROM " + RetSqlName("ZA7")
cQuery += " WHERE ZA7_IATA='"+cIatavld+"' 
cQuery += " AND ZA7_DTPR2='"+cDatavld+" ' "
cQuery += " AND ZA7_FILIAL='"+xfilial('ZA7')+"'
cQuery += " AND ZA7_TPARQ='"+ctipo+"' "

cQuery := ChangeQuery( cQuery )
dbUseArea( .T., "TOPCONN", TcGenQry( , , cQuery ), "ZA7V", .F., .T. )
 
dbSelectArea("ZA7V")
dbgotop()  
            
                                        
		nValor:= ZA7V->VALOR
		
ZA7V->(DbCloseArea())		    

Return(nValor)



Static Function AjustaSx1()

Local aArea 	:= GetArea()
Local nTamConta := TamSX3("CT1_CONTA")[1]


aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Cod Iata  Final' )  // fazer consulta padrao!!!!!!!!!!!!!!!!!!!!!!!!!
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'01','Cod Iata  Inicial ?','¿Cuenta contable final ?','Final ledger account ?','MV_CH1','C',7,0,0,'G','','IATA','003','S','mv_par03','','','','','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)



aHelpPor	:= {}
aHelpEng	:= {}
aHelpSpa	:= {}                   
Aadd( aHelpPor, 'Cod Iata Final' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'02','Cod Iata final ?','¿Cuenta contable final ?','Final ledger account ?','MV_CH2','C',7,0,0,'G','','IATA','003','S','mv_par02','','','','ZZZZZZZ','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)

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



